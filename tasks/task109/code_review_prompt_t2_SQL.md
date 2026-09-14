# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TMPNF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, CANCELAS, IMPRESS, USUARS, TMPVNF, DOPES, TIPONFS, AGRUPAS, NFISCALS, IMPNFS, EMPDOPNUMS, NFIS, VSEQNOTA, TMPNF, NF

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
  Column1.ControlSource = "TmpNFis.Flag"
  Column2.ControlSource = "TmpNFis.NFis"
  Column3.ControlSource = "TmpNFis.Series"
  Column4.ControlSource = "TmpNFis.Emis"
  Column5.ControlSource = "TmpNFis.Operas"
  Column6.ControlSource = "TmpNFis.CFis"
  Column7.ControlSource = "TmpNFis.TotNotas"
  Column8.ControlSource = "TmpNFis.Operacao"
  Column9.ControlSource = "TmpNFis.Conta"
		Select a.*, b.Rclis
			From SigMvNfi a
			Left Join SigCdCli b On b.Iclis = a.CliFors
		Select a.EmpDopNums
			From SigMvCab a 
				Inner Join SigMvNfi b On b.EmpDopNums = a.EmpDopNums
		Select a.*, c.Rclis
			From SigMvNfi a
				Inner Join <<lcIdTab1>> b On b.EmpDopNums = a.EmpDopNums
				Left Join SigCdCli c On c.Iclis = a.CliFors
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvNfi') < 1)
Select crSigCdOpe
Select crSigMvNfi
	oProg.Update(.t.)
	=Seek(crSigMvNfi.Dopes, 'crSigCdOpe', 'Dopes')
	If Not Seek(_Empr + crSigMvNfi.Series, 'crSigCdSer', 'EmpCods')
		=Seek(Space(3)+ crSigMvNfi.Series, 'crSigCdSer', 'EmpCods')
	Insert Into TmpNFis (Flag, Emis, Series, Operas, CFis, NFis, TotNotas, Conta, Operacao, Emps, Dopes, Numes) ;
Select * From TmpNFis Where Flag Into Cursor TmpVNFis
Select TmpVNFis
	lcSql = [Select Distinct c.Nfis,c.EmpdopNums From SigMvNfi c, SigCdOpe a ]+;
			[Select Distinct c.Nfis,c.EmpDopNums From SigMvNfi c, SigCdOpe a, SigCdSer b ]+;
	If Thisform.PodataMgr.SqlExecute(lcSql,'TmpFiscal') < 0
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Select TmpFical)')
		Select TmpFiscal
			Select * From tmpFiscal Where Nfis < lcNota Into cursor selecao
			Select selecao
Select TmpNFis
	lcQuery = [Select Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvCab]) < 1)
	Insert Into TprMvCab (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
	lcQuery = [Select * ] + ;
			    [From SigMvNfi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvNfi]) < 1)
Select TmpNFis
Select TmpNFis
lcQuery = [Select Series,Emps,VSeqNota ] + ;
		    [ From SigCnFn2 ]  + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCnFnfT]) < 1)
Select TmpNFis
		Select crSigCdSer
Select TmpNFis
Select TmpNFis
		lcQuery = [Select Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars ] + ;
				    [From SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvCab]) < 1)
		Insert Into TprMvCab (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
		lcQuery = [Select * ] + ;
				    [From SigMvNfi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvNfi]) < 1)
		Delete In TmpNFis
Select TmpNFis
Update TmpNFis Set Flag = .f.
Update TmpNFis Set Flag = .t.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigregnf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1039 linhas total):

*-- Linhas 25 a 45:
25:         RETURN DODEFAULT()
26:     ENDPROC
27: 
28:     *--------------------------------------------------------------------------
29:     * InicializarForm - Configura formulario de emissao global de NF
30:     * Os cursores de trabalho (cursor_4c_TmpNFis, cursor_4c_SigCdSer) sao
31:     * criados pelo sigregnfBO.Init() ao chamar CREATEOBJECT abaixo.
32:     *--------------------------------------------------------------------------
33:     PROTECTED PROCEDURE InicializarForm()
34:         LOCAL loc_lSucesso
35:         loc_lSucesso = .F.
36:         TRY
37:             *-- Criar Business Object (BO.Init() cria cursores e carrega SigCdPam/SigCdSer)
38:             THIS.this_oBusinessObject = CREATEOBJECT("sigregnfBO")
39:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
40:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio de " + ;
41:                         "Emiss" + CHR(227) + "o Global de Nota Fiscal", "Erro")
42:                 loc_lSucesso = .F.
43:             ENDIF
44: 
45:             *-- Propriedades visuais do form (EXATAS do original)

