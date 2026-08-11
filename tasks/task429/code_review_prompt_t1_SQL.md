# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, NPARCS, PARCDES

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
Select CrSigOpFpP
lcSql = [Select * From SigOpFpP Where Fpags = ']+CrSigOpFp.Fpags+[' Order by nparcs ]
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'xFpagI') < 1
Select xFpagI
	Insert Into CrSigOpFpP From array Memvar
Select xFpagI
	.Column1.ControlSource = 'xFPagi.nparcs'
	.Column2.ControlSource = 'xFPagi.Descs'
	.Column3.ControlSource = 'xFPagi.ValMins'
	.Column5.ControlSource = 'xFPagi.ValMaxs'
	.Column4.ControlSource = 'xFPagi.parcDes'
Insert Into xFPagI (fPags) Values ( crSigOpFp.fpags )
Select xFPagi
Select xFPagi
	Delete
	Select nParcs,Descs,sum(1) From xFPagi Where nParcs > 0 And (xFPagi.Descs > 0 Or xFpagi.ParcDes > 0 ) ;
	Select TT
	Select crSigOpFpP
	Delete all
	Select xFPagi
			Insert Into crSigOpFpp From array memvar
			SELECT crSigOpFpP
			SELECT xFPagi
	Retorno=ThisForm.ParentForm.podatamgr.Update("crSigOpFpP")

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFPP.prg) - TRECHOS RELEVANTES PARA PASS SQL (979 linhas total):

*-- Linhas 360 a 387:
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle   = 2
363:             .DeleteMark       = .F.
364:             .RecordMark       = .F.
365:             .RowHeight        = 16
366:             .ScrollBars       = 2
367:         ENDWITH
368: 
369:         *-- Column1: Parcelas (nparcs N(2,0)) - sempre editavel
370:         WITH loc_oGrid.Column1
371:             .Width           = 60
372:             .ControlSource   = "xFPagi.nparcs"
373:             .Sparse          = .F.
374:             .Movable         = .F.
375:             .Resizable       = .F.
376:             .FontName        = "Tahoma"
377:             .FontSize        = 8
378:         ENDWITH
379:         WITH loc_oGrid.Column1.Header1
380:             .Caption         = "Parcelas"
381:             .Alignment       = 2
382:             .FontName        = "Tahoma"
383:             .FontSize        = 8
384:         ENDWITH
385:         WITH loc_oGrid.Column1.Text1
386:             .InputMask       = "99"
387:             .Value           = 0

*-- Linhas 396 a 414:
396:         *-- Column2: % Desconto (Descs N(5,2)) - exclusivo com parcDes
397:         WITH loc_oGrid.Column2
398:             .Width           = 70
399:             .ControlSource   = "xFPagi.Descs"
400:             .Sparse          = .F.
401:             .Movable         = .F.
402:             .Resizable       = .F.
403:             .FontName        = "Tahoma"
404:             .FontSize        = 8
405:         ENDWITH
406:         WITH loc_oGrid.Column2.Header1
407:             .Caption         = "% Desconto"
408:             .Alignment       = 2
409:             .FontName        = "Tahoma"
410:             .FontSize        = 8
411:         ENDWITH
412:         WITH loc_oGrid.Column2.Text1
413:             .InputMask       = "999.99"
414:             .Value           = 0

*-- Linhas 422 a 440:
422: 
423:         *-- Column3: Valor Minimo (ValMins N(11,2))
424:         WITH loc_oGrid.Column3
425:             .ControlSource   = "xFPagi.ValMins"
426:             .Sparse          = .F.
427:             .Movable         = .F.
428:             .Resizable       = .F.
429:             .FontName        = "Tahoma"
430:             .FontSize        = 8
431:         ENDWITH
432:         WITH loc_oGrid.Column3.Header1
433:             .Caption         = "Valor M" + CHR(237) + "nimo"
434:             .Alignment       = 2
435:             .FontName        = "Tahoma"
436:             .FontSize        = 8
437:         ENDWITH
438:         WITH loc_oGrid.Column3.Text1
439:             .InputMask       = "9,999,999.99"
440:             .Value           = 0

