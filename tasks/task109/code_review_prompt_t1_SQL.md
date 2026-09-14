# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TMPVNF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, CANCELAS, IMPRESS, USUARS, TMPVNF, DOPES, TIPONFS, AGRUPAS, NFISCALS, IMPNFS, EMPDOPNUMS, NFIS, VSEQNOTA, TMPNF, NF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TMPNF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, CANCELAS, IMPRESS, USUARS, TMPVNF, DOPES, TIPONFS, AGRUPAS, NFISCALS, IMPNFS, EMPDOPNUMS, NFIS, VSEQNOTA, TMPNF, NF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, CANCELAS, IMPRESS, USUARS, TMPVNF, DOPES, TIPONFS, AGRUPAS, NFISCALS, IMPNFS, EMPDOPNUMS, NFIS, VSEQNOTA, TMPNF, NF

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigregnf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1036 linhas total):

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

*-- Linhas 408 a 439:
408:     *--------------------------------------------------------------------------
409:     * ConfigurarGridNF - Grid de 9 colunas: CheckBox(Flag), Num, Serie, Emis,
410:     *   Op, CFOP, Valor, Operacao, Emitente. Ordem obrigatoria Column1:
411:     *   AddObject -> Caption -> CurrentControl -> ControlSource (Error 1767)
412:     *   ColumnOrder: Column4.ColumnOrder=5, Column5.ColumnOrder=4 (Op exibe
413:     *   antes de Emissao, replicando ColumnOrder do original SIGREGNF.Grade).
414:     *--------------------------------------------------------------------------
415:     PROTECTED PROCEDURE ConfigurarGridNF(par_oCp)
416:         par_oCp.AddObject("grd_4c_Dados", "Grid")
417:         WITH par_oCp.grd_4c_Dados
418:             .Top                = 110
419:             .Left               = 30
420:             .Width              = 739
421:             .Height             = 364
422:             .ColumnCount        = 9
423:             .RecordSource       = "cursor_4c_TmpNFis"
424:             .DeleteMark         = .F.
425:             .RecordMark         = .F.
426:             .FontName           = "Tahoma"
427:             .FontSize           = 8
428:             .AllowHeaderSizing  = .F.
429:             .AllowRowSizing     = .F.
430:             .RowHeight          = 16
431:             .ScrollBars         = 2
432:             .HighlightStyle     = 2
433:             .GridLineColor      = RGB(238,238,238)
434:             .HighlightBackColor = RGB(255,255,255)
435:             .HighlightForeColor = RGB(15,41,104)
436:             .ForeColor          = RGB(90,90,90)
437:             .BackColor          = RGB(255,255,255)
438:             .Visible            = .T.
439: 

