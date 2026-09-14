# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONSTRAINT_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONSTRAINT_TYPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1376 linhas total):

*-- Linhas 373 a 422:
373:                 .ColumnCount       = 2
374:                 .AllowHeaderSizing = .F.
375:                 .AllowRowSizing    = .F.
376:                 .DeleteMark        = .F.
377:                 .RecordMark        = .F.
378:                 .HeaderHeight      = 18
379:                 .RowHeight         = 18
380:                 .ScrollBars        = 2
381:                 .FontName          = "Verdana"
382:                 .FontSize          = 8
383:                 .ForeColor         = RGB(90, 90, 90)
384:                 .BackColor         = RGB(255, 255, 255)
385:                 .GridLineColor     = RGB(238, 238, 238)
386:                 .HighlightStyle    = 2
387:                 .TabIndex          = 5
388:                 .RecordSource      = "csContas"
389:                 WITH .Column1
390:                     .Width         = 118
391:                     .ControlSource = "csContas.CprosAnt"
392:                     WITH .Header1
393:                         .FontName  = "Tahoma"
394:                         .FontSize  = 8
395:                         .Alignment = 2
396:                         .Caption   = "C" + CHR(243) + "digo Original"
397:                     ENDWITH
398:                     WITH .Text1
399:                         .BorderStyle = 0
400:                         .Margin      = 0
401:                         .ForeColor   = RGB(0, 0, 0)
402:                         .BackColor   = RGB(255, 255, 255)
403:                     ENDWITH
404:                 ENDWITH
405:                 WITH .Column2
406:                     .Width         = 118
407:                     .ControlSource = "csContas.CprosNov"
408:                     WITH .Header1
409:                         .FontName  = "Tahoma"
410:                         .FontSize  = 8
411:                         .Alignment = 2
412:                         .Caption   = "Novo C" + CHR(243) + "digo"
413:                     ENDWITH
414:                     WITH .Text1
415:                         .BorderStyle = 0
416:                         .Margin      = 0
417:                         .ForeColor   = RGB(0, 0, 0)
418:                         .BackColor   = RGB(255, 255, 255)
419:                     ENDWITH
420:                 ENDWITH
421:                 .Visible = .T.
422:             ENDWITH

*-- Linhas 591 a 651:
591:         loc_lOK = .F.
592: 
593:         IF USED("csContas")
594:             SELECT csContas
595:             IF !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) AND ;
596:                !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
597:                 APPEND BLANK
598:                 loc_lOK = .T.
599:             ENDIF
600:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
601:                 THIS.grd_4c_Dados.Refresh
602:                 IF loc_lOK
603:                     THIS.grd_4c_Dados.Column1.SetFocus
604:                 ENDIF
605:             ENDIF
606:         ENDIF
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * BtnExcluirClick - Remove linha selecionada do csContas
611:     *==========================================================================
612:     PROCEDURE BtnExcluirClick()
613:         IF USED("csContas")
614:             SELECT csContas
615:             IF !EOF()
616:                 DELETE
617:             ENDIF
618:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
619:                 THIS.grd_4c_Dados.Refresh
620:                 THIS.grd_4c_Dados.Column1.SetFocus
621:             ENDIF
622:         ENDIF
623:     ENDPROC
624: 
625:     *==========================================================================
626:     * BtnAlterarClick - Coloca a linha corrente do grid em edicao
627:     * Form OPERACIONAL: nao possui botao Alterar visivel; disponivel para
628:     * scripting/atalho externo que precise reposicionar o cursor no par corrente
629:     * para edicao inline no grid csContas.
630:     *==========================================================================
631:     PROCEDURE BtnAlterarClick()
632:         IF !USED("csContas")
633:             RETURN
634:         ENDIF
635: 
636:         SELECT csContas
637:         IF RECCOUNT() = 0
638:             APPEND BLANK
639:         ELSE
640:             IF EOF()
641:                 GO BOTTOM
642:             ENDIF
643:         ENDIF
644: 
645:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
646:             THIS.grd_4c_Dados.Refresh
647:             THIS.grd_4c_Dados.SetFocus
648:             THIS.grd_4c_Dados.Column1.SetFocus
649:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "Text1", 5)
650:                 THIS.grd_4c_Dados.Column1.Text1.SelStart  = 0
651:                 THIS.grd_4c_Dados.Column1.Text1.SelLength = ;