*-- Linhas 411 a 442:
411:     *--------------------------------------------------------------------------
412:     * ConfigurarGridNF - Grid de 9 colunas: CheckBox(Flag), Num, Serie, Emis,
413:     *   Op, CFOP, Valor, Operacao, Emitente. Ordem obrigatoria Column1:
414:     *   AddObject -> Caption -> CurrentControl -> ControlSource (Error 1767)
415:     *   ColumnOrder: Column4.ColumnOrder=5, Column5.ColumnOrder=4 (Op exibe
416:     *   antes de Emissao, replicando ColumnOrder do original SIGREGNF.Grade).
417:     *--------------------------------------------------------------------------
418:     PROTECTED PROCEDURE ConfigurarGridNF(par_oCp)
419:         par_oCp.AddObject("grd_4c_Dados", "Grid")
420:         WITH par_oCp.grd_4c_Dados
421:             .Top                = 110
422:             .Left               = 30
423:             .Width              = 739
424:             .Height             = 364
425:             .ColumnCount        = 9
426:             .RecordSource       = "cursor_4c_TmpNFis"
427:             .DeleteMark         = .F.
428:             .RecordMark         = .F.
429:             .FontName           = "Tahoma"
430:             .FontSize           = 8
431:             .AllowHeaderSizing  = .F.
432:             .AllowRowSizing     = .F.
433:             .RowHeight          = 16
434:             .ScrollBars         = 2
435:             .HighlightStyle     = 2
436:             .GridLineColor      = RGB(238,238,238)
437:             .HighlightBackColor = RGB(255,255,255)
438:             .HighlightForeColor = RGB(15,41,104)
439:             .ForeColor          = RGB(90,90,90)
440:             .BackColor          = RGB(255,255,255)
441:             .Visible            = .T.
442: 

*-- Linhas 453 a 565:
453:                     .AutoSize  = .T.
454:                     .BackStyle = 0
455:                     .Visible   = .T.
456:                 ENDWITH
457:                 .CurrentControl    = "Check1"
458:                 .ControlSource     = "cursor_4c_TmpNFis.Flag"
459:                 .Header1.Caption   = ""
460:                 .Header1.Alignment = 2
461:                 .Header1.ForeColor = RGB(90,90,90)
462:             ENDWITH
463: 
464:             WITH .Column2
465:                 .Width             = 45
466:                 .Movable           = .F.
467:                 .Resizable         = .F.
468:                 .ReadOnly          = .T.
469:                 .FontBold          = .T.
470:                 .ControlSource     = "cursor_4c_TmpNFis.NFis"
471:                 .Header1.Caption   = "N" + CHR(250) + "mero"
472:                 .Header1.Alignment = 2
473:                 .Header1.ForeColor = RGB(90,90,90)
474:             ENDWITH
475: 
476:             WITH .Column3
477:                 .Width             = 28
478:                 .Movable           = .F.
479:                 .Resizable         = .F.
480:                 .ReadOnly          = .T.
481:                 .ControlSource     = "cursor_4c_TmpNFis.Series"
482:                 .Header1.Caption   = "S" + CHR(233) + "rie"
483:                 .Header1.Alignment = 2
484:                 .Header1.ForeColor = RGB(90,90,90)
485:             ENDWITH
486: 
487:             WITH .Column4
488:                 .Width             = 62
489:                 .Movable           = .F.
490:                 .Resizable         = .F.
491:                 .ReadOnly          = .T.
492:                 .ColumnOrder       = 5
493:                 .ControlSource     = "cursor_4c_TmpNFis.Emis"
494:                 .Header1.Caption   = "Emiss" + CHR(227) + "o"
495:                 .Header1.Alignment = 2
496:                 .Header1.ForeColor = RGB(90,90,90)
497:             ENDWITH
498: 
499:             WITH .Column5
500:                 .Width             = 18
501:                 .Movable           = .F.
502:                 .Resizable         = .F.
503:                 .ReadOnly          = .T.
504:                 .ColumnOrder       = 4
505:                 .ControlSource     = "cursor_4c_TmpNFis.Operas"
506:                 .Header1.Caption   = "Op"
507:                 .Header1.Alignment = 2
508:                 .Header1.ForeColor = RGB(90,90,90)
509:             ENDWITH
510: 
511:             WITH .Column6
512:                 .Width             = 60
513:                 .Movable           = .F.
514:                 .Resizable         = .F.
515:                 .ReadOnly          = .T.
516:                 .ControlSource     = "cursor_4c_TmpNFis.CFis"
517:                 .Header1.Caption   = "CFOP"
518:                 .Header1.Alignment = 2
519:                 .Header1.ForeColor = RGB(90,90,90)
520:             ENDWITH
521: 
522:             WITH .Column7
523:                 .Width             = 75
524:                 .Movable           = .F.
525:                 .Resizable         = .F.
526:                 .ReadOnly          = .T.
527:                 .InputMask         = "999,999,999.99"
528:                 .ControlSource     = "cursor_4c_TmpNFis.TotNotas"
529:                 .Header1.Caption   = "Valor Total"
530:                 .Header1.Alignment = 2
531:                 .Header1.ForeColor = RGB(90,90,90)
532:             ENDWITH
533: 
534:             WITH .Column8
535:                 .Width             = 150
536:                 .Movable           = .F.
537:                 .Resizable         = .F.
538:                 .ReadOnly          = .T.
539:                 .ControlSource     = "cursor_4c_TmpNFis.Operacao"
540:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
541:                 .Header1.Alignment = 2
542:                 .Header1.ForeColor = RGB(90,90,90)
543:             ENDWITH
544: 
545:             WITH .Column9
546:                 .Width             = 246
547:                 .Movable           = .F.
548:                 .Resizable         = .F.
549:                 .ReadOnly          = .T.
550:                 .ControlSource     = "cursor_4c_TmpNFis.Conta"
551:                 .Header1.Caption   = "Emitente / Detinat" + CHR(225) + "rio"
552:                 .Header1.Alignment = 2
553:                 .Header1.ForeColor = RGB(90,90,90)
554:             ENDWITH
555:         ENDWITH
556:     ENDPROC
557: 
558:     *--------------------------------------------------------------------------
559:     * AlternarPagina - Refresh da area de dados (form FLAT sem page switching)
560:     *--------------------------------------------------------------------------
561:     PROCEDURE AlternarPagina(par_nPagina)
562:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
563:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
564:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
565:             ENDIF

