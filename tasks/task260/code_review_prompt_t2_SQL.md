# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS SQL (1065 linhas total):

*-- Linhas 11 a 29:
11: *   - ConfigurarCabecalho: cnt_4c_Cabecalho cinza com lbl_4c_Sombra/Titulo
12: *   - ConfigurarBotoes: Shape1 + cmd_4c_Inserir/Excluir/Sair
13: *   - ConfigurarGrade: grd_4c_Grade (2 colunas Codigos+Descrs) + cursor placeholder
14: *   - CarregarGrid: SQLEXEC sigprcar filtrado por CPros (cursor temp + ZAP/APPEND)
15: *   - AjustarBotoesVisibilidade: Inserir/Excluir visiveis apenas em INSERIR/ALTERAR
16: *   - RegistrarBINDEVENTs: Click e KeyPress bindados
17: *   - CmdInserirClick: insere linha vazia, foca Column1
18: *   - CmdExcluirClick: deleta linha corrente (guard CPros)
19: *   - CmdSairClick: limpa linhas vazias, reabilita form pai, Release
20: *   - GrdCol1/2KeyPress: guard ENTER/TAB/F4 + ValidarCodigo/Descricao
21: *   - ValidarCodigo/Descricao: match exato + duplicidade + picker
22: *   - AbrirPickerCodigo/Descricao: FormBuscaAuxiliar com filtro CGrus em SIGCRRAP
23: *   - Destroy: cursor + BO liberados
24: *===============================================================================
25: 
26: DEFINE CLASS FormSigPrCar AS FormBase
27: 
28:     *-- Dimensoes identicas ao original (sub-form pequeno, NAO 1000x600)
29:     Width       = 480

*-- Linhas 348 a 425:
348:     PROTECTED PROCEDURE ConfigurarGrade()
349:     *-- Cria cursor placeholder e grid de caracteristicas do produto.
350:     *-- Grade (legado): Top=103, Left=8, Width=463, Height=411, 2 colunas.
351:     *-- Dados carregados por CarregarGrid na Fase 5 (SQLEXEC SigPrCar por CPros).
352:     *===========================================================================
353:         LOCAL loc_oGrade
354: 
355:         *-- Cursor placeholder com estrutura de SigPrCar (dados carregados na Fase 5)
356:         IF USED(THIS.this_cCursorCarac)
357:             USE IN (THIS.this_cCursorCarac)
358:         ENDIF
359:         SET NULL ON
360:         CREATE CURSOR cursor_4c_CaracProd ;
361:             (CPros C(15) NULL, Codigos C(20) NULL, Descrs C(50) NULL, pkChaves C(38) NULL)
362:         SET NULL OFF
363: 
364:         THIS.AddObject("grd_4c_Grade", "Grid")
365:         loc_oGrade = THIS.grd_4c_Grade
366: 
367:         loc_oGrade.ColumnCount  = 2
368:         loc_oGrade.RecordSource = THIS.this_cCursorCarac
369: 
370:         WITH loc_oGrade
371:             .Top                = 103
372:             .Left               = 8
373:             .Width              = 463
374:             .Height             = 411
375:             .FontName           = "Tahoma"
376:             .FontSize           = 8
377:             .AllowHeaderSizing  = .F.
378:             .AllowRowSizing     = .F.
379:             .DeleteMark         = .F.
380:             .RecordMark         = .F.
381:             .RowHeight          = 17
382:             .ScrollBars         = 2
383:             .GridLineColor      = RGB(238, 238, 238)
384:             .AllowCellSelection = .T.
385: 
386:             *-- Coluna 1: Codigos (Caracteristica)
387:             WITH .Column1
388:                 .FontName      = "Tahoma"
389:                 .FontSize      = 8
390:                 .Width         = 150
391:                 .Movable       = .F.
392:                 .Resizable     = .F.
393:                 .ControlSource = THIS.this_cCursorCarac + ".Codigos"
394:                 WITH .Header1
395:                     .FontName  = "Tahoma"
396:                     .FontSize  = 8
397:                     .Alignment = 2
398:                     .Caption   = "Caracter" + CHR(237) + "stica"
399:                     .ForeColor = RGB(90, 90, 90)
400:                 ENDWITH
401:             ENDWITH
402: 
403:             *-- Coluna 2: Descrs (Descricao)
404:             WITH .Column2
405:                 .FontName      = "Tahoma"
406:                 .FontSize      = 8
407:                 .Width         = 290
408:                 .Movable       = .F.
409:                 .Resizable     = .F.
410:                 .ControlSource = THIS.this_cCursorCarac + ".Descrs"
411:                 WITH .Header1
412:                     .FontName  = "Tahoma"
413:                     .FontSize  = 8
414:                     .Alignment = 2
415:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
416:                     .ForeColor = RGB(90, 90, 90)
417:                 ENDWITH
418:             ENDWITH
419:         ENDWITH
420:     ENDPROC
421: 
422:     *===========================================================================
423:     PROCEDURE AlternarPagina(par_nPagina)
424:     *-- OPERACIONAL sem PageFrame - nao alterna paginas.
425:     *===========================================================================

