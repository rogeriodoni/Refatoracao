# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PARENTFORM, LPEMPS, DOPES, CODIGOS, EMPDOPNUMS, CPROS, CGRUS, CEMPS, EMPSUBNS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  ControlSource = "xeesti.citens"
lcSql = [Select nDopes From SigCdOpe Where Dopes = ']+ThisForm.lpDopes+[']
If Thisform.parentform.PoDataMgr.SqlExecute(lcSql,'CrxOpe') < 1
lcSql = [Select a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, ] + ;
		  [From SigMvPec a ] + ;
		  	[Join SigMvCab b on a.EmpDopnums = b.EmpDopNums ] + ;
		  	[Join SigCdOpe c on b.Dopes = c.Dopes ] + ;
		  	[Left Join SigStats d on b.pstatus = d.cods ] + ;
		[Select a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, ] + ;
		  [From SigOpDev a ] + ;
		  	[Join SigMvCab b on a.EmpDopnums = b.EmpDopNums ] + ;
		  	[Join SigCdOpe c on b.Dopes = c.Dopes ] + ;
		  	[Left Join SigStats d on b.pstatus = d.cods ] + ;
If Thisform.Parentform.PoDataMgr.SqlExecute(lcSql,'CrxEstPe') < 1
Select CrxEstPe
SELECT TmpSubN
APPEND FROM DBF('CrxEstPe')
Update TmpSubN Set PrazoEnts = Nvl(PrazoEnts, Ctot([]))
SELECT TmpSubN
	.Column1.ControlSource = 'TmpSubN.Emps'
	.Column2.Controlsource = 'TmpSubN.Dopes'
	.Column3.Controlsource = 'TmpSubN.Numes'
	.Column4.Controlsource = 'TmpSubN.Datas'
	.Column5.Controlsource = 'TmpSubN.Notas'
	.Column6.Controlsource = 'TmpSubN.Usuars'
	.Column7.Controlsource = 'TmpSubN.PrazoEnts'
	.Column8.Controlsource = 'TmpSubN.Pstatus + [-] + TmpSubN.Descs'
ThisForm.Parentform.poDataMgr.SqlExecute([Select * From SigMvItn Where EmpDopNums = ']+lcEmpDopNums+['],'crTpmMvItnSubn')
	.Produto.Controlsource    = 'crTpmMvItnSubn.cpros'
	.Fator.Controlsource      = 'crTpmMvItnSubn.fators'
	.Operacao.Controlsource   = 'crTpmMvItnSubn.opers'
	.Qtd.Controlsource        = 'crTpmMvItnSubn.qtds'
	.Peso.Controlsource       = 'crTpmMvItnSubn.pesos'
	.Valor.Controlsource      = 'crTpmMvItnSubn.units'
	.Moeda.Controlsource      = 'crTpmMvItnSubn.moedas'
	.Total.Controlsource      = 'crTpmMvItnSubn.totas'
	.PesoTot.Controlsource    = 'crTpmMvItnSubn.tpesos'
	.Item.Controlsource       = 'crTpmMvItnSubn.CItens'
Select crTpmMvItnSubn
lcQuery = [Select a.Cpros, a.FigJpgs, a.dpros, a.Cgrus, b.Dgrus From SigCdPro a, SigCdGrp b ]+;
=ThisForm.Parentform.PodataMgr.SqlExecute(lcQuery,'CrTmpPro')
Select crTpmMvItnSubn
	Select crTPro
	Delete File (lcArquivo)
=ThisForm.ParentForm.poDataMgr.SqlExecute([Select NEmps From SigCdEmp Where Cemps = ']+&lcCursor..Emps+[' ],[LocalEmp])
=ThisForm.ParentForm.poDataMgr.SqlExecute([Select DoppServs From SigCdPam],[LocalParam])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg) - TRECHOS RELEVANTES PARA PASS SQL (1679 linhas total):