*-- Linhas 634 a 676:
634:                 loc_oLookup.Show()
635:             ENDIF
636:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
637:                 SELECT cursor_4c_BuscaSerie
638:                 IF !EOF()
639:                     THIS.cnt_4c_Corpo.txt_4c_Serie.Value = PADR(ALLTRIM(Series), 3)
640:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
641:                 ENDIF
642:                 USE IN cursor_4c_BuscaSerie
643:             ENDIF
644:             loc_oLookup.Release()
645:         ENDIF
646:     ENDPROC
647: 
648:     *--------------------------------------------------------------------------
649:     * ValidarSerie - Valida serie digitada contra SigCnFNf; abre lookup se nao achar
650:     *--------------------------------------------------------------------------
651:     PROTECTED PROCEDURE ValidarSerie(par_cSerie)
652:         LOCAL loc_nResult, loc_lAchou
653:         loc_lAchou = .F.
654:         IF USED("cursor_4c_SerieVal")
655:             USE IN cursor_4c_SerieVal
656:         ENDIF
657:         loc_nResult = SQLEXEC(gnConnHandle, ;
658:             "SELECT TOP 1 Series FROM SigCnFNf WHERE Series = " + EscaparSQL(par_cSerie), ;
659:             "cursor_4c_SerieVal")
660:         IF loc_nResult > 0 AND USED("cursor_4c_SerieVal")
661:             SELECT cursor_4c_SerieVal
662:             loc_lAchou = !EOF()
663:             USE IN cursor_4c_SerieVal
664:         ENDIF
665:         IF !loc_lAchou
666:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
667:                 THIS.AbrirLookupSerie()
668:             ENDIF
669:         ENDIF
670:     ENDPROC
671: 
672:     *--------------------------------------------------------------------------
673:     * UsuarsGotFocus - Salva valor inicial do usuario para deteccao de mudanca
674:     *--------------------------------------------------------------------------
675:     PROCEDURE UsuarsGotFocus()
676:         THIS.this_cUsuarsAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)