*-- Linhas 439 a 475:
439:                 USE IN cursor_4c_CaracProdTemp
440:             ENDIF
441: 
442:             loc_cSQL = "SELECT cpros, codigos, descrs, pkchaves " + ;
443:                        "FROM sigprcar " + ;
444:                        "WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + " " + ;
445:                        "ORDER BY codigos"
446: 
447:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracProdTemp") > 0
448:                 SELECT (THIS.this_cCursorCarac)
449:                 ZAP
450:                 APPEND FROM DBF("cursor_4c_CaracProdTemp")
451:                 USE IN cursor_4c_CaracProdTemp
452:                 SELECT (THIS.this_cCursorCarac)
453:                 GO TOP
454:             ENDIF
455: 
456:             THIS.grd_4c_Grade.ColumnCount  = 2
457:             THIS.grd_4c_Grade.RecordSource = THIS.this_cCursorCarac
458:             WITH THIS.grd_4c_Grade
459:                 .Column1.ControlSource   = THIS.this_cCursorCarac + ".Codigos"
460:                 .Column2.ControlSource   = THIS.this_cCursorCarac + ".Descrs"
461:                 .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
462:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
463:             ENDWITH
464: 
465:             THIS.grd_4c_Grade.Refresh()
466:             loc_lResultado = .T.
467:         CATCH TO loc_oErro
468:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
469:                     "Erro CarregarGrid")
470:         ENDTRY
471: 
472:         RETURN loc_lResultado
473:     ENDPROC
474: 
475:     *===========================================================================

*-- Linhas 512 a 530:
512:         THIS.this_lHouveIncl = .T.
513: 
514:         IF THIS.this_oBusinessObject.InserirNovaLinha(THIS.this_cCursorCarac, THIS.this_cCpros)
515:             SELECT (THIS.this_cCursorCarac)
516:             GO BOTTOM
517:             THIS.grd_4c_Grade.Refresh()
518:             THIS.grd_4c_Grade.Column1.SetFocus()
519:         ENDIF
520:     ENDPROC
521: 
522:     *===========================================================================
523:     PROCEDURE CmdExcluirClick()
524:     *-- Remove o registro corrente do cursor (com verificacao de CPros de seguranca).
525:     *===========================================================================
526:         IF THIS.this_oBusinessObject.ExcluirLinhaAtual(THIS.this_cCursorCarac, THIS.this_cCpros)
527:             THIS.this_lHouveExcl = .T.
528:             THIS.grd_4c_Grade.Refresh()
529:         ENDIF
530:     ENDPROC

*-- Linhas 567 a 585:
567:         THIS.AjustarBotoesVisibilidade()
568: 
569:         IF USED(THIS.this_cCursorCarac)
570:             SELECT (THIS.this_cCursorCarac)
571:             IF RECCOUNT() = 0
572:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
573:                          " caracter" + CHR(237) + "sticas cadastradas para este produto." + ;
574:                          CHR(13) + "Utilize o bot" + CHR(227) + "o Inserir para adicionar.", ;
575:                          "Aten" + CHR(231) + CHR(227) + "o")
576:                 RETURN
577:             ENDIF
578:             IF EOF()
579:                 GO TOP
580:             ENDIF
581:         ENDIF
582: 
583:         TRY
584:             THIS.grd_4c_Grade.Refresh()
585:             THIS.grd_4c_Grade.SetFocus()

