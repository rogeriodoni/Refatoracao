# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'INDEX_ID' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMN_ID' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IS_PRIMARY_KEY' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES

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
  Column1.ControlSource = "csContas.CprosAnt"
  Column2.ControlSource = "csContas.CprosNov"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
lcQuery = [Select CalcCustos ] + ;
		    [From SigCdPaC ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPac') < 1)
	.DeleteMark = .F.
	.Column1.ControlSource = "csContas.CprosAnt"
	.Column2.ControlSource = "csContas.CprosNov"
Insert Into csContas(cprosAnt, cprosNov) Values ('', '')
Select csContas
Select csContas
	lcSql = [Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+CsContas.CprosNov+[' And a.Cgrus = b.Cgrus ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
		lcSql = [Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+CsContas.CprosAnt+[' And a.Cgrus = b.Cgrus ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro2')
Select Arquivos, Campos ;
From ArqDBF ;
Select Distinct Arquivos From csCampos ;
Select Upper(Arquivos) as Arquivos, Indices  from vindsql where nprimarys = 1 ;
Select ChavePrim
Select CrSigOpClP
Select csContas
	Select CsArquivos
		Select csCampos
				lcWhere = [Select Emps, Grupos, Estos, Cpros, CodCors, CodTams, Min(Datas) as Datas From SigMvHst ]+;
				=ThisForm.PodataMgr.SqlExecute(lcWhere,'CrHis')
				Select CrHis
					lcUpdate = [Update SigCdPro Set Cbars = ]+Str(csContas.BarraAnt)+[ Where Cpros = ']+csContas.CprosNOv+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					lcUpdate = [Update SigCdPro Set Cbars = 0 Where Cpros = ']+CsContas.CprosAnt+[']
					lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpDate,'')
				lcSql = [Select Cpros From SigCdPro Where Cpros = ']+CsContas.CProsAnt+[']
				ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
				Select LocalPro
				lcSql = [Select * From SigMvEst Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
				lnErro = ThisForm.PodataMgr.SqlExecute(lcSql,'LocalEst')
				Select LocalEst
					lcDelete = [Delete From SigMvEst Where Cidchaves = ']+LocalEst.CidChaves+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcDelete,'')
				Select ChavePrim
				If Seek(lcArq)
					lcSql = [Select ]+lcChave+[ From ]+lcArq+[ Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcSql,'LocalArq')
					Select LocalArq
						lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[' Where ]+lcChave+[ = ']+KeyPry+[']
							lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[', ProCarTits = ']+csContas.CprosNov+[']+;
						lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[' Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
	Select CrSigOpClP
	Select CrSigOpClC
		Select TmpCustPro
			Insert Into CrSigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves ) Values ;
		If Not ThisForm.PodataMgr.Update('CrSigOpClC')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigOpClC)')
	Select csContas
	Delete For flag
	Select csContas
Select csContas
Delete
Select csContas
Select CrImporta
Append From (gcfileexcel) type xls
Select CrImporta
	lcSql = [Select Cpros From SigCdPro Where Cpros = ']+CrImporta.CprosAnt+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro') < 1
	Select csContas
	If Not Seek(m.CprosAnt + m.CprosNov )
Select CsContas

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1379 linhas total):

*-- Linhas 376 a 425:
376:                 .ColumnCount       = 2
377:                 .AllowHeaderSizing = .F.
378:                 .AllowRowSizing    = .F.
379:                 .DeleteMark        = .F.
380:                 .RecordMark        = .F.
381:                 .HeaderHeight      = 18
382:                 .RowHeight         = 18
383:                 .ScrollBars        = 2
384:                 .FontName          = "Verdana"
385:                 .FontSize          = 8
386:                 .ForeColor         = RGB(90, 90, 90)
387:                 .BackColor         = RGB(255, 255, 255)
388:                 .GridLineColor     = RGB(238, 238, 238)
389:                 .HighlightStyle    = 2
390:                 .TabIndex          = 5
391:                 .RecordSource      = "csContas"
392:                 WITH .Column1
393:                     .Width         = 118
394:                     .ControlSource = "csContas.CprosAnt"
395:                     WITH .Header1
396:                         .FontName  = "Tahoma"
397:                         .FontSize  = 8
398:                         .Alignment = 2
399:                         .Caption   = "C" + CHR(243) + "digo Original"
400:                     ENDWITH
401:                     WITH .Text1
402:                         .BorderStyle = 0
403:                         .Margin      = 0
404:                         .ForeColor   = RGB(0, 0, 0)
405:                         .BackColor   = RGB(255, 255, 255)
406:                     ENDWITH
407:                 ENDWITH
408:                 WITH .Column2
409:                     .Width         = 118
410:                     .ControlSource = "csContas.CprosNov"
411:                     WITH .Header1
412:                         .FontName  = "Tahoma"
413:                         .FontSize  = 8
414:                         .Alignment = 2
415:                         .Caption   = "Novo C" + CHR(243) + "digo"
416:                     ENDWITH
417:                     WITH .Text1
418:                         .BorderStyle = 0
419:                         .Margin      = 0
420:                         .ForeColor   = RGB(0, 0, 0)
421:                         .BackColor   = RGB(255, 255, 255)
422:                     ENDWITH
423:                 ENDWITH
424:                 .Visible = .T.
425:             ENDWITH

*-- Linhas 594 a 654:
594:         loc_lOK = .F.
595: 
596:         IF USED("csContas")
597:             SELECT csContas
598:             IF !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) AND ;
599:                !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
600:                 APPEND BLANK
601:                 loc_lOK = .T.
602:             ENDIF
603:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
604:                 THIS.grd_4c_Dados.Refresh
605:                 IF loc_lOK
606:                     THIS.grd_4c_Dados.Column1.SetFocus
607:                 ENDIF
608:             ENDIF
609:         ENDIF
610:     ENDPROC
611: 
612:     *==========================================================================
613:     * BtnExcluirClick - Remove linha selecionada do csContas
614:     *==========================================================================
615:     PROCEDURE BtnExcluirClick()
616:         IF USED("csContas")
617:             SELECT csContas
618:             IF !EOF()
619:                 DELETE
620:             ENDIF
621:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
622:                 THIS.grd_4c_Dados.Refresh
623:                 THIS.grd_4c_Dados.Column1.SetFocus
624:             ENDIF
625:         ENDIF
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * BtnAlterarClick - Coloca a linha corrente do grid em edicao
630:     * Form OPERACIONAL: nao possui botao Alterar visivel; disponivel para
631:     * scripting/atalho externo que precise reposicionar o cursor no par corrente
632:     * para edicao inline no grid csContas.
633:     *==========================================================================
634:     PROCEDURE BtnAlterarClick()
635:         IF !USED("csContas")
636:             RETURN
637:         ENDIF
638: 
639:         SELECT csContas
640:         IF RECCOUNT() = 0
641:             APPEND BLANK
642:         ELSE
643:             IF EOF()
644:                 GO BOTTOM
645:             ENDIF
646:         ENDIF
647: 
648:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
649:             THIS.grd_4c_Dados.Refresh
650:             THIS.grd_4c_Dados.SetFocus
651:             THIS.grd_4c_Dados.Column1.SetFocus
652:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
653:                 THIS.grd_4c_Dados.Column1.Text1.SelStart  = 0
654:                 THIS.grd_4c_Dados.Column1.Text1.SelLength = ;

*-- Linhas 668 a 686:
668:             RETURN
669:         ENDIF
670: 
671:         SELECT csContas
672:         SET ORDER TO
673:         GO TOP
674: 
675:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
676:             THIS.grd_4c_Dados.Refresh
677:             THIS.grd_4c_Dados.SetFocus
678:         ENDIF
679:     ENDPROC
680: 
681:     *==========================================================================
682:     * BtnExportaClick - Importa pares de substituicao de planilha XLS para csContas
683:     *==========================================================================
684:     PROCEDURE BtnExportaClick()
685:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro
686:         loc_cArquivo   = ""

*-- Linhas 764 a 1101:
764:             ENDIF
765: 
766:             *-- Selecionar campos elegiveis: tipo C, tamanho 10 ou 14, nomes especificos de produto
767:             SELECT Arquivos, Campos ;
768:                 FROM ArqDBF ;
769:                 WHERE (Tamanhos = 10 OR Tamanhos = 14) AND ;
770:                     UPPER(Tipos) = "C" AND ;
771:                     ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
772:                     ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
773:                     ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
774:                     ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
775:                     !EMPTY(Dbcs) AND ;
776:                     INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
777:                         "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
778:                         "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
779:                 ORDER BY Arquivos ;
780:                 INTO CURSOR csCampos READWRITE
781:             INDEX ON Arquivos + Campos TAG ArqCpo
782: 
783:             SELECT DISTINCT Arquivos FROM csCampos ;
784:                 INTO CURSOR csArquivos READWRITE ;
785:                 ORDER BY Arquivos
786:             loc_nTtArq = RECCOUNT("csArquivos")
787: 
788:             *-- Obter chaves primarias dos arquivos via SQL Server INFORMATION_SCHEMA
789:             loc_cSql = "SELECT UPPER(t.name) AS Arquivos, MIN(c.name) AS Indices " + ;
790:                 "FROM sys.indexes i " + ;
791:                 "JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id " + ;
792:                 "JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id " + ;
793:                 "JOIN sys.tables t ON i.object_id = t.object_id " + ;
794:                 "WHERE i.is_primary_key = 1 " + ;
795:                 "GROUP BY t.name"
796:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ChavePrim") > 0
797:                 SELECT cursor_4c_ChavePrim
798:                 INDEX ON UPPER(ALLTRIM(Arquivos)) TAG Arquivos
799:             ENDIF
800: 
801:             THIS.AlternarPagina(.T.)
802: 
803:             loc_nRec = 0
804:             SELECT csContas
805:             loc_nCnt = RECCOUNT("csContas") * loc_nTtArq
806:             IF loc_nCnt < 1
807:                 loc_nCnt = 1
808:             ENDIF
809: 
810:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
811:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
812: 
813:             SELECT csContas
814:             SCAN
815:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(NVL(csContas.CprosAnt, ""))
816:                 THIS.cnt_4c_Result.Refresh
817: 
818:                 SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
819: 
820:                 SELECT csArquivos
821:                 SCAN
822:                     loc_cArq = UPPER(ALLTRIM(STRTRAN(csArquivos.Arquivos, ".DBF", "")))
823:                     THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
824:                     THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
825: 
826:                     SELECT csCampos
827:                     SET ORDER TO ArqCpo
828:                     SEEK csArquivos.Arquivos
829: 
830:                     SCAN WHILE ALLTRIM(csArquivos.Arquivos) == ALLTRIM(csCampos.Arquivos) ;
831:                             AND !EOF("csCampos")
832:                         loc_cCpo = ALLTRIM(csCampos.Campos)
833:                         THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq + " / " + loc_cCpo
834:                         THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
835: 
836:                         *-- Pular SIGPRPRT
837:                         IF loc_cArq == "SIGPRPRT"
838:                             SELECT csCampos
839:                             LOOP
840:                         ENDIF
841: 
842:                         *-- SIGMVHST: atualizar campo diretamente sem recalculo de saldo
843:                         IF loc_cArq == "SIGMVHST"
844:                             loc_cSql = "UPDATE SigMvHst SET " + loc_cCpo + " = " + ;
845:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
846:                                 " WHERE " + loc_cCpo + " = " + ;
847:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
848:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
849:                             SELECT csCampos
850:                             IF loc_nErro < 1
851:                                 EXIT
852:                             ENDIF
853:                             LOOP
854:                         ENDIF
855: 
856:                         *-- SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT: verificar existencia do novo codigo
857:                         IF INLIST(loc_cArq, "SIGCDPRO","SIGPRCPO","SIGCDPRF","SIGCDPFT")
858:                             IF USED("cursor_4c_TmpPro")
859:                                 USE IN cursor_4c_TmpPro
860:                             ENDIF
861:                             loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
862:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
863:                             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpPro") > 0 AND ;
864:                                USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
865: 
866:                                 IF loc_cArq == "SIGCDPRO" AND loc_cCpo == "CPROS" AND THIS.this_lManterBarra
867:                                     loc_cSql = "UPDATE SigCdPro SET Cbars = " + ;
868:                                         FormatarNumeroSQL(NVL(csContas.BarraAnt, 0), 0) + ;
869:                                         " WHERE Cpros = " + ;
870:                                         EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
871:                                     loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
872:                                     IF USED("cursor_4c_TmpPro")
873:                                         USE IN cursor_4c_TmpPro
874:                                     ENDIF
875:                                     IF loc_nErro >= 1
876:                                         loc_cSql = "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + ;
877:                                             EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
878:                                         loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
879:                                     ENDIF
880:                                     SELECT csCampos
881:                                     IF loc_nErro < 1
882:                                         EXIT
883:                                     ENDIF
884:                                     LOOP
885:                                 ENDIF
886: 
887:                                 *-- Produto antigo ainda existe? Ambos existem, pular
888:                                 IF USED("cursor_4c_LocalPro")
889:                                     USE IN cursor_4c_LocalPro
890:                                 ENDIF
891:                                 loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
892:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
893:                                 IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalPro") > 0 AND ;
894:                                    USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
895:                                     IF USED("cursor_4c_LocalPro")
896:                                         USE IN cursor_4c_LocalPro
897:                                     ENDIF
898:                                     IF USED("cursor_4c_TmpPro")
899:                                         USE IN cursor_4c_TmpPro
900:                                     ENDIF
901:                                     SELECT csCampos
902:                                     LOOP
903:                                 ENDIF
904:                                 IF USED("cursor_4c_LocalPro")
905:                                     USE IN cursor_4c_LocalPro
906:                                 ENDIF
907:                             ENDIF
908:                             IF USED("cursor_4c_TmpPro")
909:                                 USE IN cursor_4c_TmpPro
910:                             ENDIF
911:                         ENDIF
912: 
913:                         *-- SIGMVEST: DELETE movimentos de estoque sem recalculo
914:                         IF loc_cArq == "SIGMVEST"
915:                             IF USED("cursor_4c_LocalEst")
916:                                 USE IN cursor_4c_LocalEst
917:                             ENDIF
918:                             loc_cSql = "SELECT CidChaves FROM SigMvEst WHERE " + ;
919:                                 loc_cCpo + " = " + ;
920:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
921:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalEst")
922:                             IF loc_nErro >= 1 AND USED("cursor_4c_LocalEst") AND ;
923:                                RECCOUNT("cursor_4c_LocalEst") > 0
924:                                 SELECT cursor_4c_LocalEst
925:                                 SCAN
926:                                     loc_cSql = "DELETE FROM SigMvEst WHERE CidChaves = " + ;
927:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_LocalEst.CidChaves, "")))
928:                                     loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
929:                                     IF loc_nErro < 1
930:                                         EXIT
931:                                     ENDIF
932:                                 ENDSCAN
933:                             ENDIF
934:                             IF USED("cursor_4c_LocalEst")
935:                                 USE IN cursor_4c_LocalEst
936:                             ENDIF
937:                             SELECT csCampos
938:                             IF loc_nErro < 1
939:                                 EXIT
940:                             ENDIF
941:                             LOOP
942:                         ENDIF
943: 
944:                         *-- Caso geral: UPDATE via chave primaria (se disponivel) ou campo direto
945:                         IF USED("cursor_4c_ChavePrim")
946:                             SELECT cursor_4c_ChavePrim
947:                             SET ORDER TO Arquivos
948:                             IF SEEK(UPPER(ALLTRIM(loc_cArq)))
949:                                 loc_cChave = ALLTRIM(cursor_4c_ChavePrim.Indices)
950:                                 IF USED("cursor_4c_LocalArq")
951:                                     USE IN cursor_4c_LocalArq
952:                                 ENDIF
953:                                 loc_cSql = "SELECT " + loc_cChave + " FROM " + loc_cArq + ;
954:                                     " WHERE " + loc_cCpo + " = " + ;
955:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
956:                                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalArq")
957:                                 IF loc_nErro >= 1 AND USED("cursor_4c_LocalArq") AND ;
958:                                    RECCOUNT("cursor_4c_LocalArq") > 0
959:                                     SELECT cursor_4c_LocalArq
960:                                     SCAN
961:                                         loc_cType = TYPE("cursor_4c_LocalArq." + loc_cChave)
962:                                         IF loc_cType = "N"
963:                                             IF UPPER(loc_cArq) == "SIGOPETQ"
964:                                                 loc_cKeyPry = ALLTRIM(STR(&loc_cChave., 14))
965:                                             ELSE
966:                                                 loc_cKeyPry = ALLTRIM(STR(&loc_cChave.))
967:                                             ENDIF
968:                                         ELSE
969:                                             loc_cKeyPry = ALLTRIM(&loc_cChave.)
970:                                         ENDIF
971:                                         IF UPPER(loc_cArq) == "SIGCDPFT"
972:                                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
973:                                                 loc_cCpo + " = " + ;
974:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
975:                                                 ", ProCarTits = " + ;
976:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
977:                                                 "+ccars+ctits WHERE " + ;
978:                                                 loc_cChave + " = " + EscaparSQL(loc_cKeyPry)
979:                                         ELSE
980:                                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
981:                                                 loc_cCpo + " = " + ;
982:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
983:                                                 " WHERE " + loc_cChave + " = " + ;
984:                                                 EscaparSQL(loc_cKeyPry)
985:                                         ENDIF
986:                                         loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
987:                                         IF loc_nErro < 1
988:                                             EXIT
989:                                         ENDIF
990:                                     ENDSCAN
991:                                 ENDIF
992:                                 IF USED("cursor_4c_LocalArq")
993:                                     USE IN cursor_4c_LocalArq
994:                                 ENDIF
995:                                 IF loc_nErro < 1
996:                                     SELECT csCampos
997:                                     EXIT
998:                                 ENDIF
999:                             ELSE
1000:                                 *-- Arquivo sem PK conhecida: UPDATE direto pelo campo
1001:                                 loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
1002:                                     loc_cCpo + " = " + ;
1003:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
1004:                                     " WHERE " + loc_cCpo + " = " + ;
1005:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
1006:                                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1007:                                 IF loc_nErro < 1
1008:                                     SELECT csCampos
1009:                                     EXIT
1010:                                 ENDIF
1011:                             ENDIF
1012:                         ELSE
1013:                             *-- Sem informacao de PK: UPDATE direto pelo campo
1014:                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
1015:                                 loc_cCpo + " = " + ;
1016:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
1017:                                 " WHERE " + loc_cCpo + " = " + ;
1018:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
1019:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1020:                             IF loc_nErro < 1
1021:                                 SELECT csCampos
1022:                                 EXIT
1023:                             ENDIF
1024:                         ENDIF
1025: 
1026:                         SELECT csCampos
1027:                     ENDSCAN  && csCampos (campos deste arquivo)
1028: 
1029:                     IF loc_nErro < 1
1030:                         SELECT csArquivos
1031:                         EXIT
1032:                     ENDIF
1033: 
1034:                     loc_nRec = loc_nRec + 1
1035:                     loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
1036:                     THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = loc_nPct * 2
1037:                     THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
1038:                         ALLTRIM(STR(loc_nPct)) + " %"
1039:                     THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
1040:                     SELECT csArquivos
1041:                 ENDSCAN  && csArquivos
1042: 
1043:                 IF loc_nErro < 1
1044:                     SQLEXEC(gnConnHandle, "ROLLBACK")
1045:                     SELECT csContas
1046:                     EXIT
1047:                 ENDIF
1048: 
1049:                 *-- Commit deste par de substituicao
1050:                 IF SQLEXEC(gnConnHandle, "COMMIT") < 1
1051:                     MsgErro("Favor reinicializar o processo.", ;
1052:                         "Falha na Conex" + CHR(227) + "o (Commit)")
1053:                     loc_nErro = 0
1054:                     SELECT csContas
1055:                     EXIT
1056:                 ENDIF
1057: 
1058:                 SELECT csContas
1059:                 REPLACE Flag WITH .T.
1060:             ENDSCAN  && csContas
1061: 
1062:             *-- Resultado final
1063:             IF loc_nErro < 1
1064:                 SELECT csContas
1065:                 SET ORDER TO
1066:                 DELETE FOR Flag
1067:                 GO TOP
1068:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1069:                     THIS.grd_4c_Dados.Refresh
1070:                 ENDIF
1071:                 MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", ;
1072:                     "Reprocessar!!!")
1073:             ELSE
1074:                 SELECT csContas
1075:                 SET ORDER TO
1076:                 ZAP
1077:                 APPEND BLANK
1078:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1079:                     THIS.grd_4c_Dados.Refresh
1080:                 ENDIF
1081:                 MsgAviso("Todos Os Produtos Foram Alterados!!!", ;
1082:                     "Processamento Encerrado!!!")
1083:             ENDIF
1084: 
1085:         CATCH TO loc_oErro
1086:             SQLEXEC(gnConnHandle, "ROLLBACK")
1087:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1088:                 "Erro BtnProcessarClick Formsigprmdp")
1089:         ENDTRY
1090: 
1091:         THIS.AlternarPagina(.F.)
1092: 
1093:         IF USED("csCampos")
1094:             USE IN csCampos
1095:         ENDIF
1096:         IF USED("csArquivos")
1097:             USE IN csArquivos
1098:         ENDIF
1099:         IF USED("cursor_4c_ChavePrim")
1100:             USE IN cursor_4c_ChavePrim
1101:         ENDIF

