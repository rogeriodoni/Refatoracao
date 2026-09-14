# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CUNIS, FATORS, QTDS2, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CUNIS, FATORS, QTDS2, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CUNIS, FATORS, QTDS2, VALUE

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = "xnensi.cdescs"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select xNensi
Select xMFas
	Select xNensi
	Insert Into TmpDistrib (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
Select TmpDistrib
Select xNensi
Select TmpDistrib
	.Column6.ControlSource   = 'TmpDistrib.Nenvs'  					 && Envelope
	.Column1.ControlSource   = 'TmpDistrib.NOps'  					 && Ordem de Produção
	.Column2.ControlSource   = 'TmpDistrib.CodPds'  				 && Componente
	.Column5.ControlSource   = 'TmpDistrib.Qtds2'					 && Tipo de Material
	.Column4.ControlSource   = 'TmpDistrib.CUnis'					 && Unidade
	.Column7.ControlSource   = 'TmpDistrib.Pesos'					 && Peso na Fase Anterior
	.Column3.ControlSource   = 'TmpDistrib.cUniPs' 					 && Unidade do Peso
	.Column8.ControlSource   = 'TmpDistrib.Pesos2'					 && Peso Atual ( Balança )
	.Column9.ControlSource   = 'TmpDistrib.CodCors'					 && Cor
	.Column10.ControlSource   = 'TmpDistrib.CodTams'				 && Tamanho
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+xnensi.cunis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
			Select TmpDistrib
				Select TmpDistrib
					Select TmpDistrib
		Select TmpDistrib
			Select TmpDistrib
			Select TmpDistrib
Select xNensi
Select TmpDistrib
	Select xNensi
	If Not Seek(Str(TmpDistrib.Nops, 10) + TmpDistrib.CMats) && Tiago - 17/03/2016 - Não tem NLOTES no índice, com isso estava lançando varias vezes item agregado + Str(TmpDistrib.Nlotes, 10))
		Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, TpOps, ;
Select xNensi
Select xNensi
Select xNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM14.prg) - TRECHOS RELEVANTES PARA PASS SQL (1456 linhas total):

*-- Linhas 470 a 488:
470:     *--------------------------------------------------------------------------
471:     * ConfigurarDescricao - label + campo descricao do componente na parte inferior
472:     * Origem: Say2 (Left=151, Top=565) + Get_descr (Left=223, Top=567, Width=353)
473:     * ControlSource original: xnensi.cdescs (acessivel via datasession do pai)
474:     *--------------------------------------------------------------------------
475:     PROTECTED PROCEDURE ConfigurarDescricao()
476:         *-- Label "Descricao :"
477:         THIS.AddObject("lbl_4c_LblDescricao", "Label")
478:         WITH THIS.lbl_4c_LblDescricao
479:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
480:             .Left      = 151
481:             .Top       = 565
482:             .BackStyle = 0
483:             .ForeColor = RGB(231,254,253)
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .Visible   = .T.
487:         ENDWITH
488: 

*-- Linhas 510 a 528:
510:     PROTECTED PROCEDURE PreencherContainerOperacao()
511:         TRY
512:             IF USED("tmpnens") AND !EOF("tmpnens")
513:                 SELECT tmpnens
514:                 GO TOP
515:                 THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = TratarNulo(tmpnens.emps,  "C")
516:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = TratarNulo(tmpnens.dopps, "C")
517:                 THIS.cnt_4c_Operacao.txt_4c_Codigo.Value   = TratarNulo(tmpnens.numps, "N")
518:             ENDIF
519:         CATCH TO loc_oErro
520:             MsgErro(loc_oErro.Message, "Erro")
521:         ENDTRY
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * PreencherContainerMaterial - preenche campos do material com dados do BO
526:     * Dados carregados de xNensi via CarregarDoCursor no InicializarForm
527:     * Get_Pesof exibe Pesos (peso da fase) identico ao GetPeso (legado)
528:     *--------------------------------------------------------------------------

