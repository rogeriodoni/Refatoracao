# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERS, CESTOS, TOTAL, CIDQUERYS, DOPES, CPROS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
select xvalite
select crTpmMvItn
		Select xValIte
		If !Seek( _MoePeso )
			Insert into xValite ( Moeda ) Values ( _MoePeso )
		Select xValIte
		If !Seek( _MoePreco )
			Insert into xValite ( Moeda ) Values ( _MoePreco )
	Select crTpmMvIts
	If Seek(crTpmMvItn.CItens)
select xvalite
Delete For total = 0
Select xValIte
lcQueryTmpd  = [Select * From SigTempD Where CidQuerys = ?CidQuery3 ]
ThisForm.Get_Compensacao.ControlSource = 'TprMvCab.VCompensas'
	lcQuery = [Select * ] + ;
			    [From SigCdOpe ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdOpe]) < 1)
	Select CrSigTempD
	Select Cpros,Sum(Qtds) as Qtds From crTpmMvItn Group by Cpros Into cursor wEesti
	Select wEesti
		Select CrSigTempD
	If !ThisForm.Podatamgr.UpDate('CrSigTempD')
	lcQuery = [Select b.Mats as Codigos, sum(a.Qtds * b.Qtds) as Qtds, b.UniCompos, Sum(a.Qtds * b.QtsCons) as QtsCons From SigTempD a, SigPrCpo b ]+;
	If ThisForm.PoDatamgr.SqlExecute(lcQuery,'CsCompo') < 1
	lcDelete = [Delete From SigTempD Where CidQuerys = ?lcCidQuery3 ]
	If ThisForm.Podatamgr.SqlExecute(lcDelete,'') < 1
	Select CsCompo
			.Column1.ControlSource = 'csCompo.Codigos'
			.Column2.ControlSource = 'csCompo.Qtds'
			.Column3.ControlSource = 'csCompo.UniCompos'
			.Column4.ControlSource = 'csCompo.QtsCons'
	.Moeda.ControlSource = 'xValIte.Moeda'
	.Total.ControlSource = 'xValIte.Total'
Select crTpmMvItn
Select Cpros, Sum(Qtds) as Qtds From crTpmMvItn Where Not Empty(Cpros) Group by Cpros Into cursor ProEesti ReadWrite 
Select ProEesti
	.Produto.ControlSource = 'ProEesti.Cpros'
	.Total.ControlSource = 'ProEesti.Qtds'
Select Cpros+'-'+ALLTRIM(codtams) as cpros, Sum(Qtds) as Qtds From crTpmMvIts Where Not Empty(Cpros) Group by Cpros,Codtams Into cursor ProTam ReadWrite 
Select ProTam
	.Produto.ControlSource = 'ProTam.Cpros'
	.Total.ControlSource = 'ProTam.Qtds'
	Select xvalite
	Create Cursor xValServ From Array v01
	Select xValServ
	Select crTpmMvItn3
		Select xValServ
		If !Seek( _MoePreco )
			Insert into xValServ ( Moeda ) Values ( _MoePreco )
	select xvalServ
	Delete For total=0
		.Moeda.ControlSource = 'xValServ.Moeda'
		.Total.ControlSource = 'xValServ.Total'

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg) - TRECHOS RELEVANTES PARA PASS SQL (1575 linhas total):

