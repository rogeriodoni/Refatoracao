# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '12713983' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NTRANS

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
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  DeleteMark = .F.
  ControlSource = "tmpDistrib.cdescs"
Select xNensi
Select xNensi
	Insert Into TmpDistrib (Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, CGrus, Qtds, Pesos, nLotes, Peso2s, ;
Select Cmats, Cunis, CuniPs, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos, Sum(Peso2s) as Peso2s From xNensi Where Visivel Group By Cmats, Cunis, CuniPs Into Cursor TmpResumo
Select TmpResumo
	.Column1.ControlSource   = 'TmpResumo.Cmats'
	.Column2.ControlSource   = 'TmpResumo.Qtds'
	.Column3.ControlSource   = 'TmpResumo.CUnis'
	.Column4.ControlSource   = 'TmpResumo.Peso2s'
	.Column5.ControlSource   = 'TmpResumo.CUniPs'
	.Column6.ControlSource   = 'TmpResumo.Pesos'
Select TmpDistrib
	.Column1.ControlSource   = 'TmpDistrib.NOps'
	.Column2.ControlSource   = 'TmpDistrib.cMats'
	.Column4.ControlSource   = 'TmpDistrib.CUnis'
	.Column6.ControlSource   = 'TmpDistrib.CDescs'
	.Column5.ControlSource   = 'TmpDistrib.Qtds'
	.Column3.ControlSource   = 'TmpDistrib.Pesos'
	.Column7.ControlSource   = 'TmpDistrib.nLotes'
	.Column8.ControlSource   = 'TmpDistrib.Peso2s'
	.Column9.ControlSource   = 'TmpDistrib.cUniPs'
	.Column10.ControlSource   = 'TmpDistrib.CodCors'
	.Column11.ControlSource   = 'TmpDistrib.CodTams'
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
Select TmpDistrib
	Select TmpDistrib 
			Select xNensi
Select xNensi
Select xNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1064 linhas total):

*-- Linhas 240 a 292:
240:                 .Width         = 36
241:                 .Height        = 23
242:                 .ReadOnly      = .T.
243:                 .ControlSource = "tmpnens.emps"
244:                 .FontName      = "Tahoma"
245:                 .FontSize      = 8
246:                 .ForeColor     = RGB(0, 0, 0)
247:                 .BackColor     = RGB(255, 255, 255)
248:                 .BorderStyle   = 1
249:                 .Themes        = .F.
250:                 .Visible       = .T.
251:             ENDWITH
252: 
253:             .AddObject("txt_4c_Operacao", "TextBox")
254:             WITH .txt_4c_Operacao
255:                 .Left          = 114
256:                 .Top           = 9
257:                 .Width         = 156
258:                 .Height        = 23
259:                 .ReadOnly      = .T.
260:                 .ControlSource = "tmpnens.dopps"
261:                 .FontName      = "Tahoma"
262:                 .FontSize      = 8
263:                 .ForeColor     = RGB(0, 0, 0)
264:                 .BackColor     = RGB(255, 255, 255)
265:                 .BorderStyle   = 1
266:                 .Themes        = .F.
267:                 .Visible       = .T.
268:             ENDWITH
269: 
270:             .AddObject("txt_4c_Codigo", "TextBox")
271:             WITH .txt_4c_Codigo
272:                 .Left          = 272
273:                 .Top           = 9
274:                 .Width         = 81
275:                 .Height        = 23
276:                 .ReadOnly      = .T.
277:                 .ControlSource = "tmpnens.numps"
278:                 .InputMask     = "9999999999"
279:                 .Alignment     = 3
280:                 .FontName      = "Tahoma"
281:                 .FontSize      = 8
282:                 .ForeColor     = RGB(0, 0, 0)
283:                 .BackColor     = RGB(255, 255, 255)
284:                 .BorderStyle   = 1
285:                 .Themes        = .F.
286:                 .Visible       = .T.
287:             ENDWITH
288:         ENDWITH
289:     ENDPROC
290: 
291:     *==========================================================================
292:     * TornarControlesVisiveis - Torna controles visiveis recursivamente