*-- Linhas 1125 a 1158:
1125: 
1126:         TRY
1127:             IF EMPTY(loc_cVal)
1128:                 SELECT csContas
1129:                 REPLACE CprosAnt WITH ""
1130:             ELSE
1131:                 IF USED("cursor_4c_TmpPro")
1132:                     USE IN cursor_4c_TmpPro
1133:                 ENDIF
1134:                 loc_nErro = SQLEXEC(gnConnHandle, ;
1135:                     "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cVal), ;
1136:                     "cursor_4c_TmpPro")
1137: 
1138:                 IF loc_nErro > 0 AND USED("cursor_4c_TmpPro") AND ;
1139:                    RECCOUNT("cursor_4c_TmpPro") > 0
1140:                     SELECT cursor_4c_TmpPro
1141:                     loc_cVal = ALLTRIM(NVL(cursor_4c_TmpPro.Cpros, ""))
1142:                     USE IN cursor_4c_TmpPro
1143:                     SELECT csContas
1144:                     REPLACE CprosAnt WITH loc_cVal
1145:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1146:                 ELSE
1147:                     IF USED("cursor_4c_TmpPro")
1148:                         USE IN cursor_4c_TmpPro
1149:                     ENDIF
1150:                     THIS.AbrirBuscaProduto()
1151:                 ENDIF
1152:             ENDIF
1153: 
1154:         CATCH TO loc_oErro
1155:             IF USED("cursor_4c_TmpPro")
1156:                 USE IN cursor_4c_TmpPro
1157:             ENDIF
1158:             MsgErro(loc_oErro.Message, "Erro ao validar produto")