*-- Linhas 600 a 618:
600:         THIS.AjustarBotoesVisibilidade()
601: 
602:         IF USED(THIS.this_cCursorCarac)
603:             SELECT (THIS.this_cCursorCarac)
604:             IF RECCOUNT() > 0
605:                 GO TOP
606:             ENDIF
607:         ENDIF
608: 
609:         THIS.grd_4c_Grade.Refresh()
610:     ENDPROC
611: 
612:     *===========================================================================
613:     PROCEDURE BtnExcluirClick()
614:     *-- Bridge CRUD -> semantica OPERACIONAL sub-form: valida modo editavel, pede
615:     *-- confirmacao e delega para CmdExcluirClick que remove a linha corrente.
616:     *===========================================================================
617:         IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
618:             MsgAviso("Exclus" + CHR(227) + "o dispon" + CHR(237) + ;

*-- Linhas 685 a 735:
685:             loc_cPkAtual = ""
686: 
687:             IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
688:                 SELECT (THIS.this_cCursorCarac)
689:                 loc_cPkAtual = ALLTRIM(pkchaves)
690:             ENDIF
691: 
692:             IF EMPTY(loc_cValor)
693:                 IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
694:                     SELECT (THIS.this_cCursorCarac)
695:                     REPLACE codigos WITH "", descrs WITH ""
696:                 ENDIF
697:             ELSE
698:                 loc_lEncontrado = THIS.this_oBusinessObject.BuscarCodigoExato(;
699:                     loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")
700: 
701:                 IF !loc_lEncontrado
702:                     THIS.AbrirPickerCodigo(loc_cValor)
703:                 ELSE
704:                     SELECT cursor_4c_PrCarBusca
705:                     loc_cCodFinal  = ALLTRIM(codigos)
706:                     loc_cDescFinal = ALLTRIM(descrs)
707:                     USE IN cursor_4c_PrCarBusca
708: 
709:                     IF THIS.this_oBusinessObject.VerificarDuplicidade(;
710:                         loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
711:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
712:                                  " informada para este produto!", ;
713:                                  "Aten" + CHR(231) + CHR(227) + "o")
714:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
715:                             SELECT (THIS.this_cCursorCarac)
716:                             REPLACE codigos WITH "", descrs WITH ""
717:                         ENDIF
718:                     ELSE
719:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
720:                             SELECT (THIS.this_cCursorCarac)
721:                             REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
722:                         ENDIF
723:                     ENDIF
724:                 ENDIF
725:             ENDIF
726:         CATCH TO loc_oErro
727:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
728:                     "Erro ValidarCodigo")
729:         ENDTRY
730: 
731:         THIS.grd_4c_Grade.Refresh()
732:     ENDPROC
733: 
734:     *===========================================================================
735:     PROTECTED PROCEDURE ValidarDescricao()

*-- Linhas 743 a 863:
743:             loc_cPkAtual = ""
744: 
745:             IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
746:                 SELECT (THIS.this_cCursorCarac)
747:                 loc_cPkAtual = ALLTRIM(pkchaves)
748:             ENDIF
749: 
750:             IF EMPTY(loc_cValor)
751:                 IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
752:                     SELECT (THIS.this_cCursorCarac)
753:                     REPLACE codigos WITH "", descrs WITH ""
754:                 ENDIF
755:             ELSE
756:                 loc_lEncontrado = THIS.this_oBusinessObject.BuscarDescricaoExata(;
757:                     loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")
758: 
759:                 IF !loc_lEncontrado
760:                     THIS.AbrirPickerDescricao(loc_cValor)
761:                 ELSE
762:                     SELECT cursor_4c_PrCarBusca
763:                     loc_cCodFinal  = ALLTRIM(codigos)
764:                     loc_cDescFinal = ALLTRIM(descrs)
765:                     USE IN cursor_4c_PrCarBusca
766: 
767:                     IF THIS.this_oBusinessObject.VerificarDuplicidade(;
768:                         loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
769:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
770:                                  " informada para este produto!", ;
771:                                  "Aten" + CHR(231) + CHR(227) + "o")
772:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
773:                             SELECT (THIS.this_cCursorCarac)
774:                             REPLACE codigos WITH "", descrs WITH ""
775:                         ENDIF
776:                     ELSE
777:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
778:                             SELECT (THIS.this_cCursorCarac)
779:                             REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
780:                         ENDIF
781:                     ENDIF
782:                 ENDIF
783:             ENDIF
784:         CATCH TO loc_oErro
785:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
786:                     "Erro ValidarDescricao")
787:         ENDTRY
788: 
789:         THIS.grd_4c_Grade.Refresh()
790:     ENDPROC
791: 
792:     *===========================================================================
793:     PROTECTED PROCEDURE AbrirPickerCodigo(par_cValor)
794:     *-- FormBuscaAuxiliar buscando SIGCRRAP.codigos filtrado por grupo do produto.
795:     *===========================================================================
796:         LOCAL loc_oPicker, loc_cFiltro, loc_oErro
797:         LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado
798: 
799:         TRY
800:             loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"
801: 
802:             loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
803:                 gnConnHandle, ;
804:                 "SIGCRRAP", ;
805:                 "cursor_4c_PrCarPicker", ;
806:                 "codigos", ;
807:                 par_cValor, ;
808:                 "Sele" + CHR(231) + CHR(227) + "o", ;
809:                 .F., ;
810:                 .T., ;
811:                 loc_cFiltro)
812: 
813:             IF VARTYPE(loc_oPicker) = "O"
814:                 loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
815:                 loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
816:                 loc_oPicker.Show()
817: 
818:                 IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
819:                     SELECT cursor_4c_PrCarPicker
820:                     loc_cCodSel  = ALLTRIM(codigos)
821:                     loc_cDescSel = ALLTRIM(descrs)
822: 
823:                     loc_cPkAtual = ""
824:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
825:                         SELECT (THIS.this_cCursorCarac)
826:                         loc_cPkAtual = ALLTRIM(pkchaves)
827:                     ENDIF
828: 
829:                     loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
830:                         loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)
831: 
832:                     IF loc_lDuplicado
833:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
834:                                  " informada para este produto!", ;
835:                                  "Aten" + CHR(231) + CHR(227) + "o")
836:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
837:                             SELECT (THIS.this_cCursorCarac)
838:                             REPLACE codigos WITH "", descrs WITH ""
839:                         ENDIF
840:                     ELSE
841:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
842:                             SELECT (THIS.this_cCursorCarac)
843:                             REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
844:                         ENDIF
845:                     ENDIF
846:                 ELSE
847:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
848:                         SELECT (THIS.this_cCursorCarac)
849:                         REPLACE codigos WITH "", descrs WITH ""
850:                     ENDIF
851:                 ENDIF
852: 
853:                 loc_oPicker = .NULL.
854:             ENDIF
855:         CATCH TO loc_oErro
856:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
857:                     "Erro AbrirPickerCodigo")
858:         ENDTRY
859: 
860:         IF USED("cursor_4c_PrCarPicker")
861:             USE IN cursor_4c_PrCarPicker
862:         ENDIF
863: 