*-- Linhas 383 a 552:
383:             .ColumnCount = 11
384:             .RecordSource = "cursor_4c_Distrib"
385:             .RecordMark  = .F.
386:             .DeleteMark  = .F.
387:             .ReadOnly    = .F.
388:             .ScrollBars  = 2
389:             .GridLines   = 1
390:             .RowHeight   = 16
391:             .FontName    = "Verdana"
392:             .FontSize    = 8
393:             .Themes      = .F.
394: 
395:             *-- ColumnOrder replica a ordem visual do original (SCX usava ColumnOrder para rearranjar)
396:             *-- Visual: Industrializacao | Componente | Descricao | Cor | Tam. | Unid. | Qtde(1) | Unid.(2) | Qtde(2) | Peso Fabr. | Lote
397: 
398:             WITH .Column1
399:                 .ColumnOrder   = 1
400:                 .Width         = 83
401:                 .ReadOnly      = .T.
402:                 .ControlSource = "cursor_4c_Distrib.Nops"
403:                 .FontName      = "Courier New"
404:                 .FontSize      = 9
405:                 .InputMask     = "9999999999"
406:                 .Alignment     = 3
407:                 .Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
408:                 .Header1.FontName = "Tahoma"
409:                 .Header1.FontSize = 9
410:                 .Header1.Alignment = 2
411:             ENDWITH
412: 
413:             WITH .Column2
414:                 .ColumnOrder   = 2
415:                 .Width         = 100
416:                 .ReadOnly      = .T.
417:                 .ControlSource = "cursor_4c_Distrib.CMats"
418:                 .Header1.Caption = "Componente"
419:                 .Header1.FontName = "Tahoma"
420:                 .Header1.FontSize = 9
421:                 .Header1.Alignment = 2
422:             ENDWITH
423: 
424:             WITH .Column3
425:                 .ColumnOrder   = 10
426:                 .Width         = 80
427:                 .ReadOnly      = .T.
428:                 .ControlSource = "cursor_4c_Distrib.Pesos"
429:                 .Header1.Caption = "Peso Fabr."
430:                 .Header1.FontName = "Tahoma"
431:                 .Header1.FontSize = 9
432:                 .Header1.Alignment = 2
433:             ENDWITH
434: 
435:             WITH .Column4
436:                 .ColumnOrder   = 6
437:                 .Width         = 31
438:                 .ReadOnly      = .T.
439:                 .ControlSource = "cursor_4c_Distrib.CUnis"
440:                 .Header1.Caption = "Unid."
441:                 .Header1.FontName = "Tahoma"
442:                 .Header1.FontSize = 9
443:                 .Header1.Alignment = 2
444:             ENDWITH
445: 
446:             WITH .Column5
447:                 .ColumnOrder   = 7
448:                 .Width         = 80
449:                 .ReadOnly      = .T.
450:                 .ControlSource = "cursor_4c_Distrib.Qtds"
451:                 .Header1.Caption = "Qtde (1)"
452:                 .Header1.FontName = "Tahoma"
453:                 .Header1.FontSize = 9
454:                 .Header1.Alignment = 2
455:             ENDWITH
456: 
457:             WITH .Column6
458:                 .ColumnOrder   = 3
459:                 .Width         = 50
460:                 .ReadOnly      = .T.
461:                 .ControlSource = "cursor_4c_Distrib.CDescs"
462:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
463:                 .Header1.FontName = "Tahoma"
464:                 .Header1.FontSize = 9
465:                 .Header1.Alignment = 2
466:             ENDWITH
467: 
468:             WITH .Column7
469:                 .ColumnOrder   = 11
470:                 .Width         = 80
471:                 .ReadOnly      = .T.
472:                 .ControlSource = "cursor_4c_Distrib.nLotes"
473:                 .Header1.Caption = "Lote"
474:                 .Header1.FontName = "Tahoma"
475:                 .Header1.FontSize = 9
476:                 .Header1.Alignment = 2
477:             ENDWITH
478: 
479:             WITH .Column8
480:                 .ColumnOrder   = 9
481:                 .Width         = 70
482:                 .ReadOnly      = .T.
483:                 .ControlSource = "cursor_4c_Distrib.Peso2s"
484:                 .Header1.Caption = "Qtde (2)"
485:                 .Header1.FontName = "Tahoma"
486:                 .Header1.FontSize = 9
487:                 .Header1.Alignment = 2
488:             ENDWITH
489: 
490:             WITH .Column9
491:                 .ColumnOrder   = 8
492:                 .Width         = 31
493:                 .ReadOnly      = .T.
494:                 .ControlSource = "cursor_4c_Distrib.cUniPs"
495:                 .Header1.Caption = "Unid."
496:                 .Header1.FontName = "Tahoma"
497:                 .Header1.FontSize = 9
498:                 .Header1.Alignment = 2
499:             ENDWITH
500: 
501:             WITH .Column10
502:                 .ColumnOrder   = 4
503:                 .Width         = 38
504:                 .ReadOnly      = .T.
505:                 .ControlSource = "cursor_4c_Distrib.CodCors"
506:                 .Header1.Caption = "Cor"
507:                 .Header1.FontName = "Tahoma"
508:                 .Header1.FontSize = 9
509:                 .Header1.Alignment = 2
510:             ENDWITH
511: 
512:             WITH .Column11
513:                 .ColumnOrder   = 5
514:                 .Width         = 38
515:                 .ReadOnly      = .T.
516:                 .ControlSource = "cursor_4c_Distrib.CodTams"
517:                 .Header1.Caption = "Tam."
518:                 .Header1.FontName = "Tahoma"
519:                 .Header1.FontSize = 9
520:                 .Header1.Alignment = 2
521:             ENDWITH
522: 
523:             .Visible = .T.
524:         ENDWITH
525: 
526:         *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
527:         THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Distrib.Nops"
528:         THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Distrib.CMats"
529:         THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Distrib.Pesos"
530:         THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Distrib.CUnis"
531:         THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Distrib.Qtds"
532:         THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Distrib.CDescs"
533:         THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Distrib.nLotes"
534:         THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Distrib.Peso2s"
535:         THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Distrib.cUniPs"
536:         THIS.grd_4c_Dados.Column10.ControlSource = "cursor_4c_Distrib.CodCors"
537:         THIS.grd_4c_Dados.Column11.ControlSource = "cursor_4c_Distrib.CodTams"
538: 
539:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
540:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
541:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
542:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
543:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
544:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
545:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
550:     * Exibe cursor_4c_Resumo: totais agrupados por componente
551:     *==========================================================================
552:     PROTECTED PROCEDURE ConfigurarGradeResumo()

