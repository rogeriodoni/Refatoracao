# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNBOT

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
		lcSql = [Select ClockEcfs From SigCdPac ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac')
			.Column1.ControlSource = 'CrProduto.Cpros'
			.Column2.ControlSource = 'CrProduto.Dpros'
		Select CrProduto
	Select CrProduto
Select CrProduto

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS SQL (948 linhas total):

*-- Linhas 61 a 83:
61:                 TABLEREVERT(.T., "CrProduto")
62:                 USE IN CrProduto
63:             ENDIF
64:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
65:             SET NULL OFF
66: 
67:             *-- Linha em branco inicial para entrada imediata
68:             SELECT CrProduto
69:             APPEND BLANK
70: 
71:             *-- Carregar tempo de espera ECF de SigCdPac
72:             THIS.this_oBusinessObject.CarregarConfiguracao()
73:             THIS.this_nClockEcfs = THIS.this_oBusinessObject.this_nClockEcfs
74: 
75:             *-- Montar layout do form
76:             THIS.ConfigurarPageFrame()
77:             THIS.ConfigurarReferencia()
78:             THIS.ConfigurarPaginaLista()
79:             THIS.ConfigurarPaginaDados()
80:             THIS.ConfigurarMensagem()
81:             THIS.ConfigurarBotoes()
82:             THIS.TornarControlesVisiveis()
83: 

*-- Linhas 352 a 370:
352:             .ReadOnly           = .F.
353:             .RowHeight          = 17
354:             .RecordMark         = .F.
355:             .DeleteMark         = .F.
356:             .GridLineColor      = RGB(200, 200, 200)
357:             .HighlightStyle     = 2
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:         ENDWITH
361: 
362:         *-- Coluna 1: Codigo do Produto
363:         WITH loc_oGrd.Column1
364:             .Width      = 108
365:             .FontName   = "Courier New"
366:             .FontSize   = 8
367:             .Movable    = .F.
368:             .Resizable  = .F.
369:             .ReadOnly   = .F.
370:             .Sparse     = .F.

*-- Linhas 411 a 432:
411:             .Margin      = 0
412:         ENDWITH
413: 
414:         *-- Vincular RecordSource e ControlSources
415:         loc_oGrd.RecordSource          = "CrProduto"
416:         loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
417:         loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
418: 
419:         *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
420:         loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
421:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
422: 
423:         *-- Vincular eventos de teclado e foco da Column1.Text1
424:         BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus", THIS, "TxtCodProdGotFocus")
425:         BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TxtCodProdKeyPress")
426:     ENDPROC
427: 
428:     *==========================================================================
429:     * AlternarPagina - Form flat sem PageFrame; mantido para compatibilidade
430:     *==========================================================================
431:     PROCEDURE AlternarPagina(par_nPagina)
432:         *-- Form flat sem PageFrame: nao ha paginas a alternar

*-- Linhas 470 a 508:
470:         *-- Codigo nao mudou e nao e F4: apenas navegar se Enter
471:         IF loc_cCodigo = THIS.this_cAntCPro AND par_nKeyCode != 115
472:             IF par_nKeyCode = 13
473:                 SELECT CrProduto
474:                 loc_nRecno = RECNO()
475:                 LOCATE FOR EMPTY(Cpros)
476:                 IF EOF()
477:                     APPEND BLANK
478:                 ENDIF
479:                 LOCATE FOR RECNO() = loc_nRecno
480:                 KEYBOARD '{DNARROW}'
481:             ENDIF
482:             RETURN
483:         ENDIF
484: 
485:         *-- Busca exata no SQL Server
486:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
487:                    "WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCodigo)
488:         IF USED("cursor_4c_ProLkp")
489:             USE IN cursor_4c_ProLkp
490:         ENDIF
491:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProLkp") > 0
492:             IF NOT EOF("cursor_4c_ProLkp")
493:                 SELECT cursor_4c_ProLkp
494:                 loc_cCodigo = ALLTRIM(cpros)
495:                 loc_cDpros  = ALLTRIM(dpros)
496:                 loc_lAchou  = .T.
497:             ENDIF
498:             IF USED("cursor_4c_ProLkp")
499:                 USE IN cursor_4c_ProLkp
500:             ENDIF
501:         ELSE
502:             IF USED("cursor_4c_ProLkp")
503:                 USE IN cursor_4c_ProLkp
504:             ENDIF
505:         ENDIF
506: 
507:         *-- Nao encontrado: abrir picker FormBuscaAuxiliar
508:         IF NOT loc_lAchou

*-- Linhas 514 a 547:
514:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
515:                 loc_oBusca.Show()
516:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
517:                     SELECT cursor_4c_ProBusca
518:                     loc_cCodigo = ALLTRIM(cpros)
519:                     loc_cDpros  = ALLTRIM(dpros)
520:                     loc_lAchou  = .T.
521:                 ENDIF
522:                 IF USED("cursor_4c_ProBusca")
523:                     USE IN cursor_4c_ProBusca
524:                 ENDIF
525:                 loc_oBusca.Release()
526:             ENDIF
527:         ENDIF
528: 
529:         *-- Preencher campos no grid e navegar para proxima linha (se Enter)
530:         IF loc_lAchou
531:             loc_oTxt.Value = loc_cCodigo
532:             SELECT CrProduto
533:             REPLACE dpros WITH loc_cDpros
534:             loc_oGrd.Column2.Text1.Value = loc_cDpros
535:             loc_oGrd.Refresh()
536:             IF par_nKeyCode = 13
537:                 loc_nRecno = RECNO()
538:                 LOCATE FOR EMPTY(Cpros)
539:                 IF EOF()
540:                     APPEND BLANK
541:                 ENDIF
542:                 LOCATE FOR RECNO() = loc_nRecno
543:                 KEYBOARD '{DNARROW}'
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 

*-- Linhas 553 a 571:
553:         LOCAL loc_nCount, loc_ldDataI, loc_nW, loc_nX, loc_nTempo
554:         LOCAL loc_nBot, loc_cMacro
555: 
556:         SELECT CrProduto
557:         COUNT TO loc_nCount FOR NOT EMPTY(Cpros)
558:         IF loc_nCount = 0
559:             MsgAviso("Nenhum Produto Informado!!!", ;
560:                      "Aten" + CHR(231) + CHR(227) + "o")
561:             RETURN
562:         ENDIF
563: 
564:         THIS.cnt_4c_Mensagem.Visible = .T.
565:         loc_ldDataI = DATETIME()
566:         loc_nW      = THIS.this_nClockEcfs / 3
567:         loc_nX      = 13
568: 
569:         DO WHILE DATETIME() - loc_ldDataI < THIS.this_nClockEcfs
570:             loc_nTempo = DATETIME() - loc_ldDataI
571:             IF loc_nX >= 13

*-- Linhas 624 a 646:
624: 
625:         IF NOT USED("CrProduto")
626:             SET NULL ON
627:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
628:             SET NULL OFF
629:         ENDIF
630: 
631:         SELECT CrProduto
632:         LOCATE FOR EMPTY(Cpros)
633:         IF EOF()
634:             APPEND BLANK
635:         ENDIF
636:         loc_nRecno = RECNO()
637: 
638:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
639:         IF VARTYPE(loc_oGrd) = "O"
640:             loc_oGrd.Refresh()
641:             loc_oGrd.SetFocus()
642:             loc_oGrd.ActivateCell(loc_nRecno, 1)
643:             loc_oGrd.Column1.Text1.SetFocus()
644:         ENDIF
645:     ENDPROC
646: 

*-- Linhas 683 a 736:
683:         IF VARTYPE(loc_oGrd) = "O"
684:             loc_oGrd.Column1.ReadOnly = .T.
685:             loc_oGrd.Column2.ReadOnly = .T.
686:             SELECT CrProduto
687:             GO TOP
688:             loc_oGrd.Refresh()
689:         ENDIF
690:     ENDPROC
691: 
692:     *==========================================================================
693:     * BtnExcluirClick - Remove linha corrente do cursor de produtos
694:     * Confirma com MsgConfirma antes de DELETE + PACK
695:     *==========================================================================
696:     PROCEDURE BtnExcluirClick()
697:         LOCAL loc_oGrd, loc_cCodigo, loc_lConfirma
698: 
699:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
700:             MsgAviso("Nenhum produto informado para excluir.", ;
701:                      "Aten" + CHR(231) + CHR(227) + "o")
702:             RETURN
703:         ENDIF
704: 
705:         SELECT CrProduto
706:         IF EMPTY(Cpros)
707:             MsgAviso("Selecione uma linha com produto v" + CHR(225) + "lido.", ;
708:                      "Aten" + CHR(231) + CHR(227) + "o")
709:             RETURN
710:         ENDIF
711: 
712:         loc_cCodigo   = ALLTRIM(Cpros)
713:         loc_lConfirma = MsgConfirma("Excluir o produto " + loc_cCodigo + " da rela" + ;
714:                                     CHR(231) + CHR(227) + "o?", ;
715:                                     "Confirma" + CHR(231) + CHR(227) + "o")
716:         IF NOT loc_lConfirma
717:             RETURN
718:         ENDIF
719: 
720:         SELECT CrProduto
721:         DELETE
722:         PACK
723:         IF RECCOUNT("CrProduto") = 0
724:             APPEND BLANK
725:         ENDIF
726:         GO TOP
727: 
728:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
729:         IF VARTYPE(loc_oGrd) = "O"
730:             loc_oGrd.Refresh()
731:             loc_oGrd.SetFocus()
732:             loc_oGrd.Column1.Text1.SetFocus()
733:         ENDIF
734:     ENDPROC
735: 
736:     *==========================================================================

*-- Linhas 758 a 780:
758:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
759:             loc_oBusca.Show()
760:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
761:                 SELECT cursor_4c_ProBusca
762:                 loc_cCodigo = ALLTRIM(cpros)
763:                 loc_cDpros  = ALLTRIM(dpros)
764:                 loc_oTxt.Value = loc_cCodigo
765:                 SELECT CrProduto
766:                 REPLACE dpros WITH loc_cDpros
767:                 loc_oGrd.Column2.Text1.Value = loc_cDpros
768:                 loc_oGrd.Refresh()
769:             ENDIF
770:             IF USED("cursor_4c_ProBusca")
771:                 USE IN cursor_4c_ProBusca
772:             ENDIF
773:             loc_oBusca.Release()
774:         ENDIF
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * BtnEncerrarClick - Cancela o dialogo sem transmitir produtos
779:     * Alias de CmdCancelarClick para compatibilidade com o pipeline
780:     *==========================================================================

*-- Linhas 797 a 815:
797:     PROCEDURE BtnCancelarClick()
798:         LOCAL loc_oGrd
799: 
800:         SELECT CrProduto
801:         IF NOT EMPTY(THIS.this_cAntCPro)
802:             REPLACE Cpros WITH THIS.this_cAntCPro
803:         ENDIF
804:         THIS.this_cAntCPro = ""
805: 
806:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
807:         IF VARTYPE(loc_oGrd) = "O"
808:             loc_oGrd.Refresh()
809:             loc_oGrd.SetFocus()
810:             loc_oGrd.Column1.Text1.SetFocus()
811:         ENDIF
812:     ENDPROC
813: 
814:     *==========================================================================
815:     * FormParaBO - Transfere a lista de produtos do cursor CrProduto para o BO

*-- Linhas 831 a 859:
831: 
832:         IF NOT USED("CrProduto")
833:             SET NULL ON
834:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
835:             SET NULL OFF
836:         ENDIF
837: 
838:         SELECT CrProduto
839:         ZAP
840: 
841:         THIS.this_oBusinessObject.PopularCursorProdutos("CrProduto")
842: 
843:         IF RECCOUNT("CrProduto") = 0
844:             SELECT CrProduto
845:             APPEND BLANK
846:         ENDIF
847: 
848:         GO TOP
849: 
850:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
851:         IF VARTYPE(loc_oGrd) = "O"
852:             loc_oGrd.Refresh()
853:         ENDIF
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * HabilitarCampos - Habilita ou desabilita edicao do grid de produtos
858:     * par_lHabilitar: .T. = edicao livre; .F. = somente visualizacao
859:     *==========================================================================

*-- Linhas 881 a 899:
881:         LOCAL loc_oGrd
882: 
883:         IF USED("CrProduto")
884:             SELECT CrProduto
885:             ZAP
886:             APPEND BLANK
887:         ENDIF
888: 
889:         THIS.this_cAntCPro = ""
890: 
891:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
892:         IF VARTYPE(loc_oGrd) = "O"
893:             loc_oGrd.Refresh()
894:             loc_oGrd.SetFocus()
895:             loc_oGrd.Column1.Text1.SetFocus()
896:         ENDIF
897:     ENDPROC
898: 
899:     *==========================================================================

*-- Linhas 907 a 936:
907:         TRY
908:             IF NOT USED("CrProduto")
909:                 SET NULL ON
910:                 CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
911:                 SET NULL OFF
912:                 SELECT CrProduto
913:                 APPEND BLANK
914:             ENDIF
915: 
916:             loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
917:             IF VARTYPE(loc_oGrd) = "O"
918:                 loc_oGrd.ColumnCount          = 2
919:                 loc_oGrd.RecordSource         = "CrProduto"
920:                 loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
921:                 loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
922:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
923:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
924:                 loc_oGrd.Refresh()
925:             ENDIF
926:             loc_lSucesso = .T.
927:         CATCH TO loc_oErro
928:             MsgErro(loc_oErro.Message + " | LN: " + TRANSFORM(loc_oErro.LineNo), ;
929:                     "Erro ao carregar lista")
930:         ENDTRY
931: 
932:         RETURN loc_lSucesso
933:     ENDPROC
934: 
935:     *==========================================================================
936:     * AjustarBotoesPorModo - Sem modo separado neste dialogo; sem botoes CRUD


### BO (C:\4c\projeto\app\classes\SIGPRTRFBO.prg):
*==============================================================================
* SIGPRTRFBO.prg - Business Object para Relacao de Produtos (SIGPRTRF)
* Formulario OPERACIONAL - dialogo de selecao de produtos
* Tabela principal: SigCdPro (lookup de produtos)
* Tabela auxiliar:  SigCdPac (ClockEcfs - tempo de espera ECF)
*==============================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Tabela e chave primaria
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "cpros"

    *-- Configuracao de temporizacao (SigCdPac.ClockEcfs)
    this_nClockEcfs  = 0

    *-- Estado do dialogo
    this_cRetorno    = " "
    this_cAntCPro    = ""

    *-- Produto corrente (cpros char(14), dpros char(40))
    this_cCpros      = ""
    this_cDpros      = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarConfiguracao - carrega ClockEcfs de SigCdPac
    *==========================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.
        loc_cSQL     = "SELECT ClockEcfs FROM SigCdPac"

        TRY
            IF USED("cursor_4c_Pac")
                TABLEREVERT(.T., "cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    THIS.this_nClockEcfs = NVL(ClockEcfs, 0)
                ELSE
                    THIS.this_nClockEcfs = 0
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_nClockEcfs = 0
                loc_lSucesso         = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_nClockEcfs = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarProduto - busca produtos por codigo/descricao em SigCdPro
    * par_cCodigo        - valor digitado para busca (LIKE prefix)
    * par_cCursorDestino - cursor de destino (default: cursor_4c_Prods)
    * Retorna .T. se SQLEXEC bem-sucedido
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodigo, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Prods", par_cCursorDestino)
        loc_cSQL     = "SELECT cpros, dpros FROM SigCdPro" + ;
                       " WHERE cpros LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cpros"

        TRY
            IF USED(loc_cCursor)
                TABLEREVERT(.T., loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarProduto - valida se codigo exato existe em SigCdPro
    * Popula this_cCpros e this_cDpros com dados do produto encontrado
    * Retorna .T. se encontrado, .F. caso contrario
    *==========================================================================
    PROCEDURE ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso     = .F.
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro" + ;
                   " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        TRY
            IF USED("cursor_4c_ProdVal")
                TABLEREVERT(.T., "cursor_4c_ProdVal")
                USE IN cursor_4c_ProdVal
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal") > 0
                IF USED("cursor_4c_ProdVal") AND !EOF("cursor_4c_ProdVal")
                    SELECT cursor_4c_ProdVal
                    THIS.this_cCpros = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cDpros = ALLTRIM(NVL(dpros, ""))
                    loc_lSucesso     = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros = TratarNulo(cpros, "C")
            THIS.this_cDpros = TratarNulo(dpros, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave primaria do produto corrente
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDPROC

    *==========================================================================
    * ValidarDados - valida dados antes de confirmar selecao
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + ;
                                      CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigCdPro com registro de auditoria
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + ;
                                      CHR(243) + "rio para inser" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        loc_cSQL = "INSERT INTO SigCdPro (cpros, dpros)" + ;
                   " VALUES (" + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cDpros)) + ")"

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir produto no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir produto: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigCdPro com registro de auditoria
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + ;
                                      CHR(243) + "rio para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        loc_cSQL = "UPDATE SigCdPro SET" + ;
                   " dpros = " + EscaparSQL(ALLTRIM(THIS.this_cDpros)) + ;
                   " WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar produto no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar produto: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