*-- Linhas 710 a 775:
710:                 loc_oLookup.Show()
711:             ENDIF
712:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaUsuars")
713:                 SELECT cursor_4c_BuscaUsuars
714:                 IF !EOF()
715:                     THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(Usuars), 10)
716:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
717:                 ENDIF
718:                 USE IN cursor_4c_BuscaUsuars
719:             ENDIF
720:             loc_oLookup.Release()
721:         ENDIF
722:     ENDPROC
723: 
724:     *--------------------------------------------------------------------------
725:     * ValidarUsuars - Valida usuario digitado contra SigCdUsu; abre lookup se nao achar
726:     *--------------------------------------------------------------------------
727:     PROTECTED PROCEDURE ValidarUsuars(par_cUsuars)
728:         LOCAL loc_nResult, loc_lAchou
729:         loc_lAchou = .F.
730:         IF USED("cursor_4c_UsuarsVal")
731:             USE IN cursor_4c_UsuarsVal
732:         ENDIF
733:         loc_nResult = SQLEXEC(gnConnHandle, ;
734:             "SELECT TOP 1 Usuars FROM SigCdUsu WHERE Usuars = " + EscaparSQL(par_cUsuars), ;
735:             "cursor_4c_UsuarsVal")
736:         IF loc_nResult > 0 AND USED("cursor_4c_UsuarsVal")
737:             SELECT cursor_4c_UsuarsVal
738:             loc_lAchou = !EOF()
739:             USE IN cursor_4c_UsuarsVal
740:         ENDIF
741:         IF !loc_lAchou
742:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
743:                 THIS.AbrirLookupUsuars()
744:             ENDIF
745:         ENDIF
746:     ENDPROC
747: 
748:     *--------------------------------------------------------------------------
749:     * BtnProcessarClick - Executa SelecionarDados e preenche o grid com NFs
750:     *--------------------------------------------------------------------------
751:     PROCEDURE BtnProcessarClick()
752:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
753:             RETURN
754:         ENDIF
755:         THIS.FormParaBO()
756:         IF THIS.this_oBusinessObject.SelecionarDados()
757:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
758:         ENDIF
759:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
760:         IF USED("cursor_4c_TmpNFis") AND !EOF("cursor_4c_TmpNFis")
761:             THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.SetFocus()
762:         ENDIF
763:     ENDPROC
764: 
765:     *--------------------------------------------------------------------------
766:     * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
767:     *--------------------------------------------------------------------------
768:     PROCEDURE BtnSelTudoClick()
769:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
770:             THIS.this_oBusinessObject.MarcarTodos()
771:         ENDIF
772:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
773:     ENDPROC
774: 
775:     *--------------------------------------------------------------------------

*-- Linhas 787 a 835:
787:     *--------------------------------------------------------------------------
788:     PROCEDURE BtnVisualizarClick()
789:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
790:             RETURN
791:         ENDIF
792:         IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
793:             MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para visualizar.", ;
794:                      "Visualizar")
795:             RETURN
796:         ENDIF
797:         IF !THIS.this_oBusinessObject.Processamento()
798:             RETURN
799:         ENDIF
800:         IF !THIS.this_oBusinessObject.Visualizacao()
801:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
802:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
803:             ENDIF
804:         ENDIF
805:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
806:     ENDPROC
807: 
808:     *--------------------------------------------------------------------------
809:     * BtnImprimirClick - Processa e imprime todas as NFs marcadas (Flag=.T.)
810:     *--------------------------------------------------------------------------
811:     PROCEDURE BtnImprimirClick()
812:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
813:             RETURN
814:         ENDIF
815:         IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
816:             MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para impress" + ;
817:                      CHR(227) + "o.", "Impress" + CHR(227) + "o")
818:             RETURN
819:         ENDIF
820:         GO TOP IN cursor_4c_TmpNFis
821:         IF !THIS.this_oBusinessObject.Processamento()
822:             RETURN
823:         ENDIF
824:         IF !THIS.this_oBusinessObject.Impressao()
825:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
826:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
827:             ENDIF
828:         ENDIF
829:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
830:         THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * BtnExcelClick - Exportacao Excel nao disponivel para este relatorio
835:     *--------------------------------------------------------------------------

*-- Linhas 865 a 899:
865:     * BtnAlterarClick - Form REPORT/OPERACIONAL: alterar nao se aplica.
866:     *   Mapeado para Visualizar (preview da NF do registro corrente do grid),
867:     *   que e a operacao mais proxima de "abrir/editar" no fluxo do SIGREGNF.
868:     *--------------------------------------------------------------------------
869:     PROCEDURE BtnAlterarClick()
870:         IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
871:             MsgAviso("Processe a sele" + CHR(231) + CHR(227) + "o de notas fiscais " + ;
872:                      "antes de visualizar.", "Visualizar")
873:             RETURN
874:         ENDIF
875:         THIS.BtnVisualizarClick()
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * BtnExcluirClick - Form REPORT/OPERACIONAL: excluir nao se aplica.
880:     *   Mapeado para Apaga (desmarca todas as NFs do grid), que e a operacao
881:     *   de "limpeza/exclusao" disponivel no fluxo do SIGREGNF.
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnExcluirClick()
884:         IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
885:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas fiscais para " + ;
886:                      "desmarcar.", "Desmarcar")
887:             RETURN
888:         ENDIF
889:         THIS.BtnApagaClick()
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * BtnBuscarClick - Form REPORT: buscar equivale a Processar (carregar grid)
894:     *--------------------------------------------------------------------------
895:     PROCEDURE BtnBuscarClick()
896:         THIS.BtnProcessarClick()
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------

