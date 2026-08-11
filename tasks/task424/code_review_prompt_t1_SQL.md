# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NPARCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, TABDS, VALUE

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
lcSql = [Select * From SigOpFpD Where TabDs = ']+CrSigOpTdz.Codigos+[']
ThisForm.Podatamgr.SqlExecute(lcSql,'LocalFpagD')
lcSql = [Select Fpags,Descrs From SigOpFp ]
ThisForm.Podatamgr.SqlExecute(lcSql,'LocalFpag')
Select Localfpag
Select CrSigOpFpD
Append From Dbf('LocalFpagD')
	.DeleteMark = .f.
	.Column1.ControlSource = 'crSigOpFpD.Fpags'
	.Column2.ControlSource = 'crSigOpFpD.nParcs'
Select crSigOpFpD
	If Not Seek(This.Value,'LocalFpag','Fpags')
Select crSigOpFpD
Select crSigOpFpD
	Delete
	Select crSigOpFpD
	Delete For Empty(Fpags)
	Delete For Empty(nParcs)
	Update CrSigOpFpD set CidChaves = fUniqueIds()
	Select Fpags,nParcs,Sum(1) as TT From CrSigOpFpD Group by 1,2 having Sum(1) > 1;
		lcSql = [Delete From SigOpFpD Where TabDs = ']+CrSigOpTdz.Codigos+[']
		If .Podatamgr.SqlExecute(lcSql,'') < 1
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFpD'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (975 linhas total):

*-- Linhas 282 a 300:
282:             .Left              = 192
283:             .Width             = 176
284:             .Height            = 221
285:             .DeleteMark        = .F.
286:             .RecordMark        = .T.
287:             .RowHeight         = 18
288:             .ScrollBars        = 2
289:             .AllowHeaderSizing = .F.
290:             .AllowRowSizing    = .F.
291:             .GridLines         = 3
292:             .GridLineColor     = RGB(238, 238, 238)
293:             .ForeColor         = RGB(90, 90, 90)
294:             .BackColor         = RGB(255, 255, 255)
295:             .HighlightBackColor = RGB(255, 255, 255)
296:             .HighlightForeColor = RGB(15, 41, 104)
297:             .HighlightStyle    = 2
298:             .FontName          = "Tahoma"
299:             .FontSize          = 8
300:             .ReadOnly          = .F.

*-- Linhas 369 a 406:
369: 
370:     *--------------------------------------------------------------------------
371:     * CarregarLista - Carrega lookup SigOpFp + dados SigOpFpD para o TabDs
372:     * Equivale ao Init legado: SqlExecute(LocalFpagD) + ZAP + Append + RecordSource
373:     *--------------------------------------------------------------------------
374:     PROCEDURE CarregarLista()
375:         LOCAL loc_lSucesso
376:         loc_lSucesso = .F.
377:         TRY
378:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
379:                 loc_lSucesso = .T.
380:             ELSE
381:                 IF EMPTY(THIS.this_cTabDs)
382:                     loc_lSucesso = .F.
383:                 ELSE
384:                     *-- Carregar lookup de condicoes de pagamento (LocalFpag)
385:                     THIS.this_oBusinessObject.CarregarLookupFpag()
386: 
387:                     *-- Carregar dados da grade para o TabDs (cria crSigOpFpD local)
388:                     IF THIS.this_oBusinessObject.CarregarDadosGrid(THIS.this_cTabDs)
389:                         THIS.grd_4c_Dados.RecordSource          = "crSigOpFpD"
390:                         THIS.grd_4c_Dados.Column1.ControlSource = "crSigOpFpD.fpags"
391:                         THIS.grd_4c_Dados.Column2.ControlSource = "crSigOpFpD.nparcs"
392: 
393:                         *-- Reconfigurar headers apos RecordSource (OBRIGATORIO)
394:                         THIS.grd_4c_Dados.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
395:                         THIS.grd_4c_Dados.Column2.Header1.Caption = "Parcela"
396: 
397:                         *-- Atualizar caption com TabDs (legado: Caption = Caption + AllTrim(CrSigOpTdz.Codigos))
398:                         THIS.Caption = "Cond.Pagto Por Tab.Desconto - " + ALLTRIM(THIS.this_cTabDs)
399:                         IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
400:                             THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra.Caption = THIS.Caption
401:                             THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo.Caption = THIS.Caption
402:                         ENDIF
403: 
404:                         THIS.grd_4c_Dados.Refresh()
405:                         loc_lSucesso = .T.
406:                     ENDIF

