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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS SQL (1064 linhas total):

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

*-- Linhas 348 a 424:
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
367:         WITH loc_oGrade
368:             .Top                = 103
369:             .Left               = 8
370:             .Width              = 463
371:             .Height             = 411
372:             .ColumnCount        = 2
373:             .RecordSource       = THIS.this_cCursorCarac
374:             .FontName           = "Tahoma"
375:             .FontSize           = 8
376:             .AllowHeaderSizing  = .F.
377:             .AllowRowSizing     = .F.
378:             .DeleteMark         = .F.
379:             .RecordMark         = .F.
380:             .RowHeight          = 17
381:             .ScrollBars         = 2
382:             .GridLineColor      = RGB(238, 238, 238)
383:             .AllowCellSelection = .T.
384: 
385:             *-- Coluna 1: Codigos (Caracteristica)
386:             WITH .Column1
387:                 .FontName      = "Tahoma"
388:                 .FontSize      = 8
389:                 .Width         = 150
390:                 .Movable       = .F.
391:                 .Resizable     = .F.
392:                 .ControlSource = THIS.this_cCursorCarac + ".Codigos"
393:                 WITH .Header1
394:                     .FontName  = "Tahoma"
395:                     .FontSize  = 8
396:                     .Alignment = 2
397:                     .Caption   = "Caracter" + CHR(237) + "stica"
398:                     .ForeColor = RGB(90, 90, 90)
399:                 ENDWITH
400:             ENDWITH
401: 
402:             *-- Coluna 2: Descrs (Descricao)
403:             WITH .Column2
404:                 .FontName      = "Tahoma"
405:                 .FontSize      = 8
406:                 .Width         = 290
407:                 .Movable       = .F.
408:                 .Resizable     = .F.
409:                 .ControlSource = THIS.this_cCursorCarac + ".Descrs"
410:                 WITH .Header1
411:                     .FontName  = "Tahoma"
412:                     .FontSize  = 8
413:                     .Alignment = 2
414:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
415:                     .ForeColor = RGB(90, 90, 90)
416:                 ENDWITH
417:             ENDWITH
418:         ENDWITH
419:     ENDPROC
420: 
421:     *===========================================================================
422:     PROCEDURE AlternarPagina(par_nPagina)
423:     *-- OPERACIONAL sem PageFrame - nao alterna paginas.
424:     *===========================================================================

*-- Linhas 438 a 474:
438:                 USE IN cursor_4c_CaracProdTemp
439:             ENDIF
440: 
441:             loc_cSQL = "SELECT cpros, codigos, descrs, pkchaves " + ;
442:                        "FROM sigprcar " + ;
443:                        "WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + " " + ;
444:                        "ORDER BY codigos"
445: 
446:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracProdTemp") > 0
447:                 SELECT (THIS.this_cCursorCarac)
448:                 ZAP
449:                 APPEND FROM DBF("cursor_4c_CaracProdTemp")
450:                 USE IN cursor_4c_CaracProdTemp
451:                 SELECT (THIS.this_cCursorCarac)
452:                 GO TOP
453:             ENDIF
454: 
455:             WITH THIS.grd_4c_Grade
456:                 .ColumnCount             = 2
457:                 .RecordSource            = THIS.this_cCursorCarac
458:                 .Column1.ControlSource   = THIS.this_cCursorCarac + ".Codigos"
459:                 .Column2.ControlSource   = THIS.this_cCursorCarac + ".Descrs"
460:                 .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
461:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
462:             ENDWITH
463: 
464:             THIS.grd_4c_Grade.Refresh()
465:             loc_lResultado = .T.
466:         CATCH TO loc_oErro
467:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
468:                     "Erro CarregarGrid")
469:         ENDTRY
470: 
471:         RETURN loc_lResultado
472:     ENDPROC
473: 
474:     *===========================================================================

*-- Linhas 511 a 529:
511:         THIS.this_lHouveIncl = .T.
512: 
513:         IF THIS.this_oBusinessObject.InserirNovaLinha(THIS.this_cCursorCarac, THIS.this_cCpros)
514:             SELECT (THIS.this_cCursorCarac)
515:             GO BOTTOM
516:             THIS.grd_4c_Grade.Refresh()
517:             THIS.grd_4c_Grade.Column1.SetFocus()
518:         ENDIF
519:     ENDPROC
520: 
521:     *===========================================================================
522:     PROCEDURE CmdExcluirClick()
523:     *-- Remove o registro corrente do cursor (com verificacao de CPros de seguranca).
524:     *===========================================================================
525:         IF THIS.this_oBusinessObject.ExcluirLinhaAtual(THIS.this_cCursorCarac, THIS.this_cCpros)
526:             THIS.this_lHouveExcl = .T.
527:             THIS.grd_4c_Grade.Refresh()
528:         ENDIF
529:     ENDPROC

