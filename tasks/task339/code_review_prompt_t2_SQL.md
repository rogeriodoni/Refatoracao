# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNBOT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNBOT

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS SQL (953 linhas total):

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

*-- Linhas 357 a 375:
357:             .ReadOnly           = .F.
358:             .RowHeight          = 17
359:             .RecordMark         = .F.
360:             .DeleteMark         = .F.
361:             .GridLineColor      = RGB(200, 200, 200)
362:             .HighlightStyle     = 2
363:             .HighlightBackColor = RGB(255, 255, 255)
364:             .HighlightForeColor = RGB(15, 41, 104)
365:         ENDWITH
366: 
367:         *-- Coluna 1: Codigo do Produto
368:         WITH loc_oGrd.Column1
369:             .Width      = 108
370:             .FontName   = "Courier New"
371:             .FontSize   = 8
372:             .Movable    = .F.
373:             .Resizable  = .F.
374:             .ReadOnly   = .F.
375:             .Sparse     = .F.

*-- Linhas 416 a 437:
416:             .Margin      = 0
417:         ENDWITH
418: 
419:         *-- Vincular RecordSource e ControlSources
420:         loc_oGrd.RecordSource          = "CrProduto"
421:         loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
422:         loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
423: 
424:         *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
425:         loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
426:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
427: 
428:         *-- Vincular eventos de teclado e foco da Column1.Text1
429:         BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus", THIS, "TxtCodProdGotFocus")
430:         BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TxtCodProdKeyPress")
431:     ENDPROC
432: 
433:     *==========================================================================
434:     * AlternarPagina - Form flat sem PageFrame; mantido para compatibilidade
435:     *==========================================================================
436:     PROCEDURE AlternarPagina(par_nPagina)
437:         *-- Form flat sem PageFrame: nao ha paginas a alternar

*-- Linhas 475 a 513:
475:         *-- Codigo nao mudou e nao e F4: apenas navegar se Enter
476:         IF loc_cCodigo = THIS.this_cAntCPro AND par_nKeyCode != 115
477:             IF par_nKeyCode = 13
478:                 SELECT CrProduto
479:                 loc_nRecno = RECNO()
480:                 LOCATE FOR EMPTY(Cpros)
481:                 IF EOF()
482:                     APPEND BLANK
483:                 ENDIF
484:                 LOCATE FOR RECNO() = loc_nRecno
485:                 KEYBOARD '{DNARROW}'
486:             ENDIF
487:             RETURN
488:         ENDIF
489: 
490:         *-- Busca exata no SQL Server
491:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
492:                    "WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCodigo)
493:         IF USED("cursor_4c_ProLkp")
494:             USE IN cursor_4c_ProLkp
495:         ENDIF
496:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProLkp") > 0
497:             IF NOT EOF("cursor_4c_ProLkp")
498:                 SELECT cursor_4c_ProLkp
499:                 loc_cCodigo = ALLTRIM(cpros)
500:                 loc_cDpros  = ALLTRIM(dpros)
501:                 loc_lAchou  = .T.
502:             ENDIF
503:             IF USED("cursor_4c_ProLkp")
504:                 USE IN cursor_4c_ProLkp
505:             ENDIF
506:         ELSE
507:             IF USED("cursor_4c_ProLkp")
508:                 USE IN cursor_4c_ProLkp
509:             ENDIF
510:         ENDIF
511: 
512:         *-- Nao encontrado: abrir picker FormBuscaAuxiliar
513:         IF NOT loc_lAchou

*-- Linhas 519 a 552:
519:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
520:                 loc_oBusca.Show()
521:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
522:                     SELECT cursor_4c_ProBusca
523:                     loc_cCodigo = ALLTRIM(cpros)
524:                     loc_cDpros  = ALLTRIM(dpros)
525:                     loc_lAchou  = .T.
526:                 ENDIF
527:                 IF USED("cursor_4c_ProBusca")
528:                     USE IN cursor_4c_ProBusca
529:                 ENDIF
530:                 loc_oBusca.Release()
531:             ENDIF
532:         ENDIF
533: 
534:         *-- Preencher campos no grid e navegar para proxima linha (se Enter)
535:         IF loc_lAchou
536:             loc_oTxt.Value = loc_cCodigo
537:             SELECT CrProduto
538:             REPLACE dpros WITH loc_cDpros
539:             loc_oGrd.Column2.Text1.Value = loc_cDpros
540:             loc_oGrd.Refresh()
541:             IF par_nKeyCode = 13
542:                 loc_nRecno = RECNO()
543:                 LOCATE FOR EMPTY(Cpros)
544:                 IF EOF()
545:                     APPEND BLANK
546:                 ENDIF
547:                 LOCATE FOR RECNO() = loc_nRecno
548:                 KEYBOARD '{DNARROW}'
549:             ENDIF
550:         ENDIF
551:     ENDPROC
552: 