*-- Linhas 71 a 112:
71: * com a PRIMEIRA metade do bloco de campos de total do dump (SECAO 2 -
72: * Label1/Get_TotQtde "Total Quantidade", Label2/Get_TotPeso "Total do Peso" e
73: * os indicadores de sinal Get_QOper/Get_POper, que ficam na MESMA linha dos
74: * dois primeiros, direto na form - no legado nenhum tem ControlSource: o
75: * proprio CalcTotais() escreve o valor via .Value (fase de eventos, ainda
76: * nao migrada). Valores (Top/Left/Width/Height/Format/ToolTipText) EXATOS do
77: * dump (PILAR 1). A segunda metade (Label3/Get_TotPesoC, Label4/
78: * Get_Compensacao, Label5/Get_mtcub e lblTotPes/getTotPes) entra na Fase 6.
79: *
80: * Fase 6/8 - Campos restantes (parte 2/2) e evento do unico campo editavel:
81: * completado ConfigurarCamposTotais() com a SEGUNDA metade do bloco de
82: * campos de total (Label3/txt_4c_TotPesoC "Total do Peso C", Label4/
83: * txt_4c_Compensacao "Peso Unitario C" - o UNICO campo editavel deste
84: * dialogo, Label5/txt_4c_Mtcub "TT Metro Cubico" - nasce Visible=.F. igual
85: * ao dump, so aparece quando SigOpTotBO.this_lMostrarMtCub fica .T. - e
86: * lblTotPes/txt_4c_TotPes, com o rotulo dinamico "Total <DocQtd2s> :"/
87: * "Total Peso :" que o BO calcula em PrepararRotuloTotalPeso). Nao ha
88: * lookup nenhum neste form (dialogo de totalizacao, sem FormBuscaAuxiliar -
89: * ver analise.json/mapeamento.json, secao "lookups" vazia): o unico campo
90: * nao somente-leitura e txt_4c_Compensacao, ligado via BINDEVENT "LostFocus"
91: * (regra CLAUDE.md - Valid nao dispara de forma confiavel em TextBox) ao
92: * metodo PUBLIC ValidarCompensacao(), que reproduz literalmente o
93: * PROCEDURE Valid de Get_Compensacao (linhas 1767-1779 do dump): grava o
94: * valor digitado no cursor COMPARTILHADO TprMvCab.VCompensas ANTES de
95: * chamar SigOpTotBO.ValidarCompensacao() - CalcularTotais() (chamado por
96: * ValidarCompensacao) le TprMvCab.VCompensas direto do cursor, igual ao
97: * legado (onde o ControlSource 'TprMvCab.VCompensas' escreve no cursor
98: * antes do Valid rodar) - se o valor for invalido (negativo), desfaz a
99: * gravacao no cursor e repoe o TextBox com o valor anterior, com
100: * MsgAviso("Valor de Compensacao Invalido") no lugar do MessageBox cru do
101: * legado. RebindCamposTotais() (chamado ao fim de CarregarLista() e de
102: * ValidarCompensacao(), sempre depois que o BO recalculou) espelha nos
103: * controles os totais do BO (this_nTotQtde/this_cQOper/this_nTotPeso/
104: * this_cPOper/this_nTotPesoC/this_nTotPes/this_cRotuloTotalPeso/
105: * this_lMostrarMtCub/this_nMtCub) e o valor corrente de
106: * TprMvCab.VCompensas, e decide o ReadOnly de txt_4c_Compensacao pelo MESMO
107: * criterio do When legado (InList(ParentForm.Op_Escolha,'INSERIR',
108: * 'ALTERAR')) - unica forma praticavel de reproduzir When via BINDEVENT
109: * em TextBox (regra CLAUDE.md #3), e suficiente porque este dialogo e
110: * modal e Op_Escolha do form pai nao muda durante a vida dele.
111: *
112: * Fase 7/8 - Eventos principais: SIGOPTOT NAO tem Incluir/Alterar/Visualizar/

*-- Linhas 165 a 183:
165: *     legado e sempre CREATEOBJECT("SIGOPTOT", pform, datses) + Show(1)
166: *     disparado por um form de MOVIMENTO (TprMvCab), nunca por item de
167: *     menu (ver "Uso canonico" no topo deste arquivo). Adicionar um
168: *     DEFINE BAR/ON SELECTION BAR para abrir este dialogo isolado, sem
169: *     o form pai que fornece os cursores crSigCdOpe/TprMvCab/crTpmMvItn,
170: *     inventaria uma funcionalidade que o sistema legado nao tem (viola
171: *     PILAR 1) e abriria uma tela sem dados para somar. A integracao
172: *     real (o form de movimento chamando CREATEOBJECT("FormSigOpTot",
173: *     THISFORM, SET("Datasession")) + Show()) e responsabilidade da
174: *     migracao DAQUELE form de movimento, nao desta task. Pela mesma
175: *     razao, config.prg nao precisa de nenhum SET PROCEDURE novo: a
176: *     carga sob demanda (CLAUDE.md, secao "config.prg - Carga SOB
177: *     DEMANDA") ja resolve SigOpTotBO.prg/FormSigOpTot.prg pelo indice
178: *     de classes no momento em que o form pai fizer
179: *     CREATEOBJECT("FormSigOpTot", ...) - CREATEOBJECT literal dentro de
180: *     outro Form/BO nao exige edicao em config.prg.
181: *
182: * CONFERENCIA DE COMPLETUDE (comportamento.json, 24 metodos do dump):
183: * Init -> InicializarForm/ProcessarTotais; Procedure(calctotais) ->

*-- Linhas 401 a 496:
401:     * nasce ligada a um cursor PLACEHOLDER com a MESMA estrutura (e, para
402:     * xValIte/xValServ, o MESMO indice) que SigOpTotBO cria nos seus
403:     * metodos de carga - CarregarLista() (neste mesmo arquivo)
404:     * reconfigura ControlSource/Header/Width depois que o BO
405:     * processa os totais de verdade (regra "Grid RecordSource reseta
406:     * Header/Width" - FORMCOR_LICOES_APRENDIDAS Problema 2/48).
407:     *
408:     * Visibilidade inicial (igual ao legado antes de qualquer calculo):
409:     * grd_4c_TotalProdutos/grd_4c_Produto/grd_4c_ProdutoTam = .T.;
410:     * grd_4c_Servicos/grd_4c_Componentes/cnt_4c_CalculoCol = .F. (ligados
411:     * depois, so quando this_lTemServicos/this_lTemComponentes forem .T. -
412:     * cnt_4c_CalculoCol fica SEMPRE .F., ver cabecalho do arquivo).
413:     *--------------------------------------------------------------------------
414:     PROTECTED PROCEDURE ConfigurarGrades()
415:         LOCAL loc_oBO, loc_oErro
416:         loc_oBO = THIS.this_oBusinessObject
417: 
418:         TRY
419:             *-- Cursores placeholder - mesma estrutura dos cursores reais
420:             *-- que o BO cria (xValIte/xValServ com INDEX ON Moeda, igual a
421:             *-- CalcularTotais/MontarGradeServicos; ProEesti/ProTam/csCompo
422:             *-- sem indice, igual a MontarGradeProdutos/MontarGradeProdutoTam/
423:             *-- ProcessarComponentes).
424:             IF !USED(loc_oBO.this_cCursorValIte)
425:                 SET NULL ON
426:                 CREATE CURSOR (loc_oBO.this_cCursorValIte) (Moeda C(3), Total N(15,2))
427:                 SET NULL OFF
428:                 INDEX ON Moeda TAG Moeda
429:             ENDIF
430:             IF !USED(loc_oBO.this_cCursorValServ)
431:                 SET NULL ON
432:                 CREATE CURSOR (loc_oBO.this_cCursorValServ) (Moeda C(3), Total N(15,2))
433:                 SET NULL OFF
434:                 INDEX ON Moeda TAG Moeda
435:             ENDIF
436:             IF !USED(loc_oBO.this_cCursorProEesti)
437:                 SET NULL ON
438:                 CREATE CURSOR (loc_oBO.this_cCursorProEesti) (Cpros C(14), Qtds N(11,3))
439:                 SET NULL OFF
440:             ENDIF
441:             IF !USED(loc_oBO.this_cCursorProTam)
442:                 SET NULL ON
443:                 CREATE CURSOR (loc_oBO.this_cCursorProTam) (Cpros C(20), Qtds N(11,3))
444:                 SET NULL OFF
445:             ENDIF
446:             IF !USED(loc_oBO.this_cCursorCompo)
447:                 SET NULL ON
448:                 CREATE CURSOR (loc_oBO.this_cCursorCompo) (Codigos C(14), Qtds N(11,3), UniCompos C(3), QtsCons N(11,3))
449:                 SET NULL OFF
450:             ENDIF
451: 
452:             *-- grd_4c_TotalProdutos (legado: grade_total) - Total por moeda
453:             *-- dos PRODUTOS. Sempre visivel.
454:             THIS.AddObject("grd_4c_TotalProdutos", "Grid")
455:             WITH THIS.grd_4c_TotalProdutos
456:                 .Top          = 84
457:                 .Left         = 5
458:                 .Height       = 322
459:                 .FontName     = "Verdana"
460:                 .FontSize     = 8
461:                 .DeleteMark   = .F.
462:                 .RecordMark   = .F.
463:                 .ReadOnly     = .T.
464:                 .RowHeight    = 16
465:                 .ScrollBars   = 2
466:                 .GridLineColor = RGB(238, 238, 238)
467:                 .ColumnCount  = 2
468:                 .RecordSource = loc_oBO.this_cCursorValIte
469:                 .Column1.ControlSource = loc_oBO.this_cCursorValIte + ".Moeda"
470:                 .Column1.Movable  = .F.
471:                 .Column1.Resizable = .F.
472:                 .Column1.ReadOnly  = .T.
473:                 .Column1.Header1.FontName  = "Verdana"
474:                 .Column1.Header1.FontSize  = 8
475:                 .Column1.Header1.Alignment = 2
476:                 .Column1.Header1.Caption   = "Moeda"
477:                 .Column1.Text1.BorderStyle = 0
478:                 .Column1.Text1.Margin      = 0
479:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
480:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
481:                 .Column2.ControlSource = loc_oBO.this_cCursorValIte + ".Total"
482:                 .Column2.Movable  = .F.
483:                 .Column2.Resizable = .F.
484:                 .Column2.ReadOnly  = .T.
485:                 .Column2.InputMask = "999,999,999.99"
486:                 .Column2.Header1.FontName  = "Verdana"
487:                 .Column2.Header1.FontSize  = 8
488:                 .Column2.Header1.Alignment = 2
489:                 .Column2.Header1.Caption   = "Total dos Produtos"
490:                 .Column2.Text1.BorderStyle = 0
491:                 .Column2.Text1.Margin      = 0
492:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
493:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
494:                 .Column1.Width = 40
495:                 .Column2.Width = 135
496:                 .Width    = 208

*-- Linhas 506 a 544:
506:                 .Height       = 322
507:                 .FontName     = "Verdana"
508:                 .FontSize     = 8
509:                 .DeleteMark   = .F.
510:                 .RecordMark   = .F.
511:                 .ReadOnly     = .T.
512:                 .RowHeight    = 16
513:                 .ScrollBars   = 2
514:                 .GridLineColor = RGB(238, 238, 238)
515:                 .ColumnCount  = 2
516:                 .RecordSource = loc_oBO.this_cCursorProEesti
517:                 .Column1.ControlSource = loc_oBO.this_cCursorProEesti + ".Cpros"
518:                 .Column1.Movable  = .F.
519:                 .Column1.Resizable = .F.
520:                 .Column1.ReadOnly  = .T.
521:                 .Column1.Header1.FontName  = "Verdana"
522:                 .Column1.Header1.FontSize  = 8
523:                 .Column1.Header1.Alignment = 2
524:                 .Column1.Header1.Caption   = "Produto"
525:                 .Column1.Text1.BorderStyle = 0
526:                 .Column1.Text1.Margin      = 0
527:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
528:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
529:                 .Column2.ControlSource = loc_oBO.this_cCursorProEesti + ".Qtds"
530:                 .Column2.Movable  = .F.
531:                 .Column2.Resizable = .F.
532:                 .Column2.ReadOnly  = .T.
533:                 .Column2.InputMask = "999,999,999.99"
534:                 .Column2.Header1.FontName  = "Verdana"
535:                 .Column2.Header1.FontSize  = 8
536:                 .Column2.Header1.Alignment = 2
537:                 .Column2.Header1.Caption   = "Total"
538:                 .Column2.Text1.BorderStyle = 0
539:                 .Column2.Text1.Margin      = 0
540:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
541:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
542:                 .Column1.Width = 125
543:                 .Column2.Width = 80
544:                 .Width    = 237

*-- Linhas 558 a 596:
558:                 .Height       = 322
559:                 .FontName     = "Verdana"
560:                 .FontSize     = 8
561:                 .DeleteMark   = .F.
562:                 .RecordMark   = .F.
563:                 .ReadOnly     = .T.
564:                 .RowHeight    = 16
565:                 .ScrollBars   = 2
566:                 .GridLineColor = RGB(238, 238, 238)
567:                 .ColumnCount  = 2
568:                 .RecordSource = loc_oBO.this_cCursorProTam
569:                 .Column1.ControlSource = loc_oBO.this_cCursorProTam + ".Cpros"
570:                 .Column1.Movable  = .F.
571:                 .Column1.Resizable = .F.
572:                 .Column1.ReadOnly  = .T.
573:                 .Column1.Header1.FontName  = "Verdana"
574:                 .Column1.Header1.FontSize  = 8
575:                 .Column1.Header1.Alignment = 2
576:                 .Column1.Header1.Caption   = "Produto + Tam"
577:                 .Column1.Text1.BorderStyle = 0
578:                 .Column1.Text1.Margin      = 0
579:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
580:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
581:                 .Column2.ControlSource = loc_oBO.this_cCursorProTam + ".Qtds"
582:                 .Column2.Movable  = .F.
583:                 .Column2.Resizable = .F.
584:                 .Column2.ReadOnly  = .T.
585:                 .Column2.InputMask = "999,999,999.99"
586:                 .Column2.Header1.FontName  = "Verdana"
587:                 .Column2.Header1.FontSize  = 8
588:                 .Column2.Header1.Alignment = 2
589:                 .Column2.Header1.Caption   = "Total"
590:                 .Column2.Text1.BorderStyle = 0
591:                 .Column2.Text1.Margin      = 0
592:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
593:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
594:                 .Column1.Width = 150
595:                 .Column2.Width = 45
596:                 .Width    = 227

*-- Linhas 608 a 646:
608:                 .Height       = 322
609:                 .FontName     = "Verdana"
610:                 .FontSize     = 8
611:                 .DeleteMark   = .F.
612:                 .RecordMark   = .F.
613:                 .ReadOnly     = .T.
614:                 .RowHeight    = 16
615:                 .ScrollBars   = 2
616:                 .GridLineColor = RGB(238, 238, 238)
617:                 .ColumnCount  = 2
618:                 .RecordSource = loc_oBO.this_cCursorValServ
619:                 .Column1.ControlSource = loc_oBO.this_cCursorValServ + ".Moeda"
620:                 .Column1.Movable  = .F.
621:                 .Column1.Resizable = .F.
622:                 .Column1.ReadOnly  = .T.
623:                 .Column1.Header1.FontName  = "Verdana"
624:                 .Column1.Header1.FontSize  = 8
625:                 .Column1.Header1.Alignment = 2
626:                 .Column1.Header1.Caption   = "Moeda"
627:                 .Column1.Text1.BorderStyle = 0
628:                 .Column1.Text1.Margin      = 0
629:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
630:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
631:                 .Column2.ControlSource = loc_oBO.this_cCursorValServ + ".Total"
632:                 .Column2.Movable  = .F.
633:                 .Column2.Resizable = .F.
634:                 .Column2.ReadOnly  = .T.
635:                 .Column2.InputMask = "999,999,999.99"
636:                 .Column2.Header1.FontName  = "Verdana"
637:                 .Column2.Header1.FontSize  = 8
638:                 .Column2.Header1.Alignment = 2
639:                 .Column2.Header1.Caption   = "Total dos Servi" + CHR(231) + "os"
640:                 .Column2.Text1.BorderStyle = 0
641:                 .Column2.Text1.Margin      = 0
642:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
643:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
644:                 .Column1.Width = 40
645:                 .Column2.Width = 135
646:                 .Width    = 208

*-- Linhas 657 a 718:
657:                 .Height       = 322
658:                 .FontName     = "Verdana"
659:                 .FontSize     = 8
660:                 .DeleteMark   = .F.
661:                 .RecordMark   = .F.
662:                 .ReadOnly     = .T.
663:                 .RowHeight    = 16
664:                 .ScrollBars   = 2
665:                 .GridLineColor = RGB(238, 238, 238)
666:                 .ColumnCount  = 4
667:                 .RecordSource = loc_oBO.this_cCursorCompo
668:                 .Column1.ControlSource = loc_oBO.this_cCursorCompo + ".Codigos"
669:                 .Column1.Movable  = .F.
670:                 .Column1.Resizable = .F.
671:                 .Column1.ReadOnly  = .T.
672:                 .Column1.Header1.FontName  = "Verdana"
673:                 .Column1.Header1.FontSize  = 8
674:                 .Column1.Header1.Alignment = 2
675:                 .Column1.Header1.Caption   = "Componente"
676:                 .Column1.Text1.BorderStyle = 0
677:                 .Column1.Text1.Margin      = 0
678:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
679:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
680:                 .Column2.ControlSource = loc_oBO.this_cCursorCompo + ".Qtds"
681:                 .Column2.Movable  = .F.
682:                 .Column2.Resizable = .F.
683:                 .Column2.ReadOnly  = .T.
684:                 .Column2.InputMask = "99,999,999.999"
685:                 .Column2.Header1.FontName  = "Verdana"
686:                 .Column2.Header1.FontSize  = 8
687:                 .Column2.Header1.Alignment = 2
688:                 .Column2.Header1.Caption   = "Quantidade"
689:                 .Column2.Text1.BorderStyle = 0
690:                 .Column2.Text1.Margin      = 0
691:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
692:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
693:                 .Column3.ControlSource = loc_oBO.this_cCursorCompo + ".UniCompos"
694:                 .Column3.ReadOnly  = .T.
695:                 .Column3.Header1.FontName  = "Verdana"
696:                 .Column3.Header1.FontSize  = 8
697:                 .Column3.Header1.Alignment = 2
698:                 .Column3.Header1.Caption   = "Unid."
699:                 .Column3.Text1.BorderStyle = 0
700:                 .Column3.Text1.Margin      = 0
701:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
702:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
703:                 .Column4.ControlSource = loc_oBO.this_cCursorCompo + ".QtsCons"
704:                 .Column4.Movable  = .F.
705:                 .Column4.Resizable = .F.
706:                 .Column4.ReadOnly  = .T.
707:                 .Column4.InputMask = "999999"
708:                 .Column4.Header1.FontName  = "Verdana"
709:                 .Column4.Header1.FontSize  = 8
710:                 .Column4.Header1.Alignment = 2
711:                 .Column4.Header1.Caption   = "Consumo"
712:                 .Column4.Text1.BorderStyle = 0
713:                 .Column4.Text1.Margin      = 0
714:                 .Column4.Text1.MaxLength   = 6
715:                 .Column4.Text1.ReadOnly    = .T.
716:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
717:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
718:                 .Column1.Width = 80

*-- Linhas 771 a 789:
771:                 .HeaderHeight = 17
772:                 .ReadOnly     = .T.
773:                 .ScrollBars   = 2
774:                 .DeleteMark   = .F.
775:                 .RecordMark   = .F.
776:                 .GridLineColor = RGB(238, 238, 238)
777:                 .ColumnCount  = 2
778:                 .Column1.Movable  = .F.
779:                 .Column1.Resizable = .F.
780:                 .Column1.ReadOnly  = .T.
781:                 .Column1.FontBold = .T.
782:                 .Column1.FontName = "Tahoma"
783:                 .Column1.Header1.FontBold  = .T.
784:                 .Column1.Header1.FontName  = "Tahoma"
785:                 .Column1.Header1.FontSize  = 8
786:                 .Column1.Header1.Alignment = 2
787:                 .Column1.Header1.Caption   = "Tipo"
788:                 .Column1.Text1.FontBold    = .T.
789:                 .Column1.Text1.FontName    = "Tahoma"

*-- Linhas 915 a 933:
915:     * lblTotPes/getTotPes (Total do Peso, com a legenda dinamica que o BO
916:     * monta em PrepararRotuloTotalPeso).
917:     *
918:     * Nenhum destes campos tem ControlSource no legado - CalcTotais()
919:     * escreve o valor calculado direto em .Value (.get_TotQtde.Value =
920:     * Abs(lnTotQtde), .Get_QOper.Value = Iif(...,'E','S')); por isso aqui so
921:     * se cria a estrutura visual com valor inicial neutro (0 para os
922:     * numericos, "" para os indicadores de sinal) - a logica de calculo
923:     * (CalcTotais) e os eventos que a disparam entram nas fases de eventos,
924:     * ainda nao migradas (ver cabecalho do arquivo).
925:     *
926:     * Formato de exibicao (regra CLAUDE.md #49): o dump declara estes campos
927:     * com ".Format = "999,999.999""/".Format = "999,999.99"" (nao
928:     * ".InputMask"), mas .Format em TextBox VFP9 so aceita codigos de letra
929:     * (K/!/T) - padrao de digito so tem efeito como .InputMask (e e assim
930:     * que o proprio dump trata o campo gemeo Get_mtcub, que usa
931:     * ".InputMask = "999,999.999""). Transcrito como .InputMask para
932:     * preservar o EFEITO visual (separador de milhar + decimais), que e o
933:     * que a fidelidade de UX (PILAR 1) exige.

*-- Linhas 1033 a 1051:
1033: 
1034:             *-- Label4/txt_4c_Compensacao ("Peso Unitario C :") - UNICO campo
1035:             *-- editavel do dialogo (dump: SEM .ReadOnly). Legado liga
1036:             *-- ControlSource = 'TprMvCab.VCompensas'; aqui o valor inicial e
1037:             *-- o ReadOnly definitivo (por modo) sao aplicados por
1038:             *-- RebindCamposTotais(), chamado ao fim de CarregarLista() - a
1039:             *-- escrita no cursor compartilhado so acontece de verdade no
1040:             *-- LostFocus (ValidarCompensacao).
1041:             THIS.AddObject("lbl_4c_Label4", "Label")
1042:             WITH THIS.lbl_4c_Label4
1043:                 .FontBold  = .T.
1044:                 .FontName  = "Tahoma"
1045:                 .FontSize  = 8
1046:                 .BackStyle = 0
1047:                 .AutoSize  = .F.
1048:                 .Alignment = 0
1049:                 .Caption   = "Peso Unit" + CHR(225) + "rio C :"
1050:                 .Height    = 15
1051:                 .Left      = 175

*-- Linhas 1208 a 1226:
1208:     * InList(ThisForm.ParentForm.Op_Escolha,'INSERIR','ALTERAR'), enquanto os
1209:     * outros 21 devolvem .F.) e o UNICO com PROCEDURE Valid.
1210:     *
1211:     * O ControlSource do legado ('TprMvCab.VCompensas') escreve o valor
1212:     * digitado no cursor ANTES do Valid rodar - e por isso que CalcTotais()
1213:     * (que le TprMvCab.VCompensas direto do cursor, nunca de uma copia)
1214:     * ja calcula com o valor novo. Aqui a mesma ordem e reproduzida
1215:     * explicitamente: grava no cursor PRIMEIRO, so depois chama
1216:     * SigOpTotBO.ValidarCompensacao() (que valida e aciona CalcularTotais).
1217:     * Falhando (valor negativo), desfaz a gravacao no cursor e repoe o
1218:     * TextBox - o rollback "This.Value = This.AntValue" do legado.
1219:     *
1220:     * Wrapper fino + ValidarCompensacaoExec(): o corpo tem RETURN antecipado
1221:     * (guardas de modo de teste e de cursor) e exibe MsgAviso, que e modal e
1222:     * devolve o foco ao sair, redisparando o proprio LostFocus. Com set no
1223:     * topo e clear no fim do CORPO, o primeiro RETURN antecipado deixaria a
1224:     * flag travada em .T. e MATARIA a validacao pelo resto da vida do form
1225:     * (regra CLAUDE.md #47).
1226:     *

*-- Linhas 1283 a 1301:
1283:     * secao de metro cubico (If CrSigOpCdd.MtCubs <> 0, linhas 1374-1378).
1284:     *
1285:     * Tambem reaplica o valor corrente de TprMvCab.VCompensas em
1286:     * txt_4c_Compensacao (equivalente ao ControlSource do legado) e decide
1287:     * o ReadOnly pelo MESMO criterio do When original (InList(ParentForm.
1288:     * Op_Escolha,'INSERIR','ALTERAR')) - unica forma praticavel de
1289:     * reproduzir When sem BINDEVENT confiavel em TextBox (regra CLAUDE.md
1290:     * #3), suficiente porque este dialogo e modal e Op_Escolha nao muda
1291:     * durante a vida dele.
1292:     *--------------------------------------------------------------------------
1293:     PROTECTED PROCEDURE RebindCamposTotais()
1294:         LOCAL loc_oBO, loc_cModoOperacao
1295:         loc_oBO = THIS.this_oBusinessObject
1296: 
1297:         THIS.txt_4c_TotQtde.Value    = loc_oBO.this_nTotQtde
1298:         THIS.txt_4c_QOper.Value      = loc_oBO.this_cQOper
1299:         THIS.txt_4c_TotPeso.Value    = loc_oBO.this_nTotPeso
1300:         THIS.txt_4c_POper.Value      = loc_oBO.this_cPOper
1301:         THIS.txt_4c_TotPesoC.Value   = loc_oBO.this_nTotPesoC

*-- Linhas 1386 a 1439:
1386:     ENDFUNC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * RebindGradeTotalProdutos - Reaplica RecordSource/ControlSource/
1390:     * Header/Width de grd_4c_TotalProdutos depois que SigOpTotBO.
1391:     * CalcularTotais() processou this_cCursorValIte (xValIte) de verdade.
1392:     * Sempre visivel (igual ao legado - Grade_Total.Visible = .t. no Init,
1393:     * sem nenhuma condicao).
1394:     *--------------------------------------------------------------------------
1395:     PROTECTED PROCEDURE RebindGradeTotalProdutos()
1396:         LOCAL loc_cCursor
1397:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorValIte
1398: 
1399:         WITH THIS.grd_4c_TotalProdutos
1400:             .RecordSource = loc_cCursor
1401:             .Column1.ControlSource = loc_cCursor + ".Moeda"
1402:             .Column2.ControlSource = loc_cCursor + ".Total"
1403:             .Column1.Header1.Caption = "Moeda"
1404:             .Column2.Header1.Caption = "Total dos Produtos"
1405:             .Column1.Width = 40
1406:             .Column2.Width = 135
1407:             .Visible = .T.
1408:             .Refresh()
1409:         ENDWITH
1410:     ENDPROC
1411: 
1412:     *--------------------------------------------------------------------------
1413:     * RebindGradeProduto - Reaplica RecordSource/ControlSource/Header/Width
1414:     * de grd_4c_Produto depois que SigOpTotBO.MontarGradeProdutos() recriou
1415:     * this_cCursorProEesti (ProEesti) de verdade. Sempre visivel.
1416:     *--------------------------------------------------------------------------
1417:     PROTECTED PROCEDURE RebindGradeProduto()
1418:         LOCAL loc_cCursor
1419:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorProEesti
1420: 
1421:         WITH THIS.grd_4c_Produto
1422:             .RecordSource = loc_cCursor
1423:             .Column1.ControlSource = loc_cCursor + ".Cpros"
1424:             .Column2.ControlSource = loc_cCursor + ".Qtds"
1425:             .Column1.Header1.Caption = "Produto"
1426:             .Column2.Header1.Caption = "Total"
1427:             .Column1.Width = 125
1428:             .Column2.Width = 80
1429:             .Visible = .T.
1430:             .Refresh()
1431:         ENDWITH
1432:     ENDPROC
1433: 
1434:     *--------------------------------------------------------------------------
1435:     * RebindGradesServicoOuTamanho - Reproduz a exclusao mutua do Init
1436:     * legado (linhas 1580-1587): grd_4c_Servicos e grd_4c_ProdutoTam ocupam
1437:     * a MESMA posicao na tela - com servicos (this_lTemServicos),
1438:     * grd_4c_Servicos aparece ligado a xValServ e grd_4c_ProdutoTam fica
1439:     * oculta; sem servicos, o inverso (grd_4c_ProdutoTam ligado a ProTam).

*-- Linhas 1446 a 1481:
1446: 
1447:             WITH THIS.grd_4c_Servicos
1448:                 .RecordSource = loc_cCursor
1449:                 .Column1.ControlSource = loc_cCursor + ".Moeda"
1450:                 .Column2.ControlSource = loc_cCursor + ".Total"
1451:                 .Column1.Header1.Caption = "Moeda"
1452:                 .Column2.Header1.Caption = "Total dos Servi" + CHR(231) + "os"
1453:                 .Column1.Width = 40
1454:                 .Column2.Width = 135
1455:                 .Visible = .T.
1456:                 .Refresh()
1457:             ENDWITH
1458: 
1459:             THIS.grd_4c_ProdutoTam.Visible = .F.
1460:         ELSE
1461:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorProTam
1462: 
1463:             WITH THIS.grd_4c_ProdutoTam
1464:                 .RecordSource = loc_cCursor
1465:                 .Column1.ControlSource = loc_cCursor + ".Cpros"
1466:                 .Column2.ControlSource = loc_cCursor + ".Qtds"
1467:                 .Column1.Header1.Caption = "Produto + Tam"
1468:                 .Column2.Header1.Caption = "Total"
1469:                 .Column1.Width = 150
1470:                 .Column2.Width = 45
1471:                 .Visible = .T.
1472:                 .Refresh()
1473:             ENDWITH
1474: 
1475:             THIS.grd_4c_Servicos.Visible = .F.
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *--------------------------------------------------------------------------
1480:     * RebindGradeComponentes - Reproduz "If Not llTemCompo / GrdTCompo.
1481:     * Visible = .f. / EndIf" do Init legado (linha 1589-1591): so aparece

*-- Linhas 1489 a 1510:
1489:         IF THIS.this_oBusinessObject.this_lTemComponentes
1490:             WITH THIS.grd_4c_Componentes
1491:                 .RecordSource = loc_cCursor
1492:                 .Column1.ControlSource = loc_cCursor + ".Codigos"
1493:                 .Column2.ControlSource = loc_cCursor + ".Qtds"
1494:                 .Column3.ControlSource = loc_cCursor + ".UniCompos"
1495:                 .Column4.ControlSource = loc_cCursor + ".QtsCons"
1496:                 .Column1.Header1.Caption = "Componente"
1497:                 .Column2.Header1.Caption = "Quantidade"
1498:                 .Column3.Header1.Caption = "Unid."
1499:                 .Column4.Header1.Caption = "Consumo"
1500:                 .Column1.Width = 80
1501:                 .Column2.Width = 80
1502:                 .Column3.Width = 30
1503:                 .Column4.Width = 60
1504:                 .Visible = .T.
1505:                 .Refresh()
1506:             ENDWITH
1507:         ELSE
1508:             THIS.grd_4c_Componentes.Visible = .F.
1509:         ENDIF
1510:     ENDPROC