*-- Linhas 566 a 584:
566:         THIS.AjustarBotoesVisibilidade()
567: 
568:         IF USED(THIS.this_cCursorCarac)
569:             SELECT (THIS.this_cCursorCarac)
570:             IF RECCOUNT() = 0
571:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
572:                          " caracter" + CHR(237) + "sticas cadastradas para este produto." + ;
573:                          CHR(13) + "Utilize o bot" + CHR(227) + "o Inserir para adicionar.", ;
574:                          "Aten" + CHR(231) + CHR(227) + "o")
575:                 RETURN
576:             ENDIF
577:             IF EOF()
578:                 GO TOP
579:             ENDIF
580:         ENDIF
581: 
582:         TRY
583:             THIS.grd_4c_Grade.Refresh()
584:             THIS.grd_4c_Grade.SetFocus()

*-- Linhas 599 a 617:
599:         THIS.AjustarBotoesVisibilidade()
600: 
601:         IF USED(THIS.this_cCursorCarac)
602:             SELECT (THIS.this_cCursorCarac)
603:             IF RECCOUNT() > 0
604:                 GO TOP
605:             ENDIF
606:         ENDIF
607: 
608:         THIS.grd_4c_Grade.Refresh()
609:     ENDPROC
610: 
611:     *===========================================================================
612:     PROCEDURE BtnExcluirClick()
613:     *-- Bridge CRUD -> semantica OPERACIONAL sub-form: valida modo editavel, pede
614:     *-- confirmacao e delega para CmdExcluirClick que remove a linha corrente.
615:     *===========================================================================
616:         IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
617:             MsgAviso("Exclus" + CHR(227) + "o dispon" + CHR(237) + ;

*-- Linhas 684 a 734:
684:             loc_cPkAtual = ""
685: 
686:             IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
687:                 SELECT (THIS.this_cCursorCarac)
688:                 loc_cPkAtual = ALLTRIM(pkchaves)
689:             ENDIF
690: 
691:             IF EMPTY(loc_cValor)
692:                 IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
693:                     SELECT (THIS.this_cCursorCarac)
694:                     REPLACE codigos WITH "", descrs WITH ""
695:                 ENDIF
696:             ELSE
697:                 loc_lEncontrado = THIS.this_oBusinessObject.BuscarCodigoExato(;
698:                     loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")
699: 
700:                 IF !loc_lEncontrado
701:                     THIS.AbrirPickerCodigo(loc_cValor)
702:                 ELSE
703:                     SELECT cursor_4c_PrCarBusca
704:                     loc_cCodFinal  = ALLTRIM(codigos)
705:                     loc_cDescFinal = ALLTRIM(descrs)
706:                     USE IN cursor_4c_PrCarBusca
707: 
708:                     IF THIS.this_oBusinessObject.VerificarDuplicidade(;
709:                         loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
710:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
711:                                  " informada para este produto!", ;
712:                                  "Aten" + CHR(231) + CHR(227) + "o")
713:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
714:                             SELECT (THIS.this_cCursorCarac)
715:                             REPLACE codigos WITH "", descrs WITH ""
716:                         ENDIF
717:                     ELSE
718:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
719:                             SELECT (THIS.this_cCursorCarac)
720:                             REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
721:                         ENDIF
722:                     ENDIF
723:                 ENDIF
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
727:                     "Erro ValidarCodigo")
728:         ENDTRY
729: 
730:         THIS.grd_4c_Grade.Refresh()
731:     ENDPROC
732: 
733:     *===========================================================================
734:     PROTECTED PROCEDURE ValidarDescricao()

*-- Linhas 742 a 862:
742:             loc_cPkAtual = ""
743: 
744:             IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
745:                 SELECT (THIS.this_cCursorCarac)
746:                 loc_cPkAtual = ALLTRIM(pkchaves)
747:             ENDIF
748: 
749:             IF EMPTY(loc_cValor)
750:                 IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
751:                     SELECT (THIS.this_cCursorCarac)
752:                     REPLACE codigos WITH "", descrs WITH ""
753:                 ENDIF
754:             ELSE
755:                 loc_lEncontrado = THIS.this_oBusinessObject.BuscarDescricaoExata(;
756:                     loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")
757: 
758:                 IF !loc_lEncontrado
759:                     THIS.AbrirPickerDescricao(loc_cValor)
760:                 ELSE
761:                     SELECT cursor_4c_PrCarBusca
762:                     loc_cCodFinal  = ALLTRIM(codigos)
763:                     loc_cDescFinal = ALLTRIM(descrs)
764:                     USE IN cursor_4c_PrCarBusca
765: 
766:                     IF THIS.this_oBusinessObject.VerificarDuplicidade(;
767:                         loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
768:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
769:                                  " informada para este produto!", ;
770:                                  "Aten" + CHR(231) + CHR(227) + "o")
771:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
772:                             SELECT (THIS.this_cCursorCarac)
773:                             REPLACE codigos WITH "", descrs WITH ""
774:                         ENDIF
775:                     ELSE
776:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
777:                             SELECT (THIS.this_cCursorCarac)
778:                             REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
779:                         ENDIF
780:                     ENDIF
781:                 ENDIF
782:             ENDIF
783:         CATCH TO loc_oErro
784:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
785:                     "Erro ValidarDescricao")
786:         ENDTRY
787: 
788:         THIS.grd_4c_Grade.Refresh()
789:     ENDPROC
790: 
791:     *===========================================================================
792:     PROTECTED PROCEDURE AbrirPickerCodigo(par_cValor)
793:     *-- FormBuscaAuxiliar buscando SIGCRRAP.codigos filtrado por grupo do produto.
794:     *===========================================================================
795:         LOCAL loc_oPicker, loc_cFiltro, loc_oErro
796:         LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado
797: 
798:         TRY
799:             loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"
800: 
801:             loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
802:                 gnConnHandle, ;
803:                 "SIGCRRAP", ;
804:                 "cursor_4c_PrCarPicker", ;
805:                 "codigos", ;
806:                 par_cValor, ;
807:                 "Sele" + CHR(231) + CHR(227) + "o", ;
808:                 .F., ;
809:                 .T., ;
810:                 loc_cFiltro)
811: 
812:             IF VARTYPE(loc_oPicker) = "O"
813:                 loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
814:                 loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
815:                 loc_oPicker.Show()
816: 
817:                 IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
818:                     SELECT cursor_4c_PrCarPicker
819:                     loc_cCodSel  = ALLTRIM(codigos)
820:                     loc_cDescSel = ALLTRIM(descrs)
821: 
822:                     loc_cPkAtual = ""
823:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
824:                         SELECT (THIS.this_cCursorCarac)
825:                         loc_cPkAtual = ALLTRIM(pkchaves)
826:                     ENDIF
827: 
828:                     loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
829:                         loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)
830: 
831:                     IF loc_lDuplicado
832:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
833:                                  " informada para este produto!", ;
834:                                  "Aten" + CHR(231) + CHR(227) + "o")
835:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
836:                             SELECT (THIS.this_cCursorCarac)
837:                             REPLACE codigos WITH "", descrs WITH ""
838:                         ENDIF
839:                     ELSE
840:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
841:                             SELECT (THIS.this_cCursorCarac)
842:                             REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
843:                         ENDIF
844:                     ENDIF
845:                 ELSE
846:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
847:                         SELECT (THIS.this_cCursorCarac)
848:                         REPLACE codigos WITH "", descrs WITH ""
849:                     ENDIF
850:                 ENDIF
851: 
852:                 loc_oPicker = .NULL.
853:             ENDIF
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
856:                     "Erro AbrirPickerCodigo")
857:         ENDTRY
858: 
859:         IF USED("cursor_4c_PrCarPicker")
860:             USE IN cursor_4c_PrCarPicker
861:         ENDIF
862: 