*-- Linhas 34 a 59:
34: * (CarregarLista), que eh o trecho final do Init legado: BuscarSubniveis
35: * no BO, bind do grid e desabilitacao do form pai.
36: *
37: * Os Column*.ControlSource da grade principal so sao atribuidos DENTRO
38: * de CarregarLista, depois que o BO populou cursor_4c_Subniveis - o
39: * legado faz igual (With ThisForm.Grade ... no final do Init, apos o
40: * APPEND FROM em TmpSubN), e atribuir ControlSource a cursor inexistente
41: * derrubaria o Init (CLAUDE.md regra #41). Pelo mesmo motivo Width e
42: * Header1.Caption sao REAPLICADOS apos o RecordSource, que os reseta.
43: *
44: * A grade de itens (grd_4c_Itens) nasce com ControlSource vazio pelo
45: * mesmo motivo: o legado so a vincula dentro de Grade.AfterRowColChange,
46: * com o subnivel ja clicado. O bind dela mora em CarregarGradeItens.
47: *
48: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: os 4 nomes canonicos
49: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick NAO
50: * se aplicam a este form. Eles sao convencao do frmcadastro (botoes da
51: * Page1 de Lista) e o SIGMVSBN nao tem superficie CRUD nenhuma: herda de
52: * "form" (nao de frmcadastro), nao tem Grupo_Op, nao declara pcEscolha e
53: * tem exatamente DOIS CommandButton no SCX - Sair e BtnOficina. Criar os
54: * 4 aqui exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1 e
55: * a regra "NUNCA inventar") ou escrever 4 metodos vazios (proibido pela
56: * regra de completude). Os botoes que o legado REALMENTE tem estao ambos
57: * implementados e ligados por BINDEVENT: BtnSairClick e BtnOficinaClick.
58: *
59: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: o roteiro padrao

*-- Linhas 75 a 94:
75: *                               Caption "Encerrar" BtnSairClick (nome do
76: *                               no dump)           legado, preservado)
77: *   BtnSalvarClick/             NAO (nenhum       N/A - Inserir()/Atualizar()
78: *   BtnCancelarClick            Insert/Update/    do BO ja documentam que
79: *                               Delete no dump -   SigMvSbn eh tela de
80: *                               ver Inserir/       CONSULTA, nunca grava
81: *                               Atualizar do BO)
82: *   FormParaBO / BOParaForm     N/A - sem campo   Coberto por
83: *                               EDITAVEL nao ha    GradeAfterRowColChange/
84: *                               o que "mapear de   ItensAfterRowColChange/
85: *                               volta"; a leitura  CarregarImagemProduto, que
86: *                               (equivalente a     ja fazem esse sentido
87: *                               BOParaForm) ja      unico (BO -> campo) a
88: *                               existe              cada troca de linha
89: *   HabilitarCampos /            N/A - nenhum      .ReadOnly = .T. fixo,
90: *   LimparCampos                 campo muda de     declarado uma unica vez
91: *                                 estado por modo   em ConfigurarCampos*
92: *                                 (o dialogo inteiro (nao ha modo INCLUIR/
93: *                                 eh sempre so-      ALTERAR/VISUALIZAR
94: *                                 leitura)           aqui)

*-- Linhas 128 a 146:
128: *      caracteres ("001MALOTE     3") em vez dos 29 do formato gravado
129: *      ("001MALOTE                   3"). O legado NAO usa ALLTRIM - o
130: *      padding vem das colunas (Emps char(3) + Dopes char(20) +
131: *      Str(Numes,6) = 29 = EmpDopNums char(29)). Consequencia: o SELECT de
132: *      BuscarItensSubnivel rodava SEM ERRO e devolvia ZERO linhas SEMPRE,
133: *      entao a grade de itens, a descricao e a imagem do produto ficavam
134: *      permanentemente vazias e CarregarGradeItens /
135: *      ItensAfterRowColChange / CarregarImagemProduto / ImgFigJpgDblClick
136: *      eram codigo morto - metade da tela, sem um unico erro visivel.
137: *      A coluna eh char(29), logo TODO valor gravado tem 29 caracteres por
138: *      definicao do tipo e a chave de 15 nao casaria com registro nenhum
139: *      (conferido por amostragem nas 316 linhas de SigMvItn). Provado
140: *      contra a base apos o conserto: a chave montada para
141: *      ("001", "CONSERTO", 1) saiu byte a byte igual ao valor gravado
142: *      ("001CONSERTO                 1") e BuscarItensSubnivel passou a
143: *      devolver 1 item (cpros 036), enquanto a chave antiga devolve 0.
144: *      Detalhes em CLAUDE.md regra #42.
145: *
146: * FASE 8/8 CONCLUIDA.

