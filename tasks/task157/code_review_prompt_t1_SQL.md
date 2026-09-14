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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS SQL (1013 linhas total):

*-- Linhas 279 a 336:
279:             USE IN cursor_4c_Dados
280:         ENDIF
281:         SET NULL ON
282:         CREATE CURSOR cursor_4c_Dados ;
283:             (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
284:         SET NULL OFF
285: 
286:         THIS.AddObject("grd_4c_Dados", "Grid")
287:         WITH THIS.grd_4c_Dados
288:             .Top               = 103
289:             .Left              = 8
290:             .Width             = 463
291:             .Height            = 411
292:             .FontName          = "Tahoma"
293:             .FontSize          = 8
294:             .ColumnCount       = 2
295:             .RecordSource      = "cursor_4c_Dados"
296:             .DeleteMark        = .F.
297:             .RecordMark        = .F.
298:             .AllowHeaderSizing = .F.
299:             .AllowRowSizing    = .F.
300:             .RowHeight         = 17
301:             .ScrollBars        = 2
302:             .GridLineColor     = RGB(238, 238, 238)
303:             .AllowCellSelection = .T.
304:             .Panel             = 1
305: 
306:             WITH .Column1
307:                 .ControlSource = "cursor_4c_Dados.codigos"
308:                 .Width         = 150
309:                 .FontName      = "Tahoma"
310:                 .FontSize      = 8
311:                 .Movable       = .F.
312:                 .Resizable     = .F.
313:             ENDWITH
314:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
315:             .Column1.Header1.FontName  = "Tahoma"
316:             .Column1.Header1.FontSize  = 8
317:             .Column1.Header1.Alignment = 2
318:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
319: 
320:             WITH .Column2
321:                 .ControlSource = "cursor_4c_Dados.descrs"
322:                 .Width         = 290
323:                 .FontName      = "Tahoma"
324:                 .FontSize      = 8
325:                 .Movable       = .F.
326:                 .Resizable     = .F.
327:             ENDWITH
328:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
329:             .Column2.Header1.FontName  = "Tahoma"
330:             .Column2.Header1.FontSize  = 8
331:             .Column2.Header1.Alignment = 2
332:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
333:         ENDWITH
334: 
335:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCodigosKeyPress")
336:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtDescrsKeyPress")

*-- Linhas 459 a 656:
459:         WITH THIS.grd_4c_Dados
460:             .ColumnCount           = 2
461:             .RecordSource          = "cursor_4c_Dados"
462:             .Column1.ControlSource = "cursor_4c_Dados.codigos"
463:             .Column2.ControlSource = "cursor_4c_Dados.descrs"
464:             *-- Reconfigurar cabecalhos (reset automatico apos alterar RecordSource)
465:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
466:             .Column1.Header1.FontName  = "Tahoma"
467:             .Column1.Header1.FontSize  = 8
468:             .Column1.Header1.Alignment = 2
469:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
470:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
471:             .Column2.Header1.FontName  = "Tahoma"
472:             .Column2.Header1.FontSize  = 8
473:             .Column2.Header1.Alignment = 2
474:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
475:         ENDWITH
476: 
477:         SELECT cursor_4c_Dados
478:         GO TOP
479:         THIS.FormatarGridLista(THIS.grd_4c_Dados)
480:         THIS.grd_4c_Dados.Refresh()
481:     ENDPROC
482: 
483:     *==========================================================================
484:     * CmdInserirClick - Adiciona nova linha vazia ao grid para preenchimento
485:     * Equivale a cmdInserir.Click do legado (Insert Into crSigPrCar + SetFocus)
486:     *==========================================================================
487:     PROCEDURE CmdInserirClick()
488:         LOCAL loc_oErro
489: 
490:         TRY
491:             IF !USED("cursor_4c_Dados")
492:                 RETURN
493:             ENDIF
494: 
495:             THIS.this_lHouveIncl = .T.
496: 
497:             SELECT cursor_4c_Dados
498:             LOCATE FOR EMPTY(ALLTRIM(NVL(codigos, "")))
499:             IF EOF()
500:                 *-- Nao existe linha vazia: adicionar nova
501:                 APPEND BLANK IN cursor_4c_Dados
502:                 SELECT cursor_4c_Dados
503:                 GO BOTTOM
504:                 REPLACE cpros WITH THIS.this_cCPros IN cursor_4c_Dados
505:             ELSE
506:                 *-- Ja existe linha vazia: posicionar nela
507:                 SELECT cursor_4c_Dados
508:             ENDIF
509: 
510:             THIS.grd_4c_Dados.Refresh()
511:             THIS.grd_4c_Dados.SetFocus()
512: 
513:         CATCH TO loc_oErro
514:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdInserirClick")
515:         ENDTRY
516:     ENDPROC
517: 
518:     *==========================================================================
519:     * CmdExcluirClick - Exclui linha atual do grid
520:     * Para registros persistidos: SQL DELETE via BO.Excluir()
521:     * Reconstroi cursor_4c_Dados sem o registro para atualizar grid imediatamente
522:     *==========================================================================
523:     PROCEDURE CmdExcluirClick()
524:         LOCAL loc_cPkChaves, loc_nRecnoAtual, loc_oErro
525: 
526:         TRY
527:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
528:                 RETURN
529:             ENDIF
530: 
531:             SELECT cursor_4c_Dados
532:             IF ALLTRIM(NVL(cpros, "")) != ALLTRIM(THIS.this_cCPros)
533:                 RETURN
534:             ENDIF
535: 
536:             loc_cPkChaves  = ALLTRIM(NVL(pkchaves, ""))
537:             loc_nRecnoAtual = RECNO("cursor_4c_Dados")
538: 
539:             *-- Se registro persistido no SQL Server, excluir la primeiro
540:             IF !EMPTY(loc_cPkChaves)
541:                 THIS.this_oBusinessObject.this_cPkChaves = loc_cPkChaves
542:                 IF !THIS.this_oBusinessObject.Excluir()
543:                     RETURN
544:                 ENDIF
545:             ENDIF
546: 
547:             *-- Reconstruir cursor_4c_Dados sem o registro excluido
548:             IF USED("cursor_4c_DadosSwap")
549:                 USE IN cursor_4c_DadosSwap
550:             ENDIF
551:             SET NULL ON
552:             CREATE CURSOR cursor_4c_DadosSwap ;
553:                 (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
554:             SET NULL OFF
555: 
556:             SELECT cursor_4c_Dados
557:             GO TOP
558:             DO WHILE !EOF("cursor_4c_Dados")
559:                 IF RECNO("cursor_4c_Dados") != loc_nRecnoAtual
560:                     SCATTER MEMVAR MEMO
561:                     SELECT cursor_4c_DadosSwap
562:                     APPEND BLANK
563:                     GATHER MEMVAR MEMO
564:                 ENDIF
565:                 SELECT cursor_4c_Dados
566:                 SKIP
567:             ENDDO
568: 
569:             USE IN cursor_4c_Dados
570:             SET NULL ON
571:             CREATE CURSOR cursor_4c_Dados ;
572:                 (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
573:             SET NULL OFF
574:             SELECT cursor_4c_Dados
575:             APPEND FROM DBF("cursor_4c_DadosSwap")
576:             USE IN cursor_4c_DadosSwap
577: 
578:             *-- Rebind do grid
579:             WITH THIS.grd_4c_Dados
580:                 .ColumnCount           = 2
581:                 .RecordSource          = "cursor_4c_Dados"
582:                 .Column1.ControlSource = "cursor_4c_Dados.codigos"
583:                 .Column2.ControlSource = "cursor_4c_Dados.descrs"
584:                 .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
585:                 .Column1.Header1.FontName  = "Tahoma"
586:                 .Column1.Header1.FontSize  = 8
587:                 .Column1.Header1.Alignment = 2
588:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
589:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
590:                 .Column2.Header1.FontName  = "Tahoma"
591:                 .Column2.Header1.FontSize  = 8
592:                 .Column2.Header1.Alignment = 2
593:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
594:             ENDWITH
595:             THIS.FormatarGridLista(THIS.grd_4c_Dados)
596: 
597:             THIS.this_lHouveExcl = .T.
598:             SELECT cursor_4c_Dados
599:             IF !EOF()
600:                 GO TOP
601:             ENDIF
602:             THIS.grd_4c_Dados.Refresh()
603: 
604:         CATCH TO loc_oErro
605:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdExcluirClick")
606:         ENDTRY
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * CmdSairClick - Persiste alteracoes no SQL Server e fecha o form
611:     * Em INSERIR/ALTERAR: INSERT novas linhas, UPDATE linhas existentes
612:     * Em CONSULTAR: apenas reabilita o form pai e fecha
613:     * Equivale a cmdSair.Click do legado
614:     *==========================================================================
615:     PROCEDURE CmdSairClick()
616:         LOCAL loc_oBO, loc_oErro
617: 
618:         TRY
619:             IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("cursor_4c_Dados")
620:                 loc_oBO = THIS.this_oBusinessObject
621: 
622:                 SELECT cursor_4c_Dados
623:                 SCAN FOR !DELETED()
624:                     IF EMPTY(ALLTRIM(NVL(codigos, "")))
625:                         LOOP
626:                     ENDIF
627: 
628:                     loc_oBO.this_cCodigos  = ALLTRIM(NVL(codigos, ""))
629:                     loc_oBO.this_cCPros    = ALLTRIM(NVL(cpros, THIS.this_cCPros))
630:                     loc_oBO.this_cDescrs   = ALLTRIM(NVL(descrs, ""))
631: 
632:                     IF EMPTY(ALLTRIM(NVL(pkchaves, "")))
633:                         *-- Nova caracteristica: INSERT
634:                         loc_oBO.this_cPkChaves    = ""
635:                         loc_oBO.this_lEmEdicao    = .T.
636:                         loc_oBO.this_lNovoRegistro = .T.
637:                         IF loc_oBO.Salvar()
638:                             REPLACE pkchaves WITH loc_oBO.this_cPkChaves IN cursor_4c_Dados
639:                         ENDIF
640:                     ELSE
641:                         *-- Caracteristica existente: UPDATE (garante que lookup editados sejam salvos)
642:                         loc_oBO.this_cPkChaves    = ALLTRIM(NVL(pkchaves, ""))
643:                         loc_oBO.this_lEmEdicao    = .T.
644:                         loc_oBO.this_lNovoRegistro = .F.
645:                         loc_oBO.Salvar()
646:                     ENDIF
647:                 ENDSCAN
648:             ENDIF
649: 
650:             *-- Reabilitar form pai antes de fechar
651:             IF VARTYPE(THIS.this_oFormPai) = "O"
652:                 THIS.this_oFormPai.Enabled = .T.
653:             ENDIF
654: 
655:             THIS.Release()
656: 

*-- Linhas 690 a 726:
690:                 RETURN
691:             ENDIF
692: 
693:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
694:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
695: 
696:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
697:                 "SigCrRap", "cursor_4c_Busca", "codigos", loc_cValorAtual, ;
698:                 loc_cTitulo, .F., .F., loc_cFiltro)
699: 
700:             IF VARTYPE(loc_oBusca) = "O"
701:                 IF !loc_oBusca.this_lAchouRegistro
702:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
703:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
704:                     loc_oBusca.Show()
705:                 ENDIF
706: 
707:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
708:                     SELECT cursor_4c_Busca
709:                     loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
710:                     loc_cDescSel = ALLTRIM(NVL(descrs, ""))
711:                     SELECT cursor_4c_Dados
712: 
713:                     IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
714:                             loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
715:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
716:                                  " informada para este produto!", ;
717:                                  "Aten" + CHR(231) + CHR(227) + "o")
718:                         REPLACE codigos WITH "" IN cursor_4c_Dados
719:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
720:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
721:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
722:                     ELSE
723:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
724:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
725:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
726:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel

*-- Linhas 781 a 817:
781:                 RETURN
782:             ENDIF
783: 
784:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
785:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
786: 
787:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
788:                 "SigCrRap", "cursor_4c_Busca", "descrs", loc_cValorAtual, ;
789:                 loc_cTitulo, .F., .F., loc_cFiltro)
790: 
791:             IF VARTYPE(loc_oBusca) = "O"
792:                 IF !loc_oBusca.this_lAchouRegistro
793:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
794:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
795:                     loc_oBusca.Show()
796:                 ENDIF
797: 
798:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
799:                     SELECT cursor_4c_Busca
800:                     loc_cCodSel  = ALLTRIM(NVL(codigos, ""))
801:                     loc_cDescSel = ALLTRIM(NVL(descrs, ""))
802:                     SELECT cursor_4c_Dados
803: 
804:                     IF THIS.this_oBusinessObject.ValidarCaracteristicaDuplicada( ;
805:                             loc_cCodSel, THIS.this_cCPros, loc_cPkChavesAtual)
806:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
807:                                  " informada para este produto!", ;
808:                                  "Aten" + CHR(231) + CHR(227) + "o")
809:                         REPLACE codigos WITH "" IN cursor_4c_Dados
810:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
811:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
812:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
813:                     ELSE
814:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
815:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
816:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
817:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel

*-- Linhas 903 a 921:
903: 
904:     *==========================================================================
905:     * BtnEncerrarClick - Override do FormBase: delega a CmdSairClick
906:     * CmdSairClick persiste dados (INSERT/UPDATE) e fecha o form corretamente.
907:     *==========================================================================
908:     PROCEDURE BtnEncerrarClick()
909:         THIS.CmdSairClick()
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * BtnSalvarClick - Override do FormBase: delega a CmdSairClick
914:     * Neste form OPERACIONAL salvar equivale a encerrar (persiste e fecha).
915:     *==========================================================================
916:     PROCEDURE BtnSalvarClick()
917:         THIS.CmdSairClick()
918:     ENDPROC
919: 
920:     *==========================================================================
921:     * BtnCancelarClick - Override do FormBase: fecha sem persistir alteracoes

*-- Linhas 975 a 993:
975:     *==========================================================================
976:     PROCEDURE LimparCampos()
977:         IF USED("cursor_4c_Dados")
978:             SELECT cursor_4c_Dados
979:             ZAP
980:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
981:                 THIS.grd_4c_Dados.Refresh()
982:             ENDIF
983:         ENDIF
984:     ENDPROC
985: 
986:     *==========================================================================
987:     * CarregarLista - Carrega caracteristicas do produto via BO.Buscar
988:     * Chamado na inicializacao e sempre que os dados precisam ser recarregados.
989:     *==========================================================================
990:     PROCEDURE CarregarLista()
991:         LOCAL loc_lSucesso
992:         loc_lSucesso = .F.
993: 


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

            IF !EMPTY(ALLTRIM(par_cPkChavesAtual))
                loc_cSQL = loc_cSQL + " AND pkchaves <> " + EscaparSQL(par_cPkChavesAtual)
            ENDIF

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