*-- Linhas 451 a 469:
451:         WITH loc_oGrid.Column4
452:             .Width           = 20
453:             .ColumnOrder     = 5
454:             .ControlSource   = "xFPagi.parcDes"
455:             .Sparse          = .F.
456:             .Movable         = .F.
457:             .Resizable       = .F.
458:             .FontName        = "Tahoma"
459:             .FontSize        = 8
460:         ENDWITH
461:         WITH loc_oGrid.Column4.Header1
462:             .Caption         = "P"
463:             .Alignment       = 2
464:             .FontBold        = .T.
465:             .FontName        = "Tahoma"
466:             .FontSize        = 8
467:         ENDWITH
468:         WITH loc_oGrid.Column4.Text1
469:             .InputMask       = "9"

*-- Linhas 480 a 498:
480:         *-- ColumnOrder=4 faz Column5 aparecer visualmente na 4a posicao (antes de P)
481:         WITH loc_oGrid.Column5
482:             .ColumnOrder     = 4
483:             .ControlSource   = "xFPagi.ValMaxs"
484:             .Sparse          = .F.
485:             .Movable         = .F.
486:             .Resizable       = .F.
487:             .FontName        = "Tahoma"
488:             .FontSize        = 8
489:         ENDWITH
490:         WITH loc_oGrid.Column5.Header1
491:             .Caption         = "Valor M" + CHR(225) + "ximo"
492:             .Alignment       = 2
493:             .FontName        = "Tahoma"
494:             .FontSize        = 8
495:         ENDWITH
496:         WITH loc_oGrid.Column5.Text1
497:             .InputMask       = "9,999,999.99"
498:             .Value           = 0

*-- Linhas 578 a 596:
578:             IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cFpags)
579:                 THIS.this_lGravaDados = .T.
580:                 IF USED("xFPagi")
581:                     SELECT xFPagi
582:                     GO BOTTOM
583:                 ENDIF
584:                 THIS.grd_4c_Dados.Refresh()
585:                 THIS.grd_4c_Dados.Column1.SetFocus()
586:             ENDIF
587: 
588:         CATCH TO loc_oErro
589:             MsgErro(loc_oErro.Message + CHR(13) + ;
590:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
591:                     "Procedure: " + loc_oErro.Procedure, "Erro ao inserir linha")
592:         ENDTRY
593:     ENDPROC
594: 
595:     *==========================================================================
596:     * CmdExcluirClick - remove linha corrente do cursor local xFPagi

*-- Linhas 723 a 741:
723:                 RETURN
724:             ENDIF
725: 
726:             SELECT xFPagi
727:             IF RECCOUNT("xFPagi") = 0 OR EOF("xFPagi")
728:                 MsgAviso("Nenhum registro para alterar. Use Inserir para adicionar linhas.", ;
729:                         "Aviso")
730:                 RETURN
731:             ENDIF
732: 
733:             loc_oGrid = THIS.grd_4c_Dados
734: 
735:             *-- Reaplicar regras de editabilidade da linha corrente
736:             THIS.GrdAfterRowColChange(1)
737: 
738:             *-- Posicionar foco no primeiro campo editavel:
739:             *-- Column1 (nparcs) sempre editavel
740:             loc_oGrid.SetFocus()
741:             loc_oGrid.ActivateCell(RECNO("xFPagi"), 1)

*-- Linhas 781 a 799:
781:                 THIS.this_lGravaDados = .F.
782:                 THIS.grd_4c_Dados.Refresh()
783:                 IF USED("xFPagi") AND RECCOUNT("xFPagi") > 0
784:                     SELECT xFPagi
785:                     GO TOP
786:                     THIS.GrdAfterRowColChange(1)
787:                 ENDIF
788:             ELSE
789:                 MsgErro("Erro ao recarregar descontos de parcelas.", "Erro")
790:             ENDIF
791: 
792:         CATCH TO loc_oErro
793:             MsgErro(loc_oErro.Message + CHR(13) + ;
794:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
795:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
796:         ENDTRY
797:     ENDPROC
798: 
799:     *==========================================================================

*-- Linhas 809 a 845:
809:         IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFpags)
810:             THIS.grd_4c_Dados.Refresh()
811:             IF USED("xFPagi") AND RECCOUNT("xFPagi") > 0
812:                 SELECT xFPagi
813:                 GO TOP
814:                 THIS.GrdAfterRowColChange(1)
815:             ENDIF
816:             loc_lSucesso = .T.
817:         ELSE
818:             MsgErro("Erro ao carregar descontos de parcelas.", "Erro")
819:         ENDIF
820: 
821:         RETURN loc_lSucesso
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * FormParaBO - le registro corrente do cursor xFPagi e popula props do BO
826:     * Para popup OPERACIONAL com grid: mapeia linha corrente para BO.
827:     *==========================================================================
828:     PROCEDURE FormParaBO()
829:         IF USED("xFPagi") AND !EOF("xFPagi")
830:             SELECT xFPagi
831:             THIS.this_oBusinessObject.this_cFpags     = TratarNulo(xFPagi.fpags,     "C")
832:             THIS.this_oBusinessObject.this_nNparcs    = TratarNulo(xFPagi.nparcs,    "N")
833:             THIS.this_oBusinessObject.this_nDescs     = TratarNulo(xFPagi.Descs,     "N")
834:             THIS.this_oBusinessObject.this_nValMins   = TratarNulo(xFPagi.ValMins,   "N")
835:             THIS.this_oBusinessObject.this_nValMaxs   = TratarNulo(xFPagi.ValMaxs,   "N")
836:             THIS.this_oBusinessObject.this_nParcDes   = TratarNulo(xFPagi.parcDes,   "N")
837:             THIS.this_oBusinessObject.this_cCidChaves = TratarNulo(xFPagi.cidchaves, "C")
838:         ENDIF
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * BOParaForm - atualiza form a partir das props do BO
843:     * Para popup OPERACIONAL com grid: dados estao em xFPagi (cursor do grid),
844:     * basta dar Refresh no grid para refletir qualquer alteracao no BO.
845:     *==========================================================================