*-- Linhas 560 a 653:
560:             .ColumnCount       = 6
561:             .RecordSource      = "cursor_4c_Resumo"
562:             .RecordMark        = .F.
563:             .DeleteMark        = .F.
564:             .ReadOnly          = .T.
565:             .ScrollBars        = 2
566:             .GridLines         = 1
567:             .RowHeight         = 16
568:             .HeaderHeight      = 16
569:             .AllowHeaderSizing = .F.
570:             .AllowRowSizing    = .F.
571:             .FontName          = "Verdana"
572:             .FontSize          = 8
573:             .Themes            = .F.
574: 
575:             WITH .Column1
576:                 .Width         = 108
577:                 .ControlSource = "cursor_4c_Resumo.CMats"
578:                 .Header1.Caption = "Componente"
579:                 .Header1.FontName = "Tahoma"
580:                 .Header1.FontSize = 8
581:                 .Header1.Alignment = 2
582:             ENDWITH
583: 
584:             WITH .Column2
585:                 .Width         = 80
586:                 .ControlSource = "cursor_4c_Resumo.Qtds"
587:                 .Header1.Caption = "Qtde (1)"
588:                 .Header1.FontName = "Tahoma"
589:                 .Header1.FontSize = 8
590:                 .Header1.Alignment = 2
591:             ENDWITH
592: 
593:             WITH .Column3
594:                 .Width         = 31
595:                 .ControlSource = "cursor_4c_Resumo.CUnis"
596:                 .Header1.Caption = "Unid."
597:                 .Header1.FontName = "Tahoma"
598:                 .Header1.FontSize = 8
599:                 .Header1.Alignment = 2
600:             ENDWITH
601: 
602:             WITH .Column4
603:                 .Width         = 80
604:                 .ControlSource = "cursor_4c_Resumo.Peso2s"
605:                 .Header1.Caption = "Qtde (2)"
606:                 .Header1.FontName = "Tahoma"
607:                 .Header1.FontSize = 8
608:                 .Header1.Alignment = 2
609:             ENDWITH
610: 
611:             WITH .Column5
612:                 .Width         = 31
613:                 .ControlSource = "cursor_4c_Resumo.CUniPs"
614:                 .Header1.Caption = "Unid."
615:                 .Header1.FontName = "Tahoma"
616:                 .Header1.FontSize = 8
617:                 .Header1.Alignment = 2
618:             ENDWITH
619: 
620:             WITH .Column6
621:                 .Width         = 80
622:                 .ControlSource = "cursor_4c_Resumo.Pesos"
623:                 .Header1.Caption = "Peso Fabr."
624:                 .Header1.FontName = "Tahoma"
625:                 .Header1.FontSize = 8
626:                 .Header1.Alignment = 2
627:             ENDWITH
628: 
629:             .Visible = .T.
630:         ENDWITH
631: 
632:         *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
633:         THIS.grd_4c_Resumo.Column1.ControlSource = "cursor_4c_Resumo.CMats"
634:         THIS.grd_4c_Resumo.Column2.ControlSource = "cursor_4c_Resumo.Qtds"
635:         THIS.grd_4c_Resumo.Column3.ControlSource = "cursor_4c_Resumo.CUnis"
636:         THIS.grd_4c_Resumo.Column4.ControlSource = "cursor_4c_Resumo.Peso2s"
637:         THIS.grd_4c_Resumo.Column5.ControlSource = "cursor_4c_Resumo.CUniPs"
638:         THIS.grd_4c_Resumo.Column6.ControlSource = "cursor_4c_Resumo.Pesos"
639:     ENDPROC
640: 
641:     *==========================================================================
642:     * ConfigurarCamposExtras - Label+TextBox descricao e TextBox total peso
643:     * Say2 "Descricao :" + Get_descr (descricao da linha corrente do grid)
644:     * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
645:     *==========================================================================
646:     PROTECTED PROCEDURE ConfigurarCamposExtras()
647:         THIS.AddObject("lbl_4c_Label2", "Label")
648:         WITH THIS.lbl_4c_Label2
649:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
650:             .Top       = 458
651:             .Left      = 71
652:             .FontName  = "Tahoma"
653:             .FontSize  = 8