*-- Linhas 422 a 467:
422:         TRY
423:             IF USED("crSigOpFpD")
424:                 THIS.this_lInseriu = .T.
425:                 SELECT crSigOpFpD
426:                 APPEND BLANK
427:                 REPLACE tabds WITH THIS.this_cTabDs
428:                 THIS.grd_4c_Dados.Refresh()
429:                 GO BOTTOM IN crSigOpFpD
430:                 THIS.grd_4c_Dados.SetFocus()
431:                 loc_lSucesso = .T.
432:             ELSE
433:                 MsgErro("Cursor de dados nao inicializado.", "Erro")
434:             ENDIF
435:         CATCH TO loc_oErro
436:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
437:         ENDTRY
438:         RETURN loc_lSucesso
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     * BtnExcluirClick - Marca registro atual para exclusao + Refresh
443:     * Legado: cmdExcluir.Click -> Excluiu=.T. + DELETE + SKIP + SKIP-1 + Refresh
444:     *--------------------------------------------------------------------------
445:     PROCEDURE BtnExcluirClick()
446:         LOCAL loc_lSucesso
447:         loc_lSucesso = .F.
448:         TRY
449:             IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
450:                 THIS.this_lExcluiu = .T.
451:                 SELECT crSigOpFpD
452:                 DELETE
453:                 SKIP
454:                 IF EOF()
455:                     SKIP -1
456:                 ENDIF
457:                 THIS.grd_4c_Dados.Refresh()
458:                 loc_lSucesso = .T.
459:             ELSE
460:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
461:             ENDIF
462:         CATCH TO loc_oErro
463:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
464:         ENDTRY
465:         RETURN loc_lSucesso
466:     ENDPROC
467: 

*-- Linhas 476 a 494:
476:         TRY
477:             IF USED("crSigOpFpD")
478:                 THIS.this_lInseriu = .T.
479:                 SELECT crSigOpFpD
480:                 APPEND BLANK
481:                 REPLACE tabds WITH THIS.this_cTabDs
482:                 THIS.grd_4c_Dados.Refresh()
483:                 GO BOTTOM IN crSigOpFpD
484:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
485:                     THIS.grd_4c_Dados.ActiveColumn = 1
486:                     THIS.grd_4c_Dados.Column1.ReadOnly = .F.
487:                     THIS.grd_4c_Dados.SetFocus()
488:                 ENDIF
489:                 loc_lSucesso = .T.
490:             ELSE
491:                 MsgErro("Cursor de dados nao inicializado.", "Erro")
492:             ENDIF
493:         CATCH TO loc_oErro
494:             MsgErro("Erro: " + loc_oErro.Message, "Erro")

*-- Linhas 508 a 526:
508:             IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
509:                 MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
510:             ELSE
511:                 SELECT crSigOpFpD
512:                 loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
513: 
514:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
515:                     IF EMPTY(loc_cFpagsAtual)
516:                         *-- Linha nova ainda sem Fpags: habilita Column1
517:                         THIS.grd_4c_Dados.Column1.ReadOnly = .F.
518:                         THIS.grd_4c_Dados.ActiveColumn = 1
519:                     ELSE
520:                         *-- Fpags ja preenchido: habilita Column2 (nParcs) para edicao
521:                         THIS.grd_4c_Dados.Column2.ReadOnly = .F.
522:                         THIS.grd_4c_Dados.ActiveColumn = 2
523:                     ENDIF
524:                     THIS.this_lInseriu = .T.
525:                     THIS.grd_4c_Dados.SetFocus()
526:                     loc_lSucesso = .T.