*-- Linhas 871 a 937:
871:         LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado
872: 
873:         TRY
874:             loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"
875: 
876:             loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
877:                 gnConnHandle, ;
878:                 "SIGCRRAP", ;
879:                 "cursor_4c_PrCarPicker", ;
880:                 "descrs", ;
881:                 par_cValor, ;
882:                 "Sele" + CHR(231) + CHR(227) + "o", ;
883:                 .F., ;
884:                 .T., ;
885:                 loc_cFiltro)
886: 
887:             IF VARTYPE(loc_oPicker) = "O"
888:                 loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
889:                 loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
890:                 loc_oPicker.Show()
891: 
892:                 IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
893:                     SELECT cursor_4c_PrCarPicker
894:                     loc_cCodSel  = ALLTRIM(codigos)
895:                     loc_cDescSel = ALLTRIM(descrs)
896: 
897:                     loc_cPkAtual = ""
898:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
899:                         SELECT (THIS.this_cCursorCarac)
900:                         loc_cPkAtual = ALLTRIM(pkchaves)
901:                     ENDIF
902: 
903:                     loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
904:                         loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)
905: 
906:                     IF loc_lDuplicado
907:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
908:                                  " informada para este produto!", ;
909:                                  "Aten" + CHR(231) + CHR(227) + "o")
910:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
911:                             SELECT (THIS.this_cCursorCarac)
912:                             REPLACE codigos WITH "", descrs WITH ""
913:                         ENDIF
914:                     ELSE
915:                         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
916:                             SELECT (THIS.this_cCursorCarac)
917:                             REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
918:                         ENDIF
919:                     ENDIF
920:                 ELSE
921:                     IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
922:                         SELECT (THIS.this_cCursorCarac)
923:                         REPLACE codigos WITH "", descrs WITH ""
924:                     ENDIF
925:                 ENDIF
926: 
927:                 loc_oPicker = .NULL.
928:             ENDIF
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
931:                     "Erro AbrirPickerDescricao")
932:         ENDTRY
933: 
934:         IF USED("cursor_4c_PrCarPicker")
935:             USE IN cursor_4c_PrCarPicker
936:         ENDIF
937: 