### BO (C:\4c\projeto\app\classes\FPPBO.prg):
*==============================================================================
* FPPBO.prg - Business Object: Desconto por No. de Parcelas
* Tabela: SigOpFpp
* Herda de: BusinessBase
*
* Colunas SigOpFpp (schema.sql):
*   cidchaves  char(20)       - Chave unica PK (gerada por SYS(2015))
*   descs      numeric(5,2)   - % Desconto
*   fpags      char(12)       - Codigo da condicao de pagamento (FK SigOpFp)
*   nparcs     numeric(2,0)   - No. de parcelas
*   parcdes    numeric(1,0)   - Qtd parcelas de desconto (P)
*   valmins    numeric(11,2)  - Valor minimo
*   valmaxs    numeric(11,2)  - Valor maximo
*
* Cursor local de edicao: xFPagi (criado em CarregarDados, usado pelo Form)
* Salvar: DELETE FROM SigOpFpp + re-INSERT linha a linha via SQLEXEC
*==============================================================================

DEFINE CLASS FPPBO AS BusinessBase

    this_cTabela      = "SigOpFpp"
    this_cCampoChave  = "cidchaves"

    *-- Props de SigOpFpp
    this_cFpags       = ""   && fpags char(12)
    this_nNparcs      = 0    && nparcs numeric(2,0)
    this_nDescs       = 0    && descs numeric(5,2)
    this_nValMins     = 0    && valmins numeric(11,2)
    this_nValMaxs     = 0    && valmaxs numeric(11,2)
    this_nParcDes     = 0    && parcdes numeric(1,0)
    this_cCidChaves   = ""   && cidchaves char(20)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor xFPagi para props do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags     = TratarNulo(fpags,     "C")
            THIS.this_nNparcs    = TratarNulo(nparcs,    "N")
            THIS.this_nDescs     = TratarNulo(Descs,     "N")
            THIS.this_nValMins   = TratarNulo(ValMins,   "N")
            THIS.this_nValMaxs   = TratarNulo(ValMaxs,   "N")
            THIS.this_nParcDes   = TratarNulo(parcDes,   "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha individual em SigOpFpp
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave

        loc_lSucesso = .F.

        TRY
            loc_cChave           = SYS(2015)
            THIS.this_cCidChaves = loc_cChave

            loc_cSql = "INSERT INTO SigOpFpp " + ;
                       "(cidchaves, fpags, nparcs, descs, valmins, valmaxs, parcdes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDescs,  2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMaxs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nParcDes, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                MsgErro("Erro ao inserir registro em SigOpFpp.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha individual em SigOpFpp
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSql

        loc_lSucesso = .F.

        TRY
            loc_cSql = "UPDATE SigOpFpp SET " + ;
                       "nparcs  = " + FormatarNumeroSQL(THIS.this_nNparcs,  0) + ", " + ;
                       "descs   = " + FormatarNumeroSQL(THIS.this_nDescs,   2) + ", " + ;
                       "valmins = " + FormatarNumeroSQL(THIS.this_nValMins, 2) + ", " + ;
                       "valmaxs = " + FormatarNumeroSQL(THIS.this_nValMaxs, 2) + ", " + ;
                       "parcdes = " + FormatarNumeroSQL(THIS.this_nParcDes, 0) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                MsgErro("Erro ao atualizar registro em SigOpFpp.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - carrega registros de SigOpFpp para cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento (SigOpFp.fpags)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                USE IN xFPagi
            ENDIF

            SET NULL ON
            CREATE CURSOR xFPagi (;
                fpags     C(12)   NULL, ;
                nparcs    N(2,0)  NULL, ;
                Descs     N(5,2)  NULL, ;
                ValMins   N(11,2) NULL, ;
                ValMaxs   N(11,2) NULL, ;
                parcDes   N(1,0)  NULL, ;
                cidchaves C(20)   NULL  ;
            )
            SET NULL OFF

            loc_cSql = "SELECT fpags, nparcs, descs, valmins, valmaxs, parcdes, cidchaves " + ;
                       "FROM SigOpFpp " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + " " + ;
                       "ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSql, "xFPagiTemp") > 0
                SELECT xFPagi
                ZAP
                APPEND FROM DBF("xFPagiTemp")
                IF USED("xFPagiTemp")
                    USE IN xFPagiTemp
                ENDIF
            ENDIF

            SELECT xFPagi
            IF RECCOUNT() > 0
                INDEX ON nparcs TAG nparcs
                SET ORDER TO
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - adiciona nova linha vazia no cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento para preencher fpags
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                SELECT xFPagi
                INSERT INTO xFPagi ;
                    (fpags, nparcs, Descs, ValMins, ValMaxs, parcDes, cidchaves) ;
                    VALUES (par_cFpags, 0, 0, 0, 0, 0, "")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inserir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - remove linha atual do cursor local xFPagi
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi") AND NOT EOF("xFPagi")
                SELECT xFPagi
                DELETE
                SKIP
                SKIP -1
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao excluir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - verifica duplicidade nparcs+descs em xFPagi
    * Retorna .T. se os dados sao validos para gravar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAntesDeSalvar()
        LOCAL loc_lValido, loc_lDuplic

        loc_lValido = .T.

        IF USED("xFPagi")
            SELECT nparcs, Descs, SUM(1) AS nQtd ;
                FROM xFPagi ;
                WHERE nparcs > 0 AND (Descs > 0 OR parcDes > 0) ;
                GROUP BY nparcs, Descs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            loc_lDuplic = (RECCOUNT("cursor_4c_DupCheck") > 0)

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

            IF loc_lDuplic
                MsgAviso("Dados Inconsistentes. No. de Parcelas/% Desconto em duplicidade!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarDados - persiste cursor local xFPagi em SigOpFpp via SQLEXEC
    * par_cFpags: codigo da condicao de pagamento
    * Fluxo: valida -> DELETE FROM SigOpFpp -> re-INSERT linha a linha
    *--------------------------------------------------------------------------
    PROCEDURE SalvarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave, loc_lErroInsert

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarAntesDeSalvar()

                *-- Remove todos os registros anteriores desta condicao de pagamento
                loc_cSql = "DELETE FROM SigOpFpp WHERE fpags = " + EscaparSQL(par_cFpags)

                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                    MsgErro("Erro ao remover registros de SigOpFpp.", "Erro")
                ELSE
                    *-- Re-insere a partir do cursor local xFPagi
                    loc_lErroInsert = .F.

                    IF USED("xFPagi")
                        SELECT xFPagi
                        GO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(xFPagi.nparcs) AND ;
                               (!EMPTY(xFPagi.Descs) OR !EMPTY(xFPagi.parcDes))

                                loc_cChave = SYS(2015)

                                loc_cSql = "INSERT INTO SigOpFpp " + ;
                                           "(cidchaves, fpags, nparcs, descs, " + ;
                                           " valmins, valmaxs, parcdes) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave) + ", " + ;
                                           EscaparSQL(xFPagi.fpags) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.nparcs,  0) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.Descs,   2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMins, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMaxs, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.parcDes, 0) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                                    MsgErro("Erro ao inserir linha em SigOpFpp." + CHR(13) + ;
                                            "Parcelas: " + TRANSFORM(xFPagi.nparcs), "Erro")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lErroInsert
                        THIS.RegistrarAuditoria("SALVAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao salvar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSql, loc_oErro

        TRY
            loc_cSql = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, Chave, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