*-- Linhas 450 a 562:
450:                     .AutoSize  = .T.
451:                     .BackStyle = 0
452:                     .Visible   = .T.
453:                 ENDWITH
454:                 .CurrentControl    = "Check1"
455:                 .ControlSource     = "cursor_4c_TmpNFis.Flag"
456:                 .Header1.Caption   = ""
457:                 .Header1.Alignment = 2
458:                 .Header1.ForeColor = RGB(90,90,90)
459:             ENDWITH
460: 
461:             WITH .Column2
462:                 .Width             = 45
463:                 .Movable           = .F.
464:                 .Resizable         = .F.
465:                 .ReadOnly          = .T.
466:                 .FontBold          = .T.
467:                 .ControlSource     = "cursor_4c_TmpNFis.NFis"
468:                 .Header1.Caption   = "N" + CHR(250) + "mero"
469:                 .Header1.Alignment = 2
470:                 .Header1.ForeColor = RGB(90,90,90)
471:             ENDWITH
472: 
473:             WITH .Column3
474:                 .Width             = 28
475:                 .Movable           = .F.
476:                 .Resizable         = .F.
477:                 .ReadOnly          = .T.
478:                 .ControlSource     = "cursor_4c_TmpNFis.Series"
479:                 .Header1.Caption   = "S" + CHR(233) + "rie"
480:                 .Header1.Alignment = 2
481:                 .Header1.ForeColor = RGB(90,90,90)
482:             ENDWITH
483: 
484:             WITH .Column4
485:                 .Width             = 62
486:                 .Movable           = .F.
487:                 .Resizable         = .F.
488:                 .ReadOnly          = .T.
489:                 .ColumnOrder       = 5
490:                 .ControlSource     = "cursor_4c_TmpNFis.Emis"
491:                 .Header1.Caption   = "Emiss" + CHR(227) + "o"
492:                 .Header1.Alignment = 2
493:                 .Header1.ForeColor = RGB(90,90,90)
494:             ENDWITH
495: 
496:             WITH .Column5
497:                 .Width             = 18
498:                 .Movable           = .F.
499:                 .Resizable         = .F.
500:                 .ReadOnly          = .T.
501:                 .ColumnOrder       = 4
502:                 .ControlSource     = "cursor_4c_TmpNFis.Operas"
503:                 .Header1.Caption   = "Op"
504:                 .Header1.Alignment = 2
505:                 .Header1.ForeColor = RGB(90,90,90)
506:             ENDWITH
507: 
508:             WITH .Column6
509:                 .Width             = 60
510:                 .Movable           = .F.
511:                 .Resizable         = .F.
512:                 .ReadOnly          = .T.
513:                 .ControlSource     = "cursor_4c_TmpNFis.CFis"
514:                 .Header1.Caption   = "CFOP"
515:                 .Header1.Alignment = 2
516:                 .Header1.ForeColor = RGB(90,90,90)
517:             ENDWITH
518: 
519:             WITH .Column7
520:                 .Width             = 75
521:                 .Movable           = .F.
522:                 .Resizable         = .F.
523:                 .ReadOnly          = .T.
524:                 .InputMask         = "999,999,999.99"
525:                 .ControlSource     = "cursor_4c_TmpNFis.TotNotas"
526:                 .Header1.Caption   = "Valor Total"
527:                 .Header1.Alignment = 2
528:                 .Header1.ForeColor = RGB(90,90,90)
529:             ENDWITH
530: 
531:             WITH .Column8
532:                 .Width             = 150
533:                 .Movable           = .F.
534:                 .Resizable         = .F.
535:                 .ReadOnly          = .T.
536:                 .ControlSource     = "cursor_4c_TmpNFis.Operacao"
537:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
538:                 .Header1.Alignment = 2
539:                 .Header1.ForeColor = RGB(90,90,90)
540:             ENDWITH
541: 
542:             WITH .Column9
543:                 .Width             = 246
544:                 .Movable           = .F.
545:                 .Resizable         = .F.
546:                 .ReadOnly          = .T.
547:                 .ControlSource     = "cursor_4c_TmpNFis.Conta"
548:                 .Header1.Caption   = "Emitente / Destinat" + CHR(225) + "rio"
549:                 .Header1.Alignment = 2
550:                 .Header1.ForeColor = RGB(90,90,90)
551:             ENDWITH
552:         ENDWITH
553:     ENDPROC
554: 
555:     *--------------------------------------------------------------------------
556:     * AlternarPagina - Refresh da area de dados (form FLAT sem page switching)
557:     *--------------------------------------------------------------------------
558:     PROCEDURE AlternarPagina(par_nPagina)
559:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
560:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
561:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
562:             ENDIF

*-- Linhas 631 a 673:
631:                 loc_oLookup.Show()
632:             ENDIF
633:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
634:                 SELECT cursor_4c_BuscaSerie
635:                 IF !EOF()
636:                     THIS.cnt_4c_Corpo.txt_4c_Serie.Value = PADR(ALLTRIM(Series), 3)
637:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
638:                 ENDIF
639:                 USE IN cursor_4c_BuscaSerie
640:             ENDIF
641:             loc_oLookup.Release()
642:         ENDIF
643:     ENDPROC
644: 
645:     *--------------------------------------------------------------------------
646:     * ValidarSerie - Valida serie digitada contra SigCnFNf; abre lookup se nao achar
647:     *--------------------------------------------------------------------------
648:     PROTECTED PROCEDURE ValidarSerie(par_cSerie)
649:         LOCAL loc_nResult, loc_lAchou
650:         loc_lAchou = .F.
651:         IF USED("cursor_4c_SerieVal")
652:             USE IN cursor_4c_SerieVal
653:         ENDIF
654:         loc_nResult = SQLEXEC(gnConnHandle, ;
655:             "SELECT TOP 1 Series FROM SigCnFNf WHERE Series = " + EscaparSQL(par_cSerie), ;
656:             "cursor_4c_SerieVal")
657:         IF loc_nResult > 0 AND USED("cursor_4c_SerieVal")
658:             SELECT cursor_4c_SerieVal
659:             loc_lAchou = !EOF()
660:             USE IN cursor_4c_SerieVal
661:         ENDIF
662:         IF !loc_lAchou
663:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
664:                 THIS.AbrirLookupSerie()
665:             ENDIF
666:         ENDIF
667:     ENDPROC
668: 
669:     *--------------------------------------------------------------------------
670:     * UsuarsGotFocus - Salva valor inicial do usuario para deteccao de mudanca
671:     *--------------------------------------------------------------------------
672:     PROCEDURE UsuarsGotFocus()
673:         THIS.this_cUsuarsAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)