*-- Linhas 558 a 576:
558:         LOCAL loc_nCount, loc_ldDataI, loc_nW, loc_nX, loc_nTempo
559:         LOCAL loc_nBot, loc_cMacro
560: 
561:         SELECT CrProduto
562:         COUNT TO loc_nCount FOR NOT EMPTY(Cpros)
563:         IF loc_nCount = 0
564:             MsgAviso("Nenhum Produto Informado!!!", ;
565:                      "Aten" + CHR(231) + CHR(227) + "o")
566:             RETURN
567:         ENDIF
568: 
569:         THIS.cnt_4c_Mensagem.Visible = .T.
570:         loc_ldDataI = DATETIME()
571:         loc_nW      = THIS.this_nClockEcfs / 3
572:         loc_nX      = 13
573: 
574:         DO WHILE DATETIME() - loc_ldDataI < THIS.this_nClockEcfs
575:             loc_nTempo = DATETIME() - loc_ldDataI
576:             IF loc_nX >= 13

*-- Linhas 629 a 651:
629: 
630:         IF NOT USED("CrProduto")
631:             SET NULL ON
632:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
633:             SET NULL OFF
634:         ENDIF
635: 
636:         SELECT CrProduto
637:         LOCATE FOR EMPTY(Cpros)
638:         IF EOF()
639:             APPEND BLANK
640:         ENDIF
641:         loc_nRecno = RECNO()
642: 
643:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
644:         IF VARTYPE(loc_oGrd) = "O"
645:             loc_oGrd.Refresh()
646:             loc_oGrd.SetFocus()
647:             loc_oGrd.ActivateCell(loc_nRecno, 1)
648:             loc_oGrd.Column1.Text1.SetFocus()
649:         ENDIF
650:     ENDPROC
651: 

*-- Linhas 688 a 741:
688:         IF VARTYPE(loc_oGrd) = "O"
689:             loc_oGrd.Column1.ReadOnly = .T.
690:             loc_oGrd.Column2.ReadOnly = .T.
691:             SELECT CrProduto
692:             GO TOP
693:             loc_oGrd.Refresh()
694:         ENDIF
695:     ENDPROC
696: 
697:     *==========================================================================
698:     * BtnExcluirClick - Remove linha corrente do cursor de produtos
699:     * Confirma com MsgConfirma antes de DELETE + PACK
700:     *==========================================================================
701:     PROCEDURE BtnExcluirClick()
702:         LOCAL loc_oGrd, loc_cCodigo, loc_lConfirma
703: 
704:         IF NOT USED("CrProduto") OR RECCOUNT("CrProduto") = 0
705:             MsgAviso("Nenhum produto informado para excluir.", ;
706:                      "Aten" + CHR(231) + CHR(227) + "o")
707:             RETURN
708:         ENDIF
709: 
710:         SELECT CrProduto
711:         IF EMPTY(Cpros)
712:             MsgAviso("Selecione uma linha com produto v" + CHR(225) + "lido.", ;
713:                      "Aten" + CHR(231) + CHR(227) + "o")
714:             RETURN
715:         ENDIF
716: 
717:         loc_cCodigo   = ALLTRIM(Cpros)
718:         loc_lConfirma = MsgConfirma("Excluir o produto " + loc_cCodigo + " da rela" + ;
719:                                     CHR(231) + CHR(227) + "o?", ;
720:                                     "Confirma" + CHR(231) + CHR(227) + "o")
721:         IF NOT loc_lConfirma
722:             RETURN
723:         ENDIF
724: 
725:         SELECT CrProduto
726:         DELETE
727:         PACK
728:         IF RECCOUNT("CrProduto") = 0
729:             APPEND BLANK
730:         ENDIF
731:         GO TOP
732: 
733:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
734:         IF VARTYPE(loc_oGrd) = "O"
735:             loc_oGrd.Refresh()
736:             loc_oGrd.SetFocus()
737:             loc_oGrd.Column1.Text1.SetFocus()
738:         ENDIF
739:     ENDPROC
740: 
741:     *==========================================================================