*-- Linhas 872 a 938:
872:         LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado
873: 
874:         TRY
875:             loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"
876: 
877:             loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
878:                 gnConnHandle, ;
879:                 "SIGCRRAP", ;
880:                 "cursor_4c_PrCarPicker", ;
881:                 "descrs", ;
882:                 par_cValor, ;
883:                 "Sele" + CHR(231) + CHR(227) + "o", ;
884:                 .F., ;
885:                 .T., ;
886:                 loc_cFiltro)
887: 
888:             IF VARTYPE(loc_oPicker) = "O"
889:                 loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
890:                 loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
891:                 loc_oPicker.Show()
892: 
893:                 IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
894:                     SELECT cursor_4c_PrCarPicker
895:                     loc_cCodSel  = ALLTRIM(codigos)
896:                     loc_cDescSel = ALLTRIM(descrs)
897: 
898:                     loc_cPkAtual = ""
899:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
900:                         SELECT (THIS.this_cCursorCarac)
901:                         loc_cPkAtual = ALLTRIM(pkchaves)
902:                     ENDIF
903: 
904:                     loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
905:                         loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)
906: 
907:                     IF loc_lDuplicado
908:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
909:                                  " informada para este produto!", ;
910:                                  "Aten" + CHR(231) + CHR(227) + "o")
911:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
912:                             SELECT (THIS.this_cCursorCarac)
913:                             REPLACE codigos WITH "", descrs WITH ""
914:                         ENDIF
915:                     ELSE
916:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
917:                             SELECT (THIS.this_cCursorCarac)
918:                             REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
919:                         ENDIF
920:                     ENDIF
921:                 ELSE
922:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
923:                         SELECT (THIS.this_cCursorCarac)
924:                         REPLACE codigos WITH "", descrs WITH ""
925:                     ENDIF
926:                 ENDIF
927: 
928:                 loc_oPicker = .NULL.
929:             ENDIF
930:         CATCH TO loc_oErro
931:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
932:                     "Erro AbrirPickerDescricao")
933:         ENDTRY
934: 
935:         IF USED("cursor_4c_PrCarPicker")
936:             USE IN cursor_4c_PrCarPicker
937:         ENDIF
938: 