*-- Linhas 707 a 772:
707:                 loc_oLookup.Show()
708:             ENDIF
709:             IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaUsuars")
710:                 SELECT cursor_4c_BuscaUsuars
711:                 IF !EOF()
712:                     THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(Usuarios), 10)
713:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
714:                 ENDIF
715:                 USE IN cursor_4c_BuscaUsuars
716:             ENDIF
717:             loc_oLookup.Release()
718:         ENDIF
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     * ValidarUsuars - Valida usuario digitado contra SigCdUsu; abre lookup se nao achar
723:     *--------------------------------------------------------------------------
724:     PROTECTED PROCEDURE ValidarUsuars(par_cUsuars)
725:         LOCAL loc_nResult, loc_lAchou
726:         loc_lAchou = .F.
727:         IF USED("cursor_4c_UsuarsVal")
728:             USE IN cursor_4c_UsuarsVal
729:         ENDIF
730:         loc_nResult = SQLEXEC(gnConnHandle, ;
731:             "SELECT TOP 1 Usuarios FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(par_cUsuars), ;
732:             "cursor_4c_UsuarsVal")
733:         IF loc_nResult > 0 AND USED("cursor_4c_UsuarsVal")
734:             SELECT cursor_4c_UsuarsVal
735:             loc_lAchou = !EOF()
736:             USE IN cursor_4c_UsuarsVal
737:         ENDIF
738:         IF !loc_lAchou
739:             IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
740:                 THIS.AbrirLookupUsuars()
741:             ENDIF
742:         ENDIF
743:     ENDPROC
744: 
745:     *--------------------------------------------------------------------------
746:     * BtnProcessarClick - Executa SelecionarDados e preenche o grid com NFs
747:     *--------------------------------------------------------------------------
748:     PROCEDURE BtnProcessarClick()
749:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
750:             RETURN
751:         ENDIF
752:         THIS.FormParaBO()
753:         IF THIS.this_oBusinessObject.SelecionarDados()
754:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
755:         ENDIF
756:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
757:         IF USED("cursor_4c_TmpNFis") AND !EOF("cursor_4c_TmpNFis")
758:             THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.SetFocus()
759:         ENDIF
760:     ENDPROC
761: 
762:     *--------------------------------------------------------------------------
763:     * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
764:     *--------------------------------------------------------------------------
765:     PROCEDURE BtnSelTudoClick()
766:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
767:             THIS.this_oBusinessObject.MarcarTodos()
768:         ENDIF
769:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
770:     ENDPROC
771: 
772:     *--------------------------------------------------------------------------

*-- Linhas 784 a 832:
784:     *--------------------------------------------------------------------------
785:     PROCEDURE BtnVisualizarClick()
786:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
787:             RETURN
788:         ENDIF
789:         IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
790:             MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para visualizar.", ;
791:                      "Visualizar")
792:             RETURN
793:         ENDIF
794:         IF !THIS.this_oBusinessObject.Processamento()
795:             RETURN
796:         ENDIF
797:         IF !THIS.this_oBusinessObject.Visualizacao()
798:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
799:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
800:             ENDIF
801:         ENDIF
802:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
803:     ENDPROC
804: 
805:     *--------------------------------------------------------------------------
806:     * BtnImprimirClick - Processa e imprime todas as NFs marcadas (Flag=.T.)
807:     *--------------------------------------------------------------------------
808:     PROCEDURE BtnImprimirClick()
809:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
810:             RETURN
811:         ENDIF
812:         IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
813:             MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para impress" + ;
814:                      CHR(227) + "o.", "Impress" + CHR(227) + "o")
815:             RETURN
816:         ENDIF
817:         GO TOP IN cursor_4c_TmpNFis
818:         IF !THIS.this_oBusinessObject.Processamento()
819:             RETURN
820:         ENDIF
821:         IF !THIS.this_oBusinessObject.Impressao()
822:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
823:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
824:             ENDIF
825:         ENDIF
826:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
827:         THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
828:     ENDPROC
829: 
830:     *--------------------------------------------------------------------------
831:     * BtnExcelClick - Exportacao Excel nao disponivel para este relatorio
832:     *--------------------------------------------------------------------------

