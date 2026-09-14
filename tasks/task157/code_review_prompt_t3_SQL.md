# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS

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
  AllowCellSelection = .T.
Select crSigPrCar
	.Column1.ControlSource = [crSigPrCar.Codigos]
	.Column2.ControlSource = [crSigPrCar.Descrs]
			Select a.Codigos ;
			  From crSigPrCar a ;
			Select crAux
			Select crSigPrCar
			Select a.Codigos ;
			  From crSigPrCar a ;
			Select crAux
Select crSigPrCar
	Delete
		Select crSigPrCar
				Delete In crSigPrCar
Select crSigPrCar
	Insert Into crSigPrCar (CPros, pkChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigPrCar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS SQL (1007 linhas total):

*-- Linhas 279 a 335:
279:             USE IN cursor_4c_Dados
280:         ENDIF
281:         SET NULL ON
282:         CREATE CURSOR cursor_4c_Dados ;
283:             (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
284:         SET NULL OFF
285: 
286:         THIS.AddObject("grd_4c_Dados", "Grid")
287:         THIS.grd_4c_Dados.ColumnCount  = 2
288:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
289:         WITH THIS.grd_4c_Dados
290:             .Top               = 103
291:             .Left              = 8
292:             .Width             = 463
293:             .Height            = 411
294:             .FontName          = "Tahoma"
295:             .FontSize          = 8
296:             .DeleteMark        = .F.
297:             .RecordMark        = .F.
298:             .AllowHeaderSizing = .F.
299:             .AllowRowSizing    = .F.
300:             .RowHeight         = 17
301:             .ScrollBars        = 2
302:             .GridLineColor     = RGB(238, 238, 238)
303:             .AllowCellSelection = .T.
304:             .Panel             = 1
305:         ENDWITH
306:         WITH THIS.grd_4c_Dados.Column1
307:             .ControlSource     = "cursor_4c_Dados.codigos"
308:             .Width             = 150
309:             .FontName          = "Tahoma"
310:             .FontSize          = 8
311:             .Movable           = .F.
312:             .Resizable         = .F.
313:             .Header1.Caption   = "Caracter" + CHR(237) + "stica"
314:             .Header1.FontName  = "Tahoma"
315:             .Header1.FontSize  = 8
316:             .Header1.Alignment = 2
317:             .Header1.ForeColor = RGB(90, 90, 90)
318:         ENDWITH
319:         WITH THIS.grd_4c_Dados.Column2
320:             .ControlSource     = "cursor_4c_Dados.descrs"
321:             .Width             = 290
322:             .FontName          = "Tahoma"
323:             .FontSize          = 8
324:             .Movable           = .F.
325:             .Resizable         = .F.
326:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
327:             .Header1.FontName  = "Tahoma"
328:             .Header1.FontSize  = 8
329:             .Header1.Alignment = 2
330:             .Header1.ForeColor = RGB(90, 90, 90)
331:         ENDWITH
332: 
333:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCodigosKeyPress")
334:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtDescrsKeyPress")
335:     ENDPROC

*-- Linhas 456 a 650:
456: 
457:         THIS.grd_4c_Dados.ColumnCount  = 2
458:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
459:         THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
460:         THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
461:         *-- Reconfigurar cabecalhos (reset automatico apos alterar RecordSource)
462:         THIS.grd_4c_Dados.Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
463:         THIS.grd_4c_Dados.Column1.Header1.FontName  = "Tahoma"
464:         THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
465:         THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
466:         THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(90, 90, 90)
467:         THIS.grd_4c_Dados.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
468:         THIS.grd_4c_Dados.Column2.Header1.FontName  = "Tahoma"
469:         THIS.grd_4c_Dados.Column2.Header1.FontSize  = 8
470:         THIS.grd_4c_Dados.Column2.Header1.Alignment = 2
471:         THIS.grd_4c_Dados.Column2.Header1.ForeColor = RGB(90, 90, 90)
472: 
473:         SELECT cursor_4c_Dados
474:         GO TOP
475:         THIS.FormatarGridLista(THIS.grd_4c_Dados)
476:         THIS.grd_4c_Dados.Refresh()
477:     ENDPROC
478: 
479:     *==========================================================================
480:     * CmdInserirClick - Adiciona nova linha vazia ao grid para preenchimento
481:     * Equivale a cmdInserir.Click do legado (Insert Into crSigPrCar + SetFocus)
482:     *==========================================================================
483:     PROCEDURE CmdInserirClick()
484:         LOCAL loc_oErro
485: 
486:         TRY
487:             IF !USED("cursor_4c_Dados")
488:                 RETURN
489:             ENDIF
490: 
491:             THIS.this_lHouveIncl = .T.
492: 
493:             SELECT cursor_4c_Dados
494:             LOCATE FOR EMPTY(ALLTRIM(NVL(codigos, "")))
495:             IF EOF()
496:                 *-- Nao existe linha vazia: adicionar nova
497:                 APPEND BLANK IN cursor_4c_Dados
498:                 SELECT cursor_4c_Dados
499:                 GO BOTTOM
500:                 REPLACE cpros WITH THIS.this_cCPros IN cursor_4c_Dados
501:             ELSE
502:                 *-- Ja existe linha vazia: posicionar nela
503:                 SELECT cursor_4c_Dados
504:             ENDIF
505: 
506:             THIS.grd_4c_Dados.Refresh()
507:             THIS.grd_4c_Dados.SetFocus()
508: 
509:         CATCH TO loc_oErro
510:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdInserirClick")
511:         ENDTRY
512:     ENDPROC
513: 
514:     *==========================================================================
515:     * CmdExcluirClick - Exclui linha atual do grid
516:     * Para registros persistidos: SQL DELETE via BO.Excluir()
517:     * Reconstroi cursor_4c_Dados sem o registro para atualizar grid imediatamente
518:     *==========================================================================
519:     PROCEDURE CmdExcluirClick()
520:         LOCAL loc_cPkChaves, loc_nRecnoAtual, loc_oErro
521: 
522:         TRY
523:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
524:                 RETURN
525:             ENDIF
526: 
527:             SELECT cursor_4c_Dados
528:             IF ALLTRIM(NVL(cpros, "")) != ALLTRIM(THIS.this_cCPros)
529:                 RETURN
530:             ENDIF
531: 
532:             loc_cPkChaves  = ALLTRIM(NVL(pkchaves, ""))
533:             loc_nRecnoAtual = RECNO("cursor_4c_Dados")
534: 
535:             *-- Se registro persistido no SQL Server, excluir la primeiro
536:             IF !EMPTY(loc_cPkChaves)
537:                 THIS.this_oBusinessObject.this_cPkChaves = loc_cPkChaves
538:                 IF !THIS.this_oBusinessObject.Excluir()
539:                     RETURN
540:                 ENDIF
541:             ENDIF
542: 
543:             *-- Reconstruir cursor_4c_Dados sem o registro excluido
544:             IF USED("cursor_4c_DadosSwap")
545:                 USE IN cursor_4c_DadosSwap
546:             ENDIF
547:             SET NULL ON
548:             CREATE CURSOR cursor_4c_DadosSwap ;
549:                 (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
550:             SET NULL OFF
551: 
552:             SELECT cursor_4c_Dados
553:             GO TOP
554:             DO WHILE !EOF("cursor_4c_Dados")
555:                 IF RECNO("cursor_4c_Dados") != loc_nRecnoAtual
556:                     SCATTER MEMVAR MEMO
557:                     SELECT cursor_4c_DadosSwap
558:                     APPEND BLANK
559:                     GATHER MEMVAR MEMO
560:                 ENDIF
561:                 SELECT cursor_4c_Dados
562:                 SKIP
563:             ENDDO
564: 
565:             USE IN cursor_4c_Dados
566:             SET NULL ON
567:             CREATE CURSOR cursor_4c_Dados ;
568:                 (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
569:             SET NULL OFF
570:             SELECT cursor_4c_Dados
571:             APPEND FROM DBF("cursor_4c_DadosSwap")
572:             USE IN cursor_4c_DadosSwap
573: 
574:             *-- Rebind do grid
575:             THIS.grd_4c_Dados.ColumnCount  = 2
576:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
577:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
578:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
579:             THIS.grd_4c_Dados.Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
580:             THIS.grd_4c_Dados.Column1.Header1.FontName  = "Tahoma"
581:             THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
582:             THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
583:             THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(90, 90, 90)
584:             THIS.grd_4c_Dados.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
585:             THIS.grd_4c_Dados.Column2.Header1.FontName  = "Tahoma"
586:             THIS.grd_4c_Dados.Column2.Header1.FontSize  = 8
587:             THIS.grd_4c_Dados.Column2.Header1.Alignment = 2
588:             THIS.grd_4c_Dados.Column2.Header1.ForeColor = RGB(90, 90, 90)
589:             THIS.FormatarGridLista(THIS.grd_4c_Dados)
590: 
591:             THIS.this_lHouveExcl = .T.
592:             SELECT cursor_4c_Dados
593:             IF !EOF()
594:                 GO TOP
595:             ENDIF
596:             THIS.grd_4c_Dados.Refresh()
597: 
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdExcluirClick")
600:         ENDTRY
601:     ENDPROC
602: 
603:     *==========================================================================
604:     * CmdSairClick - Persiste alteracoes no SQL Server e fecha o form
605:     * Em INSERIR/ALTERAR: INSERT novas linhas, UPDATE linhas existentes
606:     * Em CONSULTAR: apenas reabilita o form pai e fecha
607:     * Equivale a cmdSair.Click do legado
608:     *==========================================================================
609:     PROCEDURE CmdSairClick()
610:         LOCAL loc_oBO, loc_oErro
611: 
612:         TRY
613:             IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("cursor_4c_Dados")
614:                 loc_oBO = THIS.this_oBusinessObject
615: 
616:                 SELECT cursor_4c_Dados
617:                 SCAN FOR !DELETED()
618:                     IF EMPTY(ALLTRIM(NVL(codigos, "")))
619:                         LOOP
620:                     ENDIF
621: 
622:                     loc_oBO.this_cCodigos  = ALLTRIM(NVL(codigos, ""))
623:                     loc_oBO.this_cCPros    = ALLTRIM(NVL(cpros, THIS.this_cCPros))
624:                     loc_oBO.this_cDescrs   = ALLTRIM(NVL(descrs, ""))
625: 
626:                     IF EMPTY(ALLTRIM(NVL(pkchaves, "")))
627:                         *-- Nova caracteristica: INSERT
628:                         loc_oBO.this_cPkChaves    = ""
629:                         loc_oBO.this_lEmEdicao    = .T.
630:                         loc_oBO.this_lNovoRegistro = .T.
631:                         IF loc_oBO.Salvar()
632:                             REPLACE pkchaves WITH loc_oBO.this_cPkChaves IN cursor_4c_Dados
633:                         ENDIF
634:                     ELSE
635:                         *-- Caracteristica existente: UPDATE (garante que lookup editados sejam salvos)
636:                         loc_oBO.this_cPkChaves    = ALLTRIM(NVL(pkchaves, ""))
637:                         loc_oBO.this_lEmEdicao    = .T.
638:                         loc_oBO.this_lNovoRegistro = .F.
639:                         loc_oBO.Salvar()
640:                     ENDIF
641:                 ENDSCAN
642:             ENDIF
643: 
644:             *-- Reabilitar form pai antes de fechar
645:             IF VARTYPE(THIS.this_oFormPai) = "O"
646:                 THIS.this_oFormPai.Enabled = .T.
647:             ENDIF
648: 
649:             THIS.Release()
650: 

*-- Linhas 684 a 720:
684:                 RETURN
685:             ENDIF
686: 
687:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
688:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
689: 
690:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
691:                 "SigCrRap", "cursor_4c_Busca", "codigos", loc_cValorAtual, ;
692:                 loc_cTitulo, .F., .F., loc_cFiltro)
693: 
694:             IF VARTYPE(loc_oBusca) = "O"
695:                 IF !loc_oBusca.this_lAchouRegistro
696:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
697:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
698:                     loc_oBusca.Show()
699:                 ENDIF
700: 
701:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
702:                     SELECT cursor_4c_Busca
703:                     loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
704:                     loc_cDescSel = ALLTRIM(NVL(descrs, ""))
705:                     SELECT cursor_4c_Dados
706: 
707:                     IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
708:                             loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
709:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
710:                                  " informada para este produto!", ;
711:                                  "Aten" + CHR(231) + CHR(227) + "o")
712:                         REPLACE codigos WITH "" IN cursor_4c_Dados
713:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
714:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
715:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
716:                     ELSE
717:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
718:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
719:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
720:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel

*-- Linhas 775 a 811:
775:                 RETURN
776:             ENDIF
777: 
778:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
779:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
780: 
781:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
782:                 "SigCrRap", "cursor_4c_Busca", "descrs", loc_cValorAtual, ;
783:                 loc_cTitulo, .F., .F., loc_cFiltro)
784: 
785:             IF VARTYPE(loc_oBusca) = "O"
786:                 IF !loc_oBusca.this_lAchouRegistro
787:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
788:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
789:                     loc_oBusca.Show()
790:                 ENDIF
791: 
792:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
793:                     SELECT cursor_4c_Busca
794:                     loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
795:                     loc_cDescSel = ALLTRIM(NVL(descrs, ""))
796:                     SELECT cursor_4c_Dados
797: 
798:                     IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
799:                             loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
800:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
801:                                  " informada para este produto!", ;
802:                                  "Aten" + CHR(231) + CHR(227) + "o")
803:                         REPLACE codigos WITH "" IN cursor_4c_Dados
804:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
805:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
806:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
807:                     ELSE
808:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
809:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
810:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
811:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel

*-- Linhas 897 a 915:
897: 
898:     *==========================================================================
899:     * BtnEncerrarClick - Override do FormBase: delega a CmdSairClick
900:     * CmdSairClick persiste dados (INSERT/UPDATE) e fecha o form corretamente.
901:     *==========================================================================
902:     PROCEDURE BtnEncerrarClick()
903:         THIS.CmdSairClick()
904:     ENDPROC
905: 
906:     *==========================================================================
907:     * BtnSalvarClick - Override do FormBase: delega a CmdSairClick
908:     * Neste form OPERACIONAL salvar equivale a encerrar (persiste e fecha).
909:     *==========================================================================
910:     PROCEDURE BtnSalvarClick()
911:         THIS.CmdSairClick()
912:     ENDPROC
913: 
914:     *==========================================================================
915:     * BtnCancelarClick - Override do FormBase: fecha sem persistir alteracoes

*-- Linhas 969 a 987:
969:     *==========================================================================
970:     PROCEDURE LimparCampos()
971:         IF USED("cursor_4c_Dados")
972:             SELECT cursor_4c_Dados
973:             ZAP
974:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
975:                 THIS.grd_4c_Dados.Refresh()
976:             ENDIF
977:         ENDIF
978:     ENDPROC
979: 
980:     *==========================================================================
981:     * CarregarLista - Carrega caracteristicas do produto via BO.Buscar
982:     * Chamado na inicializacao e sempre que os dados precisam ser recarregados.
983:     *==========================================================================
984:     PROCEDURE CarregarLista()
985:         LOCAL loc_lSucesso
986:         loc_lSucesso = .F.
987: 


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*==============================================================================
* SigPrCarBO.prg - Business Object para Caracter" + CHR(237) + "sticas do Produto
* Data: 2026-07-01
* Tabela: sigprcar | PK: pkchaves
* Relacionamento: sigprcar JOIN SIGCRRAP (para descrs)
* Filtro lookup: SIGCRRAP.cgrus = produto.cgrus
*==============================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades persistidas (tabela sigprcar)
    this_cCodigos   = ""    && codigos   CHAR(20) - C" + CHR(243) + "digo da caracter" + CHR(237) + "stica (FK -> SIGCRRAP)
    this_cCPros     = ""    && cpros     CHAR(14) - C" + CHR(243) + "digo do produto (FK)
    this_cPkChaves  = ""    && pkchaves  CHAR(20) - Chave prim" + CHR(225) + "ria

    *-- Propriedades auxiliares (n" + CHR(227) + "o persistidas - carregadas via JOIN)
    this_cDescrs    = ""    && SIGCRRAP.descrs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica
    this_cCGrus     = ""    && produto.cgrus    CHAR(3)  - Grupo (filtro do lookup SigCrRap)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos, "C")
            THIS.this_cCPros    = TratarNulo(cpros, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega caracter" + CHR(237) + "sticas de um produto do SQL Server
    * par_cCPros: c" + CHR(243) + "digo do produto (obrigat" + CHR(243) + "rio)
    * Popula cursor_4c_Dados com JOIN em SIGCRRAP para obter descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCPros)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT p.codigos, r.descrs, p.cpros, p.pkchaves " + ;
                       "FROM sigprcar p " + ;
                       "LEFT JOIN SIGCRRAP r ON r.codigos = p.codigos " + ;
                       "WHERE p.cpros = " + EscaparSQL(par_cCPros) + " " + ;
                       "ORDER BY r.descrs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ;
                    (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp

                SELECT cursor_4c_Dados
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar caracter" + CHR(237) + "sticas do produto.", "SigPrCarBO.Buscar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCaracteristicaDuplicada - Verifica se caracter" + CHR(237) + "stica j" + CHR(225) + " existe
    * para o produto (excluindo o registro atual em edi" + CHR(231) + CHR(227) + "o)
    * Retorna .T. se duplicada (j" + CHR(225) + " existe), .F. se " + CHR(250) + "nica
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCaracteristicaDuplicada(par_cCodigos, par_cCPros, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_lDuplicado, loc_oErro

        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste " + ;
                       "FROM sigprcar " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + " " + ;
                       "AND cpros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicado = NVL(nExiste, 0) > 0
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ValidarCaracteristicaDuplicada")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("Informe o c" + CHR(243) + "digo da caracter" + CHR(237) + "stica.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova caracter" + CHR(237) + "stica no SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            *-- Gera chave prim" + CHR(225) + "ria se n" + CHR(227) + "o informada
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigprcar " + ;
                       "(codigos, cpros, pkchaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCPros) + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir caracter" + CHR(237) + "stica.", "SigPrCarBO.Inserir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza c" + CHR(243) + "digo da caracter" + CHR(237) + "stica no SQL Server
    * (descrs n" + CHR(227) + "o " + CHR(233) + " persistida - vem de JOIN com SIGCRRAP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Caracter" + CHR(237) + "stica sem chave prim" + CHR(225) + "ria.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE sigprcar " + ;
                       "SET codigos = " + EscaparSQL(THIS.this_cCodigos) + " " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar caracter" + CHR(237) + "stica.", "SigPrCarBO.Atualizar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui caracter" + CHR(237) + "stica do SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Nenhuma caracter" + CHR(237) + "stica selecionada para exclus" + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM sigprcar " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir caracter" + CHR(237) + "stica.", "SigPrCarBO.ExecutarExclusao")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