*-- Linhas 544 a 595:
544:             IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
545:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
546:             ELSE
547:                 SELECT crSigOpFpD
548:                 loc_cFpags = ALLTRIM(NVL(fpags, ""))
549:                 loc_nParcs = NVL(nparcs, 0)
550: 
551:                 loc_cDescr = ""
552:                 IF USED("LocalFpag")
553:                     SELECT LocalFpag
554:                     IF SEEK(loc_cFpags, "LocalFpag", "fpags")
555:                         loc_cDescr = ALLTRIM(NVL(LocalFpag.descrs, ""))
556:                     ELSE
557:                         LOCATE FOR ALLTRIM(fpags) == loc_cFpags
558:                         IF FOUND()
559:                             loc_cDescr = ALLTRIM(NVL(descrs, ""))
560:                         ENDIF
561:                     ENDIF
562:                     SELECT crSigOpFpD
563:                 ENDIF
564: 
565:                 loc_cMsg = "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + loc_cFpags + CHR(13) + ;
566:                            "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescr + CHR(13) + ;
567:                            "N" + CHR(250) + "mero de Parcelas: " + ALLTRIM(TRANSFORM(loc_nParcs)) + CHR(13) + ;
568:                            "Tabela Desconto: " + ALLTRIM(THIS.this_cTabDs)
569:                 MsgInfo(loc_cMsg, "Detalhes do Registro")
570:                 loc_lSucesso = .T.
571:             ENDIF
572:         CATCH TO loc_oErro
573:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
574:         ENDTRY
575:         RETURN loc_lSucesso
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * BtnEncerrarClick - Salva se houve mudancas, reabilita parent e fecha
580:     * Legado: cmdSair.Click -> valida duplicatas -> DELETE all -> INSERT batch -> Release
581:     *--------------------------------------------------------------------------
582:     PROCEDURE BtnEncerrarClick()
583:         LOCAL loc_lSucesso
584:         loc_lSucesso = .F.
585:         TRY
586:             IF THIS.this_lInseriu OR THIS.this_lExcluiu
587:                 loc_lSucesso = THIS.this_oBusinessObject.SalvarGrid(THIS.this_cTabDs)
588:             ELSE
589:                 loc_lSucesso = .T.
590:             ENDIF
591:         CATCH TO loc_oErro
592:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
593:         ENDTRY
594: 
595:         IF loc_lSucesso