*-- Linhas 665 a 683:
665:             RETURN
666:         ENDIF
667: 
668:         SELECT csContas
669:         SET ORDER TO
670:         GO TOP
671: 
672:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
673:             THIS.grd_4c_Dados.Refresh
674:             THIS.grd_4c_Dados.SetFocus
675:         ENDIF
676:     ENDPROC
677: 
678:     *==========================================================================
679:     * BtnExportaClick - Importa pares de substituicao de planilha XLS para csContas
680:     *==========================================================================
681:     PROCEDURE BtnExportaClick()
682:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro
683:         loc_cArquivo   = ""

*-- Linhas 761 a 1098:
761:             ENDIF
762: 
763:             *-- Selecionar campos elegiveis: tipo C, tamanho 10 ou 14, nomes especificos de produto
764:             SELECT Arquivos, Campos ;
765:                 FROM ArqDBF ;
766:                 WHERE (Tamanhos = 10 OR Tamanhos = 14) AND ;
767:                     UPPER(Tipos) = "C" AND ;
768:                     ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
769:                     ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
770:                     ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
771:                     ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
772:                     !EMPTY(Dbcs) AND ;
773:                     INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
774:                         "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
775:                         "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
776:                 ORDER BY Arquivos ;
777:                 INTO CURSOR csCampos READWRITE
778:             INDEX ON Arquivos + Campos TAG ArqCpo
779: 
780:             SELECT DISTINCT Arquivos FROM csCampos ;
781:                 INTO CURSOR csArquivos READWRITE ;
782:                 ORDER BY Arquivos
783:             loc_nTtArq = RECCOUNT("csArquivos")
784: 
785:             *-- Obter chaves primarias dos arquivos via SQL Server INFORMATION_SCHEMA
786:             loc_cSql = "SELECT KCU.TABLE_NAME AS Arquivos, MIN(KCU.COLUMN_NAME) AS Indices " + ;
787:                 "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU " + ;
788:                 "JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC " + ;
789:                 "ON KCU.CONSTRAINT_SCHEMA = TC.CONSTRAINT_SCHEMA " + ;
790:                 "AND KCU.CONSTRAINT_NAME = TC.CONSTRAINT_NAME " + ;
791:                 "WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY' " + ;
792:                 "GROUP BY KCU.TABLE_NAME"
793:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ChavePrim") > 0
794:                 SELECT cursor_4c_ChavePrim
795:                 INDEX ON UPPER(ALLTRIM(Arquivos)) TAG Arquivos
796:             ENDIF
797: 
798:             THIS.AlternarPagina(.T.)
799: 
800:             loc_nRec = 0
801:             SELECT csContas
802:             loc_nCnt = RECCOUNT("csContas") * loc_nTtArq
803:             IF loc_nCnt < 1
804:                 loc_nCnt = 1
805:             ENDIF
806: 
807:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
808:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
809: 
810:             SELECT csContas
811:             SCAN
812:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(NVL(csContas.CprosAnt, ""))
813:                 THIS.cnt_4c_Result.Refresh
814: 
815:                 SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
816: 
817:                 SELECT csArquivos
818:                 SCAN
819:                     loc_cArq = UPPER(ALLTRIM(STRTRAN(csArquivos.Arquivos, ".DBF", "")))
820:                     THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
821:                     THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
822: 
823:                     SELECT csCampos
824:                     SET ORDER TO ArqCpo
825:                     SEEK csArquivos.Arquivos
826: 
827:                     SCAN WHILE ALLTRIM(csArquivos.Arquivos) == ALLTRIM(csCampos.Arquivos) ;
828:                             AND !EOF("csCampos")
829:                         loc_cCpo = ALLTRIM(csCampos.Campos)
830:                         THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq + " / " + loc_cCpo
831:                         THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
832: 
833:                         *-- Pular SIGPRPRT
834:                         IF loc_cArq == "SIGPRPRT"
835:                             SELECT csCampos
836:                             LOOP
837:                         ENDIF
838: 
839:                         *-- SIGMVHST: atualizar campo diretamente sem recalculo de saldo
840:                         IF loc_cArq == "SIGMVHST"
841:                             loc_cSql = "UPDATE SigMvHst SET " + loc_cCpo + " = " + ;
842:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
843:                                 " WHERE " + loc_cCpo + " = " + ;
844:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
845:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
846:                             SELECT csCampos
847:                             IF loc_nErro < 1
848:                                 EXIT
849:                             ENDIF
850:                             LOOP
851:                         ENDIF
852: 
853:                         *-- SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT: verificar existencia do novo codigo
854:                         IF INLIST(loc_cArq, "SIGCDPRO","SIGPRCPO","SIGCDPRF","SIGCDPFT")
855:                             IF USED("cursor_4c_TmpPro")
856:                                 USE IN cursor_4c_TmpPro
857:                             ENDIF
858:                             loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
859:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
860:                             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpPro") > 0 AND ;
861:                                USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
862: 
863:                                 IF loc_cArq == "SIGCDPRO" AND loc_cCpo == "CPROS" AND THIS.this_lManterBarra
864:                                     loc_cSql = "UPDATE SigCdPro SET Cbars = " + ;
865:                                         FormatarNumeroSQL(NVL(csContas.BarraAnt, 0), 0) + ;
866:                                         " WHERE Cpros = " + ;
867:                                         EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, "")))
868:                                     loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
869:                                     IF USED("cursor_4c_TmpPro")
870:                                         USE IN cursor_4c_TmpPro
871:                                     ENDIF
872:                                     IF loc_nErro >= 1
873:                                         loc_cSql = "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + ;
874:                                             EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
875:                                         loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
876:                                     ENDIF
877:                                     SELECT csCampos
878:                                     IF loc_nErro < 1
879:                                         EXIT
880:                                     ENDIF
881:                                     LOOP
882:                                 ENDIF
883: 
884:                                 *-- Produto antigo ainda existe? Ambos existem, pular
885:                                 IF USED("cursor_4c_LocalPro")
886:                                     USE IN cursor_4c_LocalPro
887:                                 ENDIF
888:                                 loc_cSql = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
889:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
890:                                 IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalPro") > 0 AND ;
891:                                    USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
892:                                     IF USED("cursor_4c_LocalPro")
893:                                         USE IN cursor_4c_LocalPro
894:                                     ENDIF
895:                                     IF USED("cursor_4c_TmpPro")
896:                                         USE IN cursor_4c_TmpPro
897:                                     ENDIF
898:                                     SELECT csCampos
899:                                     LOOP
900:                                 ENDIF
901:                                 IF USED("cursor_4c_LocalPro")
902:                                     USE IN cursor_4c_LocalPro
903:                                 ENDIF
904:                             ENDIF
905:                             IF USED("cursor_4c_TmpPro")
906:                                 USE IN cursor_4c_TmpPro
907:                             ENDIF
908:                         ENDIF
909: 
910:                         *-- SIGMVEST: DELETE movimentos de estoque sem recalculo
911:                         IF loc_cArq == "SIGMVEST"
912:                             IF USED("cursor_4c_LocalEst")
913:                                 USE IN cursor_4c_LocalEst
914:                             ENDIF
915:                             loc_cSql = "SELECT CidChaves FROM SigMvEst WHERE " + ;
916:                                 loc_cCpo + " = " + ;
917:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
918:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalEst")
919:                             IF loc_nErro >= 1 AND USED("cursor_4c_LocalEst") AND ;
920:                                RECCOUNT("cursor_4c_LocalEst") > 0
921:                                 SELECT cursor_4c_LocalEst
922:                                 SCAN
923:                                     loc_cSql = "DELETE FROM SigMvEst WHERE CidChaves = " + ;
924:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_LocalEst.CidChaves, "")))
925:                                     loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
926:                                     IF loc_nErro < 1
927:                                         EXIT
928:                                     ENDIF
929:                                 ENDSCAN
930:                             ENDIF
931:                             IF USED("cursor_4c_LocalEst")
932:                                 USE IN cursor_4c_LocalEst
933:                             ENDIF
934:                             SELECT csCampos
935:                             IF loc_nErro < 1
936:                                 EXIT
937:                             ENDIF
938:                             LOOP
939:                         ENDIF
940: 
941:                         *-- Caso geral: UPDATE via chave primaria (se disponivel) ou campo direto
942:                         IF USED("cursor_4c_ChavePrim")
943:                             SELECT cursor_4c_ChavePrim
944:                             SET ORDER TO Arquivos
945:                             IF SEEK(UPPER(ALLTRIM(loc_cArq)))
946:                                 loc_cChave = ALLTRIM(cursor_4c_ChavePrim.Indices)
947:                                 IF USED("cursor_4c_LocalArq")
948:                                     USE IN cursor_4c_LocalArq
949:                                 ENDIF
950:                                 loc_cSql = "SELECT " + loc_cChave + " FROM " + loc_cArq + ;
951:                                     " WHERE " + loc_cCpo + " = " + ;
952:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
953:                                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_LocalArq")
954:                                 IF loc_nErro >= 1 AND USED("cursor_4c_LocalArq") AND ;
955:                                    RECCOUNT("cursor_4c_LocalArq") > 0
956:                                     SELECT cursor_4c_LocalArq
957:                                     SCAN
958:                                         loc_cType = TYPE("cursor_4c_LocalArq." + loc_cChave)
959:                                         IF loc_cType = "N"
960:                                             IF UPPER(loc_cArq) == "SIGOPETQ"
961:                                                 loc_cKeyPry = ALLTRIM(STR(&loc_cChave., 14))
962:                                             ELSE
963:                                                 loc_cKeyPry = ALLTRIM(STR(&loc_cChave.))
964:                                             ENDIF
965:                                         ELSE
966:                                             loc_cKeyPry = ALLTRIM(&loc_cChave.)
967:                                         ENDIF
968:                                         IF UPPER(loc_cArq) == "SIGCDPFT"
969:                                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
970:                                                 loc_cCpo + " = " + ;
971:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
972:                                                 ", ProCarTits = " + ;
973:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
974:                                                 "+ccars+ctits WHERE " + ;
975:                                                 loc_cChave + " = " + EscaparSQL(loc_cKeyPry)
976:                                         ELSE
977:                                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
978:                                                 loc_cCpo + " = " + ;
979:                                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
980:                                                 " WHERE " + loc_cChave + " = " + ;
981:                                                 EscaparSQL(loc_cKeyPry)
982:                                         ENDIF
983:                                         loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
984:                                         IF loc_nErro < 1
985:                                             EXIT
986:                                         ENDIF
987:                                     ENDSCAN
988:                                 ENDIF
989:                                 IF USED("cursor_4c_LocalArq")
990:                                     USE IN cursor_4c_LocalArq
991:                                 ENDIF
992:                                 IF loc_nErro < 1
993:                                     SELECT csCampos
994:                                     EXIT
995:                                 ENDIF
996:                             ELSE
997:                                 *-- Arquivo sem PK conhecida: UPDATE direto pelo campo
998:                                 loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
999:                                     loc_cCpo + " = " + ;
1000:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
1001:                                     " WHERE " + loc_cCpo + " = " + ;
1002:                                     EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
1003:                                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1004:                                 IF loc_nErro < 1
1005:                                     SELECT csCampos
1006:                                     EXIT
1007:                                 ENDIF
1008:                             ENDIF
1009:                         ELSE
1010:                             *-- Sem informacao de PK: UPDATE direto pelo campo
1011:                             loc_cSql = "UPDATE " + loc_cArq + " SET " + ;
1012:                                 loc_cCpo + " = " + ;
1013:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosNov, ""))) + ;
1014:                                 " WHERE " + loc_cCpo + " = " + ;
1015:                                 EscaparSQL(ALLTRIM(NVL(csContas.CprosAnt, "")))
1016:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1017:                             IF loc_nErro < 1
1018:                                 SELECT csCampos
1019:                                 EXIT
1020:                             ENDIF
1021:                         ENDIF
1022: 
1023:                         SELECT csCampos
1024:                     ENDSCAN  && csCampos (campos deste arquivo)
1025: 
1026:                     IF loc_nErro < 1
1027:                         SELECT csArquivos
1028:                         EXIT
1029:                     ENDIF
1030: 
1031:                     loc_nRec = loc_nRec + 1
1032:                     loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
1033:                     THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = loc_nPct * 2
1034:                     THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
1035:                         ALLTRIM(STR(loc_nPct)) + " %"
1036:                     THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
1037:                     SELECT csArquivos
1038:                 ENDSCAN  && csArquivos
1039: 
1040:                 IF loc_nErro < 1
1041:                     SQLEXEC(gnConnHandle, "ROLLBACK")
1042:                     SELECT csContas
1043:                     EXIT
1044:                 ENDIF
1045: 
1046:                 *-- Commit deste par de substituicao
1047:                 IF SQLEXEC(gnConnHandle, "COMMIT") < 1
1048:                     MsgErro("Favor reinicializar o processo.", ;
1049:                         "Falha na Conex" + CHR(227) + "o (Commit)")
1050:                     loc_nErro = 0
1051:                     SELECT csContas
1052:                     EXIT
1053:                 ENDIF
1054: 
1055:                 SELECT csContas
1056:                 REPLACE Flag WITH .T.
1057:             ENDSCAN  && csContas
1058: 
1059:             *-- Resultado final
1060:             IF loc_nErro < 1
1061:                 SELECT csContas
1062:                 SET ORDER TO
1063:                 DELETE FOR Flag
1064:                 GO TOP
1065:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1066:                     THIS.grd_4c_Dados.Refresh
1067:                 ENDIF
1068:                 MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", ;
1069:                     "Reprocessar!!!")
1070:             ELSE
1071:                 SELECT csContas
1072:                 SET ORDER TO
1073:                 ZAP
1074:                 APPEND BLANK
1075:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1076:                     THIS.grd_4c_Dados.Refresh
1077:                 ENDIF
1078:                 MsgAviso("Todos Os Produtos Foram Alterados!!!", ;
1079:                     "Processamento Encerrado!!!")
1080:             ENDIF
1081: 
1082:         CATCH TO loc_oErro
1083:             SQLEXEC(gnConnHandle, "ROLLBACK")
1084:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1085:                 "Erro BtnProcessarClick Formsigprmdp")
1086:         ENDTRY
1087: 
1088:         THIS.AlternarPagina(.F.)
1089: 
1090:         IF USED("csCampos")
1091:             USE IN csCampos
1092:         ENDIF
1093:         IF USED("csArquivos")
1094:             USE IN csArquivos
1095:         ENDIF
1096:         IF USED("cursor_4c_ChavePrim")
1097:             USE IN cursor_4c_ChavePrim
1098:         ENDIF