*-- Linhas 1177 a 1218:
1177:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1178:                 loc_oLookup.Show()
1179:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1180:                     SELECT cursor_4c_BuscaPro
1181:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaPro.CPros, ""))
1182:                     USE IN cursor_4c_BuscaPro
1183:                     SELECT csContas
1184:                     REPLACE CprosAnt WITH loc_cVal
1185:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1186:                 ELSE
1187:                     IF USED("cursor_4c_BuscaPro")
1188:                         USE IN cursor_4c_BuscaPro
1189:                     ENDIF
1190:                 ENDIF
1191:             ENDIF
1192:         CATCH TO loc_oErro
1193:             IF USED("cursor_4c_BuscaPro")
1194:                 USE IN cursor_4c_BuscaPro
1195:             ENDIF
1196:             MsgErro(loc_oErro.Message, "Erro ao buscar produto")
1197:         ENDTRY
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * CarregarLista - (Re)inicializa o cursor csContas exibido no grd_4c_Dados
1202:     * Form OPERACIONAL: nao ha SELECT de Grid CRUD; carga = InicializarCursorContas
1203:     * do BO (CREATE CURSOR csContas + INDEX + APPEND BLANK).
1204:     *==========================================================================
1205:     PROCEDURE CarregarLista()
1206:         LOCAL loc_lSucesso, loc_oErro
1207:         loc_lSucesso = .F.
1208: 
1209:         TRY
1210:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1211:                 loc_lSucesso = THIS.this_oBusinessObject.InicializarCursorContas()
1212:             ENDIF
1213: 
1214:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1215:                 IF USED("csContas")
1216:                     THIS.grd_4c_Dados.RecordSource = "csContas"
1217:                 ENDIF
1218:                 THIS.grd_4c_Dados.Refresh

