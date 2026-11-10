# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopexi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (901 linhas total):

*-- Linhas 51 a 93:
51: *             PageFrame nem Page1/Page2 (ver comentario acima).
52: *   Fase 4:   Estrutura visual completa (todos filhos DIRETOS do form, sem
53: *             Page1/Page2 - este dialogo NAO tem PageFrame): ConfigurarCabecalho
54: *             (cnt_4c_Sombra + lbl_4c_LblSombra/LblTitulo), ConfigurarBarras
55: *             (lbl_4c_Label7 + txt_4c_Barras), ConfigurarGradeDevolucoes
56: *             (grd_4c_Dados, 4 colunas Item/Barras/Produto/Descricao - todas
57: *             ReadOnly, igual ao When=.F. do dump em cada Column.Text1),
58: *             ConfigurarTotais (lbl_4c_Label1 residual oculto + txt_4c_Totitens
59: *             + lbl_4c_Label2 + txt_4c_Totven + lbl_4c_Label3) e
60: *             ConfigurarBotoesAcao (cmd_4c_Confirmar/cmd_4c_BtnCancelar,
61: *             standalone). Column.ControlSource fica VAZIO (CLAUDE.md regra
62: *             #41 - o cursor crSigOpExI pode ainda nao estar com a estrutura
63: *             final neste ponto); o bind com o cursor (RecordSource +
64: *             Column*.ControlSource), o calculo dos totais (BO.
65: *             AtualizarTotais) e os handlers de clique/Valid ficam para fase
66: *             posterior, mesmo padrao de Formsigopagr.prg (Fase 4 so
67: *             estrutura, MontaGrade/eventos em fase seguinte).
68: *   Fase 5:   VincularGradeDevolucoes() - bind do grd_4c_Dados ao cursor
69: *             crSigOpExI (RecordSource + Column1..4.ControlSource) e
70: *             espelhamento dos totais (BO.AtualizarTotais) em
71: *             txt_4c_Totitens/txt_4c_Totven, equivalente literal ao bloco
72: *             "If Used([crSigOpExI]) ... EndIf" do Init legado (ver
73: *             cabecalho do arquivo). So age quando o cursor JA esta aberto
74: *             (ele eh aberto pelo form de Movimentacao ANTES deste dialogo
75: *             ser criado) - CLAUDE.md regra #41. Chamado uma vez em
76: *             InicializarForm; os handlers que o chamam de novo apos
77: *             incluir/confirmar/cancelar item (getBarras.Valid, confirmar.
78: *             Click, btnCancelar.Click) ficam para fase posterior.
79: *   Fase 6:   ValidarBarras()/BarrasKeyPress() - equivalente ao getBarras.
80: *             Valid legado (bipagem do codigo de barras). Este form NAO tem
81: *             lookup F4/FormBuscaAuxiliar (comportamento.json: temLookup=
82: *             false em todos os metodos) - o "lookup" real desta fase eh a
83: *             busca do item na movimentacao (crTpmMvItn) por codigo de
84: *             barras, ja encapsulada em THIS.this_oBusinessObject.
85: *             AdicionarItemPorBarras() (fase 1/2). BINDEVENT em "KeyPress"
86: *             (ENTER/TAB), nao em "Valid" (CLAUDE.md regra #3/#35 -
87: *             BINDEVENT "Valid" nao funciona em TextBox). cmd_4c_Confirmar.
88: *             Click e cmd_4c_BtnCancelar.Click (equivalentes a confirmar.
89: *             Click/btnCancelar.Click do legado) ficam para fase posterior.
90: *   Fase 7:   BtnConfirmarClick()/BtnCancelarClick() - equivalentes a
91: *             confirmar.Click/btnCancelar.Click do dump (ver SECAO 3 do
92: *             codigo fonte). NOTA: o meta-prompt generico desta fase pede
93: *             BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/

*-- Linhas 112 a 132:
112: *             HabilitarCampos/LimparCampos/CarregarLista/
113: *             AjustarBotoesPorModo - template de form CRUD (Page1=Lista/
114: *             Page2=Dados, cursor_4c_Dados, modos INCLUIR/ALTERAR/
115: *             VISUALIZAR/EXCLUIR). Este dialogo NAO tem NENHUM desses
116: *             elementos: nao tem PageFrame, nao tem grid de LISTA de
117: *             registros (grd_4c_Dados eh a grade de ITENS da devolucao
118: *             em edicao, nao uma lista de "registros sigopexi"), nao tem
119: *             modos de form CRUD e seus UNICOS dois botoes (Confirmar/
120: *             Cancelar, equivalentes a confirmar/btnCancelar do dump -
121: *             mapeamento.json nao lista nenhum outro CommandButton) ja
122: *             tem handler completo desde a Fase 7 (BtnConfirmarClick/
123: *             BtnCancelarClick). Nao ha BtnBuscarClick/BtnEncerrarClick/
124: *             BtnSalvarClick a implementar porque esses botoes NAO EXISTEM
125: *             no form (nem no legado, nem no mapeamento). FormParaBO/
126: *             BOParaForm nao se aplicam porque o form nao edita um UNICO
127: *             registro via BO - cada bipagem de codigo de barras grava
128: *             direto no cursor da grade via THIS.this_oBusinessObject.
129: *             AdicionarItemPorBarras() (fase 1/2/6), e a gravacao final
130: *             (tabela sigopexi) acontece dentro de
131: *             THIS.this_oBusinessObject.ConfirmarDevolucoes() (fase 1/2/7).
132: *             Conferido: nenhum TODO/FIXME/stub remanescente no Form nem