*-- Linhas 958 a 1013:
958:     *-- Copia dados da linha corrente do cursor para o Business Object.
959:     *===========================================================================
960:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
961:             SELECT (THIS.this_cCursorCarac)
962:             THIS.this_oBusinessObject.this_cCodigos  = ALLTRIM(NVL(codigos,  ""))
963:             THIS.this_oBusinessObject.this_cCpros    = ALLTRIM(NVL(cpros,    ""))
964:             THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
965:             IF TYPE("descrs") != "U"
966:                 THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(descrs, ""))
967:             ENDIF
968:         ENDIF
969:     ENDPROC
970: 
971:     *===========================================================================
972:     PROTECTED PROCEDURE BOParaForm()
973:     *-- Copia dados do Business Object para a linha corrente do cursor.
974:     *===========================================================================
975:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
976:             SELECT (THIS.this_cCursorCarac)
977:             REPLACE codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
978:                     descrs   WITH THIS.this_oBusinessObject.this_cDescrs,   ;
979:                     cpros    WITH THIS.this_oBusinessObject.this_cCpros,    ;
980:                     pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves
981:         ENDIF
982:     ENDPROC
983: 
984:     *===========================================================================
985:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
986:     *-- Habilita/desabilita edicao do grid conforme modo de operacao.
987:     *===========================================================================
988:         IF VARTYPE(THIS.grd_4c_Grade) = "O"
989:             THIS.grd_4c_Grade.ReadOnly = !par_lHabilitar
990:         ENDIF
991:     ENDPROC
992: 
993:     *===========================================================================
994:     PROTECTED PROCEDURE LimparCampos()
995:     *-- Limpa campos da linha corrente do cursor (codigos e descrs).
996:     *===========================================================================
997:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
998:             SELECT (THIS.this_cCursorCarac)
999:             REPLACE codigos WITH "", descrs WITH ""
1000:         ENDIF
1001:         IF VARTYPE(THIS.grd_4c_Grade) = "O"
1002:             THIS.grd_4c_Grade.Refresh()
1003:         ENDIF
1004:     ENDPROC
1005: 
1006:     *===========================================================================
1007:     PROCEDURE BtnBuscarClick()
1008:     *-- Recarrega o grid com os dados atuais do produto (sem filtro adicional).
1009:     *===========================================================================
1010:         THIS.CarregarGrid()
1011:     ENDPROC
1012: 
1013:     *===========================================================================


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
* Business Object: Caracteristicas do Produto (sigprcar)
* Tabela principal: sigprcar
* Sub-form: aberto pelo form de produto (SigPrApr/SigPrAop)
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Campos da tabela sigprcar
    this_cCodigos  = ""    && char(20) - codigo da caracteristica (FK SIGCRRAP)
    this_cCpros    = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_cPkChaves = ""    && char(20) - chave primaria

    *-- Campo de exibicao: vem de SIGCRRAP.descrs, NAO armazenado em sigprcar
    this_cDescrs   = ""    && char(40) - descricao da caracteristica

    *-- Contexto do produto pai (passado pelo form chamador)
    this_cCgrus    = ""    && char(3) - grupo do produto (filtro de lookup SigCrRap)

    *-- Flags de controle de sessao (consultados pelo form pai apos fechar)
    this_lHouveIncl = .F.  && houve insercao nesta sessao
    this_lHouveExcl = .F.  && houve exclusao nesta sessao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor (crSigPrCar ou outro)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos,  "C")
            THIS.this_cCpros    = TratarNulo(cpros,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * Inserir - SQL INSERT INTO sigprcar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)   + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - SQL UPDATE sigprcar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprcar SET codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - SQL DELETE FROM sigprcar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprcar WHERE pkchaves = " + ;
                       EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InserirNovaLinha - Insere linha vazia no cursor local
    * Equivalente a cmdInserir.Click do legado
    * par_cCursorCarac: alias do cursor local (ex: "crSigPrCar")
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE InserirNovaLinha(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cPkChaves, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                *-- Verifica se ja existe linha vazia para este produto
                SELECT (par_cCursorCarac)
                LOCATE FOR RTRIM(cpros) == RTRIM(par_cCpros) AND EMPTY(codigos) AND !DELETED()
                IF !EOF()
                    loc_lResultado = .T.
                ELSE
                    *-- Obtem chave unica do SQL Server
                    IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_PrCarNewid") > 0
                        SELECT cursor_4c_PrCarNewid
                        loc_cPkChaves = LEFT(ALLTRIM(nid), 20)
                        USE IN cursor_4c_PrCarNewid
                    ELSE
                        loc_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
                    ENDIF

                    *-- Insere linha vazia no cursor local
                    SELECT (par_cCursorCarac)
                    INSERT INTO (par_cCursorCarac) (cpros, pkchaves, codigos, descrs) ;
                        VALUES (par_cCpros, loc_cPkChaves, "", "")

                    THIS.this_lHouveIncl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir nova linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove o registro corrente do cursor local
    * Equivalente a cmdExcluir.Click do legado
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto (verificacao de seguranca)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (par_cCursorCarac)
                IF !EOF() AND RTRIM(cpros) == RTRIM(par_cCpros)
                    DELETE
                    SKIP
                    SKIP -1
                    THIS.this_lHouveExcl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LimparLinhasVazias - Remove linhas sem codigo do cursor local
    * Chamado antes de fechar o form (cmdSair.Click do legado)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE LimparLinhasVazias(par_cCursorCarac)
        LOCAL loc_oErro
        TRY
            IF USED(par_cCursorCarac)
                SELECT (par_cCursorCarac)
                SCAN WHILE !EOF()
                    IF EMPTY(codigos)
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao limpar linhas vazias: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarCodigoExato - Busca codigo exato em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    * par_cCodigos: valor a buscar
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular com resultado
    *====================================================================
    PROCEDURE BuscarCodigoExato(par_cCodigos, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar c" + CHR(243) + "digo: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescricaoExata - Busca descricao exata em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    *====================================================================
    PROCEDURE BuscarDescricaoExata(par_cDescrs, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE descrs = " + EscaparSQL(par_cDescrs) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorCodigo - Lista para picker (Column1)
    * Busca registros em SIGCRRAP por LIKE no campo codigos
    * par_cValor: prefixo digitado
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorCodigo(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE codigos LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorDescricao - Lista para picker (Column2)
    * Busca registros em SIGCRRAP por LIKE no campo descrs
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorDescricao(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE descrs LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Checa se codigo ja existe no cursor local
    * para o mesmo produto (exceto o registro corrente)
    * Retorna .T. se duplicado
    * par_cCodigos: codigo a verificar
    * par_cPkChaveAtual: pkchaves do registro corrente (excluido da busca)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodigos, par_cPkChaveAtual, par_cCursorCarac)
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(par_cCursorCarac) AND !EMPTY(par_cCodigos)
                SELECT codigos FROM (par_cCursorCarac) ;
                    WHERE RTRIM(codigos) == RTRIM(par_cCodigos) ;
                    AND RTRIM(pkchaves) != RTRIM(par_cPkChaveAtual) ;
                    AND !DELETED() ;
                    INTO CURSOR cursor_4c_PrCarDupCheck
                SELECT cursor_4c_PrCarDupCheck
                loc_lDuplicado = !EOF()
                USE IN cursor_4c_PrCarDupCheck
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao verificar duplicidade: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * SalvarTodasCaracteristicas - Persiste cursor local no SQL Server
    * Chamado pelo form pai (SigPrAop/SigPrApr) ao salvar o produto
    * Estrategia: DELETE todas as do produto + INSERT das validas
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE SalvarTodasCaracteristicas(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_lOk
        loc_lResultado = .F.
        TRY
            *-- Remove todas as caracteristicas anteriores do produto
            loc_cSQL = "DELETE FROM sigprcar WHERE cpros = " + EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lOk = .T.
                *-- Reinsere todas as linhas validas do cursor local
                IF USED(par_cCursorCarac)
                    SELECT (par_cCursorCarac)
                    GO TOP
                    SCAN WHILE !EOF() AND loc_lOk
                        IF !DELETED() AND !EMPTY(codigos)
                            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                                       EscaparSQL(codigos) + ", " + ;
                                       EscaparSQL(par_cCpros) + ", " + ;
                                       EscaparSQL(pkchaves) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                THIS.this_cMensagemErro = "Erro ao salvar caracter" + ;
                                    CHR(237) + "stica: " + ALLTRIM(codigos)
                                loc_lOk = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
                IF loc_lOk
                    loc_lResultado = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + ;
                    "sticas anteriores do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao salvar caracter" + CHR(237) + ;
                "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