*-- Linhas 973 a 994:
973:         ENDIF
974:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
975:             THIS.this_oBusinessObject.this_cSeries  = ""
976:             THIS.this_oBusinessObject.this_cUsuars  = ""
977:             THIS.this_oBusinessObject.this_lNotasAnt = .F.
978:             IF USED("cursor_4c_TmpNFis")
979:                 ZAP IN cursor_4c_TmpNFis
980:             ENDIF
981:         ENDIF
982:         THIS.this_cSerieAnterior  = ""
983:         THIS.this_cUsuarsAnterior = ""
984:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
985:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
986:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
987:             ENDIF
988:         ENDIF
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * CarregarLista - Recarrega o grid com dados do banco (se filtros preenchidos)
993:     *--------------------------------------------------------------------------
994:     PROCEDURE CarregarLista()

*-- Linhas 1021 a 1039:
1021:         LOCAL loc_lTemSerie, loc_lTemDados
1022:         IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
1023:             RETURN
1024:         ENDIF
1025:         loc_lTemSerie = !EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
1026:         loc_lTemDados = USED("cursor_4c_TmpNFis") AND RECCOUNT("cursor_4c_TmpNFis") > 0
1027: 
1028:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
1029:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = loc_lTemSerie
1030:         ENDIF
1031:         IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
1032:             THIS.cmd_4c_SelTudo.Enabled = loc_lTemDados
1033:         ENDIF
1034:         IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
1035:             THIS.cmd_4c_Apaga.Enabled = loc_lTemDados
1036:         ENDIF
1037:     ENDPROC
1038: 
1039: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigregnfBO.prg):
*==============================================================================
* SIGREGNFBO.PRG
* Business Object - Emissao Global de Nota Fiscal
*
* Herda de RelatorioBase
* Selecao, verificacao, impressao e visualizacao de NFs
* Form legado: sigregnf.SCX (classe frmrelatorio)
*==============================================================================