*-- Linhas 862 a 896:
862:     * BtnAlterarClick - Form REPORT/OPERACIONAL: alterar nao se aplica.
863:     *   Mapeado para Visualizar (preview da NF do registro corrente do grid),
864:     *   que e a operacao mais proxima de "abrir/editar" no fluxo do SIGREGNF.
865:     *--------------------------------------------------------------------------
866:     PROCEDURE BtnAlterarClick()
867:         IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
868:             MsgAviso("Processe a sele" + CHR(231) + CHR(227) + "o de notas fiscais " + ;
869:                      "antes de visualizar.", "Visualizar")
870:             RETURN
871:         ENDIF
872:         THIS.BtnVisualizarClick()
873:     ENDPROC
874: 
875:     *--------------------------------------------------------------------------
876:     * BtnExcluirClick - Form REPORT/OPERACIONAL: excluir nao se aplica.
877:     *   Mapeado para Apaga (desmarca todas as NFs do grid), que e a operacao
878:     *   de "limpeza/exclusao" disponivel no fluxo do SIGREGNF.
879:     *--------------------------------------------------------------------------
880:     PROCEDURE BtnExcluirClick()
881:         IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
882:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas fiscais para " + ;
883:                      "desmarcar.", "Desmarcar")
884:             RETURN
885:         ENDIF
886:         THIS.BtnApagaClick()
887:     ENDPROC
888: 
889:     *--------------------------------------------------------------------------
890:     * BtnBuscarClick - Form REPORT: buscar equivale a Processar (carregar grid)
891:     *--------------------------------------------------------------------------
892:     PROCEDURE BtnBuscarClick()
893:         THIS.BtnProcessarClick()
894:     ENDPROC
895: 
896:     *--------------------------------------------------------------------------

*-- Linhas 970 a 991:
970:         ENDIF
971:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
972:             THIS.this_oBusinessObject.this_cSeries  = ""
973:             THIS.this_oBusinessObject.this_cUsuars  = ""
974:             THIS.this_oBusinessObject.this_lNotasAnt = .F.
975:             IF USED("cursor_4c_TmpNFis")
976:                 ZAP IN cursor_4c_TmpNFis
977:             ENDIF
978:         ENDIF
979:         THIS.this_cSerieAnterior  = ""
980:         THIS.this_cUsuarsAnterior = ""
981:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
982:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
983:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
984:             ENDIF
985:         ENDIF
986:     ENDPROC
987: 
988:     *--------------------------------------------------------------------------
989:     * CarregarLista - Recarrega o grid com dados do banco (se filtros preenchidos)
990:     *--------------------------------------------------------------------------
991:     PROCEDURE CarregarLista()

*-- Linhas 1018 a 1036:
1018:         LOCAL loc_lTemSerie, loc_lTemDados
1019:         IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
1020:             RETURN
1021:         ENDIF
1022:         loc_lTemSerie = !EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
1023:         loc_lTemDados = USED("cursor_4c_TmpNFis") AND RECCOUNT("cursor_4c_TmpNFis") > 0
1024: 
1025:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
1026:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = loc_lTemSerie
1027:         ENDIF
1028:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_SelTudo", 5)
1029:             THIS.cnt_4c_Corpo.cmd_4c_SelTudo.Enabled = loc_lTemDados
1030:         ENDIF
1031:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Apaga", 5)
1032:             THIS.cnt_4c_Corpo.cmd_4c_Apaga.Enabled = loc_lTemDados
1033:         ENDIF
1034:     ENDPROC
1035: 
1036: ENDDEFINE


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
            IF USED("cursor_4c_TmpVNFis")
                USE IN cursor_4c_TmpVNFis
            ENDIF
            SELECT * FROM (THIS.this_cCursorNFis) WHERE Flag ;
                INTO CURSOR cursor_4c_TmpVNFis

            loc_lAbortado = .F.
            SELECT cursor_4c_TmpVNFis
            SCAN WHILE !loc_lAbortado
                loc_cVEmps   = cursor_4c_TmpVNFis.Emps
                loc_cVDopes  = cursor_4c_TmpVNFis.Dopes
                loc_cVSeries = cursor_4c_TmpVNFis.Series
                loc_nVNumes  = cursor_4c_TmpVNFis.Numes
                loc_cVNFis   = cursor_4c_TmpVNFis.NFis

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

            IF USED("cursor_4c_TmpVNFis")
                USE IN cursor_4c_TmpVNFis
            ENDIF
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
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))

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
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))

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
        LOCAL loc_aCursors(11), loc_nI

        loc_aCursors(1)  = THIS.this_cCursorNFis
        loc_aCursors(2)  = THIS.this_cCursorClientes
        loc_aCursors(3)  = THIS.this_cCursorSeries
        loc_aCursors(4)  = "cursor_4c_TmpVNFis"
        loc_aCursors(5)  = "cursor_4c_TmpFiscal"
        loc_aCursors(6)  = "cursor_4c_SigCdOpe"
        loc_aCursors(7)  = "cursor_4c_SigMvNfi"
        loc_aCursors(8)  = "cursor_4c_SigMvCab"
        loc_aCursors(9)  = "cursor_4c_SigCnFnfT"
        loc_aCursors(10) = "cursor_4c_TprMvCab"
        loc_aCursors(11) = "cursor_4c_Selecao"

        FOR loc_nI = 1 TO 11
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