*-- Linhas 461 a 670:
461:     * ConfigurarGradeSubniveis - Grade principal (Grade/TmpSubN do legado),
462:     * filha DIRETA do form (sem PageFrame/Page - form FLAT). ColumnCount,
463:     * larguras, InputMask e headers identicos ao SCX (SIGMVSBN.Grade).
464:     * Column*.ControlSource fica VAZIO propositalmente: o cursor
465:     * cursor_4c_Subniveis (equivalente a TmpSubN) ainda nao existe neste
466:     * ponto do Init - o legado tambem so atribui ControlSource dentro do
467:     * With ThisForm.Grade no final do proprio Init, depois de popular
468:     * TmpSubN (CLAUDE.md regra #41). O bind real fica para a Fase 7-8.
469:     *==========================================================================
470:     PROTECTED PROCEDURE ConfigurarGradeSubniveis()
471:         LOCAL loc_oGrid
472: 
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
483:             .ReadOnly     = .T.
484:             .RowHeight    = 16
485:             .ScrollBars   = 2
486:             .DeleteMark   = .F.
487:             .RecordMark   = .F.
488:             .GridLineColor = RGB(238, 238, 238)
489:             .Visible      = .T.
490:         ENDWITH
491: 
492:         *-- Column1: Emp (TmpSubN.Emps)
493:         WITH loc_oGrid.Column1
494:             .FontName      = "Tahoma"
495:             .FontSize      = 8
496:             .ColumnOrder   = 1
497:             .ControlSource = ""
498:             .Width         = 30
499:             .Movable       = .F.
500:             .Resizable     = .F.
501:             .ReadOnly      = .T.
502:             .Visible       = .T.
503:             .Header1.Alignment = 2
504:             .Header1.Caption   = "Emp"
505:         ENDWITH
506: 
507:         *-- Column2: Movimentacao (TmpSubN.Dopes)
508:         WITH loc_oGrid.Column2
509:             .FontName      = "Tahoma"
510:             .FontSize      = 8
511:             .ColumnOrder   = 2
512:             .ControlSource = ""
513:             .Width         = 130
514:             .Movable       = .F.
515:             .Resizable     = .F.
516:             .ReadOnly      = .T.
517:             .Visible       = .T.
518:             .Header1.Alignment = 2
519:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
520:         ENDWITH
521: 
522:         *-- Column3: Codigo (TmpSubN.Numes)
523:         WITH loc_oGrid.Column3
524:             .FontName      = "Tahoma"
525:             .FontSize      = 8
526:             .ColumnOrder   = 3
527:             .ControlSource = ""
528:             .Width         = 65
529:             .Movable       = .F.
530:             .Resizable     = .F.
531:             .ReadOnly      = .T.
532:             .Visible       = .T.
533:             .InputMask     = "999999"
534:             .Header1.Alignment = 2
535:             .Header1.Caption   = "C" + CHR(243) + "digo"
536:         ENDWITH
537: 
538:         *-- Column4: Data (TmpSubN.Datas)
539:         WITH loc_oGrid.Column4
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .ColumnOrder   = 4
543:             .ControlSource = ""
544:             .Width         = 60
545:             .Movable       = .F.
546:             .Resizable     = .F.
547:             .ReadOnly      = .T.
548:             .Visible       = .T.
549:             .Header1.Alignment = 2
550:             .Header1.Caption   = "Data"
551:         ENDWITH
552: 
553:         *-- Column5: Documento (TmpSubN.Notas)
554:         WITH loc_oGrid.Column5
555:             .FontName      = "Tahoma"
556:             .FontSize      = 8
557:             .ColumnOrder   = 5
558:             .ControlSource = ""
559:             .Width         = 65
560:             .Movable       = .F.
561:             .Resizable     = .F.
562:             .ReadOnly      = .T.
563:             .Visible       = .T.
564:             .Header1.Alignment = 2
565:             .Header1.Caption   = "Documento"
566:         ENDWITH
567: 
568:         *-- Column6: Usuario (TmpSubN.Usuars)
569:         WITH loc_oGrid.Column6
570:             .FontName      = "Tahoma"
571:             .FontSize      = 8
572:             .ColumnOrder   = 6
573:             .ControlSource = ""
574:             .Width         = 65
575:             .Movable       = .F.
576:             .Resizable     = .F.
577:             .ReadOnly      = .T.
578:             .Visible       = .T.
579:             .Header1.Alignment = 2
580:             .Header1.Caption   = "Usu" + CHR(225) + "rio"
581:         ENDWITH
582: 
583:         *-- Column7: Prazo de Entrega (TmpSubN.PrazoEnts)
584:         WITH loc_oGrid.Column7
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .ColumnOrder   = 7
588:             .ControlSource = ""
589:             .Width         = 60
590:             .Movable       = .F.
591:             .Resizable     = .F.
592:             .ReadOnly      = .T.
593:             .Visible       = .T.
594:             .Header1.Alignment = 2
595:             .Header1.Caption   = "Prz. Entrega"
596:         ENDWITH
597: 
598:         *-- Column8: Status (TmpSubN.Pstatus + "-" + TmpSubN.Descs)
599:         WITH loc_oGrid.Column8
600:             .FontName      = "Tahoma"
601:             .FontSize      = 8
602:             .ColumnOrder   = 8
603:             .ControlSource = ""
604:             .Width         = 150
605:             .Movable       = .F.
606:             .Resizable     = .F.
607:             .ReadOnly      = .T.
608:             .Visible       = .T.
609:             .Header1.Alignment = 2
610:             .Header1.Caption   = "Status"
611:         ENDWITH
612: 
613:         *-- Legado: evento nativo do Grade (AfterRowColChange) - aqui via
614:         *-- BINDEVENT porque o grid nasce por AddObject. Handler PUBLIC e
615:         *-- com o parametro do evento (CLAUDE.md #3).
616:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
617:     ENDPROC
618: 
619:     *==========================================================================
620:     * ConfigurarGradeItens - Grade de itens do subnivel selecionado
621:     * (fwgrade/crTpmMvItnSubn do legado), filha DIRETA do form. Larguras,
622:     * ColumnOrder, InputMask e headers identicos ao SCX (SIGMVSBN.fwgrade).
623:     * Assim como na grade principal, Column*.ControlSource fica VAZIO -
624:     * o legado so preenche dentro de Grade.AfterRowColChange, depois de
625:     * popular crTpmMvItnSubn com o subnivel clicado (Fase 7-8 aqui).
626:     *==========================================================================
627:     PROTECTED PROCEDURE ConfigurarGradeItens()
628:         LOCAL loc_oGrid
629: 
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
640:             .AllowHeaderSizing = .F.
641:             .ReadOnly          = .T.
642:             .RowHeight         = 16
643:             .ScrollBars        = 2
644:             .DeleteMark        = .F.
645:             .RecordMark        = .F.
646:             .GridLineColor     = RGB(238, 238, 238)
647:             .Visible           = .T.
648:         ENDWITH
649: 
650:         *-- Column1 (ordem visual 2): Produto (crTpmMvItnSubn.cpros)
651:         WITH loc_oGrid.Column1
652:             .FontName      = "Tahoma"
653:             .FontSize      = 8
654:             .ColumnOrder   = 2
655:             .ControlSource = ""
656:             .Width         = 140
657:             .Movable       = .F.
658:             .Resizable     = .F.
659:             .ReadOnly      = .T.
660:             .Visible       = .T.
661:             .ForeColor     = RGB(0, 0, 0)
662:             .Header1.Alignment = 2
663:             .Header1.Caption   = "Produto"
664:             .Header1.ForeColor = RGB(90, 90, 90)
665:             .Text1.BorderStyle = 0
666:             .Text1.Format      = "K!"
667:             .Text1.InputMask   = REPLICATE("!", 14)
668:             .Text1.Margin      = 0
669:             .Text1.MaxLength   = 10
670:             .Text1.ReadOnly    = .T.

*-- Linhas 677 a 860:
677:             .FontName      = "Tahoma"
678:             .FontSize      = 8
679:             .ColumnOrder   = 6
680:             .ControlSource = ""
681:             .Width         = 100
682:             .Movable       = .F.
683:             .Resizable     = .F.
684:             .ReadOnly      = .T.
685:             .Visible       = .T.
686:             .Header1.Alignment = 2
687:             .Header1.Caption   = "Fator"
688:             .Header1.ForeColor = RGB(90, 90, 90)
689:             .Text1.BorderStyle = 0
690:             .Text1.InputMask   = "9999.999"
691:             .Text1.Margin      = 0
692:             .Text1.ReadOnly    = .T.
693:             .Text1.ForeColor   = RGB(0, 0, 0)
694:             .Text1.BackColor   = RGB(255, 255, 255)
695:         ENDWITH
696: 
697:         *-- Column3 (ordem visual 3): Operacao (crTpmMvItnSubn.opers)
698:         WITH loc_oGrid.Column3
699:             .FontName      = "Tahoma"
700:             .FontSize      = 8
701:             .ColumnOrder   = 3
702:             .ControlSource = ""
703:             .Width         = 20
704:             .Movable       = .F.
705:             .Resizable     = .F.
706:             .ReadOnly      = .T.
707:             .Visible       = .T.
708:             .Header1.Alignment = 2
709:             .Header1.Caption   = "Op"
710:             .Header1.ForeColor = RGB(90, 90, 90)
711:             .Text1.Alignment   = 2
712:             .Text1.BorderStyle = 0
713:             .Text1.Margin      = 0
714:             .Text1.MaxLength   = 1
715:             .Text1.ReadOnly    = .T.
716:         ENDWITH
717: 
718:         *-- Column4 (ordem visual 4): Qtd (crTpmMvItnSubn.qtds)
719:         WITH loc_oGrid.Column4
720:             .FontName      = "Tahoma"
721:             .FontSize      = 8
722:             .ColumnOrder   = 4
723:             .ControlSource = ""
724:             .Width         = 100
725:             .Movable       = .F.
726:             .Resizable     = .F.
727:             .ReadOnly      = .T.
728:             .Visible       = .T.
729:             .Header1.Alignment = 2
730:             .Header1.Caption   = "Qtd."
731:             .Header1.ForeColor = RGB(90, 90, 90)
732:             .Text1.BorderStyle = 0
733:             .Text1.InputMask   = "99999.99"
734:             .Text1.Margin      = 0
735:             .Text1.ReadOnly    = .T.
736:         ENDWITH
737: 
738:         *-- Column5 (ordem visual 5): Peso (crTpmMvItnSubn.pesos)
739:         WITH loc_oGrid.Column5
740:             .FontName      = "Tahoma"
741:             .FontSize      = 8
742:             .ColumnOrder   = 5
743:             .ControlSource = ""
744:             .Width         = 100
745:             .Movable       = .F.
746:             .Resizable     = .F.
747:             .ReadOnly      = .T.
748:             .Visible       = .T.
749:             .Header1.Alignment = 2
750:             .Header1.Caption   = "Peso (gr)"
751:             .Header1.ForeColor = RGB(90, 90, 90)
752:             .Text1.BorderStyle = 0
753:             .Text1.InputMask   = "99999.99"
754:             .Text1.Margin      = 0
755:             .Text1.ReadOnly    = .T.
756:         ENDWITH
757: 
758:         *-- Column6 (ordem visual 8): Valor (crTpmMvItnSubn.units)
759:         WITH loc_oGrid.Column6
760:             .FontName      = "Tahoma"
761:             .FontSize      = 8
762:             .ColumnOrder   = 8
763:             .ControlSource = ""
764:             .Width         = 120
765:             .Movable       = .F.
766:             .Resizable     = .F.
767:             .ReadOnly      = .T.
768:             .Visible       = .T.
769:             .InputMask     = "99,999,999.99"
770:             .Header1.Alignment = 2
771:             .Header1.Caption   = "Valor"
772:             .Header1.ForeColor = RGB(90, 90, 90)
773:             .Text1.BorderStyle = 0
774:             .Text1.InputMask   = "99,999,999.99"
775:             .Text1.Margin      = 0
776:             .Text1.ReadOnly    = .T.
777:         ENDWITH
778: 
779:         *-- Column7 (ordem visual 9): Moeda (crTpmMvItnSubn.moedas)
780:         WITH loc_oGrid.Column7
781:             .FontName      = "Tahoma"
782:             .FontSize      = 8
783:             .ColumnOrder   = 9
784:             .ControlSource = ""
785:             .Width         = 33
786:             .Movable       = .F.
787:             .Resizable     = .F.
788:             .ReadOnly      = .T.
789:             .Visible       = .T.
790:             .Header1.Alignment = 2
791:             .Header1.Caption   = "Moe"
792:             .Header1.ForeColor = RGB(90, 90, 90)
793:             .Text1.BorderStyle = 0
794:             .Text1.Margin      = 0
795:             .Text1.ReadOnly    = .T.
796:         ENDWITH
797: 
798:         *-- Column8 (ordem visual 10): Total (crTpmMvItnSubn.totas)
799:         WITH loc_oGrid.Column8
800:             .FontName      = "Tahoma"
801:             .FontSize      = 8
802:             .ColumnOrder   = 10
803:             .ControlSource = ""
804:             .Width         = 185
805:             .Movable       = .F.
806:             .Resizable     = .F.
807:             .ReadOnly      = .T.
808:             .Visible       = .T.
809:             .InputMask     = "999,999,999.99"
810:             .Header1.Alignment = 2
811:             .Header1.Caption   = "Total"
812:             .Header1.ForeColor = RGB(90, 90, 90)
813:             .Text1.Alignment   = 3
814:             .Text1.BorderStyle = 0
815:             .Text1.InputMask   = "999,999,999.99"
816:             .Text1.Margin      = 0
817:             .Text1.ReadOnly    = .T.
818:         ENDWITH
819: 
820:         *-- Column9 (ordem visual 7): Total Peso (crTpmMvItnSubn.tpesos)
821:         WITH loc_oGrid.Column9
822:             .FontName      = "Tahoma"
823:             .FontSize      = 8
824:             .ColumnOrder   = 7
825:             .ControlSource = ""
826:             .Width         = 100
827:             .Movable       = .F.
828:             .Resizable     = .F.
829:             .ReadOnly      = .T.
830:             .Visible       = .T.
831:             .Header1.Alignment = 2
832:             .Header1.Caption   = "Total Peso"
833:             .Header1.ForeColor = RGB(90, 90, 90)
834:             .Text1.BorderStyle = 0
835:             .Text1.InputMask   = "999,999.99"
836:             .Text1.Margin      = 0
837:             .Text1.ReadOnly    = .T.
838:         ENDWITH
839: 
840:         *-- Column10 (ordem visual 1): Item (crTpmMvItnSubn.CItens)
841:         WITH loc_oGrid.Column10
842:             .FontName      = "Tahoma"
843:             .FontSize      = 8
844:             .ColumnOrder   = 1
845:             .ControlSource = ""
846:             .Width         = 45
847:             .Movable       = .F.
848:             .Resizable     = .F.
849:             .ReadOnly      = .T.
850:             .Visible       = .T.
851:             .InputMask     = "999"
852:             .Header1.Alignment = 2
853:             .Header1.Caption   = ""
854:             .Text1.Alignment   = 3
855:             .Text1.BorderStyle = 0
856:             .Text1.InputMask   = "999"
857:             .Text1.Margin      = 0
858:             .Text1.ReadOnly    = .T.
859:         ENDWITH
860: 

*-- Linhas 1052 a 1070:
1052:     * vincula a grade principal e desabilita o form pai.
1053:     *
1054:     * Ordem do bind obrigatoria (CLAUDE.md regra #41 / Problema 48):
1055:     * RecordSource -> ControlSource -> Width -> Header1.Caption. Atribuir
1056:     * RecordSource RESETA Width e Caption das colunas para o default, entao
1057:     * os valores do SCX sao reaplicados DEPOIS dele, nunca antes.
1058:     *==========================================================================
1059:     PROCEDURE CarregarLista()
1060:         LOCAL loc_lSucesso, loc_oGrid, loc_cCursor, loc_cMsg, loc_oErro, loc_oErroFoco
1061:         loc_lSucesso = .F.
1062: 
1063:         TRY
1064:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1065:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
1066:                         "FormSigMvSbn.CarregarLista")
1067:             ELSE
1068:                 IF !THIS.this_oBusinessObject.BuscarSubniveis(THIS.this_cEmps, ;
1069:                         THIS.this_cDopes, THIS.this_nNumes)
1070: 

*-- Linhas 1085 a 1119:
1085:                     *--            ThisForm.fwGrade.Visible = .f.
1086:                     THIS.grd_4c_Itens.Visible = !THIS.this_oBusinessObject.this_lOcultaPrs
1087: 
1088:                     SELECT (loc_cCursor)
1089:                     GO TOP
1090: 
1091:                     loc_oGrid = THIS.grd_4c_Subniveis
1092:                     WITH loc_oGrid
1093:                         .RecordSource = loc_cCursor
1094: 
1095:                         .Column1.ControlSource = loc_cCursor + ".Emps"
1096:                         .Column2.ControlSource = loc_cCursor + ".Dopes"
1097:                         .Column3.ControlSource = loc_cCursor + ".Numes"
1098:                         .Column4.ControlSource = loc_cCursor + ".Datas"
1099:                         .Column5.ControlSource = loc_cCursor + ".Notas"
1100:                         .Column6.ControlSource = loc_cCursor + ".Usuars"
1101:                         .Column7.ControlSource = loc_cCursor + ".PrazoEnts"
1102:                         *-- Coluna de EXPRESSAO, igual ao legado
1103:                         *-- ('TmpSubN.Pstatus + [-] + TmpSubN.Descs')
1104:                         .Column8.ControlSource = loc_cCursor + ".Pstatus + [-] + " + ;
1105:                                                  loc_cCursor + ".Descs"
1106: 
1107:                         *-- Width e Header DEPOIS do RecordSource, que os reseta
1108:                         .Column1.Width = 30
1109:                         .Column2.Width = 130
1110:                         .Column3.Width = 65
1111:                         .Column4.Width = 60
1112:                         .Column5.Width = 65
1113:                         .Column6.Width = 65
1114:                         .Column7.Width = 60
1115:                         .Column8.Width = 150
1116: 
1117:                         .Column1.Header1.Caption = "Emp"
1118:                         .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1119:                         .Column3.Header1.Caption = "C" + CHR(243) + "digo"

*-- Linhas 1250 a 1272:
1250:     * CarregarGradeItens - Popula grd_4c_Itens com os itens (SigMvItn) do
1251:     * subnivel cuja chave EmpDopNums foi passada (BO.BuscarItensSubnivel) e
1252:     * carrega a imagem/descricao do produto do PRIMEIRO item (equivalente ao
1253:     * "Select crTpmMvItnSubn / Go Top" seguido da consulta SigCdPro/SigCdGrp
1254:     * em Grade.AfterRowColChange do legado).
1255:     *
1256:     * Ordem do bind obrigatoria (CLAUDE.md regra #41 / Problema 48):
1257:     * RecordSource -> ControlSource -> Width/InputMask -> Header1.Caption -
1258:     * atribuir RecordSource RESETA os tres ultimos, por isso reaplicados
1259:     * DEPOIS dele, nunca antes (mesmo padrao de CarregarLista).
1260:     *==========================================================================
1261:     PROCEDURE CarregarGradeItens(par_cChave)
1262:         LOCAL loc_oGrid, loc_cCursor, loc_cProduto
1263: 
1264:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1265:             RETURN
1266:         ENDIF
1267: 
1268:         IF !THIS.this_oBusinessObject.BuscarItensSubnivel(par_cChave)
1269:             *-- Sem itens para o subnivel: grade fica vazia e os campos de
1270:             *-- produto sao limpos - o legado nao interrompe a tela por isso.
1271:             IF USED(THIS.this_oBusinessObject.this_cCursorItens)
1272:                 THIS.grd_4c_Itens.RecordSource = ""

*-- Linhas 1281 a 1308:
1281:         WITH loc_oGrid
1282:             .RecordSource = loc_cCursor
1283: 
1284:             .Column1.ControlSource  = loc_cCursor + ".cpros"
1285:             .Column2.ControlSource  = loc_cCursor + ".fators"
1286:             .Column3.ControlSource  = loc_cCursor + ".opers"
1287:             .Column4.ControlSource  = loc_cCursor + ".qtds"
1288:             .Column5.ControlSource  = loc_cCursor + ".pesos"
1289:             .Column6.ControlSource  = loc_cCursor + ".units"
1290:             .Column7.ControlSource  = loc_cCursor + ".moedas"
1291:             .Column8.ControlSource  = loc_cCursor + ".totas"
1292:             .Column9.ControlSource  = loc_cCursor + ".tpesos"
1293:             .Column10.ControlSource = loc_cCursor + ".CItens"
1294: 
1295:             *-- Width/InputMask/Header DEPOIS do RecordSource, que os reseta
1296:             .Column1.Width           = 140
1297:             .Column2.Width           = 100
1298:             .Column3.Width           = 20
1299:             .Column3.Text1.MaxLength = 1
1300:             .Column4.Width           = 100
1301:             .Column5.Width           = 100
1302:             .Column6.Width           = 120
1303:             .Column6.InputMask       = "99,999,999.99"
1304:             .Column6.Text1.InputMask = "99,999,999.99"
1305:             .Column7.Width           = 33
1306:             .Column8.Width           = 185
1307:             .Column8.InputMask       = "999,999,999.99"
1308:             .Column8.Text1.InputMask = "999,999,999.99"

*-- Linhas 1323 a 1341:
1323:             .Refresh()
1324:         ENDWITH
1325: 
1326:         SELECT (loc_cCursor)
1327:         GO TOP
1328: 
1329:         IF !EOF()
1330:             loc_cProduto = TratarNulo(EVALUATE(loc_cCursor + ".cpros"), "")
1331:             THIS.CarregarImagemProduto(loc_cProduto, .T.)
1332:         ELSE
1333:             THIS.LimparCamposProduto()
1334:         ENDIF
1335:     ENDPROC
1336: 
1337:     *==========================================================================
1338:     * ItensAfterRowColChange - SIGMVSBN.fwgrade.AfterRowColChange do legado:
1339:     * ao trocar de item dentro do subnivel, recarrega so a imagem/descricao
1340:     * do produto do item clicado (consulta enxuta, sem o grupo - CursorQuery
1341:     * do legado, equivalente a BO.BuscarImagemProdutoPorCodigo). PUBLIC

*-- Linhas 1479 a 1497:
1479:             loc_cArquivo = ""
1480:         ENDTRY
1481: 
1482:         *-- Legado: If File(lcArquivo) / Do Form SigOpZom With ... / Delete
1483:         *-- File (lcArquivo). Show() de form modal fica FORA de qualquer TRY
1484:         *-- (CLAUDE.md regra #29).
1485:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1486:             THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescProduto, loc_cGrupo, loc_cDescGrupo)
1487:             ERASE (loc_cArquivo)
1488:         ENDIF
1489: 
1490:         *-- Legado: If Thisform.fwgrade.Visible / Thisform.fwgrade.SetFocus
1491:         IF THIS.grd_4c_Itens.Visible
1492:             TRY
1493:                 THIS.grd_4c_Itens.SetFocus()
1494:             CATCH TO loc_oErro
1495:                 *-- foco indisponivel no momento: sem impacto para o usuario
1496:             ENDTRY
1497:         ENDIF


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