DEFINE CLASS sigregnfBO AS RelatorioBase

    *-- Filtros de selecao (preenchidos pelo form antes de SelecionarDados)
    this_cSeries            = ""    && Serie da NF para filtro (C, 3)
    this_cUsuars            = ""    && Usuario para filtro (C, 10 - vazio = todos)

    *-- Estado interno do processamento
    this_lNotasAnt          = .F.   && .T. se existem notas anteriores nao impressas desta serie

    *-- Dados auxiliares carregados no Init
    this_cMascNums          = ""    && Mascara de numeracao de SigCdPam.MascNums

    *-- Nomes dos cursors de trabalho persistentes
    this_cCursorNFis        = "cursor_4c_TmpNFis"     && Dados das NFs selecionadas (usado no grid)
    this_cCursorClientes    = "cursor_4c_Clientes"    && Cache de clientes (Iclis/RClis)
    this_cCursorSeries      = "cursor_4c_SigCdSer"    && Series carregadas no Init (persiste para busca)

    *-- Mensagem de erro para o form exibir
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Cria cursors de trabalho e carrega dados auxiliares do banco
    * Equivalente ao Load + Init do legado: fConfigGeral + SigCdPam + SigCdSer
    * Em modo gb_4c_ValidandoUI (.T.) os cursores sao criados vazios sem SQL.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Cursor principal: equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorNFis)
                USE IN (THIS.this_cCursorNFis)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorNFis) ;
                (Flag l, ;
                 Emis d, ;
                 Series c(3), ;
                 Operas c(1), ;
                 CFis c(10), ;
                 NFis c(6), ;
                 TotNotas n(12,2), ;
                 Conta c(40), ;
                 Operacao c(30), ;
                 Emps c(3), ;
                 Dopes c(20), ;
                 Numes n(6))
            INDEX ON NFis TAG NFis

            *-- Cursor auxiliar de clientes: equivalente ao crClientes do legado
            IF USED(THIS.this_cCursorClientes)
                USE IN (THIS.this_cCursorClientes)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorClientes) ;
                (Iclis c(10), RClis c(50))
            INDEX ON Iclis TAG Iclis

            *-- Em modo ValidarUI sem conexao SQL, cursores vazios sao suficientes
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = DODEFAULT()
            ELSE
                *-- Carregar mascara de numeracao de SigCdPam
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT MascNums FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult > 0 AND USED("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    IF !EOF()
                        THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                    ENDIF
                    USE IN cursor_4c_SigCdPam
                ENDIF

                *-- Carregar series para validacao em SelecionarDados (mantido aberto)
                IF USED(THIS.this_cCursorSeries)
                    USE IN (THIS.this_cCursorSeries)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT EmpCods, TipoNfs FROM SigCdSer", ;
                    THIS.this_cCursorSeries)
                IF loc_nResult > 0 AND USED(THIS.this_cCursorSeries)
                    SELECT (THIS.this_cCursorSeries)
                    INDEX ON EmpCods TAG EmpCods
                    loc_lSucesso = DODEFAULT()
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdSer"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro do BO
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook de RelatorioBase: prepara dados para a tela/relatorio
    * Delega para SelecionarDados que monta filtros (Serie + Usuario opcional)
    * e popula cursor_4c_TmpNFis com as NFs disponiveis para impressao
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cSeries))
                THIS.this_cMensagemErro = "S" + CHR(233) + "rie n" + CHR(227) + ;
                                          "o informada"
            ELSE
                loc_lSucesso = THIS.SelecionarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente em cursor_4c_TmpNFis
    * Formato: Emps + Dopes + Numes (mesmo padrao EmpDopNums do legado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cCursorNFis)
            SELECT (THIS.this_cCursorNFis)
            IF !EOF() AND !BOF()
                loc_cChave = EVALUATE(THIS.this_cCursorNFis + ".Emps") + ;
                             ALLTRIM(EVALUATE(THIS.this_cCursorNFis + ".Dopes")) + ;
                             STR(EVALUATE(THIS.this_cCursorNFis + ".Numes"), 6)
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de emissao/visualizacao de NFs
    * Insere em LogAuditoria via INSERT direto (sem BusinessBase neste fluxo)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(Tabela, ChavePrimaria, Operacao, Usuario, DataHora) VALUES (" + ;
                           EscaparSQL("SigMvNfi") + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE())"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lSucesso = (loc_nResult >= 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Seleciona NFs disponiveis para impressao
    * Filtra por Serie (obrigatorio) e Usuario (opcional)
    * Popula cursor_4c_TmpNFis com NFs nao impressas/canceladas
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_lAbortado
        LOCAL loc_cEmpr, loc_cSeries, loc_cUsuars
        LOCAL loc_lcCli, loc_cDopes, loc_cEmps, loc_cMvSeries, loc_nNumes
        LOCAL loc_dEmis, loc_cOperas, loc_cCFis, loc_cNFis, loc_nTotNotas, loc_cCliFors
        loc_lSucesso = .F.
        TRY
            ZAP IN (THIS.this_cCursorNFis)
            WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cSeries = PADR(THIS.this_cSeries, 3)
            loc_cUsuars = PADR(THIS.this_cUsuars, 10)
            loc_lAbortado = .F.

            *-- Seleciona NFs nao impressas/canceladas da serie indicada
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                *-- Sem filtro de usuario: query direta em SigMvNfi
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, b.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "LEFT JOIN SigCdCli b ON b.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ELSE
                *-- Com filtro de usuario: join via SigMvCab para filtrar por Usuars
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, c.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "INNER JOIN SigMvCab cab ON cab.EmpDopNums = a.EmpDopNums " + ;
                           "LEFT JOIN SigCdCli c ON c.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND cab.Usuars = " + EscaparSQL(loc_cUsuars) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao selecionar NFs"
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                *-- Carrega operacoes para filtragem por tipo
                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                loc_nResult2 = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes, TipoNfs, Nfiscals, Agrupas FROM SigCdOpe", ;
                    "cursor_4c_SigCdOpe")
                IF loc_nResult2 < 1 OR !USED("cursor_4c_SigCdOpe")
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdOpe)"
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_SigCdOpe
                    INDEX ON Dopes TAG Dopes ADDITIVE
                ENDIF
            ENDIF

            IF !loc_lAbortado
                *-- Scan: aplica filtros de tipo e insere em cursor_4c_TmpNFis
                SELECT cursor_4c_SigMvNfi
                SCAN
                    *-- Captura campos antes de mudar work area
                    loc_lcCli     = ALLTRIM(NVL(cursor_4c_SigMvNfi.Rclis, ""))
                    loc_cDopes    = cursor_4c_SigMvNfi.Dopes
                    loc_cEmps     = cursor_4c_SigMvNfi.Emps
                    loc_cMvSeries = cursor_4c_SigMvNfi.Series
                    loc_nNumes    = cursor_4c_SigMvNfi.Numes
                    loc_dEmis     = cursor_4c_SigMvNfi.Emis
                    loc_cOperas   = cursor_4c_SigMvNfi.Operas
                    loc_cCFis     = cursor_4c_SigMvNfi.CFis
                    loc_cNFis     = cursor_4c_SigMvNfi.NFis
                    loc_nTotNotas = cursor_4c_SigMvNfi.TotNotas
                    loc_cCliFors  = cursor_4c_SigMvNfi.CliFors

                    =SEEK(loc_cDopes, "cursor_4c_SigCdOpe", "Dopes")

                    IF !SEEK(loc_cEmpr + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                        =SEEK(SPACE(3) + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                    ENDIF

                    *-- Filtra por tipo de NF (igual ao legado)
                    IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 4
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ELSE
                        IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 2
                            LOOP
                        ENDIF
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ENDIF

                    INSERT INTO (THIS.this_cCursorNFis) ;
                        (Flag, Emis, Series, Operas, CFis, NFis, TotNotas, Conta, ;
                         Operacao, Emps, Dopes, Numes) ;
                        VALUES (.T., ;
                                NVL(loc_dEmis, CTOD("")), ;
                                loc_cMvSeries, ;
                                loc_cOperas, ;
                                loc_cCFis, ;
                                loc_cNFis, ;
                                loc_nTotNotas, ;
                                loc_cCliFors + " " + loc_lcCli, ;
                                loc_cEmps + ALLTRIM(loc_cDopes) + ;
                                    " " + ALLTRIM(fGerMascara(loc_nNumes)), ;
                                loc_cEmps, ;
                                loc_cDopes, ;
                                loc_nNumes)
                ENDSCAN

                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarNf - Verifica se existem NFs anteriores nao impressas da serie
    * Retorna .T. se pode prosseguir, .F. se ha bloqueio por nota anterior
    *--------------------------------------------------------------------------
    PROCEDURE VerificarNf()
        LOCAL loc_lSucesso, loc_nResult, loc_lAbortado
        LOCAL loc_lcEdn, loc_lcSql, loc_lcNota, loc_lcTxt
        LOCAL loc_cVEmps, loc_cVDopes, loc_cVSeries, loc_nVNumes, loc_cVNFis
        loc_lSucesso = .T.
        TRY
            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                IF !Flag
                    LOOP
                ENDIF
                loc_cVEmps   = Emps
                loc_cVDopes  = Dopes
                loc_cVSeries = Series
                loc_nVNumes  = Numes
                loc_cVNFis   = NFis

                loc_lcEdn = loc_cVEmps + loc_cVDopes + STR(loc_nVNumes, 6)

                loc_lcSql = "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.dopes = a.dopes AND a.nfiscals IN (1,2)" + ;
                            " AND a.tiponfs <> 4 AND a.agrupas = 1" + ;
                            " UNION ALL " + ;
                            "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.series = b.cods AND c.dopes = a.dopes" + ;
                            " AND a.nfiscals IN (1,2) AND a.tiponfs = 4 AND b.impnfs = 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TmpFiscal")
                IF loc_nResult < 0
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha na Conex" + CHR(227) + "o (TmpFiscal)")
                    loc_lSucesso  = .F.
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_TmpFiscal
                    IF RECCOUNT() > 0
                        LOCATE FOR EmpDopNums = loc_lcEdn
                        loc_lcNota = loc_cVNFis

                        SELECT * FROM cursor_4c_TmpFiscal ;
                            WHERE Nfis < loc_lcNota ;
                            INTO CURSOR cursor_4c_Selecao

                        SELECT cursor_4c_Selecao
                        IF RECCOUNT() > 0
                            loc_lcTxt = ""
                            SCAN
                                loc_lcTxt = loc_lcTxt + CHR(13) + ;
                                    "Nota : " + cursor_4c_Selecao.NFis + ;
                                    " - Opera" + CHR(231) + CHR(227) + "o : " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 01, 03)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 04, 20)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 24, 06)) + ;
                                    SPACE(10)
                            ENDSCAN
                            MsgAviso("Existem Notas Anteriores Desta S" + CHR(233) + ;
                                     "rie Ainda N" + CHR(227) + ;
                                     "o Impressas!!!" + loc_lcTxt, ;
                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpFiscal")
                        USE IN cursor_4c_TmpFiscal
                    ENDIF
                ENDIF
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Verifica sequencia de NFs antes de imprimir
    * Consulta SigCnFn2 e chama VerificarNf para detectar notas anteriores
    * Deve ser chamado pelo form antes de Impressao()
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cSeries, loc_cEmps
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorNFis) OR EOF(THIS.this_cCursorNFis)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_lNotasAnt = .F.

            loc_cSeries = EVALUATE(THIS.this_cCursorNFis + ".Series")
            loc_cEmps   = EVALUATE(THIS.this_cCursorNFis + ".Emps")

            loc_cSQL = "SELECT Series, Emps, VSeqNota FROM SigCnFn2 " + ;
                       "WHERE Series = " + EscaparSQL(loc_cSeries) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND VSeqNota = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCnFnfT")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigCnFnfT)")
            ELSE
                SELECT cursor_4c_SigCnFnfT
                IF !EOF()
                    IF !THIS.VerificarNf()
                        THIS.this_lNotasAnt = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_SigCnFnfT")
                    USE IN cursor_4c_SigCnFnfT
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Imprime todas as NFs marcadas (Flag=.T.)
    * Chama SigPrNfs para cada NF marcada e recarrega lista ao final
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_lFlag, loc_cEmps, loc_cDopes, loc_nNumes, loc_cNFis
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            GO BOTTOM IN (THIS.this_cCursorNFis)
            GO TOP IN (THIS.this_cCursorNFis)

            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                loc_lFlag  = Flag
                loc_cEmps  = Emps
                loc_cDopes = Dopes
                loc_nNumes = Numes
                loc_cNFis  = NFis

                IF loc_lFlag
                    WAIT WINDOW "Imprimindo Nota Fiscal n" + CHR(186) + " " + ;
                        loc_cNFis NOWAIT

                    ZAP IN cursor_4c_TprMvCab

                    loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)

                    *-- Busca cabecalho em SigMvCab
                    loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                               "TpFats, Obses, ValVars FROM SigMvCab " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                        loc_lAbortado = .T.
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvCab

                        INSERT INTO cursor_4c_TprMvCab ;
                            (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                            VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                                    cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                                    cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                                    cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                        *-- Busca itens em SigMvNfi
                        loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                        loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                        IF loc_nResult2 < 1
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                            loc_lAbortado = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvNfi

                        *-- Imprime usando rotina legada SigPrNfs.prg
                        DO SigPrNfs WITH "I", loc_cEmps, loc_cDopes, loc_nNumes

                        SELECT (THIS.this_cCursorNFis)
                        DELETE
                    ENDIF
                ENDIF
            ENDSCAN

            IF !loc_lAbortado
                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                THIS.SelecionarDados()
                WAIT CLEAR
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Visualiza a NF do registro corrente do cursor
    * Cursor cursor_4c_TmpNFis deve estar posicionado no registro desejado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNFis)
        IF EOF() OR BOF() OR !Flag
            RETURN .F.
        ENDIF

        TRY
            loc_cEmps  = EVALUATE(THIS.this_cCursorNFis + ".Emps")
            loc_cDopes = EVALUATE(THIS.this_cCursorNFis + ".Dopes")
            loc_nNumes = EVALUATE(THIS.this_cCursorNFis + ".Numes")

            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
            loc_lAbortado = .F.

            *-- Busca cabecalho em SigMvCab
            loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                       "TpFats, Obses, ValVars FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvCab

                INSERT INTO cursor_4c_TprMvCab ;
                    (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                    VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                            cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                            cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                            cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                *-- Busca itens em SigMvNfi
                loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                IF loc_nResult2 < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                    loc_lAbortado = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvNfi

                *-- Visualiza usando rotina legada SigPrNfs.prg
                DO SigPrNfs WITH "V", loc_cEmps, loc_cDopes, loc_nNumes

                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os registros do cursor TmpNFis (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os registros do cursor TmpNFis (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(10), loc_nI

        loc_aCursors(1)  = THIS.this_cCursorNFis
        loc_aCursors(2)  = THIS.this_cCursorClientes
        loc_aCursors(3)  = THIS.this_cCursorSeries
        loc_aCursors(4)  = "cursor_4c_TmpFiscal"
        loc_aCursors(5)  = "cursor_4c_SigCdOpe"
        loc_aCursors(6)  = "cursor_4c_SigMvNfi"
        loc_aCursors(7)  = "cursor_4c_SigMvCab"
        loc_aCursors(8)  = "cursor_4c_SigCnFnfT"
        loc_aCursors(9)  = "cursor_4c_TprMvCab"
        loc_aCursors(10) = "cursor_4c_Selecao"

        FOR loc_nI = 1 TO 10
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