*-- Linhas 1122 a 1155:
1122: 
1123:         TRY
1124:             IF EMPTY(loc_cVal)
1125:                 SELECT csContas
1126:                 REPLACE CprosAnt WITH ""
1127:             ELSE
1128:                 IF USED("cursor_4c_TmpPro")
1129:                     USE IN cursor_4c_TmpPro
1130:                 ENDIF
1131:                 loc_nErro = SQLEXEC(gnConnHandle, ;
1132:                     "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cVal), ;
1133:                     "cursor_4c_TmpPro")
1134: 
1135:                 IF loc_nErro > 0 AND USED("cursor_4c_TmpPro") AND ;
1136:                    RECCOUNT("cursor_4c_TmpPro") > 0
1137:                     SELECT cursor_4c_TmpPro
1138:                     loc_cVal = ALLTRIM(NVL(cursor_4c_TmpPro.Cpros, ""))
1139:                     USE IN cursor_4c_TmpPro
1140:                     SELECT csContas
1141:                     REPLACE CprosAnt WITH loc_cVal
1142:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1143:                 ELSE
1144:                     IF USED("cursor_4c_TmpPro")
1145:                         USE IN cursor_4c_TmpPro
1146:                     ENDIF
1147:                     THIS.AbrirBuscaProduto()
1148:                 ENDIF
1149:             ENDIF
1150: 
1151:         CATCH TO loc_oErro
1152:             IF USED("cursor_4c_TmpPro")
1153:                 USE IN cursor_4c_TmpPro
1154:             ENDIF
1155:             MsgErro(loc_oErro.Message, "Erro ao validar produto")

