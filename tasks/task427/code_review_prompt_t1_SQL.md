# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, FPAGS

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
	.Column1.ControlSource = 'xOpe.fpags'
	.Column2.ControlSource = 'xOpe.descrs'
lcSql = [Select a.*, b.descrs From SigCdFpN a, SigOpfp b Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.fpags = b.fpags ]
ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
Select CsSelecao
	Select xOpe
Select xOpe
Insert Into xOpe (fpags) Values ( Space(12))
Select xOpe
Select xOpe
	Select xOpe
	Delete 
	Select Fpags, Sum(1) as Qt From xOpe Group by 1 Into Cursor Selecao where Fpags <> ' ' having Sum(1) > 1
	Select CrSigCdFpN
	Select xOpe
			Insert Into CrSigCdFpN (Dopes, Fpags, cIdChaves) ;
		lcSql = [Delete From SigCdFpN Where dopes = ']+CrSigCdOpe.dopes+[']
		m.lnErro1 = ( .PodataMgr.SqlExecute(lcSql,'') )
			m.lnErro1 = Iif(.poDataMgr.UpDate('CrSigCdFpN'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpN.prg) - TRECHOS RELEVANTES PARA PASS SQL (868 linhas total):

*-- Linhas 335 a 353:
335:                 .Width         = 313
336:                 .Height        = 274
337:                 .ColumnCount   = 2
338:                 .DeleteMark    = .F.
339:                 .RecordMark    = .F.
340:                 .GridLines     = 1
341:                 .GridLineColor = RGB(238, 238, 238)
342:                 .FontName      = "Tahoma"
343:                 .FontSize      = 8
344:                 .ForeColor     = RGB(90, 90, 90)
345:                 .RowHeight     = 16
346:                 .ScrollBars    = 2
347:                 .Visible       = .T.
348:             ENDWITH
349: 
350:             WITH loc_oGrid.Column1
351:                 .Width     = 80
352:                 .Movable   = .F.
353:                 .Resizable = .F.

*-- Linhas 410 a 449:
410:     *==========================================================================
411:     * CarregarDados - Carrega registros do BO e vincula grid ao cursor
412:     * Deve ser chamado APOS ConfigurarPaginaLista (grid ja existe)
413:     * RecordSource/ControlSource definidos aqui pois BO recria o cursor
414:     *==========================================================================
415:     PROTECTED PROCEDURE CarregarDados()
416:         LOCAL loc_lSucesso, loc_oGrid, loc_cCursor, loc_oErro
417:         loc_lSucesso = .F.
418:         TRY
419:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND NOT EMPTY(THIS.this_cDopes)
420:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarRegistros(THIS.this_cDopes)
421:                 loc_cCursor  = THIS.this_oBusinessObject.this_cCursorOpe
422: 
423:                 IF VARTYPE(THIS.pgf_4c_Principal) = "O"
424:                     IF VARTYPE(THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe) = "O"
425:                         loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
426: 
427:                         *-- Pinar ColumnCount ANTES de RecordSource (evita auto-expand)
428:                         loc_oGrid.ColumnCount  = 2
429:                         loc_oGrid.RecordSource = loc_cCursor
430: 
431:                         loc_oGrid.Column1.ControlSource = loc_cCursor + ".Fpags"
432:                         loc_oGrid.Column2.ControlSource = loc_cCursor + ".Descrs"
433: 
434:                         *-- Reaplicar cabecalhos apos ControlSource (VFP reseta captions)
435:                         loc_oGrid.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
436:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
437: 
438:                         THIS.FormatarGridLista(loc_oGrid)
439:                         loc_oGrid.Refresh()
440:                     ENDIF
441:                 ENDIF
442:             ENDIF
443:         CATCH TO loc_oErro
444:             MsgErro(loc_oErro.Message + CHR(13) + ;
445:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
446:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CarregarDados")
447:         ENDTRY
448:         RETURN loc_lSucesso
449:     ENDPROC

*-- Linhas 510 a 573:
510: 
511:     *==========================================================================
512:     * CmdInserirClick - Insere linha em branco no grid para nova condicao
513:     * Original: Insert Into xOpe (fpags) Values (Space(12)) + SetFocus Column1
514:     *==========================================================================
515:     PROCEDURE CmdInserirClick()
516:         LOCAL loc_oGrid, loc_oErro
517:         TRY
518:             IF THIS.this_oBusinessObject.InserirLinhaVazia()
519:                 IF VARTYPE(THIS.pgf_4c_Principal) = "O"
520:                     loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
521:                     IF VARTYPE(loc_oGrid) = "O"
522:                         SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
523:                         GO BOTTOM
524:                         loc_oGrid.Refresh()
525:                         loc_oGrid.Column1.SetFocus()
526:                     ENDIF
527:                 ENDIF
528:             ENDIF
529:         CATCH TO loc_oErro
530:             MsgErro(loc_oErro.Message + CHR(13) + ;
531:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
532:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdInserirClick")
533:         ENDTRY
534:     ENDPROC
535: 
536:     *==========================================================================
537:     * CmdExcluirClick - Exclui linha corrente do grid
538:     * Original: Delete + Skip + Go Bott (se Eof) + GradeOpe.SetFocus
539:     *==========================================================================
540:     PROCEDURE CmdExcluirClick()
541:         LOCAL loc_oErro
542:         TRY
543:             IF THIS.this_oBusinessObject.ExcluirLinhaAtual()
544:                 IF VARTYPE(THIS.pgf_4c_Principal) = "O"
545:                     THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe.Refresh()
546:                 ENDIF
547:             ENDIF
548:         CATCH TO loc_oErro
549:             MsgErro(loc_oErro.Message + CHR(13) + ;
550:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
551:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdExcluirClick")
552:         ENDTRY
553:     ENDPROC
554: 
555:     *==========================================================================
556:     * CmdConfirmarClick - Salva condicoes e fecha o dialog
557:     * Original: valida duplicatas -> se duplicata Return .F. (NAO fecha)
558:     *           -> DELETE SigCdFpN -> INSERT novos -> Release
559:     *==========================================================================
560:     PROCEDURE CmdConfirmarClick()
561:         LOCAL loc_lPodeFechar, loc_oErro
562:         loc_lPodeFechar = .T.
563:         TRY
564:             IF THIS.this_oBusinessObject.this_lGravaDados
565:                 IF !THIS.this_oBusinessObject.Salvar(THIS.this_cDopes)
566:                     loc_lPodeFechar = .F.
567:                 ENDIF
568:             ENDIF
569:         CATCH TO loc_oErro
570:             MsgErro(loc_oErro.Message + CHR(13) + ;
571:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
572:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdConfirmarClick")
573:             loc_lPodeFechar = .F.

*-- Linhas 611 a 629:
611:             THIS.AbrirLookupFpags()
612:         ELSE
613:             IF THIS.this_oBusinessObject.ValidarLookupFpags(loc_cFpags)
614:                 SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
615:                 REPLACE Descrs WITH ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
616:                 THIS.this_oBusinessObject.this_lGravaDados = .T.
617:                 loc_oGrid.Refresh()
618:             ELSE
619:                 THIS.AbrirLookupFpags()
620:             ENDIF
621:         ENDIF
622:     ENDPROC
623: 
624:     *==========================================================================
625:     * AbrirLookupFpags - Abre picker FormBuscaAuxiliar para SigOpFp
626:     * Original: fwBuscaExt em Column1.Text1.Valid
627:     *==========================================================================
628:     PROTECTED PROCEDURE AbrirLookupFpags()
629:         LOCAL loc_oBusca, loc_oGrid, loc_cValAtual, loc_oErro

*-- Linhas 651 a 674:
651:                 loc_oBusca.Show()
652: 
653:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FpNLkpPicker")
654:                     SELECT cursor_4c_FpNLkpPicker
655:                     LOCAL loc_cFpagsEscolhido, loc_cDescrsEscolhido
656:                     loc_cFpagsEscolhido  = ALLTRIM(Fpags)
657:                     loc_cDescrsEscolhido = ALLTRIM(descrs)
658: 
659:                     SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
660:                     REPLACE Fpags  WITH loc_cFpagsEscolhido
661:                     REPLACE Descrs WITH loc_cDescrsEscolhido
662:                     THIS.this_oBusinessObject.this_lGravaDados = .T.
663: 
664:                     IF VARTYPE(loc_oGrid) = "O"
665:                         loc_oGrid.Refresh()
666:                     ENDIF
667:                 ENDIF
668: 
669:                 IF USED("cursor_4c_FpNLkpPicker")
670:                     USE IN cursor_4c_FpNLkpPicker
671:                 ENDIF
672:             ENDIF
673:         CATCH TO loc_oErro
674:             IF USED("cursor_4c_FpNLkpPicker")

*-- Linhas 701 a 719:
701:                 IF VARTYPE(loc_oGrid) = "O"
702:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
703:                     IF USED(loc_cCursor)
704:                         SELECT (loc_cCursor)
705:                         IF RECCOUNT() > 0 AND !EOF()
706:                             loc_oGrid.Refresh()
707:                             loc_oGrid.Column1.SetFocus()
708:                         ELSE
709:                             MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
710:                                 "o de pagamento para alterar.", "Aviso")
711:                         ENDIF
712:                     ENDIF
713:                 ENDIF
714:             ENDIF
715:         CATCH TO loc_oErro
716:             MsgErro(loc_oErro.Message + CHR(13) + ;
717:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
718:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnAlterarClick")
719:         ENDTRY

*-- Linhas 730 a 748:
730:                 IF VARTYPE(loc_oGrid) = "O"
731:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
732:                     IF USED(loc_cCursor)
733:                         SELECT (loc_cCursor)
734:                         IF RECCOUNT() > 0
735:                             GO TOP
736:                             loc_oGrid.Refresh()
737:                             loc_oGrid.SetFocus()
738:                         ELSE
739:                             MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
740:                                 "o de pagamento cadastrada.", "Aviso")
741:                         ENDIF
742:                     ENDIF
743:                 ENDIF
744:             ENDIF
745:         CATCH TO loc_oErro
746:             MsgErro(loc_oErro.Message + CHR(13) + ;
747:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
748:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnVisualizarClick")


### BO (C:\4c\projeto\app\classes\FpNBO.prg):
*====================================================================
* FpNBO.prg
*
* Business Object para Condicoes de Pagamento por Operacao
* Tabela: SigCdFpN (sigcdfpn)
* Schema: cidchaves char(20) PK, dopes char(20), fpags char(12)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpNBO AS BusinessBase

    *-- Campos de SigCdFpN (mapeamento direto com a tabela)
    this_cIdChaves = ""    && cidchaves char(20) - PK (chave unica)
    this_cDopes    = ""    && dopes char(20) - codigo da operacao (FK SigCdOpe)
    this_cFpags    = ""    && fpags char(12) - codigo da condicao de pagamento (FK SigOpFp)

    *-- Campo auxiliar de lookup (SigOpFp.descrs - nao armazenado em SigCdFpN)
    this_cDescrs   = ""    && descrs char(30) - descricao da condicao (SigOpFp)

    *-- Controle de estado operacional
    this_lGravaDados = .F. && .T. se houver alteracoes pendentes de gravacao

    *-- Cursores de trabalho
    this_cCursorOpe    = "cursor_4c_xOpe"        && cursor editavel do grid
    this_cCursorDados  = "cursor_4c_SigCdFpN"    && cursor de dados SQL Server

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFpN"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cDopes    = TratarNulo(Dopes,     "C")
                THIS.this_cFpags    = TratarNulo(Fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarCursorTrabalho - Cria cursor editavel para o grid
    * Estrutura identica ao cursor xOpe do legado
    *====================================================================
    PROCEDURE InicializarCursorTrabalho()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorOpe) ;
                (Dopes C(20) NULL, Fpags C(12) NULL, Descrs C(30) NULL)
            SET NULL OFF
            INDEX ON Dopes TAG Dopes
            SET ORDER TO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InicializarCursorTrabalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarRegistros - Carrega SigCdFpN + descricao SigOpFp para o grid
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    PROCEDURE CarregarRegistros(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarCursorTrabalho()
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.Fpags, b.descrs " + ;
                       "FROM SigCdFpN a " + ;
                       "INNER JOIN SigOpFp b ON a.Fpags = b.Fpags " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNTemp")
            IF loc_nRet < 1
                MsgAviso("Erro ao carregar condi" + CHR(231) + CHR(245) + ;
                    "es de pagamento para opera" + CHR(231) + CHR(227) + "o: " + ;
                    ALLTRIM(par_cDopes), "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            APPEND FROM DBF("cursor_4c_FpNTemp")

            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarRegistros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaVazia - Adiciona linha em branco no cursor de trabalho
    *====================================================================
    PROCEDURE InserirLinhaVazia()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                INSERT INTO (THIS.this_cCursorOpe) (Fpags) VALUES (SPACE(12))
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InserirLinhaVazia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Exclui linha corrente do cursor de trabalho
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                IF NOT EOF()
                    DELETE
                    SKIP
                    IF EOF()
                        GO BOTTOM
                    ENDIF
                    THIS.this_lGravaDados = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExcluirLinhaAtual")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDuplicatas - Verifica se ha condicoes de pagamento duplicadas
    * Retorna .T. se SEM duplicatas, .F. se houver
    *====================================================================
    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_nDupls
        loc_lValido = .T.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT Fpags, COUNT(*) AS Qt ;
                    FROM (THIS.this_cCursorOpe) ;
                    WHERE NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags)) ;
                    GROUP BY Fpags ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_FpNDupl

                loc_nDupls = RECCOUNT("cursor_4c_FpNDupl")
                IF USED("cursor_4c_FpNDupl")
                    USE IN cursor_4c_FpNDupl
                ENDIF

                IF loc_nDupls > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Condi" + CHR(231) + ;
                        CHR(245) + "es Em Duplicidade!!!", ;
                        "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNDupl")
                USE IN cursor_4c_FpNDupl
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarDuplicatas")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *====================================================================
    * ValidarLookupFpags - Valida codigo de condicao de pagamento no SQL Server
    * Retorna .T. se encontrado e preenche this_cDescrs
    *====================================================================
    FUNCTION ValidarLookupFpags(par_cFpags)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nRet
        loc_lEncontrou = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cFpags))
                loc_cSQL = "SELECT TOP 1 Fpags, descrs FROM SigOpFp " + ;
                           "WHERE Fpags = " + EscaparSQL(ALLTRIM(par_cFpags))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNLkp")
                IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_FpNLkp") > 0
                    SELECT cursor_4c_FpNLkp
                    THIS.this_cFpags  = ALLTRIM(Fpags)
                    THIS.this_cDescrs = ALLTRIM(descrs)
                    loc_lEncontrou = .T.
                ENDIF
                IF USED("cursor_4c_FpNLkp")
                    USE IN cursor_4c_FpNLkp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNLkp")
                USE IN cursor_4c_FpNLkp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarLookupFpags")
        ENDTRY
        RETURN loc_lEncontrou
    ENDFUNC

    *====================================================================
    * Inserir - Insere registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o e Condi" + CHR(231) + ;
                    CHR(227) + "o de Pagamento s" + CHR(227) + "o obrigat" + CHR(243) + "rios.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                MsgAviso("Registro n" + CHR(227) + "o identificado para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdFpN SET " + ;
                       "Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + " " + ;
                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui registro unico por chave primaria
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdFpN WHERE cIdChaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento.", ;
                    "FpNBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Salvar - Salva todas as condicoes de pagamento de uma operacao
    * Fluxo: validar duplicatas -> DELETE todos -> INSERT novos -> COMMIT
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    FUNCTION Salvar(par_cDopes)
        LOCAL loc_lSucesso, loc_nRet, loc_cSql, loc_cIdChaves, loc_cFpags
        loc_lSucesso = .F.
        TRY
            *-- 1. Validar duplicatas antes de qualquer operacao SQL
            IF NOT THIS.ValidarDuplicatas()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir todos os registros existentes para a operacao
            loc_cSql = "DELETE FROM SigCdFpN WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
            IF loc_nRet < 0
                MsgErro("Erro ao excluir registros anteriores de " + ALLTRIM(par_cDopes) + ".", ;
                    "FpNBO.Salvar")
                loc_lSucesso = .F.
            ENDIF

            *-- 3. Inserir registros nao-excluidos e nao-vazios do cursor de trabalho
            SELECT (THIS.this_cCursorOpe)
            SCAN FOR NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags))
                loc_cFpags    = ALLTRIM(Fpags)
                loc_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSql = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                           EscaparSQL(loc_cFpags) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
                IF loc_nRet < 0
                    MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o: " + loc_cFpags + ".", ;
                        "FpNBO.Salvar")
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorOpe)
            ENDSCAN

            *-- 4. Auditoria
            THIS.this_cDopes = ALLTRIM(par_cDopes)
            THIS.RegistrarAuditoria("ATUALIZAR")

            THIS.this_lGravaDados = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Salvar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores ao destruir o BO
    *====================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