*-- Linhas 957 a 1012:
957:     *-- Copia dados da linha corrente do cursor para o Business Object.
958:     *===========================================================================
959:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
960:             SELECT (THIS.this_cCursorCarac)
961:             THIS.this_oBusinessObject.this_cCodigos  = ALLTRIM(NVL(codigos,  ""))
962:             THIS.this_oBusinessObject.this_cCpros    = ALLTRIM(NVL(cpros,    ""))
963:             THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
964:             IF TYPE("descrs") != "U"
965:                 THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(descrs, ""))
966:             ENDIF
967:         ENDIF
968:     ENDPROC
969: 
970:     *===========================================================================
971:     PROTECTED PROCEDURE BOParaForm()
972:     *-- Copia dados do Business Object para a linha corrente do cursor.
973:     *===========================================================================
974:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
975:             SELECT (THIS.this_cCursorCarac)
976:             REPLACE codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
977:                     descrs   WITH THIS.this_oBusinessObject.this_cDescrs,   ;
978:                     cpros    WITH THIS.this_oBusinessObject.this_cCpros,    ;
979:                     pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves
980:         ENDIF
981:     ENDPROC
982: 
983:     *===========================================================================
984:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
985:     *-- Habilita/desabilita edicao do grid conforme modo de operacao.
986:     *===========================================================================
987:         IF VARTYPE(THIS.grd_4c_Grade) = "O"
988:             THIS.grd_4c_Grade.ReadOnly = !par_lHabilitar
989:         ENDIF
990:     ENDPROC
991: 
992:     *===========================================================================
993:     PROTECTED PROCEDURE LimparCampos()
994:     *-- Limpa campos da linha corrente do cursor (codigos e descrs).
995:     *===========================================================================
996:         IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
997:             SELECT (THIS.this_cCursorCarac)
998:             REPLACE codigos WITH "", descrs WITH ""
999:         ENDIF
1000:         IF VARTYPE(THIS.grd_4c_Grade) = "O"
1001:             THIS.grd_4c_Grade.Refresh()
1002:         ENDIF
1003:     ENDPROC
1004: 
1005:     *===========================================================================
1006:     PROCEDURE BtnBuscarClick()
1007:     *-- Recarrega o grid com os dados atuais do produto (sem filtro adicional).
1008:     *===========================================================================
1009:         THIS.CarregarGrid()
1010:     ENDPROC
1011: 
1012:     *===========================================================================


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