*-- Linhas 1174 a 1215:
1174:                 loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1175:                 loc_oLookup.Show()
1176:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1177:                     SELECT cursor_4c_BuscaPro
1178:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaPro.CPros, ""))
1179:                     USE IN cursor_4c_BuscaPro
1180:                     SELECT csContas
1181:                     REPLACE CprosAnt WITH loc_cVal
1182:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cVal
1183:                 ELSE
1184:                     IF USED("cursor_4c_BuscaPro")
1185:                         USE IN cursor_4c_BuscaPro
1186:                     ENDIF
1187:                 ENDIF
1188:             ENDIF
1189:         CATCH TO loc_oErro
1190:             IF USED("cursor_4c_BuscaPro")
1191:                 USE IN cursor_4c_BuscaPro
1192:             ENDIF
1193:             MsgErro(loc_oErro.Message, "Erro ao buscar produto")
1194:         ENDTRY
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * CarregarLista - (Re)inicializa o cursor csContas exibido no grd_4c_Dados
1199:     * Form OPERACIONAL: nao ha SELECT de Grid CRUD; carga = InicializarCursorContas
1200:     * do BO (CREATE CURSOR csContas + INDEX + APPEND BLANK).
1201:     *==========================================================================
1202:     PROCEDURE CarregarLista()
1203:         LOCAL loc_lSucesso, loc_oErro
1204:         loc_lSucesso = .F.
1205: 
1206:         TRY
1207:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1208:                 loc_lSucesso = THIS.this_oBusinessObject.InicializarCursorContas()
1209:             ENDIF
1210: 
1211:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1212:                 IF USED("csContas")
1213:                     THIS.grd_4c_Dados.RecordSource = "csContas"
1214:                 ENDIF
1215:                 THIS.grd_4c_Dados.Refresh