*-- Linhas 1290 a 1308:
1290:     *==========================================================================
1291:     PROCEDURE LimparCampos()
1292:         IF USED("csContas")
1293:             SELECT csContas
1294:             SET ORDER TO
1295:             ZAP
1296:             APPEND BLANK
1297:         ENDIF
1298: 
1299:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
1300:             THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
1301:             THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
1302:             IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
1303:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
1304:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
1305:             ENDIF
1306:             THIS.cnt_4c_Result.Visible = .F.
1307:         ENDIF
1308: 

*-- Linhas 1360 a 1378:
1360:         loc_lTemDados = .F.
1361: 
1362:         IF USED("csContas")
1363:             SELECT csContas
1364:             LOCATE FOR !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) OR ;
1365:                 !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
1366:             loc_lTemDados = FOUND()
1367:         ENDIF
1368: 
1369:         IF loc_lTemDados
1370:             IF !MsgConfirma("Descartar os pares informados?", ;
1371:                     "Cancelar Substitui" + CHR(231) + CHR(227) + "o")
1372:                 RETURN
1373:             ENDIF
1374:         ENDIF
1375: 
1376:         THIS.LimparCampos()
1377:     ENDPROC
1378: 


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* sigprmdpBO.prg - Business Object para Substitui??o de Refer?ncias de Produtos
* Tabela: SigOpClC (opera??es de recalculo de custo/estoque)
* Heran?a: BusinessBase
* Data: 2026-07-17
*==============================================================================
* FASE 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Chave e tabela principal (SigOpClC: recalculo de custo/estoque)
    this_cTabela      = "SigOpClC"
    this_cCampoChave  = "CidChaves"

    *-- Flags de controle de comportamento (parametros do form original)
    this_lCheckCadPro   = .F.   && Se .T., pula valida??o do produto no SigCdPro
    this_lManterBarra   = .F.   && Se .T., mant?m o c?digo de barras do produto antigo
    this_lCalculaCusto  = .F.   && Se .T., recalcula custo ap?s substitui??o

    *-- Par de c?digos sendo processado no loop atual
    this_cCprosAnt      = ""    && C?digo de produto antigo (Cpros char(14))
    this_cCprosNov      = ""    && C?digo de produto novo (Cpros char(14))

    *-- Atributos do produto antigo capturados antes do processamento
    this_nBarraAnt      = 0     && C?digo de barras (Cbars) do produto antigo

    *-- Estado de progresso do processamento em lote
    this_nTotal         = 0     && Total de pares a processar (csContas * csCampos)
    this_nProcessados   = 0     && Pares j? processados (para barra de progresso)
    this_nErro          = 0     && C?digo do ?ltimo erro de SQL (< 1 = falha)

    *-- Feedback visual do arquivo/campo sendo processado no momento
    this_cArquivoAtual  = ""    && Nome do arquivo DBF sendo atualizado
    this_cCampoAtual    = ""    && Nome do campo sendo atualizado no arquivo

    *-- C?digo do usu?rio logado (capturado no Init para auditoria)
    this_cUsuar         = ""    && Usuar - usu?rio logado

    *--------------------------------------------------------------------------
    * Init - Configura??o inicial do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        this.this_cTabela     = "SigOpClC"
        this.this_cCampoChave = "CidChaves"

        *-- Captura usu?rio logado para auditoria (fGravarLog)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            this.this_cUsuar = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (csContas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCprosAnt = TratarNulo(CprosAnt, "C")
            THIS.this_cCprosNov = TratarNulo(CprosNov, "C")
            THIS.this_nBarraAnt = TratarNulo(BarraAnt, "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna campo chave prim?ria de SigOpClC
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados m?nimos antes de Inserir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCprosNov)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto novo " + ;
                CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o configurada no sistema."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere pendencia de recalculo em SigOpClC
    * Sobrescreve BusinessBase.Inserir (chamado por Salvar quando lNovoRegistro=.T.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                FormatarDataSQL(DATE()) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCampoChave = loc_cCidChaves
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza pendencia em SigOpClC (data/usuario da requisicao)
    * Sobrescreve BusinessBase.Atualizar (chamado por Salvar quando lNovoRegistro=.F.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCampoChave)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria ausente para atualiza" + CHR(231) + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClC SET " + ;
                "CPros = " + EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                "EmpCPros = " + EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                "Datas = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuars = " + EscaparSQL(THIS.this_cUsuar) + " " + ;
                "WHERE CidChaves = " + EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove pend?ncia de rec?lculo de SigOpClC
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + ;
                EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao excluir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir de SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas - Cria cursor local de pares de substitui??o
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csContas")
                USE IN csContas
            ENDIF

            SET NULL ON
            CREATE CURSOR csContas (CprosAnt C(14) NULL, CprosNov C(14) NULL, Flag L NULL, BarraAnt N(8) NULL)
            SET NULL OFF

            INDEX ON CprosAnt + CprosNov TAG Duplica
            INDEX ON CprosAnt TAG CprosAnt
            INDEX ON CprosNov TAG CprosNov
            SET ORDER TO

            INSERT INTO csContas (CprosAnt, CprosNov) VALUES ("", "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCalcCustos - Busca configura??o de c?lculo de custos em SigCdPaC
    * Seta this_lCalculaCusto = .T. se CalcCustos <> 3
    *--------------------------------------------------------------------------
    FUNCTION BuscarCalcCustos()
        LOCAL loc_nCalcCustos, loc_oErro, loc_cSQL
        loc_nCalcCustos = 0

        TRY
            loc_cSQL = "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CalcCustos") > 0
                IF USED("cursor_4c_CalcCustos") AND RECCOUNT("cursor_4c_CalcCustos") > 0
                    SELECT cursor_4c_CalcCustos
                    loc_nCalcCustos = NVL(CalcCustos, 0)
                ENDIF
                IF USED("cursor_4c_CalcCustos")
                    USE IN cursor_4c_CalcCustos
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPaC)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo")
        ENDTRY

        THIS.this_lCalculaCusto = (loc_nCalcCustos <> 3)
        RETURN loc_nCalcCustos
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesNoGrid - Valida todos os pares em csContas antes do processamento
    * Retorna "" se OK, mensagem de erro se houver inconsist?ncia
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesNoGrid(par_lCheckCadPro, par_lManterBarra)
        LOCAL loc_cMensagem, loc_oErro, loc_cSQL, loc_nErro, loc_cEstoqsNov
        loc_cMensagem = ""

        TRY
            SELECT csContas
            GO TOP

            IF EOF()
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
                loc_lSucesso = loc_cMensagem
            ENDIF

            SELECT csContas
            SCAN
                IF EMPTY(csContas.CprosAnt)
                    loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(csContas.CprosAnt))
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                    IF loc_nErro < 1 OR (USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") = 0)
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lSucesso = loc_cMensagem
                    ENDIF
                    IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                        SELECT cursor_4c_TmpPro
                        REPLACE BarraAnt WITH NVL(cursor_4c_TmpPro.Cbars, 0) IN csContas
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                IF par_lManterBarra AND csContas.BarraAnt = 0
                    loc_cMensagem = "Existe Uma Referencia Antigo Sem Barra !!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF EMPTY(csContas.CprosNov)
                    loc_cMensagem = "Existe Uma Referencia Nova Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF csContas.CprosAnt = csContas.CprosNov
                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova Com o Mesmo C" + CHR(243) + "digo!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                    "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                    "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosNov))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0
                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        loc_cEstoqsNov = ALLTRIM(NVL(cursor_4c_LocalPro.Cestoqs, ""))
                        USE IN cursor_4c_LocalPro

                        loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                            "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                            "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosAnt))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") > 0
                            IF USED("cursor_4c_LocalPro2") AND RECCOUNT("cursor_4c_LocalPro2") > 0
                                SELECT cursor_4c_LocalPro2
                                IF ALLTRIM(NVL(cursor_4c_LocalPro2.Cestoqs, "")) <> loc_cEstoqsNov
                                    USE IN cursor_4c_LocalPro2
                                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova com Controle de Estoque diferente!!!"
                                    loc_lSucesso = loc_cMensagem
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_LocalPro2")
                                USE IN cursor_4c_LocalPro2
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            loc_cMensagem = "Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPendencia - Insere linha em SigOpClC para rec?lculo posterior
    * Chamado no loop de processamento para cada produto/empresa
    *--------------------------------------------------------------------------
    FUNCTION InserirPendencia(par_cEmps, par_cCpros, par_dData)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()
            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(par_cEmps) + ", " + ;
                EscaparSQL(par_cCpros) + ", " + ;
                EscaparSQL(par_cEmps + par_cCpros) + ", " + ;
                FormatarDataSQL(par_dData) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir pend" + CHR(234) + "ncia em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarXLS - Importa pares de substitui??o de planilha Excel para csContas
    * Retorna n?mero de registros importados com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarXLS(par_cArquivoXLS, par_lCheckCadPro)
        LOCAL loc_nImportados, loc_oErro, loc_cSQL, loc_cCprosAnt, loc_cCprosNov
        loc_nImportados = 0

        TRY
            IF !FILE(par_cArquivoXLS)
                MsgErro("Arquivo Excel n" + CHR(227) + "o encontrado: " + par_cArquivoXLS, "Erro")
                loc_lSucesso = 0
            ENDIF

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF

            CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
            INDEX ON CprosAnt TAG CprosAnt

            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivoXLS) TYPE XLS

            SELECT cursor_4c_Importa
            SCAN
                loc_cCprosAnt = ALLTRIM(cursor_4c_Importa.CprosAnt)
                loc_cCprosNov = ALLTRIM(cursor_4c_Importa.CprosNov)

                IF EMPTY(loc_cCprosAnt) OR EMPTY(loc_cCprosNov) OR loc_cCprosAnt = loc_cCprosNov
                    LOOP
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(loc_cCprosAnt)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") < 1
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                SELECT csContas
                SET ORDER TO Duplica
                IF !SEEK(loc_cCprosAnt + loc_cCprosNov)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_cCprosAnt, CprosNov WITH loc_cCprosNov
                    loc_nImportados = loc_nImportados + 1
                ENDIF
            ENDSCAN

            SELECT csContas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao importar planilha Excel")
        ENDTRY

        RETURN loc_nImportados
    ENDFUNC

ENDDEFINE