*-- Linhas 627 a 711:
627:         ENDIF
628: 
629:         LOCAL loc_cFpagsAtual, loc_nParcsAtual
630:         SELECT crSigOpFpD
631:         loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
632:         loc_nParcsAtual = NVL(nparcs, 0)
633: 
634:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
635:             *-- Column1: editavel apenas quando Fpags esta vazio (linha nova)
636:             *-- Legado Column1.Text1.When: Return ( Empty(CrSigOpFpD.Fpags) )
637:             THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)
638: 
639:             *-- Column2: editavel quando Fpags preenchido E nParcs = 0
640:             *-- Legado Column2.Text1.When: Return ( Not Empty(CrSigOpFpD.Fpags) And This.Value = 0 )
641:             THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
642:         ENDIF
643: 
644:         *-- Validar Fpags ao sair da Column1 (equivale ao Valid do Text1 no legado)
645:         IF par_nColIndex = 1
646:             THIS.ValidarFpagsGrade()
647: 
648:             *-- Recalcular ReadOnly de Column2 apos validacao (Fpags pode ter mudado)
649:             IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
650:                 SELECT crSigOpFpD
651:                 loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
652:                 loc_nParcsAtual = NVL(nparcs, 0)
653:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
654:                     THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)
655:                     THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
656:                 ENDIF
657:             ENDIF
658:         ENDIF
659:     ENDPROC
660: 
661:     *--------------------------------------------------------------------------
662:     * ValidarFpagsGrade - Verifica Fpags contra LocalFpag; abre picker se invalido
663:     * Legado: Column1.Text1.Valid -> Seek em LocalFpag -> fwBuscaInt se nao achou
664:     *--------------------------------------------------------------------------
665:     PROTECTED PROCEDURE ValidarFpagsGrade()
666:         LOCAL loc_cFpags, loc_oBusca
667:         loc_oBusca = .NULL.
668: 
669:         IF !USED("crSigOpFpD") OR EOF("crSigOpFpD")
670:             RETURN
671:         ENDIF
672: 
673:         SELECT crSigOpFpD
674:         loc_cFpags = ALLTRIM(fpags)
675: 
676:         IF EMPTY(loc_cFpags)
677:             *-- Legado: LostFocus com Fpags vazio -> cmdSair.SetFocus
678:             IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
679:                 IF VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_Encerrar) = "O"
680:                     THIS.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
681:                 ENDIF
682:             ENDIF
683:             RETURN
684:         ENDIF
685: 
686:         *-- Legado: Valid -> If Not Seek(This.Value,'LocalFpag','Fpags') -> fwBuscaInt
687:         IF !THIS.this_oBusinessObject.ValidarFpags(loc_cFpags)
688:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
689:                 "SigOpFp", "cursor_4c_FpdBusca", "fpags", loc_cFpags, ;
690:                 "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
691:             IF VARTYPE(loc_oBusca) = "O"
692:                 loc_oBusca.mAddColuna("fpags",  "", "C" + CHR(243) + "digo")
693:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
694:                 loc_oBusca.Show()
695:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FpdBusca")
696:                     SELECT crSigOpFpD
697:                     REPLACE fpags WITH ALLTRIM(cursor_4c_FpdBusca.fpags)
698:                 ENDIF
699:                 loc_oBusca.Release()
700:             ENDIF
701:             IF USED("cursor_4c_FpdBusca")
702:                 USE IN cursor_4c_FpdBusca
703:             ENDIF
704:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
705:                 THIS.grd_4c_Dados.Refresh()
706:             ENDIF
707:         ENDIF
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * ConfigurarPaginaDados - Configura propriedades das celulas editaveis da grade

*-- Linhas 799 a 838:
799:         loc_lSucesso = .F.
800:         TRY
801:             IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
802:                 SELECT crSigOpFpD
803:                 THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cidchaves, ""))
804:                 THIS.this_oBusinessObject.this_cFpags     = ALLTRIM(NVL(fpags, ""))
805:                 THIS.this_oBusinessObject.this_nNParcs    = NVL(nparcs, 0)
806:                 THIS.this_oBusinessObject.this_cTabDs     = ALLTRIM(NVL(tabds, ""))
807:                 loc_lSucesso = .T.
808:             ENDIF
809:         CATCH TO loc_oErro
810:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
811:         ENDTRY
812:         RETURN loc_lSucesso
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     * BOParaForm - Grava propriedades do BO na linha atual de crSigOpFpD
817:     *--------------------------------------------------------------------------
818:     PROTECTED PROCEDURE BOParaForm()
819:         LOCAL loc_lSucesso
820:         loc_lSucesso = .F.
821:         TRY
822:             IF USED("crSigOpFpD") AND !EOF("crSigOpFpD")
823:                 SELECT crSigOpFpD
824:                 REPLACE cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves
825:                 REPLACE fpags     WITH THIS.this_oBusinessObject.this_cFpags
826:                 REPLACE nparcs    WITH THIS.this_oBusinessObject.this_nNParcs
827:                 REPLACE tabds     WITH THIS.this_oBusinessObject.this_cTabDs
828:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
829:                     THIS.grd_4c_Dados.Refresh()
830:                 ENDIF
831:                 loc_lSucesso = .T.
832:             ENDIF
833:         CATCH TO loc_oErro
834:             MsgErro("Erro: " + loc_oErro.Message, "Erro")
835:         ENDTRY
836:         RETURN loc_lSucesso
837:     ENDPROC
838: 