*-- Linhas 1287 a 1305:
1287:     *==========================================================================
1288:     PROCEDURE LimparCampos()
1289:         IF USED("csContas")
1290:             SELECT csContas
1291:             SET ORDER TO
1292:             ZAP
1293:             APPEND BLANK
1294:         ENDIF
1295: 
1296:         IF PEMSTATUS(THIS, "cnt_4c_Result", 5)
1297:             THIS.cnt_4c_Result.txt_4c_Cpros.Value   = ""
1298:             THIS.cnt_4c_Result.txt_4c_Arquivo.Value = ""
1299:             IF PEMSTATUS(THIS.cnt_4c_Result, "cnt_4c_Barra", 5)
1300:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
1301:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
1302:             ENDIF
1303:             THIS.cnt_4c_Result.Visible = .F.
1304:         ENDIF
1305: 

*-- Linhas 1357 a 1375:
1357:         loc_lTemDados = .F.
1358: 
1359:         IF USED("csContas")
1360:             SELECT csContas
1361:             LOCATE FOR !EMPTY(ALLTRIM(NVL(csContas.CprosAnt, ""))) OR ;
1362:                 !EMPTY(ALLTRIM(NVL(csContas.CprosNov, "")))
1363:             loc_lTemDados = FOUND()
1364:         ENDIF
1365: 
1366:         IF loc_lTemDados
1367:             IF !MsgConfirma("Descartar os pares informados?", ;
1368:                     "Cancelar Substitui" + CHR(231) + CHR(227) + "o")
1369:                 RETURN
1370:             ENDIF
1371:         ENDIF
1372: 
1373:         THIS.LimparCampos()
1374:     ENDPROC
1375: 


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