*-- Linhas 663 a 681:
663:             .Width         = 335
664:             .Height        = 23
665:             .ReadOnly      = .T.
666:             .ControlSource = "cursor_4c_Distrib.CDescs"
667:             .FontName      = "Tahoma"
668:             .FontSize      = 8
669:             .BackColor     = RGB(240, 240, 240)
670:             .BorderStyle   = 1
671:             .Themes        = .F.
672:             .Visible       = .T.
673:         ENDWITH
674: 
675:         THIS.AddObject("txt_4c_TotPeso", "TextBox")
676:         WITH THIS.txt_4c_TotPeso
677:             .Top         = 454
678:             .Left        = 577
679:             .Width       = 81
680:             .Height      = 23
681:             .ReadOnly    = .T.

*-- Linhas 853 a 871:
853:         THIS.this_oBusinessObject.SalvarAlteracoes()
854: 
855:         IF USED("xNensi")
856:             SELECT xNensi
857:             SET ORDER TO Editar
858:             IF THIS.this_nRecnoAnt > 0
859:                 GO THIS.this_nRecnoAnt
860:             ENDIF
861:         ENDIF
862: 
863:         IF VARTYPE(THIS.this_oFormPai) = "O"
864:             THIS.this_oFormPai.Enabled = .T.
865:         ENDIF
866: 
867:         THIS.Release()
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * GrdDistribAfterRowColChange - Atualiza campo descricao ao mudar linha/col

*-- Linhas 1045 a 1063:
1045:     PROCEDURE BtnBuscarClick()
1046:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1047:             IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
1048:                 SELECT cursor_4c_Distrib
1049:                 GO TOP
1050:             ENDIF
1051:             THIS.grd_4c_Dados.Refresh()
1052:         ENDIF
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * Destroy - Libera BO e referencia ao form pai
1057:     *==========================================================================
1058:     PROCEDURE Destroy()
1059:         THIS.this_oBusinessObject = .NULL.
1060:         THIS.this_oFormPai        = .NULL.
1061:         DODEFAULT()
1062:     ENDPROC
1063: 