*-- Linhas 847 a 865:
847:         THIS.grd_4c_Dados.ReadOnly = !par_lHabilitar
848:         IF par_lHabilitar AND USED("crSigOpFpD") AND !EOF("crSigOpFpD")
849:             LOCAL loc_cFpagsAtual, loc_nParcsAtual
850:             SELECT crSigOpFpD
851:             loc_cFpagsAtual = ALLTRIM(NVL(fpags, ""))
852:             loc_nParcsAtual = NVL(nparcs, 0)
853:             THIS.grd_4c_Dados.Column1.ReadOnly = !EMPTY(loc_cFpagsAtual)
854:             THIS.grd_4c_Dados.Column2.ReadOnly = EMPTY(loc_cFpagsAtual) OR (loc_nParcsAtual != 0)
855:         ENDIF
856:     ENDPROC
857: 
858:     *--------------------------------------------------------------------------
859:     * LimparCampos - Descarta todas as linhas do cursor local (ZAP sem salvar)
860:     * Redefine flags de alteracao para estado limpo
861:     *--------------------------------------------------------------------------
862:     PROTECTED PROCEDURE LimparCampos()
863:         LOCAL loc_lSucesso
864:         loc_lSucesso = .F.
865:         TRY


### BO (C:\4c\projeto\app\classes\FpdBO.prg):
*==============================================================================
* FpdBO.PRG
* Business Object para Condicoes de Pagamento por Tabela de Desconto (SIGCDFPD)
*
* Tabela Principal : SigOpFpd - Condicoes de pagamento por tabela
*                               (cidchaves char(20), fpags char(12),
*                                nparcs numeric(2), tabds char(10))
* Tabela Lookup    : SigOpFp  - Cadastro de condicoes de pagamento
*                               (fpags char(12), descrs char(30))
*
* Logica: Gerencia colecao de condicoes de pagamento vinculadas a uma
*         tabela de desconto (TabDs). Salvar = DELETE all for TabDs
*         + re-INSERT from cursor crSigOpFpD.
*==============================================================================