*-- Linhas 267 a 328:
267:     * filha DIRETA do form (sem compensacao +29 - nao ha PageFrame). Detectada
268:     * por BackColor=RGB(100,100,100)+Height>=60 (CLAUDE.md regra #11).
269:     * lblSombra/lblTitulo recebem Caption = THIS.Caption diretamente aqui
270:     * (equivalente a "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption"
271:     * do Init legado - a classe "say" do dump so tinha o texto residual
272:     * "Cadastro de Testes", sobrescrito em runtime pelo proprio Init).
273:     * AddObject dos labels fica FORA do WITH do container, e cada WITH usa o
274:     * caminho explicito completo (NUNCA "WITH .filho" aninhado logo apos
275:     * ".AddObject" - props ficariam SILENCIOSAMENTE ignoradas).
276:     *--------------------------------------------------------------------------
277:     PROTECTED PROCEDURE ConfigurarCabecalho()
278:         LOCAL loc_cCaption
279:         loc_cCaption = THIS.Caption
280: 
281:         THIS.AddObject("cnt_4c_Sombra", "Container")
282:         WITH THIS.cnt_4c_Sombra
283:             .Top         = 0
284:             .Left        = 0
285:             .Width       = THIS.Width
286:             .Height      = 80
287:             .BackColor   = RGB(100, 100, 100)
288:             .BorderWidth = 0
289:             .Visible     = .T.
290:         ENDWITH
291: 
292:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
293:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
294:             .Top        = 18
295:             .Left       = 10
296:             .Width      = 769
297:             .Height     = 40
298:             .FontName   = "Tahoma"
299:             .FontSize   = 18
300:             .FontBold   = .T.
301:             .WordWrap   = .T.
302:             .Alignment  = 0
303:             .BackStyle  = 0
304:             .ForeColor  = RGB(0, 0, 0)
305:             .Caption    = loc_cCaption
306:             .Visible    = .T.
307:         ENDWITH
308: 
309:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
310:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
311:             .Top         = 17
312:             .Left        = 10
313:             .Width       = 769
314:             .Height      = 46
315:             .FontName    = "Tahoma"
316:             .FontSize    = 18
317:             .FontBold    = .T.
318:             .WordWrap    = .T.
319:             .Alignment   = 0
320:             .BackStyle   = 0
321:             .ForeColor   = RGB(255, 255, 255)
322:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
323:             .Caption     = loc_cCaption
324:             .Visible     = .T.
325:         ENDWITH
326:     ENDPROC
327: 
328:     *--------------------------------------------------------------------------

*-- Linhas 334 a 368:
334:     * (CLAUDE.md regra sobre Enabled=.F. em runtime apagar icone so se aplica
335:     * a mudanca POSTERIOR a criacao - aqui nao ha Picture, entao nem isso se
336:     * aplica). InputMask com 14 noves = largura exata de cbars numeric(14,0).
337:     * lbl_4c_Label7.Width = 42 (nao autosize, regra #23) - derivado do GAP do
338:     * dump (getBarras.Left=61 - Say7.Left=16 = 45px, menos margem), NUNCA do
339:     * tamanho do texto, para nao invadir o TextBox vizinho.
340:     *--------------------------------------------------------------------------
341:     PROTECTED PROCEDURE ConfigurarBarras()
342:         LOCAL loc_lHabilitado
343:         loc_lHabilitado = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
344: 
345:         THIS.AddObject("lbl_4c_Label7", "Label")
346:         WITH THIS.lbl_4c_Label7
347:             .Top       = 87
348:             .Left      = 16
349:             .Width     = 42
350:             .Height    = 17
351:             .FontName  = "Tahoma"
352:             .FontSize  = 8
353:             .Alignment = 0
354:             .BackStyle = 0
355:             .ForeColor = RGB(0, 0, 0)
356:             .Caption   = "Barra :"
357:             .Visible   = .T.
358:         ENDWITH
359: 
360:         THIS.AddObject("txt_4c_Barras", "TextBox")
361:         WITH THIS.txt_4c_Barras
362:             .Top       = 84
363:             .Left      = 61
364:             .Width     = 108
365:             .Height    = 24
366:             .Alignment = 3
367:             .Value     = 0
368:             .Format    = "K!"

*-- Linhas 432 a 486:
432: 
433:                 IF USED(loc_cCursor)
434:                     SELECT (loc_cCursor)
435:                     GO TOP
436:                 ENDIF
437:                 THIS.grd_4c_Dados.Refresh()
438: 
439:             CASE loc_cStatus == "BLOQUEADO"
440:                 MsgAviso("C" + CHR(243) + "digo do Produto n" + CHR(227) + "o pode ser Alterado", ;
441:                     "Opera" + CHR(231) + CHR(227) + "o com Baixa Parcial")
442: 
443:             CASE loc_cStatus == "INEXISTENTE"
444:                 MsgAviso("Item inexistente nessa opera" + CHR(231) + CHR(227) + "o", "Aviso")
445:                 THIS.txt_4c_Barras.Value = 0
446: 
447:             OTHERWISE
448:                 *-- "DUPLICADO" - sem acao, igual ao legado
449:         ENDCASE
450: 
451:         IF THIS.txt_4c_Barras.Enabled
452:             THIS.txt_4c_Barras.SetFocus()
453:         ENDIF
454:     ENDPROC
455: 
456:     *--------------------------------------------------------------------------
457:     * ConfigurarGradeDevolucoes - grdDevols do dump (grd_4c_Dados), filha
458:     * DIRETA do form, 4 colunas (Item/Barras/Produto/Descricao). Larguras,
459:     * ColumnOrder, Format/InputMask e headers EXATOS do dump (SECAO 2 -
460:     * "PROPRIEDADES DE: SIGOPEXI.grdDevols" - a extracao lista as 4 colunas
461:     * fora de ordem, mas o campo .Name de cada grupo confere com o Column
462:     * real: grupo rotulado "Column2" no dump pertence a Column3/"Produto",
463:     * grupo "Column3" pertence a Column4/"Descricao", grupo "Column4"
464:     * pertence a Column2/"Barras"). Column*.ControlSource fica VAZIO
465:     * propositalmente - ver comentario de InicializarForm.
466:     *--------------------------------------------------------------------------
467:     PROTECTED PROCEDURE ConfigurarGradeDevolucoes()
468:         LOCAL loc_oGrid
469: 
470:         THIS.AddObject("grd_4c_Dados", "Grid")
471:         loc_oGrid = THIS.grd_4c_Dados
472:         WITH loc_oGrid
473:             .Top               = 112
474:             .Left              = 9
475:             .Width             = 809
476:             .Height            = 452
477:             .ColumnCount       = 4
478:             .FontName          = "Courier New"
479:             .AllowHeaderSizing = .F.
480:             .DeleteMark        = .F.
481:             .RecordMark        = .F.
482:             .HeaderHeight      = 16
483:             .ScrollBars        = 2
484:             .ToolTipText       = "Grade de Produtos Para Devolu" + CHR(231) + CHR(227) + "o"
485:             .Visible           = .T.
486:         ENDWITH

*-- Linhas 499 a 507:
499:             .Header1.FontName  = "Arial"
500:             .Header1.FontSize  = 8
501:             .Header1.Alignment = 2
502:             .Header1.Caption   = "Item"
503:             .Text1.Margin      = 0
504:             .Text1.ReadOnly    = .T.
505:         ENDWITH
506: 
507:         *-- Column2: Barras (crSigOpExI.CBars) - ColumnOrder 2

*-- Linhas 518 a 526:
518:             .Header1.FontName  = "Arial"
519:             .Header1.FontSize  = 8
520:             .Header1.Alignment = 2
521:             .Header1.Caption   = "Barras"
522:             .Text1.FontName    = "Courier New"
523:             .Text1.Alignment   = 3
524:             .Text1.BorderStyle = 0
525:             .Text1.InputMask   = "99999999"
526:             .Text1.Margin      = 0

*-- Linhas 541 a 549:
541:             .Header1.FontName  = "Arial"
542:             .Header1.FontSize  = 8
543:             .Header1.Alignment = 2
544:             .Header1.Caption   = "Produto"
545:             .Text1.ReadOnly    = .T.
546:         ENDWITH
547: 
548:         *-- Column4: Descricao (crSigOpExI.DPros) - ColumnOrder 4
549:         WITH loc_oGrid.Column4

*-- Linhas 557 a 723:
557:             .Header1.FontName  = "Arial"
558:             .Header1.FontSize  = 8
559:             .Header1.Alignment = 2
560:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
561:             .Text1.Height      = 23
562:             .Text1.Left        = 35
563:             .Text1.Top         = 19
564:             .Text1.Width       = 100
565:         ENDWITH
566:     ENDPROC
567: 
568:     *--------------------------------------------------------------------------
569:     * ConfigurarTotais - Say1 (residual, invisivel no dump - Visible = .F.),
570:     * gettotitens, Say2, gettotven, Say3, filhos DIRETOS do form. gettotitens/
571:     * gettotven sao SEMPRE ReadOnly (When do dump retorna .F. nos dois) - os
572:     * valores sao calculados pelo BO (AtualizarTotais) e espelhados aqui em
573:     * fase posterior, junto com o bind do grid. lbl_4c_Label2/Label3.Width
574:     * (64/70, regra #23) vem do GAP do dump ate o proximo TextBox
575:     * (gettotitens.Left=89 - Say2.Left=22 / gettotven.Left=249 - Say3.Left=176),
576:     * nao do tamanho do texto - evita invadir o campo vizinho.
577:     *--------------------------------------------------------------------------
578:     PROTECTED PROCEDURE ConfigurarTotais()
579:         THIS.AddObject("lbl_4c_Label1", "Label")
580:         WITH THIS.lbl_4c_Label1
581:             .Top       = 24
582:             .Left      = 370
583:             .Width     = 300
584:             .Height    = 25
585:             .FontName  = "Tahoma"
586:             .FontSize  = 16
587:             .ForeColor = RGB(0, 0, 0)
588:             .Caption   = "Devolu" + CHR(231) + CHR(227) + "o de Produtos"
589:             .Visible   = .F.
590:         ENDWITH
591: 
592:         THIS.AddObject("txt_4c_Totitens", "TextBox")
593:         WITH THIS.txt_4c_Totitens
594:             .Top       = 569
595:             .Left      = 89
596:             .Width     = 66
597:             .Height    = 23
598:             .Alignment = 3
599:             .Value     = 0
600:             .Format    = "K!"
601:             .BackColor = RGB(234, 255, 234)
602:             .ReadOnly  = .T.
603:             .Visible   = .T.
604:         ENDWITH
605: 
606:         THIS.AddObject("lbl_4c_Label2", "Label")
607:         WITH THIS.lbl_4c_Label2
608:             .Top       = 574
609:             .Left      = 22
610:             .Width     = 64
611:             .Height    = 17
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .Alignment = 0
615:             .BackStyle = 0
616:             .ForeColor = RGB(0, 0, 0)
617:             .Caption   = "Total itens:"
618:             .Visible   = .T.
619:         ENDWITH
620: 
621:         THIS.AddObject("txt_4c_Totven", "TextBox")
622:         WITH THIS.txt_4c_Totven
623:             .Top       = 569
624:             .Left      = 249
625:             .Width     = 80
626:             .Height    = 23
627:             .Alignment = 3
628:             .Value     = 0
629:             .Format    = "K!"
630:             .BackColor = RGB(234, 255, 234)
631:             .ReadOnly  = .T.
632:             .Visible   = .T.
633:         ENDWITH
634: 
635:         THIS.AddObject("lbl_4c_Label3", "Label")
636:         WITH THIS.lbl_4c_Label3
637:             .Top       = 574
638:             .Left      = 176
639:             .Width     = 70
640:             .Height    = 17
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .Alignment = 0
644:             .BackStyle = 0
645:             .ForeColor = RGB(0, 0, 0)
646:             .Caption   = "Total valor:"
647:             .Visible   = .T.
648:         ENDWITH
649:     ENDPROC
650: 
651:     *--------------------------------------------------------------------------
652:     * ConfigurarBotoesAcao - confirmar/btnCancelar do dump (cmd_4c_Confirmar/
653:     * cmd_4c_BtnCancelar), CommandButtons standalone (fora de CommandGroup),
654:     * filhos DIRETOS do form. FontName = "Comic Sans MS" - a classe fwbtng do
655:     * dump nao reescreve FontName/FontBold/FontItalic (herdados da classe),
656:     * mas a tabela de fontes usadas (SECAO 2, rodape) lista "Comic Sans MS"
657:     * e nenhum outro controle deste form usa essa fonte - e exatamente o
658:     * padrao canonico dos botoes CRUD do projeto (framework_frmcadastro_layout.md).
659:     * .Themes = .T. + .DisabledPicture (CLAUDE.md - standalone CommandButton
660:     * com .Picture definido exige isso para o icone renderizar).
661:     * cmd_4c_Confirmar.Enabled replica o When do dump ("Return
662:     * Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])"), avaliado na
663:     * criacao (mesmo raciocinio de ConfigurarBarras). btnCancelar nao tem
664:     * When no dump - sempre habilitado.
665:     *--------------------------------------------------------------------------
666:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
667:         LOCAL loc_lHabilitado
668:         loc_lHabilitado = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
669: 
670:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
671:         WITH THIS.cmd_4c_Confirmar
672:             .Top            = 3
673:             .Left           = 848
674:             .Width          = 75
675:             .Height         = 75
676:             .FontName       = "Comic Sans MS"
677:             .FontSize       = 8
678:             .FontBold       = .T.
679:             .FontItalic     = .T.
680:             .Caption        = "Confirmar"
681:             .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
682:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
683:             .PicturePosition = 13
684:             .ForeColor      = RGB(90, 90, 90)
685:             .BackColor      = RGB(255, 255, 255)
686:             .Themes         = .T.
687:             .WordWrap       = .T.
688:             .MousePointer   = 15
689:             .SpecialEffect  = 0
690:             .Enabled        = loc_lHabilitado
691:             .Visible        = .T.
692:         ENDWITH
693:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
694: 
695:         THIS.AddObject("cmd_4c_BtnCancelar", "CommandButton")
696:         WITH THIS.cmd_4c_BtnCancelar
697:             .Top            = 3
698:             .Left           = 923
699:             .Width          = 75
700:             .Height         = 75
701:             .FontName       = "Comic Sans MS"
702:             .FontSize       = 8
703:             .FontBold       = .T.
704:             .FontItalic     = .T.
705:             .Caption        = "Retornar"
706:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
707:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
708:             .PicturePosition = 13
709:             .Cancel         = .T.
710:             .ForeColor      = RGB(90, 90, 90)
711:             .BackColor      = RGB(255, 255, 255)
712:             .Themes         = .T.
713:             .WordWrap       = .T.
714:             .MousePointer   = 15
715:             .SpecialEffect  = 0
716:             .Visible        = .T.
717:         ENDWITH
718:         BINDEVENT(THIS.cmd_4c_BtnCancelar, "Click", THIS, "BtnCancelarClick")
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     * BtnConfirmarClick - equivalente ao confirmar.Click do dump (SECAO 3).
723:     * O SCAN sobre a grade de devolucao (localizar por codigo de barras em

*-- Linhas 822 a 842:
822:         THIS.this_oBusinessObject.LimparItensDevolucao(THIS.this_cCursorDevolucao)
823:         THIS.Release()
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * VincularGradeDevolucoes - Liga grd_4c_Dados ao cursor de devolucao
828:     * (THIS.this_cCursorDevolucao, igual a "crSigOpExI" - aberto pelo form
829:     * de Movimentacao ANTES deste dialogo ser criado) e espelha os totais
830:     * calculados pelo BO (sigopexiBO.AtualizarTotais) em txt_4c_Totitens/
831:     * txt_4c_Totven - equivalente literal ao bloco "If Used([crSigOpExI])
832:     * ... EndIf" do Init legado (ver cabecalho do arquivo). So faz algo se
833:     * o cursor JA estiver aberto (CLAUDE.md regra #41 - Column.ControlSource
834:     * de cursor ainda inexistente derruba o Init); se nao estiver, a grade
835:     * fica com ControlSource vazio (ja deixado assim em
836:     * ConfigurarGradeDevolucoes). GO TOP + Grid.Refresh no fim (cursor
837:     * populado nao repinta a grade sozinho).
838:     *--------------------------------------------------------------------------
839:     PROTECTED PROCEDURE VincularGradeDevolucoes()
840:         LOCAL loc_cCursor
841: 
842:         loc_cCursor = THIS.this_cCursorDevolucao

*-- Linhas 855 a 901:
855: 
856:             *-- RecordSource/ControlSource RESETAM Column.Width e
857:             *-- Header1.Caption (Problema 48/FormCor Licoes Aprendidas) -
858:             *-- reconfigurar os dois IMEDIATAMENTE depois, na mesma ordem
859:             *-- em que foram definidos em ConfigurarGradeDevolucoes.
860:             WITH THIS.grd_4c_Dados
861:                 .RecordSource          = loc_cCursor
862:                 .Column1.ControlSource = loc_cCursor + ".CItens"
863:                 .Column2.ControlSource = loc_cCursor + ".CBars"
864:                 .Column3.ControlSource = loc_cCursor + ".CPros"
865:                 .Column4.ControlSource = loc_cCursor + ".DPros"
866: 
867:                 .Column1.Width           = 31
868:                 .Column1.Header1.Caption = "Item"
869: 
870:                 .Column2.Width           = 108
871:                 .Column2.Header1.Caption = "Barras"
872: 
873:                 .Column3.Width           = 122
874:                 .Column3.Header1.Caption = "Produto"
875: 
876:                 .Column4.Width           = 513
877:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
878:             ENDWITH
879: 
880:             THIS.this_oBusinessObject.AtualizarTotais(loc_cCursor)
881:             THIS.txt_4c_Totitens.Value = THIS.this_oBusinessObject.this_nTotalItens
882:             THIS.txt_4c_Totven.Value   = THIS.this_oBusinessObject.this_nTotalValor
883: 
884:             SELECT (loc_cCursor)
885:             GO TOP
886:             THIS.grd_4c_Dados.Refresh()
887:         ENDIF
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * Destroy - Libera a referencia ao form chamador e chama DODEFAULT()
892:     * (CLAUDE.md regra #29 - Destroy sem DODEFAULT: FormBase.Destroy() faz o
893:     * RELEASE POPUP + CriarMenuPrincipal() que evita o menu "encolher" apos
894:     * fechar form modal, alem de liberar THIS.this_oBusinessObject).
895:     *--------------------------------------------------------------------------
896:     PROCEDURE Destroy()
897:         THIS.this_oFormPai = .NULL.
898:         DODEFAULT()
899:     ENDPROC
900: 
901: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopexiBO.prg):
*====================================================================
* sigopexiBO.prg
*
* Business Object para Devolucao de Produtos (dialogo filho OPERACIONAL)
* Tabela: sigopexi
* Herda de: BusinessBase
*
* NOTA: SIGOPEXI eh um dialogo MODAL chamado pela tela de Movimentacao
* (parentform) para lancar devolucao de itens digitados por codigo de
* barras. A tabela sigopexi grava so as colunas persistidas abaixo;
* CItens e DPros existem apenas no cursor em memoria (crSigOpExI) usado
* pela grade do dialogo e NAO tem coluna correspondente na tabela.
*====================================================================

DEFINE CLASS sigopexiBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopexi)
    this_cPkChaves    = ""    && pkchaves char(20) - PK (gerada via fUniqueIds())
    this_nCBars       = 0     && cbars numeric(14,0) - codigo de barras do produto devolvido
    this_cCPros       = ""    && cpros char(14) - codigo do produto
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave do movimento (Emps+Dopes+Str(Numes,6))
    this_dDatas       = {}    && datas datetime - data/hora do lancamento da devolucao
    this_nValors      = 0     && valors numeric(11,2) - valor da devolucao (qtds * units)

    *-- Propriedades auxiliares somente-memoria (nao persistidas em sigopexi)
    this_nCItens      = 0     && citens - sequencial do item na grade (crSigOpExI.CItens)
    this_cDPros       = ""    && dpros char(50) - descricao do produto (crSigOpExI.DPros, via SigCdPro)

    *-- Propriedades auxiliares de processo (equivalentes a propriedades/
    *-- controles do form legado - preenchidas/lidas pelos metodos desta
    *-- fase, consumidas pelo FormSigopexi nas fases seguintes)
    this_cOpEscolha            = ""    && espelha ThisForm.op_escolha (recebido do form pai) - usado em AdicionarItemPorBarras/ConfirmarDevolucoes
    this_nTotalItens           = 0     && espelha thisform.gettotitens.Value (COUNT da grade de devolucao)
    this_nTotalValor           = 0     && espelha thisform.gettotven.Value (SUM de valors da grade de devolucao)
    this_cProdutosParaExcluir  = ""    && codigos de produto (separados por virgula) elegiveis para exclusao de cadastro (CrSigCdOpe.CadProds = 3) - o Form pergunta ao usuario e chama THIS.parentform.ExcluirPro() para cada
    this_nNovoCItem            = 0     && equivalente a thisform.parentform.CItem apos ConfirmarDevolucoes renumerar crTpmMvItn
    this_lChamouApaIte         = .F.   && .T. quando ConfirmarDevolucoes identifica que o Form deve chamar THIS.parentform.ApaIte()

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopexi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopexiBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da tabela sigopexi
    * (pkchaves/cbars/cpros/empdopnums/datas/valors) a partir da linha
    * CORRENTE do cursor informado (tipicamente crSigOpExI - a grade de
    * devolucao), mais as duas colunas auxiliares somente-memoria
    * (citens/dpros), quando presentes no cursor.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_nCBars      = TratarNulo(cbars, 0)
            THIS.this_cCPros      = TratarNulo(cpros, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_nValors     = TratarNulo(valors, 0)

            *-- Colunas auxiliares somente-memoria do cursor da grade
            *-- (nao existem na tabela sigopexi - ver cabecalho da classe)
            IF TYPE(par_cAliasCursor + ".citens") != "U"
                THIS.this_nCItens = TratarNulo(citens, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dpros") != "U"
                THIS.this_cDPros = TratarNulo(dpros, "")
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO sigopexi com os valores das properties this_*.
    * Gera THIS.this_cPkChaves via fUniqueIds() quando ainda vazio (igual
    * ao getBarras.Valid do legado, que gera a chave no momento do insert).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigopexi (pkchaves, cbars, cpros, empdopnums, datas, valors)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCBars, 0) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE sigopexi, identificado por this_cPkChaves.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigopexi SET" + ;
                " cbars = "      + FormatarNumeroSQL(THIS.this_nCBars, 0) + "," + ;
                " cpros = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + "," + ;
                " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + "," + ;
                " datas = "      + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                " valors = "     + FormatarNumeroSQL(THIS.this_nValors, 2) + ;
                " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da tabela sigopexi (pkchaves).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * AtualizarTotais - Recalcula THIS.this_nTotalItens/this_nTotalValor a
    * partir do cursor de devolucao (equivalente a "Select crSigOpExI /
    * Sum valors to lntotven / Count to lnitn" repetido no getBarras.Valid
    * e no Init do legado). O Form eh quem espelha estes valores nos
    * labels gettotitens/gettotven - esta funcao so calcula.
    *====================================================================
    PROCEDURE AtualizarTotais(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias, loc_nTotalValor, loc_nTotalItens

        loc_cAlias      = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        loc_nTotalValor = 0
        loc_nTotalItens = 0

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            SUM valors TO loc_nTotalValor
            COUNT TO loc_nTotalItens
        ENDIF

        THIS.this_nTotalValor = loc_nTotalValor
        THIS.this_nTotalItens = loc_nTotalItens

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterDescricaoProduto - SELECT dpros FROM SigCdPro WHERE cpros = ...
    * (equivalente a "podatamgr.sqlexecute('select dpros from SigCdPro
    * where cpros = ?csProcura1.CPros','LocalPro')" do getBarras.Valid
    * legado - unica consulta SQL de verdade neste dialogo).
    *====================================================================
    PROTECTED PROCEDURE ObterDescricaoProduto(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao

        loc_cDescricao = ""

        loc_cSQL = "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(par_cCodigoProduto, "")))

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")

        IF loc_nResultado > 0 AND USED("cursor_4c_BuscaProduto")
            SELECT cursor_4c_BuscaProduto
            GO TOP
            IF !EOF()
                loc_cDescricao = TratarNulo(dpros, "")
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL do movimento (EmpDopNums),
    * igual a "TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)" do
    * legado. O padding faz parte da chave (regra das colunas char de
    * largura fixa) - NUNCA usar ALLTRIM nas partes, so no resultado
    * inteiro seria inofensivo. Larguras conferidas no schema: emps
    * char(3) + dopes char(20) + Str(numes,6) = 29 = empdopnums char(29).
    *====================================================================
    PROTECTED PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(ALLTRIM(NVL(par_cEmps, "")), 3) + ;
               PADR(ALLTRIM(NVL(par_cDopes, "")), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * AdicionarItemPorBarras - Localiza o item da movimentacao
    * (crTpmMvItn - cursor global compartilhado com o form pai de
    * Movimentacao) pelo codigo de barras e, se elegivel, inclui uma nova
    * linha no cursor de devolucao (equivalente ao getBarras.Valid do
    * legado). So manipula dados - o Form (fases seguintes) limpa o
    * campo de barras, da Refresh no Grid e exibe a mensagem conforme o
    * status retornado.
    *
    * Retorno:
    *   "OK"          - item incluido com sucesso na grade de devolucao
    *   "BLOQUEADO"   - produto com baixa parcial, nao pode ser alterado
    *   "INEXISTENTE" - codigo de barras nao encontrado na movimentacao
    *   "DUPLICADO"   - produto ja estava na grade de devolucao (nao faz
    *                   nada, igual ao legado, que ignora em silencio)
    *====================================================================
    PROCEDURE AdicionarItemPorBarras(par_nBarras, par_cAliasCursorDevolucao)
        LOCAL loc_cStatus, loc_cAliasDevol, loc_nItem, loc_cDescricao, loc_cChave

        loc_cStatus     = "INEXISTENTE"
        loc_cAliasDevol = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        *-- VARTYPE isolado num IF proprio: VFP9 nao faz short-circuit em
        *-- AND/OR, e "par_nBarras != 0" com par_nBarras nao-numerico
        *-- estouraria "Operator/operand type mismatch" se avaliado junto.
        IF VARTYPE(par_nBarras) = "N"
        IF par_nBarras != 0 AND USED("crTpmMvItn") AND USED(loc_cAliasDevol)
            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
            SELECT RECNO() AS NRec, CPros, BlqAlts, qtds, units FROM crTpmMvItn ;
                WHERE CodBarras = par_nBarras INTO CURSOR cursor_4c_BuscaMovimento
            GO TOP IN cursor_4c_BuscaMovimento

            IF !EOF("cursor_4c_BuscaMovimento")
                IF cursor_4c_BuscaMovimento.BlqAlts
                    loc_cStatus = "BLOQUEADO"
                ELSE
                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                    SELECT RECNO() AS NRec FROM (loc_cAliasDevol) ;
                        WHERE CBars = par_nBarras INTO CURSOR cursor_4c_BuscaDuplicado
                    GO TOP IN cursor_4c_BuscaDuplicado

                    IF EOF("cursor_4c_BuscaDuplicado")
                        *-- Renumera CItens das linhas existentes (igual ao
                        *-- legado - normalmente no-op, preserva fidelidade)
                        loc_nItem = 0
                        SELECT (loc_cAliasDevol)
                        SCAN
                            loc_nItem = loc_nItem + 1
                            REPLACE CItens WITH loc_nItem IN (loc_cAliasDevol)
                        ENDSCAN
                        loc_nItem = loc_nItem + 1

                        loc_cDescricao = THIS.ObterDescricaoProduto(cursor_4c_BuscaMovimento.CPros)
                        loc_cChave     = THIS.MontarChaveEmpDopNums(TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)

                        INSERT INTO (loc_cAliasDevol) (EmpDopNums, Datas, pkChaves, CBars, CPros, dpros, valors, CItens) VALUES ( ;
                            loc_cChave, ;
                            DATETIME(), ;
                            fUniqueIds(), ;
                            par_nBarras, ;
                            cursor_4c_BuscaMovimento.CPros, ;
                            loc_cDescricao, ;
                            cursor_4c_BuscaMovimento.qtds * cursor_4c_BuscaMovimento.units, ;
                            loc_nItem)

                        THIS.AtualizarTotais(loc_cAliasDevol)

                        loc_cStatus = "OK"
                    ELSE
                        loc_cStatus = "DUPLICADO"
                    ENDIF

                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
        ENDIF
        ENDIF

        RETURN loc_cStatus
    ENDPROC

    *====================================================================
    * LimparItensDevolucao - Esvazia o cursor de devolucao (equivalente a
    * "SELECT crSigOpExI / Zap" do btnCancelar.Click do legado).
    *====================================================================
    PROCEDURE LimparItensDevolucao(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias
        loc_cAlias = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            ZAP
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConfirmarDevolucoes - Processa a confirmacao da devolucao
    * (equivalente ao confirmar.Click do legado). Para cada item da
    * grade de devolucao, localiza o item correspondente na movimentacao
    * (crTpmMvItn) pelo codigo de barras e, se nao estiver bloqueado,
    * exclui o item (e seus componentes, em crTpmMvIts) da movimentacao,
    * renumera os itens restantes e, quando aplicavel, estorna a baixa
    * de estoque (xBaixa) e avalia se o cadastro do produto pode ser
    * excluido (CrSigCdOpe.CadProds = 3 - ver AvaliarExclusaoProduto).
    *
    * Cursores globais compartilhados com o form pai de Movimentacao
    * (crTpmMvItn, crTpmMvIts, TprMvCab, CrSigCdOpe, CrSigOpCdc,
    * TmpOperacao, xBaixa) sao referenciados por NOME, igual ao legado -
    * este dialogo so eh aberto depois que o pai os deixa abertos.
    *
    * O que o legado faz em "ThisForm.parentform" (fwgrade/fwgradeR.
    * Refresh, Produto.SetFocus, CItem, ExcluirPro, ApaIte) eh
    * responsabilidade de UI/navegacao do FORM pai, nao deste BO - o
    * Form (fases seguintes) le o resultado desta chamada
    * (this_cProdutosParaExcluir, this_nNovoCItem, this_lChamouApaIte) e
    * executa essas acoes contra o parentform depois de chamar este
    * metodo.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo sem
    * nenhuma devolucao processada - igual ao legado, que nao verifica
    * sucesso por item).
    *====================================================================
    PROCEDURE ConfirmarDevolucoes(par_cAliasCursorDevolucao)
        LOCAL loc_cAliasDevol, loc_oErro, loc_lSucesso, loc_nBarras
        LOCAL loc_cItem, loc_cPro, loc_nQtde, loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper
        LOCAL loc_nReg, loc_lDel, loc_lSubNiv, loc_cont, loc_cIt, loc_nRecNo2

        loc_lSucesso                  = .F.
        loc_cAliasDevol                = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        THIS.this_cProdutosParaExcluir = ""
        THIS.this_nNovoCItem           = 0
        THIS.this_lChamouApaIte        = .F.

        TRY
            IF USED(loc_cAliasDevol) AND USED("crTpmMvItn")
                SELECT (loc_cAliasDevol)
                SCAN
                    loc_nBarras = cbars

                    SELECT crTpmMvItn
                    LOCATE FOR CodBarras = loc_nBarras

                    IF !EOF("crTpmMvItn")
                        IF crTpmMvItn.BlqAlts
                            *-- bloqueado: o legado so exibe o MessageBox e
                            *-- segue para o proximo item do SCAN (o Form
                            *-- exibe a mensagem de bloqueio, se desejar).
                        ELSE
                            IF !EMPTY(crTpmMvItn.cpros)
                                loc_cItem         = crTpmMvItn.CItens
                                loc_cPro          = crTpmMvItn.Cpros
                                loc_nQtde         = crTpmMvItn.Qtds
                                loc_lCarregaItens = INLIST(NVL(CrSigCdOpe.ItAutos, 0), 1, 3, 4, 5) AND THIS.this_cOpEscolha == "INSERIR"
                                loc_lChecaQtde    = INLIST(NVL(CrSigCdOpe.ChkQtdss, 0), 1, 3, 4)
                                loc_lChecaOper    = (EMPTY(CrSigOpCdc.ChkOpers) OR crTpmMvItn.Opers == CrSigOpCdc.ChkOpers)

                                SELECT crTpmMvItn
                                loc_nReg = RECNO()
                                loc_lDel = .F.

                                LOCATE FOR .F.
                                IF BETWEEN(loc_nReg, 1, RECCOUNT("crTpmMvItn"))
                                    GO loc_nReg
                                    DELETE
                                    DELETE FOR cItem2 = loc_cItem
                                    loc_lDel = .T.
                                ENDIF

                                IF loc_lDel
                                    loc_lSubNiv = .F.
                                    IF USED("TmpOperacao")
                                        SELECT TmpOperacao
                                        SCAN FOR !EMPTY(Codigos)
                                            loc_lSubNiv = .T.
                                        ENDSCAN
                                    ENDIF

                                    IF loc_lSubNiv AND loc_lChecaQtde AND loc_lChecaOper AND !loc_lCarregaItens
                                        IF USED("xBaixa")
                                            SELECT xBaixa
                                            IF SEEK(loc_cPro)
                                                REPLACE qtbaixas WITH qtbaixas - loc_nQtde IN xBaixa
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    IF USED("crTpmMvIts")
                                        SELECT crTpmMvIts
                                        SET ORDER TO
                                        SET ORDER TO CItens
                                        SEEK (loc_cItem)
                                        DO WHILE !EOF("crTpmMvIts") AND crTpmMvIts.CItens = loc_cItem
                                            DELETE
                                            SEEK (loc_cItem)
                                        ENDDO
                                    ENDIF

                                    IF NVL(CrSigCdOpe.CadProds, 0) = 3
                                        THIS.AvaliarExclusaoProduto(loc_cPro, NVL(TprMvCab.EmpdopNums, ""))
                                    ENDIF
                                ENDIF
                            ELSE
                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                                SELECT "" AS Agrupar, COUNT(1) AS Total FROM crTpmMvItn ;
                                    WHERE EMPTY(CPros) INTO CURSOR xApaga GROUP BY 1

                                IF xApaga.Total > 1
                                    SELECT crTpmMvItn
                                    DELETE
                                ELSE
                                    THIS.this_lChamouApaIte = .T.
                                ENDIF

                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                            ENDIF

                            SELECT crTpmMvItn
                            SET ORDER TO CItens
                            GO TOP
                            IF EOF()
                                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CItens) ;
                                    VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, 1)
                            ENDIF

                            loc_cont = 0
                            SELECT crTpmMvItn
                            SCAN
                                loc_cont = loc_cont + 1
                                IF USED("crTpmMvIts")
                                    SELECT crTpmMvIts
                                    SET ORDER TO
                                    SET ORDER TO CItens
                                    SEEK crTpmMvItn.CItens
                                    SCAN WHILE CItens = crTpmMvItn.CItens
                                        REPLACE CItens WITH loc_cont
                                    ENDSCAN
                                ENDIF
                                SELECT crTpmMvItn
                                loc_cIt     = CItens
                                loc_nRecNo2 = RECNO()
                                REPLACE cItem2 WITH loc_cont FOR cItem2 = loc_cIt
                                GO loc_nRecNo2
                                REPLACE CItens WITH loc_cont
                            ENDSCAN

                            THIS.this_nNovoCItem = loc_cont

                            SELECT crTpmMvItn
                            SET ORDER TO
                            GO BOTTOM
                            IF !EOF() AND USED("crTpmMvIts")
                                SELECT crTpmMvIts
                                SET ORDER TO CItens
                                SET KEY TO crTpmMvItn.CItens
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT (loc_cAliasDevol)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao confirmar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.ConfirmarDevolucoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AvaliarExclusaoProduto - Verifica se o produto devolvido ainda tem
    * movimento (SigMvItn), historico (SigMvHst) ou composicao (SigPrCpo)
    * em outro documento; se nao tiver nenhum, acrescenta o codigo a
    * THIS.this_cProdutosParaExcluir (lista separada por virgula) para o
    * Form perguntar ao usuario (MessageBox) e chamar
    * THIS.parentform.ExcluirPro() - equivalente ao bloco "If
    * CrSigCdOpe.CadProds = 3" do confirmar.Click legado.
    *====================================================================
    PROTECTED PROCEDURE AvaliarExclusaoProduto(par_cCodigoProduto, par_cEmpDopNumsAtual)
        LOCAL loc_cSQL, loc_nTotalMov, loc_nTotalHist, loc_nTotalCompo, loc_cProduto, loc_cEmpDopNums

        loc_cProduto     = ALLTRIM(NVL(par_cCodigoProduto, ""))
        loc_cEmpDopNums  = NVL(par_cEmpDopNumsAtual, "")

        loc_cSQL = "SELECT cpros FROM SigMvItn WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaMov")
        loc_nTotalMov = IIF(USED("cursor_4c_VerificaMov"), RECCOUNT("cursor_4c_VerificaMov"), 0)

        loc_cSQL = "SELECT cpros FROM SigMvHst WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaHist")
        loc_nTotalHist = IIF(USED("cursor_4c_VerificaHist"), RECCOUNT("cursor_4c_VerificaHist"), 0)

        loc_cSQL = "SELECT mats FROM SigPrCpo WHERE mats = " + EscaparSQL(loc_cProduto)
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaCompo")
        loc_nTotalCompo = IIF(USED("cursor_4c_VerificaCompo"), RECCOUNT("cursor_4c_VerificaCompo"), 0)

        IF loc_nTotalMov = 0 AND loc_nTotalHist = 0 AND loc_nTotalCompo = 0
            THIS.this_cProdutosParaExcluir = THIS.this_cProdutosParaExcluir + ;
                IIF(EMPTY(THIS.this_cProdutosParaExcluir), "", ",") + loc_cProduto
        ENDIF

        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
    ENDPROC

ENDDEFINE