### BO (C:\4c\projeto\app\classes\SigPdMp1BO.prg):
*==============================================================================
* SIGPDMP1BO.PRG
* Business Object para Componentes Agregados (SIGPDMP1)
* Form operacional: exibe e permite edicao de componentes de uma operacao
* de industrializacao. Recebe cursor xNensi do form pai e trabalha
* com cursores locais cursor_4c_Distrib e cursor_4c_Resumo.
*==============================================================================

DEFINE CLASS SigPdMp1BO AS BusinessBase

    *-- Tabela e chave (form operacional sem CRUD direto na tabela principal)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Dados da operacao (vindos de tmpnens / xNensi do form pai)
    this_nNumPs  = 0    && Numero da operacao (tmpnens.numps)
    this_cEmps   = ""   && Empresa (tmpnens.emps)
    this_cDOpPs  = ""   && Descricao da operacao (tmpnens.dopps)
    this_cTitulo = ""   && Titulo da col. Industrializacao (ParentForm.ParentForm.Titulo)

    *-- Controle de edicao
    this_lLiberaAlteracao = .F.  && .T. quando usuario clica Alterar
    this_cEscolha         = ""   && "INSERIR" ou outro modo vindo do form pai

    *-- Posicao de navegacao em xNensi antes de abrir o form
    this_nRecnoAnt = 0

    *-- Totalizador de peso (soma de PsFaseAnt dos registros nao-visiveis)
    this_nTotPeso = 0

    *-- Valor anterior de celula em edicao no grid (controle de alteracao)
    this_nAntValue = 0

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO operacional de Componentes Agregados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumPs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor_4c_Distrib
    * Mapeia colunas da linha corrente do grid principal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumPs = TratarNulo(Nops,   "N")
            THIS.this_cEmps  = ALLTRIM(TratarNulo(CMats,  "C"))
            THIS.this_cDOpPs = ALLTRIM(TratarNulo(CDescs, "C"))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDistrib - Cria cursor_4c_Distrib a partir de xNensi
    * Equivale ao bloco de criacao do TmpDistrib no Init original.
    * Percorre xNensi na ordem NopCMat, incluindo apenas registros onde
    * Visivel = .F. (os que ainda nao foram distribuidos).
    * par_cTitulo: caption dinamico da coluna Industrializacao
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarDistrib(par_cTitulo)
        LOCAL loc_lSucesso, loc_nTotPeso, loc_nX, loc_nQtds, loc_nPesos
        loc_lSucesso = .F.
        loc_nTotPeso = 0
        loc_nX       = 1

        TRY
            THIS.this_cTitulo = par_cTitulo

            *-- Salva posicao corrente de xNensi para restaurar no OK
            SELECT xNensi
            THIS.this_nRecnoAnt = RECNO()

            *-- Recria cursor de distribuicao
            IF USED("cursor_4c_Distrib")
                USE IN cursor_4c_Distrib
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Distrib ( ;
                Nops    N(10,0), ;
                Nenvs   N(10,0), ;
                CodPds  C(10),   ;
                CMats   C(14),   ;
                CUnis   C(3),    ;
                Qtds    N(10,3), ;
                Pesos   N(10,3), ;
                Qtds2   N(10,3), ;
                Pesos2  N(10,3), ;
                CDescs  C(40),   ;
                CGrus   C(3),    ;
                TpOps   C(15),   ;
                nLotes  N(10,0), ;
                Qtd2s   N(10,3), ;
                Peso2s  N(10,3), ;
                cUniPs  C(3),    ;
                CodCors C(4),    ;
                CodTams C(4),    ;
                nTrans  N(6,0),  ;
                Locals  C(1)     ;
            )

            *-- Percorre xNensi em ordem NopCMat, pula visiveis (ja distribuidos)
            SELECT xNensi
            SET ORDER TO NopCMat
            SCAN
                IF xNensi.Visivel
                    LOOP
                ENDIF

                loc_nQtds  = xNensi.QtFaseAnt
                loc_nPesos = xNensi.PsFaseAnt

                REPLACE nTrans WITH loc_nX IN xNensi

                INSERT INTO cursor_4c_Distrib ( ;
                    Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, ;
                    CGrus, Qtds, Pesos, nLotes, Peso2s, cUniPs, ;
                    CodCors, CodTams, nTrans ;
                ) VALUES ( ;
                    xNensi.Nops, xNensi.Nenvs, loc_nQtds, loc_nPesos, ;
                    xNensi.CUnis, xNensi.CMats, xNensi.CDescs, ;
                    xNensi.CGrus, xNensi.Qtds, xNensi.Pesos, xNensi.nLotes, ;
                    xNensi.Peso2s, xNensi.cUniPs, xNensi.CodCors, ;
                    xNensi.CodTams, xNensi.nTrans ;
                )

                loc_nX       = loc_nX + 1
                loc_nTotPeso = loc_nTotPeso + loc_nPesos
            ENDSCAN

            THIS.this_nTotPeso = loc_nTotPeso

            SELECT cursor_4c_Distrib
            GO TOP
            SET NULL OFF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarResumo - Cria cursor_4c_Resumo com totais por componente
    * Replica SELECT...GROUP BY...INTO CURSOR TmpResumo do Init original.
    * Agrupa xNensi onde Visivel = .T. (registros ja distribuidos).
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarResumo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Resumo")
                USE IN cursor_4c_Resumo
            ENDIF

            SELECT CMats, CUnis, CUniPs,      ;
                   SUM(Qtds)   AS Qtds,       ;
                   SUM(Pesos)  AS Pesos,      ;
                   SUM(Peso2s) AS Peso2s      ;
            FROM xNensi                       ;
            WHERE xNensi.Visivel              ;
            GROUP BY CMats, CUnis, CUniPs     ;
            INTO CURSOR cursor_4c_Resumo READWRITE

            SELECT cursor_4c_Resumo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Grava linhas modificadas de cursor_4c_Distrib em xNensi
    * Replica logica do botao OK original.
    * So persiste quando this_lLiberaAlteracao = .T. (usuario clicou Alterar).
    * Identifica linhas modificadas pelo campo Locals = 'M'.
    * Atualiza Qtds, Pesos e Peso2s em xNensi via nTrans.
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF THIS.this_lLiberaAlteracao
                SELECT cursor_4c_Distrib
                SCAN
                    IF cursor_4c_Distrib.Locals = "M"
                        SELECT xNensi
                        LOCATE FOR nTrans = cursor_4c_Distrib.nTrans
                        IF !EOF()
                            REPLACE Qtds   WITH cursor_4c_Distrib.Qtds, ;
                                    Pesos  WITH cursor_4c_Distrib.Pesos, ;
                                    Peso2s WITH cursor_4c_Distrib.Peso2s
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * HabilitarAlteracao - Permite edicao nas colunas Pesos, Qtds e Peso2s
    * Define this_lLiberaAlteracao = .T. para que SalvarAlteracoes persista
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarAlteracao()
        THIS.this_lLiberaAlteracao = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarModificado - Marca registro corrente de cursor_4c_Distrib como 'M'
    * Chamado pelos handlers de Valid/KeyPress do grid ao detectar mudanca
    *--------------------------------------------------------------------------
    PROCEDURE MarcarModificado()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Distrib")
                REPLACE Locals WITH "M" IN cursor_4c_Distrib
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: form operacional nao insere registros no banco
    * A criacao inicial dos componentes ocorre via InicializarDistrib (cursor
    * em memoria) e a persistencia eh feita em xNensi pelo form pai (SigPdMov)
    * no momento do salvamento global da operacao.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persiste alteracoes do cursor_4c_Distrib em xNensi
    * Equivale ao "OK Click" do form original: percorre linhas marcadas como
    * 'M' (modificadas) e replica Qtds/Pesos/Peso2s para o cursor pai xNensi
    * via campo nTrans. Form operacional nao executa UPDATE direto no banco;
    * a gravacao em SigPdNen ocorre pelo form SigPdMov que mantem xNensi.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SalvarAlteracoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: form operacional usa cursores locais
    * Alteracoes ficam em xNensi (cursor do datasession do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF EMPTY(par_cOperacao)
            RETURN
        ENDIF
        RETURN
    ENDPROC

ENDDEFINE