*-- Linhas 605 a 814:
605:             .HighlightBackColor = RGB(255,255,255)
606:             .HighlightForeColor = RGB(15,41,104)
607:             .HighlightStyle     = 2
608:             .DeleteMark         = .F.
609:             .RecordMark         = .F.
610:             .RowHeight          = 16
611:             .ScrollBars         = 2
612:             .Panel              = 1
613:             .ColumnCount        = 10
614: 
615:             *-- RecordSource primeiro para evitar reset de headers depois
616:             .RecordSource = "TmpDistrib"
617: 
618:             *-- Column1: NOps / Industrializacao (ColumnOrder=2, ReadOnly)
619:             WITH .Column1
620:                 .ColumnOrder       = 2
621:                 .Width             = 90
622:                 .Movable           = .F.
623:                 .Resizable         = .F.
624:                 .ReadOnly          = .T.
625:                 .Format            = "L"
626:                 .InputMask         = "9999999999"
627:                 .ControlSource     = "TmpDistrib.Nops"
628:                 .Header1.Caption   = loc_cTitulo
629:                 .Header1.Alignment = 2
630:                 .Header1.FontName  = "Tahoma"
631:                 .Header1.FontSize  = 8
632:                 .Text1.FontName    = "Courier New"
633:                 .Text1.BorderStyle = 0
634:                 .Text1.Margin      = 0
635:                 .Text1.ReadOnly    = .T.
636:                 .Text1.ForeColor   = RGB(0,0,0)
637:                 .Text1.BackColor   = RGB(255,255,255)
638:             ENDWITH
639: 
640:             *-- Column2: Pesos / Qtde Agregar (ColumnOrder=8, editavel condicional)
641:             WITH .Column2
642:                 .ColumnOrder       = 8
643:                 .Width             = 83
644:                 .Movable           = .F.
645:                 .Resizable         = .F.
646:                 .ReadOnly          = .F.
647:                 .ControlSource     = "TmpDistrib.Pesos"
648:                 .Header1.Caption   = "Qtde Agregar"
649:                 .Header1.Alignment = 2
650:                 .Header1.FontName  = "Tahoma"
651:                 .Header1.FontSize  = 8
652:                 .Text1.BorderStyle = 0
653:                 .Text1.Margin      = 0
654:                 .Text1.ForeColor   = RGB(0,0,0)
655:                 .Text1.BackColor   = RGB(255,255,255)
656:             ENDWITH
657: 
658:             *-- Column3: CUnis / Unid. (ColumnOrder=7, ReadOnly)
659:             WITH .Column3
660:                 .ColumnOrder       = 7
661:                 .Width             = 31
662:                 .Movable           = .F.
663:                 .Resizable         = .F.
664:                 .ReadOnly          = .T.
665:                 .ControlSource     = "TmpDistrib.CUnis"
666:                 .Header1.Caption   = "Unid."
667:                 .Header1.Alignment = 2
668:                 .Header1.FontName  = "Tahoma"
669:                 .Header1.FontSize  = 8
670:                 .Text1.BorderStyle = 0
671:                 .Text1.Margin      = 0
672:                 .Text1.ReadOnly    = .T.
673:                 .Text1.ForeColor   = RGB(0,0,0)
674:                 .Text1.BackColor   = RGB(255,255,255)
675:             ENDWITH
676: 
677:             *-- Column4: Pesos2 / Peso Fabr Agregar (ColumnOrder=10, editavel condicional)
678:             WITH .Column4
679:                 .ColumnOrder       = 10
680:                 .Width             = 95
681:                 .Movable           = .F.
682:                 .Resizable         = .F.
683:                 .ReadOnly          = .F.
684:                 .ControlSource     = "TmpDistrib.Pesos2"
685:                 .Header1.Caption   = "Peso Fabr Agregar"
686:                 .Header1.Alignment = 2
687:                 .Header1.FontName  = "Tahoma"
688:                 .Header1.FontSize  = 8
689:                 .Text1.BorderStyle = 0
690:                 .Text1.Margin      = 0
691:                 .Text1.ForeColor   = RGB(0,0,0)
692:                 .Text1.BackColor   = RGB(255,255,255)
693:             ENDWITH
694: 
695:             *-- Column5: cUniPs / Unid. (ColumnOrder=9, ReadOnly)
696:             WITH .Column5
697:                 .ColumnOrder       = 9
698:                 .Width             = 31
699:                 .Movable           = .F.
700:                 .Resizable         = .F.
701:                 .ReadOnly          = .T.
702:                 .ControlSource     = "TmpDistrib.cUniPs"
703:                 .Header1.Caption   = "Unid."
704:                 .Header1.Alignment = 2
705:                 .Header1.FontName  = "Tahoma"
706:                 .Header1.FontSize  = 8
707:                 .Text1.BorderStyle = 0
708:                 .Text1.Margin      = 0
709:                 .Text1.ReadOnly    = .T.
710:                 .Text1.ForeColor   = RGB(0,0,0)
711:                 .Text1.BackColor   = RGB(255,255,255)
712:             ENDWITH
713: 
714:             *-- Column6: Qtds2 / Qtde Agregar (ColumnOrder=6, editavel em INSERIR/ALTERAR)
715:             WITH .Column6
716:                 .ColumnOrder       = 6
717:                 .Width             = 80
718:                 .Movable           = .F.
719:                 .Resizable         = .F.
720:                 .ReadOnly          = .F.
721:                 .InputMask         = loc_cMask
722:                 .ControlSource     = "TmpDistrib.Qtds2"
723:                 .Header1.Caption   = "Qtde Agregar"
724:                 .Header1.Alignment = 2
725:                 .Header1.FontName  = "Tahoma"
726:                 .Header1.FontSize  = 8
727:                 .Text1.BorderStyle = 0
728:                 .Text1.Margin      = 0
729:                 .Text1.InputMask   = loc_cMask
730:                 .Text1.ForeColor   = RGB(0,0,0)
731:                 .Text1.BackColor   = RGB(255,255,255)
732:             ENDWITH
733: 
734:             *-- Column7: Nenvs / Envelope (ColumnOrder=1, ReadOnly)
735:             WITH .Column7
736:                 .ColumnOrder       = 1
737:                 .Width             = 80
738:                 .Movable           = .F.
739:                 .Resizable         = .F.
740:                 .ReadOnly          = .T.
741:                 .ControlSource     = "TmpDistrib.Nenvs"
742:                 .Header1.Caption   = "Envelope"
743:                 .Header1.Alignment = 2
744:                 .Header1.FontName  = "Tahoma"
745:                 .Header1.FontSize  = 8
746:                 .Text1.BorderStyle = 0
747:                 .Text1.Margin      = 0
748:                 .Text1.ReadOnly    = .T.
749:                 .Text1.ForeColor   = RGB(0,0,0)
750:                 .Text1.BackColor   = RGB(255,255,255)
751:             ENDWITH
752: 
753:             *-- Column8: CodPds / Produto (ColumnOrder=3, ReadOnly)
754:             WITH .Column8
755:                 .ColumnOrder       = 3
756:                 .Width             = 108
757:                 .Movable           = .F.
758:                 .Resizable         = .F.
759:                 .ReadOnly          = .T.
760:                 .ControlSource     = "TmpDistrib.CodPds"
761:                 .Header1.Caption   = "Produto"
762:                 .Header1.Alignment = 2
763:                 .Header1.FontName  = "Tahoma"
764:                 .Header1.FontSize  = 8
765:                 .Text1.FontSize    = 8
766:                 .Text1.BorderStyle = 0
767:                 .Text1.Margin      = 0
768:                 .Text1.ReadOnly    = .T.
769:                 .Text1.ForeColor   = RGB(0,0,0)
770:                 .Text1.BackColor   = RGB(255,255,255)
771:             ENDWITH
772: 
773:             *-- Column9: CodCors / Cor (ColumnOrder=4, ReadOnly)
774:             WITH .Column9
775:                 .ColumnOrder       = 4
776:                 .Width             = 38
777:                 .Movable           = .F.
778:                 .Resizable         = .F.
779:                 .ReadOnly          = .T.
780:                 .ControlSource     = "TmpDistrib.CodCors"
781:                 .Header1.Caption   = "Cor"
782:                 .Header1.Alignment = 2
783:                 .Header1.FontName  = "Tahoma"
784:                 .Header1.FontSize  = 8
785:                 .Text1.BorderStyle = 0
786:                 .Text1.Margin      = 0
787:                 .Text1.ReadOnly    = .T.
788:                 .Text1.ForeColor   = RGB(0,0,0)
789:                 .Text1.BackColor   = RGB(255,255,255)
790:             ENDWITH
791: 
792:             *-- Column10: CodTams / Tam (ColumnOrder=5, ReadOnly)
793:             WITH .Column10
794:                 .ColumnOrder       = 5
795:                 .Width             = 38
796:                 .Movable           = .F.
797:                 .Resizable         = .F.
798:                 .ReadOnly          = .T.
799:                 .ControlSource     = "TmpDistrib.CodTams"
800:                 .Header1.Caption   = "Tam"
801:                 .Header1.Alignment = 2
802:                 .Header1.FontName  = "Tahoma"
803:                 .Header1.FontSize  = 8
804:                 .Text1.BorderStyle = 0
805:                 .Text1.Margin      = 0
806:                 .Text1.ReadOnly    = .T.
807:                 .Text1.ForeColor   = RGB(0,0,0)
808:                 .Text1.BackColor   = RGB(255,255,255)
809:             ENDWITH
810: 
811:             .Refresh()
812:             .Visible = .T.
813:         ENDWITH
814: 