*-- Linhas 763 a 785:
763:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
764:             loc_oBusca.Show()
765:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProBusca")
766:                 SELECT cursor_4c_ProBusca
767:                 loc_cCodigo = ALLTRIM(cpros)
768:                 loc_cDpros  = ALLTRIM(dpros)
769:                 loc_oTxt.Value = loc_cCodigo
770:                 SELECT CrProduto
771:                 REPLACE dpros WITH loc_cDpros
772:                 loc_oGrd.Column2.Text1.Value = loc_cDpros
773:                 loc_oGrd.Refresh()
774:             ENDIF
775:             IF USED("cursor_4c_ProBusca")
776:                 USE IN cursor_4c_ProBusca
777:             ENDIF
778:             loc_oBusca.Release()
779:         ENDIF
780:     ENDPROC
781: 
782:     *==========================================================================
783:     * BtnEncerrarClick - Cancela o dialogo sem transmitir produtos
784:     * Alias de CmdCancelarClick para compatibilidade com o pipeline
785:     *==========================================================================

*-- Linhas 802 a 820:
802:     PROCEDURE BtnCancelarClick()
803:         LOCAL loc_oGrd
804: 
805:         SELECT CrProduto
806:         IF NOT EMPTY(THIS.this_cAntCPro)
807:             REPLACE Cpros WITH THIS.this_cAntCPro
808:         ENDIF
809:         THIS.this_cAntCPro = ""
810: 
811:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
812:         IF VARTYPE(loc_oGrd) = "O"
813:             loc_oGrd.Refresh()
814:             loc_oGrd.SetFocus()
815:             loc_oGrd.Column1.Text1.SetFocus()
816:         ENDIF
817:     ENDPROC
818: 
819:     *==========================================================================
820:     * FormParaBO - Transfere a lista de produtos do cursor CrProduto para o BO

*-- Linhas 836 a 864:
836: 
837:         IF NOT USED("CrProduto")
838:             SET NULL ON
839:             CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
840:             SET NULL OFF
841:         ENDIF
842: 
843:         SELECT CrProduto
844:         ZAP
845: 
846:         THIS.this_oBusinessObject.PopularCursorProdutos("CrProduto")
847: 
848:         IF RECCOUNT("CrProduto") = 0
849:             SELECT CrProduto
850:             APPEND BLANK
851:         ENDIF
852: 
853:         GO TOP
854: 
855:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
856:         IF VARTYPE(loc_oGrd) = "O"
857:             loc_oGrd.Refresh()
858:         ENDIF
859:     ENDPROC
860: 
861:     *==========================================================================
862:     * HabilitarCampos - Habilita ou desabilita edicao do grid de produtos
863:     * par_lHabilitar: .T. = edicao livre; .F. = somente visualizacao
864:     *==========================================================================

*-- Linhas 886 a 904:
886:         LOCAL loc_oGrd
887: 
888:         IF USED("CrProduto")
889:             SELECT CrProduto
890:             ZAP
891:             APPEND BLANK
892:         ENDIF
893: 
894:         THIS.this_cAntCPro = ""
895: 
896:         loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
897:         IF VARTYPE(loc_oGrd) = "O"
898:             loc_oGrd.Refresh()
899:             loc_oGrd.SetFocus()
900:             loc_oGrd.Column1.Text1.SetFocus()
901:         ENDIF
902:     ENDPROC
903: 
904:     *==========================================================================

*-- Linhas 912 a 941:
912:         TRY
913:             IF NOT USED("CrProduto")
914:                 SET NULL ON
915:                 CREATE CURSOR CrProduto (Cpros C(14), dpros C(40))
916:                 SET NULL OFF
917:                 SELECT CrProduto
918:                 APPEND BLANK
919:             ENDIF
920: 
921:             loc_oGrd = THIS.cnt_4c_Referencia.grd_4c_Dados
922:             IF VARTYPE(loc_oGrd) = "O"
923:                 loc_oGrd.ColumnCount          = 2
924:                 loc_oGrd.RecordSource         = "CrProduto"
925:                 loc_oGrd.Column1.ControlSource = "CrProduto.Cpros"
926:                 loc_oGrd.Column2.ControlSource = "CrProduto.Dpros"
927:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
928:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
929:                 loc_oGrd.Refresh()
930:             ENDIF
931:             loc_lSucesso = .T.
932:         CATCH TO loc_oErro
933:             MsgErro(loc_oErro.Message + " | LN: " + TRANSFORM(loc_oErro.LineNo), ;
934:                     "Erro ao carregar lista")
935:         ENDTRY
936: 
937:         RETURN loc_lSucesso
938:     ENDPROC
939: 
940:     *==========================================================================
941:     * AjustarBotoesPorModo - Sem modo separado neste dialogo; sem botoes CRUD


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

ENDDEFINE