DEFINE CLASS FpdBO AS BusinessBase

    *-- Campos de SigOpFpd
    this_cCidChaves = ""    && cidchaves CHAR(20) - chave unica (PK)
    this_nNParcs    = 0     && nparcs    NUMERIC(2,0) - numero de parcelas
    this_cFpags     = ""    && fpags     CHAR(12) - codigo condicao de pagamento
    this_cTabDs     = ""    && tabds     CHAR(10) - discriminador (chave do parent)

    *-- Cursor de dados da grade (nome legado obrigatorio - FRX/grid referencia este nome)
    this_cCursorDados = "crSigOpFpD"

    *-- Cursor de lookup para condicoes de pagamento
    this_cCursorLookup = "LocalFpag"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpd com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdCarga")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_FpdCarga") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_FpdCarga")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_FpdCarga")
            USE IN cursor_4c_FpdCarga
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNParcs    = TratarNulo(nparcs, "N")
            THIS.this_cTabDs     = TratarNulo(tabds, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       EscaparSQL(THIS.this_cTabDs) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigOpFpd SET " + ;
                       "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "nparcs = " + FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       "tabds = " + EscaparSQL(THIS.this_cTabDs) + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpFpd (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(cidchaves) = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrid - Carrega crSigOpFpD do servidor para o TabDs informado
    * Cria cursor editavel local a partir dos dados do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrid(par_cTabDs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                USE IN crSigOpFpD
            ENDIF
            IF USED("cursor_4c_FpdLoad")
                USE IN cursor_4c_FpdLoad
            ENDIF

            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(tabds) = " + EscaparSQL(ALLTRIM(par_cTabDs))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdLoad")

            IF loc_nResult >= 0
                SET NULL ON
                CREATE CURSOR crSigOpFpD (cidchaves C(20), fpags C(12), nparcs N(2,0), tabds C(10))
                SET NULL OFF

                IF RECCOUNT("cursor_4c_FpdLoad") > 0
                    APPEND FROM DBF("cursor_4c_FpdLoad")
                ENDIF

                IF USED("cursor_4c_FpdLoad")
                    USE IN cursor_4c_FpdLoad
                ENDIF

                GO TOP IN crSigOpFpD
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar dados da grade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLookupFpag - Carrega LocalFpag de SigOpFp indexado por fpags
    * Necessario para validacao/busca na Column1 da grade
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLookupFpag()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("LocalFpag")
                USE IN LocalFpag
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalFpag")

            IF loc_nResult >= 0
                SELECT LocalFpag
                INDEX ON ALLTRIM(fpags) TAG fpags
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lookup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFpags - Verifica se codigo Fpags existe em LocalFpag
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFpags(par_cFpags)
        LOCAL loc_lValido
        loc_lValido = .F.
        IF USED("LocalFpag") AND !EMPTY(par_cFpags)
            loc_lValido = SEEK(ALLTRIM(par_cFpags), "LocalFpag", "fpags")
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrid - Persiste grade crSigOpFpD no servidor para o TabDs dado
    * Logica: limpa vazios -> valida duplicatas -> DELETE all -> INSERT batch
    * Retorna .T. se gravado, .F. se duplicata detectada ou erro
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrid(par_cTabDs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount
        LOCAL loc_cChave, loc_cFpags, loc_nNParcs
        loc_lSucesso = .F.

        IF !USED("crSigOpFpD")
            MsgErro("Cursor crSigOpFpD nao encontrado.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover linhas com Fpags ou nParcs vazios
            SELECT crSigOpFpD
            DELETE FOR EMPTY(ALLTRIM(fpags))
            DELETE FOR nparcs = 0
            PACK

            *-- Passo 2: Atribuir cidchaves para registros sem chave unica
            SELECT crSigOpFpD
            GO TOP
            DO WHILE !EOF()
                IF EMPTY(ALLTRIM(cidchaves))
                    REPLACE cidchaves WITH LEFT(PADL(TRANSFORM(RECNO()), 10, "0") + SYS(2015), 20)
                ENDIF
                SKIP
            ENDDO

            *-- Passo 3: Verificar duplicatas (fpags + nparcs) - logica do legado
            SELECT fpags, nparcs, SUM(1) AS TT ;
                FROM crSigOpFpD ;
                GROUP BY 1, 2 ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_FpdDupls READWRITE
            loc_nCount = RECCOUNT("cursor_4c_FpdDupls")
            IF USED("cursor_4c_FpdDupls")
                USE IN cursor_4c_FpdDupls
            ENDIF

            IF loc_nCount > 0
                MsgAviso("Dados em duplicidade! Verifique a grade antes de salvar.", "Duplicidade")
            ELSE
                *-- Passo 4: DELETE todos os registros existentes para TabDs
                loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(tabds) = " + ;
                           EscaparSQL(ALLTRIM(par_cTabDs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Passo 5: INSERT cada linha valida do cursor
                    loc_lSucesso = .T.
                    SELECT crSigOpFpD
                    GO TOP
                    DO WHILE !EOF() AND loc_lSucesso
                        loc_cChave  = ALLTRIM(cidchaves)
                        loc_cFpags  = ALLTRIM(fpags)
                        loc_nNParcs = nparcs

                        IF !EMPTY(loc_cFpags)
                            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave) + ", " + ;
                                       EscaparSQL(loc_cFpags) + ", " + ;
                                       FormatarNumeroSQL(loc_nNParcs) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cTabDs)) + ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SKIP
                    ENDDO

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir registros antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha cursores abertos pelo BO (chamado no Destroy do Form)
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED("crSigOpFpD")
            USE IN crSigOpFpD
        ENDIF
        IF USED("LocalFpag")
            USE IN LocalFpag
        ENDIF
    ENDPROC

ENDDEFINE