*-- Linhas 984 a 1016:
984:                    INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND ;
985:                    !EMPTY(xNensi.CMats)
986: 
987:                     loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
988:                                EscaparSQL(ALLTRIM(xNensi.CMats))
989:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
990:                        USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
991: 
992:                         loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
993:                                    EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
994:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
995:                            USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
996: 
997:                             IF !((CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
998:                                 (LocalUni.QtEqualPs = "S"))
999:                                 IF (CrTmpGru.TpMovs <> 1 AND LocalUni2.Fators <> 1) OR ;
1000:                                    (LocalUni2.QtEqualPs = "S")
1001:                                     SELECT TmpDistrib
1002:                                     REPLACE Pesos2 WITH (TmpDistrib.Pesos * LocalUni2.Fators)
1003:                                 ENDIF
1004:                             ENDIF
1005:                         ENDIF
1006:                     ENDIF
1007:                 ENDIF
1008:             ENDIF
1009: 
1010:             IF USED("CrTmpPro")
1011:                 USE IN CrTmpPro
1012:             ENDIF
1013:             IF USED("CrTmpGru")
1014:                 USE IN CrTmpGru
1015:             ENDIF
1016:         CATCH TO loc_oErro

*-- Linhas 1065 a 1102:
1065:                         THIS.grd_4c_Dados.Column4.Text1.Value = 0
1066:                         loc_lOK = .F.
1067:                     ELSE
1068:                         loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
1069:                                    EscaparSQL(ALLTRIM(TmpDistrib.CMats))
1070:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
1071:                            USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
1072: 
1073:                             loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
1074:                                        EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
1075:                             IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
1076:                                USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
1077: 
1078:                                 IF (CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
1079:                                    (LocalUni.QtEqualPs = "S")
1080:                                     SELECT TmpDistrib
1081:                                     REPLACE Qtds2 WITH (TmpDistrib.Pesos2 / LocalUni.Fators)
1082:                                 ELSE
1083:                                     IF USED("LocalUni2") AND !EOF("LocalUni2")
1084:                                         IF LocalUni.cEstos = "3" AND !EMPTY(xNensi.cUniPs) AND ;
1085:                                            ((CrTmpGru.TpMovs <> 1 AND LocalUni2.Fators <> 1) OR ;
1086:                                             (LocalUni2.QtEqualPs = "S"))
1087:                                             SELECT TmpDistrib
1088:                                             REPLACE Pesos WITH (TmpDistrib.Pesos2 / LocalUni2.Fators)
1089:                                         ENDIF
1090:                                     ENDIF
1091:                                 ENDIF
1092:                             ENDIF
1093:                         ENDIF
1094:                     ENDIF
1095:                 ENDIF
1096:             ENDIF
1097: 
1098:             IF USED("CrTmpPro")
1099:                 USE IN CrTmpPro
1100:             ENDIF
1101:             IF USED("CrTmpGru")
1102:                 USE IN CrTmpGru

*-- Linhas 1114 a 1132:
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE GradeCol4LostFocusHandler()
1116:         IF USED("TmpDistrib")
1117:             SELECT TmpDistrib
1118:             SKIP
1119:             IF !EOF()
1120:                 SKIP -1
1121:                 THIS.grd_4c_Dados.Column6.SetFocus()
1122:                 KEYBOARD '{DNARROW}'
1123:             ELSE
1124:                 SKIP -1
1125:             ENDIF
1126:         ENDIF
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * GradeCol6WhenHandler - Column6 (Qtds2): salva valor anterior e consulta
1131:     *   LocalUni para uso no Valid
1132:     * Origem: Grade.Column5.Text1.When

*-- Linhas 1158 a 1188:
1158:                             THIS.grd_4c_Dados.Column6.Text1.Value = 0
1159:                             loc_lOK = .F.
1160:                         ELSE
1161:                             loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE CPros = " + ;
1162:                                        EscaparSQL(ALLTRIM(TmpDistrib.CMats))
1163:                             IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpPro") > 0 AND ;
1164:                                USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
1165: 
1166:                                 loc_cSQL = "SELECT TpMovs FROM SigCdGrp WHERE CGrus = " + ;
1167:                                            EscaparSQL(ALLTRIM(CrTmpPro.Cgrus))
1168:                                 IF SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpGru") > 0 AND ;
1169:                                    USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
1170: 
1171:                                     IF (CrTmpGru.TpMovs <> 1 AND LocalUni.Fators <> 1) OR ;
1172:                                        (LocalUni.QtEqualPs = "S")
1173:                                         SELECT TmpDistrib
1174:                                         REPLACE Pesos2 WITH (TmpDistrib.Qtds2 * LocalUni.Fators)
1175:                                     ENDIF
1176:                                 ENDIF
1177:                             ENDIF
1178:                         ENDIF
1179:                     ENDIF
1180:                 ENDIF
1181:             ENDIF
1182: 
1183:             IF USED("CrTmpPro")
1184:                 USE IN CrTmpPro
1185:             ENDIF
1186:             IF USED("CrTmpGru")
1187:                 USE IN CrTmpGru
1188:             ENDIF

*-- Linhas 1369 a 1387:
1369:         LOCAL loc_oErro
1370:         TRY
1371:             IF VARTYPE(THIS.grd_4c_Dados) = "O" AND USED("TmpDistrib")
1372:                 SELECT TmpDistrib
1373:                 THIS.grd_4c_Dados.Refresh()
1374:                 THIS.this_oBusinessObject.this_nTPeso  = 0
1375:                 THIS.this_oBusinessObject.this_nTQtde  = 0
1376:                 THIS.this_oBusinessObject.this_nTPeso2 = 0
1377:                 SCAN
1378:                     THIS.this_oBusinessObject.this_nTPeso  = ;
1379:                         THIS.this_oBusinessObject.this_nTPeso  + TmpDistrib.Pesos2
1380:                     THIS.this_oBusinessObject.this_nTQtde  = ;
1381:                         THIS.this_oBusinessObject.this_nTQtde  + TmpDistrib.Qtds2
1382:                     THIS.this_oBusinessObject.this_nTPeso2 = ;
1383:                         THIS.this_oBusinessObject.this_nTPeso2 + TmpDistrib.Pesos
1384:                 ENDSCAN
1385:             ENDIF
1386:         CATCH TO loc_oErro
1387:             MsgErro(loc_oErro.Message, "Erro FormParaBO")

*-- Linhas 1417 a 1435:
1417:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("TmpDistrib")
1418:                 THIS.this_oBusinessObject.CalcularDistribuicao()
1419:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
1420:                     SELECT TmpDistrib
1421:                     GO TOP
1422:                     THIS.grd_4c_Dados.Refresh()
1423:                 ENDIF
1424:                 THIS.PreencherContainerMaterial()
1425:             ENDIF
1426:         CATCH TO loc_oErro
1427:             MsgErro(loc_oErro.Message, "Erro BtnBuscar")
1428:         ENDTRY
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     * BtnEncerrarClick - Encerra o dialogo sem confirmar (alias de Cancelar)
1433:     *--------------------------------------------------------------------------
1434:     PROCEDURE BtnEncerrarClick()
1435:         THIS.BtnCancelarClick()


### BO (C:\4c\projeto\app\classes\SigPdM14BO.prg):
*==============================================================================
* SigPdM14BO.prg - Business Object para Rateio de Componentes (SIGPDM14)
* Herda de BusinessBase
* Form OPERACIONAL modal: opera sobre cursores VFP locais (xNensi, xMFas, TmpDistrib)
*==============================================================================

DEFINE CLASS SigPdM14BO AS BusinessBase

    *-- Identificacao (sem tabela SQL - opera sobre cursores locais)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Dados do item principal (lidos de xNensi pelo form pai)
    this_cMats        = ""    && CMats  - Codigo do material componente
    this_nPesos       = 0     && Pesos  - Peso original da NE
    this_nQtds        = 0     && Qtds   - Quantidade original da NE
    this_cGrus        = ""    && CGrus  - Codigo do grupo do material
    this_cUnis        = ""    && CUnis  - Unidade de medida (qtde)
    this_cDescs       = ""    && CDescs - Descricao do material
    this_cTpOps       = ""    && TpOps  - Tipo de operacao
    this_nLotes       = 0     && nLotes - Numero do lote
    this_nNenvs       = 0     && Nenvs  - Numero do envelope (filtro de fases)
    this_nPeso2s      = 0     && Peso2s - Peso na fase anterior
    this_cCodCors     = ""    && CodCors - Codigo da cor
    this_cCodTams     = ""    && CodTams - Codigo do tamanho
    this_cUniPs       = ""    && cUniPs  - Unidade de medida do peso

    *-- Estado de navegacao/edicao (preservado durante o ciclo do form)
    this_nRecnoAnt    = 0     && Recno original de xNensi para restaurar ao fechar
    this_cOrder       = ""    && Ordem original de xNensi (Order()) para restaurar
    this_nAntValue    = 0     && Valor anterior de Qtds2 (Column5.Text1.When)
    this_nAntValueP   = 0     && Valor anterior de Pesos2 (Column8.Text1.When)
    this_cPcEscolha   = ""    && Modo de operacao do form pai: INSERIR ou ALTERAR
    this_nCas         = 0     && Casas decimais para mascara de quantidade (CasQtds)

    *-- Totais acumulados durante ok.Click (Confirmar)
    this_nTPeso       = 0     && Soma de Pesos2 de todos os itens confirmados
    this_nTQtde       = 0     && Soma de Qtds2 de todos os itens confirmados
    this_nTPeso2      = 0     && Soma de Pesos de todos os itens confirmados
    this_nXAmarra     = 0     && Identificador de amarracao (CtrlAgrega do form pai)

    *--------------------------------------------------------------------------
    * Init - Configura identificacao do BO (sem tabela SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le dados do cursor xNensi para propriedades do BO
    * Mapeia TODAS as colunas usadas pelo form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cMats    = TratarNulo(CMats,   "C")
                THIS.this_nPesos   = TratarNulo(Pesos,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cGrus    = TratarNulo(CGrus,   "C")
                THIS.this_cUnis    = TratarNulo(CUnis,   "C")
                THIS.this_cDescs   = TratarNulo(CDescs,  "C")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                THIS.this_nLotes   = TratarNulo(nLotes,  "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nPeso2s  = TratarNulo(Peso2s,  "N")
                THIS.this_cCodCors = TratarNulo(CodCors, "C")
                THIS.this_cCodTams = TratarNulo(CodTams, "C")
                THIS.this_cUniPs   = TratarNulo(cUniPs,  "C")
                THIS.this_nRecnoAnt = RECNO()
                THIS.this_cOrder    = ORDER()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria TmpDistrib e preenche com dados de xMFas
    * par_nNenv = filtro de envelope (0 = todos)
    * Requer this_c*/this_n* carregados via CarregarDoCursor antes
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores(par_nNenv)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib (Nops N(10) NULL, Nenvs N(10) NULL, CodPds C(14) NULL, ;
                CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, ;
                Qtds2 N(10,3) NULL, Pesos2 N(10,3) NULL, CDescs C(40) NULL, CGrus C(3) NULL, ;
                TpOps C(15) NULL, nLotes N(10) NULL, Peso2s N(10,3) NULL, cUniPs C(3) NULL, ;
                CodCors C(4) NULL, codTams C(4) NULL)
            SET NULL OFF

            SELECT xMFas
            SCAN
                IF par_nNenv <> 0
                    IF par_nNenv <> xMFas.Nenvs
                        LOOP
                    ENDIF
                ENDIF

                INSERT INTO TmpDistrib ;
                    (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, ;
                     CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
                VALUES ;
                    (xMFas.Nops, xMFas.Nenvs, xMFas.CodPds, 0, 0, ;
                     THIS.this_cUnis, THIS.this_cMats, THIS.this_cDescs, ;
                     THIS.this_cGrus, THIS.this_cTpOps, THIS.this_nLotes, ;
                     THIS.this_cUniPs, THIS.this_cCodCors, THIS.this_cCodTams)
            ENDSCAN

            THIS.CalcularDistribuicao()

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularDistribuicao - Distribui Pesos2/Qtds2 proporcionalmente
    * Requer TmpDistrib existente e this_nPesos/this_nQtds/this_nLotes carregados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularDistribuicao()
        LOCAL loc_lSucesso, loc_nQt, loc_nPs, loc_nPes2, loc_nQtd2
        loc_lSucesso = .F.
        TRY
            SELECT TmpDistrib
            GO TOP

            IF (THIS.this_nPesos > 0) AND (THIS.this_nLotes > 0)
                SUM Qtds, Pesos TO loc_nQt, loc_nPs
                GO TOP
                SCAN
                    REPLACE Pesos2 WITH ROUND(Pesos / IIF(loc_nPs = 0, 1, loc_nPs) * THIS.this_nPesos, 2), ;
                            Qtds2  WITH ROUND(Qtds  / IIF(loc_nQt = 0, 1, loc_nQt) * THIS.this_nQtds,  2)
                ENDSCAN

                SUM Pesos2, Qtds2 TO loc_nPes2, loc_nQtd2
                IF (THIS.this_nPesos <> loc_nPes2) OR (THIS.this_nQtds <> loc_nQtd2)
                    GO BOTTOM
                    REPLACE Pesos2 WITH Pesos2 + (THIS.this_nPesos - loc_nPes2), ;
                            Qtds2  WITH Qtds2  + (THIS.this_nQtds  - loc_nQtd2)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUnidadeSQL - Consulta SigCdUni via SQL Server
    * par_cCUnis   = codigo da unidade a buscar
    * par_cAlias   = nome do cursor destino (ex: "LocalUni", "LocalUni2")
    * par_cCampos  = campos a retornar (ex: "Fators,QtEqualPs,cestos")
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUnidadeSQL(par_cCUnis, par_cAlias, par_cCampos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSelect
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAlias)
                loc_lSucesso = .F.
            ENDIF

            IF USED(par_cAlias)
                TABLEREVERT(.T., par_cAlias)
                USE IN (par_cAlias)
            ENDIF

            loc_cSelect = IIF(EMPTY(par_cCampos), "CUnis, Fators, QtEqualPs, cEstos", par_cCampos)
            loc_cSQL = "SELECT " + loc_cSelect + ;
                       " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

            SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

            IF USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
                SELECT (par_cAlias)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEstoquePeso - Verifica se estoque suporta quantidade adicional
    * Equivalente ao fVerEstP do framework legado
    * par_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds (diferenca a verificar)
    * Retorna .T. se pode prosseguir
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEstoquePeso(par_nQuant)
        LOCAL loc_lOK, loc_cSQL, loc_nSaldo
        loc_lOK = .T.
        TRY
            IF par_nQuant > 0 AND !EMPTY(THIS.this_cMats)
                IF USED("TmpDistrib") AND !EOF("TmpDistrib")
                    *-- Verifica saldo em processo: compara quantidade a adicionar com
                    *-- disponivel no lote (Pesos do item de NE como referencia de saldo)
                    IF THIS.this_nPesos > 0
                        loc_nSaldo = THIS.this_nPesos
                        IF par_nQuant > loc_nSaldo
                            loc_lOK = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCasasDecimais - Retorna casas decimais da operacao para mascara
    * Lido de CrSigCdOpd.CasQtds
    *--------------------------------------------------------------------------
    PROCEDURE ObterCasasDecimais()
        LOCAL loc_nCas
        loc_nCas = 3
        TRY
            IF USED("CrSigCdOpd") AND !EOF("CrSigCdOpd")
                loc_nCas = IIF(CrSigCdOpd.CasQtds = 0, 3, CrSigCdOpd.CasQtds)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCas
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarRateio - Itera TmpDistrib e insere/atualiza xNensi
    * Logica do ok.Click do form legado
    * par_nCtrlAgrega = identificador de amarracao fornecido pelo form pai
    * Zera e recalcula this_nTPeso, this_nTQtde, this_nTPeso2
    * Retorna .T. se confirmado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarRateio(par_nCtrlAgrega)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_nTPeso   = 0
            THIS.this_nTQtde   = 0
            THIS.this_nTPeso2  = 0
            THIS.this_nXAmarra = par_nCtrlAgrega

            SELECT xNensi
            GO (THIS.this_nRecnoAnt)

            SELECT TmpDistrib
            SCAN
                SELECT xNensi
                SET ORDER TO NopCMatnV
                IF !SEEK(STR(TmpDistrib.Nops, 10) + TmpDistrib.CMats)
                    INSERT INTO xNensi ;
                        (CMats, CUnis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                         Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs) ;
                    VALUES ;
                        (TmpDistrib.CMats, TmpDistrib.CUnis, TmpDistrib.CDescs, ;
                         TmpDistrib.CGrus, TmpDistrib.Nops, 3, .T., TmpDistrib.Nenvs, ;
                         TmpDistrib.Qtds2, TmpDistrib.Pesos2, TmpDistrib.TpOps, ;
                         TmpDistrib.nLotes, TmpDistrib.Pesos, ;
                         TmpDistrib.CodCors, TmpDistrib.CodTams, TmpDistrib.cUniPs)
                ENDIF

                REPLACE Qtds   WITH TmpDistrib.Qtds2, ;
                        Peso2s WITH TmpDistrib.Pesos, ;
                        Pesos  WITH TmpDistrib.Pesos2

                REPLACE QtFaseAnt  WITH TmpDistrib.Qtds2, ;
                        Amarracao  WITH THIS.this_nXAmarra IN xNensi

                IF TmpDistrib.Pesos2 <> 0
                    REPLACE PsFaseAnt WITH TmpDistrib.Pesos2
                ENDIF
                IF TmpDistrib.Pesos <> 0
                    REPLACE Ps2FaseAnt WITH TmpDistrib.Pesos
                ENDIF

                THIS.this_nTPeso  = THIS.this_nTPeso  + TmpDistrib.Pesos2
                THIS.this_nTQtde  = THIS.this_nTQtde  + TmpDistrib.Qtds2
                THIS.this_nTPeso2 = THIS.this_nTPeso2 + TmpDistrib.Pesos
            ENDSCAN

            SELECT xNensi
            SET ORDER TO Editar
            GO (THIS.this_nRecnoAnt)
            REPLACE Qtds      WITH THIS.this_nTQtde, ;
                    Pesos     WITH THIS.this_nTPeso, ;
                    Peso2s    WITH THIS.this_nTPeso2, ;
                    Rateio    WITH 1, ;
                    Amarracao WITH THIS.this_nXAmarra IN xNensi

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarRateio - Restaura estado do cursor xNensi ao cancelar
    * Equivalente ao Cancelar.Click do form legado
    *--------------------------------------------------------------------------
    PROCEDURE CancelarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO (THIS.this_nRecnoAnt)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste novo rateio em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: nao ha tabela SQL propria; opera sobre cursor xNensi.
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza rateio existente em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: ConfirmarRateio decide INSERT vs UPDATE conforme SEEK
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem auditoria em form OPERACIONAL (sem tabela SQL)
    * par_cOperacao = "INSERIR" ou "ATUALIZAR" (recebido de Inserir/Atualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

