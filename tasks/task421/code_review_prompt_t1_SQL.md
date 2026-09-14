# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IFORS, I, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IFORS, I, VALUE

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
		lcSql = [Select Dpros From SigCdPro Where Cpros = ']+pcPro+[']
		.PodataMgr.Sqlexecute(lcSql,'LocalPro')
		lcSql = [Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ']+pcPro+[']
		.Podatamgr.Sqlexecute(lcSql,'CrSigPrFnc')
Update crSigPrFnc Set DtValid = Nvl(DtValid, Ctot([]))
Select crSigPrFnc
	.Column1.ControlSource = [crSigPrFnc.iFors]
	.Column2.ControlSource = [crSigPrFnc.rClis]
	.Column3.ControlSource = [crSigPrFnc.Reffs]
	.Column4.ControlSource = [crSigPrFnc.Moevs]
	.Column5.ControlSource = [crSigPrFnc.PVens]
	.Column6.ControlSource = [crSigPrFnc.dtValid]
	.Column7.ControlSource = [crSigPrFnc.Situas]
	.Column8.ControlSource = [crSigPrFnc.Colecoes]
	.Column9.ControlSource = [crSigPrFnc.CodCors]
	.Column10.ControlSource= [crSigPrFnc.CodTams]
Select crSigPrFnc
	Delete
		Select crSigPrFnc
			Select a.IFors ;
			  From crSigPrFnc a ;
			Select crAux
Select crSigPrFnc
	Insert Into crSigPrFnc (cPros, CidChaves) Values (crSigCdPro.cPros,fUniqueIds())
Select crSigPrFnc
	Select crSigPrFnc
		Select crSigPrFnc
		Select crSigPrFnc
Select crSigPrFnc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1522 linhas total):

*-- Linhas 86 a 107:
86: 
87:                 *-- Obter descricao do produto para o caption
88:                 IF !EMPTY(THIS.this_cCpros)
89:                     loc_cSQL = "SELECT ISNULL(Dpros, '') AS Dpros " + ;
90:                                "FROM SigCdPro " + ;
91:                                "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
92:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crFopProdDesc")
93:                     IF loc_nRet > 0 AND !EOF("crFopProdDesc")
94:                         THIS.this_cDpros = ALLTRIM(NVL(crFopProdDesc.Dpros, ""))
95:                     ENDIF
96:                     IF USED("crFopProdDesc")
97:                         USE IN crFopProdDesc
98:                     ENDIF
99: 
100:                     THIS.Caption = "Fornecedores do Produto : " + THIS.this_cCpros + "-" + THIS.this_cDpros
101:                 ENDIF
102: 
103:                 *-- Estrutura visual base (Fase 3) via orquestrador
104:                 THIS.ConfigurarPageFrame()
105: 
106:                 *-- Sincronizar caption nos labels
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

*-- Linhas 464 a 559:
464:                 .FontName           = "Tahoma"
465:                 .FontSize           = 8
466:                 .RowHeight          = 17
467:                 .DeleteMark         = .F.
468:                 .RecordMark         = .F.
469:                 .ScrollBars         = 2
470:                 .AllowHeaderSizing  = .F.
471:                 .AllowRowSizing     = .F.
472:                 .AllowCellSelection = .T.
473:                 .GridLineColor      = RGB(238, 238, 238)
474:                 .HighlightBackColor = RGB(255, 255, 255)
475:                 .HighlightForeColor = RGB(15, 41, 104)
476:                 .HighlightStyle     = 2
477:             ENDWITH
478: 
479:             *-- Column1: iFors (Codigo Fornecedor) ColumnOrder=1
480:             WITH loc_oGrid.Column1
481:                 .Width         = 108
482:                 .ColumnOrder   = 1
483:                 .Movable       = .F.
484:                 .Resizable     = .F.
485:                 .FontName      = "Tahoma"
486:                 .FontSize      = 8
487:                 .ControlSource = "crSigPrFnc.iFors"
488:                 .ReadOnly      = !THIS.this_lModoEdicao
489:             ENDWITH
490:             WITH loc_oGrid.Column1.Header1
491:                 .Caption   = "C" + CHR(243) + "digo"
492:                 .Alignment = 2
493:                 .FontName  = "Tahoma"
494:                 .FontSize  = 8
495:                 .ForeColor = RGB(90, 90, 90)
496:             ENDWITH
497: 
498:             *-- Column2: rClis (Razao Social) ColumnOrder=2
499:             WITH loc_oGrid.Column2
500:                 .Width         = 334
501:                 .ColumnOrder   = 2
502:                 .Movable       = .F.
503:                 .Resizable     = .F.
504:                 .FontName      = "Tahoma"
505:                 .FontSize      = 8
506:                 .ControlSource = "crSigPrFnc.rClis"
507:                 .ReadOnly      = !THIS.this_lModoEdicao
508:             ENDWITH
509:             WITH loc_oGrid.Column2.Header1
510:                 .Caption   = "Raz" + CHR(227) + "o Social"
511:                 .Alignment = 2
512:                 .FontName  = "Tahoma"
513:                 .FontSize  = 8
514:                 .ForeColor = RGB(90, 90, 90)
515:             ENDWITH
516: 
517:             *-- Column3: Reffs (Ref. Fornecedor) ColumnOrder=3
518:             WITH loc_oGrid.Column3
519:                 .Width         = 140
520:                 .ColumnOrder   = 3
521:                 .Movable       = .F.
522:                 .Resizable     = .F.
523:                 .FontName      = "Tahoma"
524:                 .FontSize      = 8
525:                 .ControlSource = "crSigPrFnc.Reffs"
526:                 .ReadOnly      = !THIS.this_lModoEdicao
527:             ENDWITH
528:             WITH loc_oGrid.Column3.Header1
529:                 .Caption   = "Ref. Fornecedor"
530:                 .Alignment = 2
531:                 .FontName  = "Tahoma"
532:                 .FontSize  = 8
533:                 .ForeColor = RGB(90, 90, 90)
534:             ENDWITH
535: 
536:             *-- Column4: MoeVs (Moeda) ColumnOrder=8
537:             WITH loc_oGrid.Column4
538:                 .Width         = 31
539:                 .ColumnOrder   = 8
540:                 .Movable       = .F.
541:                 .Resizable     = .F.
542:                 .FontName      = "Tahoma"
543:                 .FontSize      = 8
544:                 .ControlSource = "crSigPrFnc.MoeVs"
545:                 .ReadOnly      = !THIS.this_lModoEdicao
546:             ENDWITH
547:             WITH loc_oGrid.Column4.Text1
548:                 .ForeColor   = RGB(0, 0, 0)
549:                 .BackColor   = RGB(255, 255, 255)
550:                 .BorderStyle = 0
551:                 .Margin      = 0
552:             ENDWITH
553:             WITH loc_oGrid.Column4.Header1
554:                 .Caption   = "Moe"
555:                 .Alignment = 2
556:                 .FontName  = "Tahoma"
557:                 .FontSize  = 8
558:                 .ForeColor = RGB(90, 90, 90)
559:             ENDWITH

*-- Linhas 566 a 584:
566:                 .Resizable     = .F.
567:                 .FontName      = "Tahoma"
568:                 .FontSize      = 8
569:                 .ControlSource = "crSigPrFnc.PVens"
570:                 .InputMask     = "9,999,999.99"
571:                 .ReadOnly      = !THIS.this_lModoEdicao
572:             ENDWITH
573:             WITH loc_oGrid.Column5.Text1
574:                 .Format      = "K"
575:                 .InputMask   = "9,999,999.99"
576:                 .ForeColor   = RGB(0, 0, 0)
577:                 .BackColor   = RGB(255, 255, 255)
578:                 .BorderStyle = 0
579:                 .Margin      = 0
580:             ENDWITH
581:             WITH loc_oGrid.Column5.Header1
582:                 .Caption   = "Pre" + CHR(231) + "o de Custo"
583:                 .Alignment = 2
584:                 .FontName  = "Tahoma"

*-- Linhas 594 a 612:
594:                 .Resizable     = .F.
595:                 .FontName      = "Tahoma"
596:                 .FontSize      = 8
597:                 .ControlSource = "crSigPrFnc.DtValid"
598:                 .ReadOnly      = !THIS.this_lModoEdicao
599:             ENDWITH
600:             WITH loc_oGrid.Column6.Text1
601:                 .ForeColor   = RGB(0, 0, 0)
602:                 .BackColor   = RGB(255, 255, 255)
603:                 .BorderStyle = 0
604:                 .Margin      = 0
605:                 .NullDisplay = "  /  /    "
606:             ENDWITH
607:             WITH loc_oGrid.Column6.Header1
608:                 .Caption   = "Validade"
609:                 .Alignment = 2
610:                 .FontName  = "Tahoma"
611:                 .FontSize  = 8
612:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 619 a 637:
619:                 .FontName      = "Tahoma"
620:                 .FontSize      = 8
621:                 .Sparse        = .F.
622:                 .ControlSource = "crSigPrFnc.Situas"
623:                 .ReadOnly      = !THIS.this_lModoEdicao
624:             ENDWITH
625:             loc_oGrid.Column7.AddObject("Check1", "CheckBox")
626:             WITH loc_oGrid.Column7
627:                 .CurrentControl = "Check1"
628:             ENDWITH
629:             WITH loc_oGrid.Column7.Check1
630:                 .Caption   = ""
631:                 .Alignment = 0
632:                 .ReadOnly  = .F.
633:                 .Visible   = .T.
634:                 .Top       = 9
635:                 .Left      = 2
636:                 .Height    = 17
637:                 .Width     = 22

*-- Linhas 653 a 671:
653:                 .Resizable     = .F.
654:                 .FontName      = "Tahoma"
655:                 .FontSize      = 8
656:                 .ControlSource = "crSigPrFnc.Colecoes"
657:                 .ReadOnly      = !THIS.this_lModoEdicao
658:             ENDWITH
659:             WITH loc_oGrid.Column8.Text1
660:                 .ForeColor   = RGB(0, 0, 0)
661:                 .BackColor   = RGB(255, 255, 255)
662:                 .BorderStyle = 0
663:                 .Margin      = 0
664:             ENDWITH
665:             WITH loc_oGrid.Column8.Header1
666:                 .Caption   = "Grupo Venda"
667:                 .Alignment = 2
668:                 .FontName  = "Tahoma"
669:                 .FontSize  = 8
670:                 .ForeColor = RGB(90, 90, 90)
671:             ENDWITH

*-- Linhas 678 a 696:
678:                 .Resizable     = .F.
679:                 .FontName      = "Tahoma"
680:                 .FontSize      = 8
681:                 .ControlSource = "crSigPrFnc.CodCors"
682:                 .ReadOnly      = !THIS.this_lModoEdicao
683:             ENDWITH
684:             WITH loc_oGrid.Column9.Text1
685:                 .ForeColor   = RGB(0, 0, 0)
686:                 .BackColor   = RGB(255, 255, 255)
687:                 .BorderStyle = 0
688:                 .Margin      = 0
689:             ENDWITH
690:             WITH loc_oGrid.Column9.Header1
691:                 .Caption   = "Cor"
692:                 .Alignment = 2
693:                 .FontName  = "Tahoma"
694:                 .FontSize  = 8
695:                 .ForeColor = RGB(90, 90, 90)
696:             ENDWITH

*-- Linhas 703 a 721:
703:                 .Resizable     = .F.
704:                 .FontName      = "Tahoma"
705:                 .FontSize      = 8
706:                 .ControlSource = "crSigPrFnc.CodTams"
707:                 .ReadOnly      = !THIS.this_lModoEdicao
708:             ENDWITH
709:             WITH loc_oGrid.Column10.Text1
710:                 .ForeColor   = RGB(0, 0, 0)
711:                 .BackColor   = RGB(255, 255, 255)
712:                 .BorderStyle = 0
713:                 .Margin      = 0
714:             ENDWITH
715:             WITH loc_oGrid.Column10.Header1
716:                 .Caption   = "Tam"
717:                 .Alignment = 2
718:                 .FontName  = "Tahoma"
719:                 .FontSize  = 8
720:                 .ForeColor = RGB(90, 90, 90)
721:             ENDWITH

*-- Linhas 791 a 809:
791:             IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cCpros)
792:                 THIS.grd_4c_Dados.Refresh()
793:                 IF USED("crSigPrFnc")
794:                     SELECT crSigPrFnc
795:                     GO BOTTOM
796:                 ENDIF
797:                 THIS.grd_4c_Dados.Column1.SetFocus()
798:             ENDIF
799:         CATCH TO loc_oErro
800:             MsgErro(loc_oErro.Message + CHR(13) + ;
801:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
802:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
803:         ENDTRY
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * CmdExcluirClick - Marca linha corrente para exclusao
808:     *==========================================================================
809:     PROCEDURE CmdExcluirClick()

*-- Linhas 830 a 848:
830:             IF !USED("crSigPrFnc")
831:                 RETURN
832:             ENDIF
833:             SELECT crSigPrFnc
834:             IF EOF() OR EMPTY(iFors)
835:                 MsgAviso("Selecione um registro para ser repetido.", ;
836:                          "Aten" + CHR(231) + CHR(227) + "o")
837:                 RETURN
838:             ENDIF
839:             THIS.lbl_4c_LblQtde.Visible = .T.
840:             THIS.txt_4c_Qtde.Visible    = .T.
841:             THIS.shp_4c_ShpQtde.Visible = .T.
842:             THIS.txt_4c_Qtde.Value      = 0
843:             THIS.txt_4c_Qtde.SetFocus()
844:         CATCH TO loc_oErro
845:             MsgErro(loc_oErro.Message + CHR(13) + ;
846:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
847:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRepetirClick")
848:         ENDTRY

*-- Linhas 901 a 940:
901:             THIS.txt_4c_Qtde.Visible     = .F.
902: 
903:             IF USED("crSigPrFnc")
904:                 SELECT crSigPrFnc
905:             ENDIF
906:             THIS.grd_4c_Dados.Column1.SetFocus()
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message + CHR(13) + ;
909:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
910:                     "Procedure: " + loc_oErro.Procedure, "Erro em TxtQtdeKeyPress")
911:         ENDTRY
912:     ENDPROC
913: 
914:     *==========================================================================
915:     * TxtQtdeLostFocus - Oculta area de repeticao ao perder foco
916:     *==========================================================================
917:     PROCEDURE TxtQtdeLostFocus()
918:         LOCAL loc_oErro
919: 
920:         TRY
921:             THIS.lbl_4c_LblQtde.Visible = .F.
922:             THIS.shp_4c_ShpQtde.Visible  = .F.
923:             THIS.txt_4c_Qtde.Visible     = .F.
924:             IF USED("crSigPrFnc")
925:                 SELECT crSigPrFnc
926:                 THIS.grd_4c_Dados.Column1.SetFocus()
927:             ENDIF
928:         CATCH TO loc_oErro
929:             MsgErro(loc_oErro.Message, "Erro em TxtQtdeLostFocus")
930:         ENDTRY
931:     ENDPROC
932: 
933:     *==========================================================================
934:     * GrdCol1KeyPress - Lookup Column1 (iFors) em SigCdCli por codigo
935:     *==========================================================================
936:     PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
937: 
938:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
939:             RETURN
940:         ENDIF

*-- Linhas 1040 a 1058:
1040:                     loc_cIfors = ALLTRIM(NVL(crFopBuscaCli.iclis, ""))
1041:                     loc_cRClis = ALLTRIM(NVL(crFopBuscaCli.rclis, ""))
1042:                     USE IN crFopBuscaCli
1043:                     SELECT crSigPrFnc
1044:                     REPLACE iFors WITH loc_cIfors, rClis WITH loc_cRClis
1045:                     THIS.grd_4c_Dados.Refresh()
1046:                 ELSE
1047:                     USE IN crFopBuscaCli
1048:                 ENDIF
1049:             ENDIF
1050:         CATCH TO loc_oErro
1051:             MsgErro(loc_oErro.Message + CHR(13) + ;
1052:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1053:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCli")
1054:             IF USED("crFopBuscaCli")
1055:                 USE IN crFopBuscaCli
1056:             ENDIF
1057:         ENDTRY
1058:     ENDPROC

*-- Linhas 1078 a 1096:
1078:                 IF !EOF("crFopBuscaMoe")
1079:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaMoe.CMoes, ""))
1080:                     USE IN crFopBuscaMoe
1081:                     SELECT crSigPrFnc
1082:                     REPLACE MoeVs WITH loc_cCodigo
1083:                     THIS.grd_4c_Dados.Refresh()
1084:                 ELSE
1085:                     USE IN crFopBuscaMoe
1086:                 ENDIF
1087:             ENDIF
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + CHR(13) + ;
1090:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1091:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaMoe")
1092:             IF USED("crFopBuscaMoe")
1093:                 USE IN crFopBuscaMoe
1094:             ENDIF
1095:         ENDTRY
1096:     ENDPROC

*-- Linhas 1117 a 1135:
1117:                 IF !EOF("crFopBuscaCol")
1118:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCol.Colecoes, ""))
1119:                     USE IN crFopBuscaCol
1120:                     SELECT crSigPrFnc
1121:                     REPLACE Colecoes WITH loc_cCodigo
1122:                     THIS.grd_4c_Dados.Refresh()
1123:                 ELSE
1124:                     USE IN crFopBuscaCol
1125:                 ENDIF
1126:             ENDIF
1127:         CATCH TO loc_oErro
1128:             MsgErro(loc_oErro.Message + CHR(13) + ;
1129:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1130:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCol")
1131:             IF USED("crFopBuscaCol")
1132:                 USE IN crFopBuscaCol
1133:             ENDIF
1134:         ENDTRY
1135:     ENDPROC

*-- Linhas 1155 a 1173:
1155:                 IF !EOF("crFopBuscaCor")
1156:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCor.Cods, ""))
1157:                     USE IN crFopBuscaCor
1158:                     SELECT crSigPrFnc
1159:                     REPLACE CodCors WITH loc_cCodigo
1160:                     THIS.grd_4c_Dados.Refresh()
1161:                 ELSE
1162:                     USE IN crFopBuscaCor
1163:                 ENDIF
1164:             ENDIF
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message + CHR(13) + ;
1167:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1168:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCor")
1169:             IF USED("crFopBuscaCor")
1170:                 USE IN crFopBuscaCor
1171:             ENDIF
1172:         ENDTRY
1173:     ENDPROC

*-- Linhas 1229 a 1247:
1229:                 IF !EOF("crFopBuscaTam")
1230:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaTam.Cods, ""))
1231:                     USE IN crFopBuscaTam
1232:                     SELECT crSigPrFnc
1233:                     REPLACE CodTams WITH loc_cCodigo
1234:                     THIS.grd_4c_Dados.Refresh()
1235:                 ELSE
1236:                     USE IN crFopBuscaTam
1237:                 ENDIF
1238:             ENDIF
1239:         CATCH TO loc_oErro
1240:             MsgErro(loc_oErro.Message + CHR(13) + ;
1241:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1242:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaTam")
1243:             IF USED("crFopBuscaTam")
1244:                 USE IN crFopBuscaTam
1245:             ENDIF
1246:         ENDTRY
1247:     ENDPROC

*-- Linhas 1474 a 1492:
1474: 
1475:         TRY
1476:             IF USED("crSigPrFnc")
1477:                 SELECT crSigPrFnc
1478:                 ZAP
1479:                 THIS.grd_4c_Dados.Refresh()
1480:             ENDIF
1481:             THIS.this_lHouveIncl = .F.
1482:             THIS.this_lHouveExcl = .F.
1483:         CATCH TO loc_oErro
1484:             MsgErro(loc_oErro.Message + CHR(13) + ;
1485:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1486:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1487:         ENDTRY
1488:     ENDPROC
1489: 
1490:     *==========================================================================
1491:     * FormParaBO - Sincroniza a linha corrente do cursor com as propriedades do BO
1492:     * Neste form OPERACIONAL, a edicao ocorre diretamente nas celulas do grid


### BO (C:\4c\projeto\app\classes\FopBO.prg):
*==============================================================================
* FopBO.prg - Business Object para Fornecedores do Produto
* Tabela   : SigPrFnc
* Herda de : BusinessBase
* Migrado de: SIGCDFOP.SCX (task421)
*==============================================================================
DEFINE CLASS FopBO AS BusinessBase

    *---------------------------------------------------------------------------
    *-- Campos da tabela SigPrFnc (schema.sql)
    *---------------------------------------------------------------------------
    this_cCidChaves  = ""   && PK char(20)
    this_cCpros      = ""   && Produto char(14) - FK SigCdPro
    this_cIfors      = ""   && Fornecedor char(10) - FK SigCdCli
    this_cRClis      = ""   && Razao Social (JOIN SigCdCli - exibicao, nao persistido)
    this_cReffs      = ""   && Referencia do Fornecedor char(40)
    this_cMoevs      = ""   && Moeda char(3) - FK SigCdMoe
    this_nPvens      = 0    && Preco de Custo numeric(10,2)
    this_dDtvalid    = {}   && Validade datetime NULL
    this_nSituas     = 0    && Situacao numeric(1,0) - checkbox (Situas)
    this_cColecoes   = ""   && Grupo Venda char(10) - FK SigCdCol
    this_cCodcors    = ""   && Cor char(4) - FK SigCdCor
    this_cCodtams    = ""   && Tamanho char(4) - FK SigCdTam

    *---------------------------------------------------------------------------
    *-- Estado operacional do formulario
    *---------------------------------------------------------------------------
    this_cCprosAtivo = ""   && Codigo do produto em edicao
    this_lHouveIncl  = .F.  && Houve inclusoes nesta sessao
    this_lHouveExcl  = .F.  && Houve exclusoes nesta sessao
    this_cModoAtual  = ""   && Modo atual: INSERIR / ALTERAR / VISUALIZAR

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrFnc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *===========================================================================
    PROCEDURE BuscarPorProduto(par_cCpros)
    *===========================================================================
    * Carrega fornecedores do produto do SQL Server para cursor crSigPrFnc.
    * O cursor inclui coluna lNovo (.F. para registros ja existentes no DB).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cCPros, loc_cIfors, loc_cRClis
        LOCAL loc_cReffs, loc_cMoevs, loc_nPvens, loc_dDtvalid
        LOCAL loc_nSituas, loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.cPros, a.iFors, " + ;
                       "ISNULL(b.rClis, '') AS rClis, " + ;
                       "a.Reffs, a.MoeVs, a.PVens, a.DtValid, " + ;
                       "a.Situas, a.Colecoes, a.CodCors, a.CodTams " + ;
                       "FROM SigPrFnc a " + ;
                       "LEFT JOIN SigCdCli b ON b.iClis = a.iFors " + ;
                       "WHERE a.cPros = " + EscaparSQL(par_cCpros)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrFncTemp")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar fornecedores do produto.", "Erro em BuscarPorProduto")
            ELSE
                IF USED("crSigPrFnc")
                    TABLEREVERT(.T., "crSigPrFnc")
                    USE IN crSigPrFnc
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigPrFnc ;
                    (CidChaves C(20) NULL, cPros C(14) NULL, iFors C(10) NULL, ;
                     rClis C(50) NULL, Reffs C(40) NULL, MoeVs C(3) NULL, ;
                     PVens N(10,2) NULL, DtValid T NULL, Situas N(1,0) NULL, ;
                     Colecoes C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     lNovo L)
                SET NULL OFF

                SELECT crSigPrFncTemp
                GO TOP
                SCAN
                    loc_cCidChaves = NVL(crSigPrFncTemp.CidChaves, "")
                    loc_cCPros     = NVL(crSigPrFncTemp.cPros, "")
                    loc_cIfors     = NVL(crSigPrFncTemp.iFors, "")
                    loc_cRClis     = NVL(crSigPrFncTemp.rClis, "")
                    loc_cReffs     = NVL(crSigPrFncTemp.Reffs, "")
                    loc_cMoevs     = NVL(crSigPrFncTemp.MoeVs, "")
                    loc_nPvens     = NVL(crSigPrFncTemp.PVens, 0)
                    loc_dDtvalid   = crSigPrFncTemp.DtValid
                    loc_nSituas    = NVL(crSigPrFncTemp.Situas, 0)
                    loc_cColecoes  = NVL(crSigPrFncTemp.Colecoes, "")
                    loc_cCodcors   = NVL(crSigPrFncTemp.CodCors, "")
                    loc_cCodtams   = NVL(crSigPrFncTemp.CodTams, "")

                    SELECT crSigPrFnc
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cCidChaves, ;
                            cPros     WITH loc_cCPros, ;
                            iFors     WITH loc_cIfors, ;
                            rClis     WITH loc_cRClis, ;
                            Reffs     WITH loc_cReffs, ;
                            MoeVs     WITH loc_cMoevs, ;
                            PVens     WITH loc_nPvens, ;
                            DtValid   WITH loc_dDtvalid, ;
                            Situas    WITH loc_nSituas, ;
                            Colecoes  WITH loc_cColecoes, ;
                            CodCors   WITH loc_cCodcors, ;
                            CodTams   WITH loc_cCodtams, ;
                            lNovo     WITH .F.

                    SELECT crSigPrFncTemp
                ENDSCAN

                USE IN crSigPrFncTemp

                SELECT crSigPrFnc
                GO TOP

                THIS.this_cCprosAtivo = par_cCpros
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE InserirLinha(par_cCpros)
    *===========================================================================
    * Adiciona linha em branco ao cursor crSigPrFnc (ainda nao persiste no DB).
    * Replica cmdInserir.Click: localiza linha vazia existente, senao append.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cChave, loc_lAchou

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                MsgErro("Cursor crSigPrFnc n" + CHR(227) + "o inicializado.", "Erro em InserirLinha")
            ELSE
                SELECT crSigPrFnc
                SET EXACT ON
                LOCATE FOR ALLTRIM(cPros) == ALLTRIM(par_cCpros) AND EMPTY(iFors) AND !DELETED()
                loc_lAchou = !EOF()

                IF !loc_lAchou
                    loc_cChave = THIS.GerarCidChaves()
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cChave, ;
                            cPros     WITH par_cCpros, ;
                            iFors     WITH "", ;
                            rClis     WITH "", ;
                            Reffs     WITH "", ;
                            MoeVs     WITH "", ;
                            PVens     WITH 0, ;
                            Situas    WITH 0, ;
                            Colecoes  WITH "", ;
                            CodCors   WITH "", ;
                            CodTams   WITH "", ;
                            lNovo     WITH .T.
                    THIS.this_lHouveIncl = .T.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ExcluirLinha()
    *===========================================================================
    * Marca a linha corrente do cursor para exclusao (replica cmdExcluir.Click).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF !EOF() AND ALLTRIM(cPros) == ALLTRIM(THIS.this_cCprosAtivo) AND !DELETED()
                    DELETE
                    SKIP
                    SKIP - 1
                    THIS.this_lHouveExcl = .T.
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE RepetirLinha(par_nVezes)
    *===========================================================================
    * Duplica a linha corrente do cursor N vezes (replica getQtde.Valid).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_i, loc_cChave
        LOCAL loc_cIfors, loc_cRClis, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams, loc_cCpros

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF EMPTY(iFors)
                    MsgAviso("Selecione um registro para ser repetido.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cRClis    = ALLTRIM(rClis)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cMoevs    = ALLTRIM(MoeVs)
                    loc_nPvens    = NVL(PVens, 0)
                    loc_dDtvalid  = DtValid
                    loc_nSituas   = NVL(Situas, 0)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_cCodcors  = ALLTRIM(CodCors)
                    loc_cCodtams  = ALLTRIM(CodTams)
                    loc_cCpros    = ALLTRIM(cPros)

                    FOR loc_i = 1 TO par_nVezes
                        loc_cChave = THIS.GerarCidChaves()
                        SELECT crSigPrFnc
                        APPEND BLANK
                        REPLACE CidChaves WITH loc_cChave, ;
                                cPros     WITH loc_cCpros, ;
                                iFors     WITH loc_cIfors, ;
                                rClis     WITH loc_cRClis, ;
                                Reffs     WITH loc_cReffs, ;
                                MoeVs     WITH loc_cMoevs, ;
                                PVens     WITH loc_nPvens, ;
                                DtValid   WITH loc_dDtvalid, ;
                                Situas    WITH loc_nSituas, ;
                                Colecoes  WITH loc_cColecoes, ;
                                CodCors   WITH loc_cCodcors, ;
                                CodTams   WITH loc_cCodtams, ;
                                lNovo     WITH .T.
                    ENDFOR

                    THIS.this_lHouveIncl = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RepetirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ValidarCursor(par_cModo)
    *===========================================================================
    * Valida todas as linhas do cursor antes de salvar (replica cmdSair.Click).
    * Retorna .T. se valido, .F. se invalido (com MsgAviso ao usuario).
    *---------------------------------------------------------------------------
        LOCAL loc_lValido
        LOCAL loc_cIfors, loc_cReffs, loc_cColecoes, loc_cCidChaves, loc_nPvens
        LOCAL loc_nDupli

        loc_lValido = .T.

        TRY
            IF USED("crSigPrFnc") AND INLIST(UPPER(par_cModo), "INSERIR", "ALTERAR")
                SELECT crSigPrFnc
                GO TOP
                SCAN
                    IF DELETED()
                        LOOP
                    ENDIF

                    IF EMPTY(iFors)
                        MsgAviso("Fornecedor deve ser informado!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(Reffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(MoeVs)
                        MsgAviso("A Moeda deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    loc_cIfors     = ALLTRIM(iFors)
                    loc_cReffs     = ALLTRIM(Reffs)
                    loc_cColecoes  = ALLTRIM(Colecoes)
                    loc_cCidChaves = ALLTRIM(CidChaves)
                    loc_nPvens     = NVL(PVens, 0)

                    SELECT COUNT(*) AS nDupli ;
                        FROM crSigPrFnc a ;
                        WHERE ALLTRIM(a.iFors)     == m.loc_cIfors ;
                          AND ALLTRIM(a.Reffs)     == m.loc_cReffs ;
                          AND ALLTRIM(a.Colecoes)  == m.loc_cColecoes ;
                          AND ALLTRIM(a.CidChaves) != m.loc_cCidChaves ;
                          AND NVL(a.PVens, 0)       = m.loc_nPvens ;
                          AND !DELETED() ;
                        INTO CURSOR crAuxDupli READWRITE

                    SELECT crAuxDupli
                    loc_nDupli = NVL(crAuxDupli.nDupli, 0)
                    USE IN crAuxDupli

                    IF loc_nDupli > 0
                        MsgAviso("Fornecedor j" + CHR(225) + " informado para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    SELECT crSigPrFnc
                ENDSCAN

                SELECT crSigPrFnc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarCursor")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *===========================================================================
    PROCEDURE SalvarAlteracoes(par_cCpros)
    *===========================================================================
    * Persiste as alteracoes do cursor crSigPrFnc no SQL Server.
    * Estrategia: DELETE todos existentes para o produto + INSERT os nao-deletados.
    * Isso replica o comportamento do fSqlConector.ReQuery do legado.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cIfors, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "DELETE FROM SigPrFnc WHERE cPros = " + EscaparSQL(par_cCpros)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir registros anteriores de SigPrFnc.", ;
                            "Erro em SalvarAlteracoes")
                ELSE
                    SELECT crSigPrFnc
                    GO TOP
                    SCAN
                        IF DELETED()
                            LOOP
                        ENDIF

                        loc_cCidChaves = ALLTRIM(CidChaves)
                        loc_cIfors     = ALLTRIM(iFors)
                        loc_cReffs     = ALLTRIM(Reffs)
                        loc_cMoevs     = ALLTRIM(MoeVs)
                        loc_nPvens     = NVL(PVens, 0)
                        loc_dDtvalid   = DtValid
                        loc_nSituas    = NVL(Situas, 0)
                        loc_cColecoes  = ALLTRIM(Colecoes)
                        loc_cCodcors   = ALLTRIM(CodCors)
                        loc_cCodtams   = ALLTRIM(CodTams)

                        loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                   "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                   "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCpros) + ", " + ;
                                   EscaparSQL(loc_cIfors) + ", " + ;
                                   EscaparSQL(loc_cReffs) + ", " + ;
                                   EscaparSQL(loc_cMoevs) + ", " + ;
                                   FormatarNumeroSQL(loc_nPvens, 2) + ", " + ;
                                   IIF(ISNULL(loc_dDtvalid) OR EMPTY(loc_dDtvalid), ;
                                       "NULL", FormatarDataSQL(loc_dDtvalid)) + ", " + ;
                                   FormatarNumeroSQL(loc_nSituas, 0) + ", " + ;
                                   EscaparSQL(loc_cColecoes) + ", " + ;
                                   EscaparSQL(loc_cCodcors) + ", " + ;
                                   EscaparSQL(loc_cCodtams) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet < 0
                            MsgErro("Erro ao inserir fornecedor " + loc_cIfors + " em SigPrFnc.", ;
                                    "Erro em SalvarAlteracoes")
                            EXIT
                        ENDIF

                        SELECT crSigPrFnc
                    ENDSCAN

                    IF loc_nRet >= 0
                        SELECT crSigPrFnc
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarAlteracoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
    *===========================================================================
    * Mapeia campos do cursor para propriedades do BO.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_cCpros     = TratarNulo(cPros, "C")
                THIS.this_cIfors     = TratarNulo(iFors, "C")
                THIS.this_cRClis     = TratarNulo(rClis, "C")
                THIS.this_cReffs     = TratarNulo(Reffs, "C")
                THIS.this_cMoevs     = TratarNulo(MoeVs, "C")
                THIS.this_nPvens     = NVL(PVens, 0)
                THIS.this_dDtvalid   = NVL(DtValid, {})
                THIS.this_nSituas    = NVL(Situas, 0)
                THIS.this_cColecoes  = TratarNulo(Colecoes, "C")
                THIS.this_cCodcors   = TratarNulo(CodCors, "C")
                THIS.this_cCodtams   = TratarNulo(CodTams, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED FUNCTION GerarCidChaves()
    *===========================================================================
    * Gera chave unica de 20 chars para CidChaves (replica fUniqueIds do legado).
    * Usa NEWID() do SQL Server (GUID sem hifens, truncado em 20 chars).
    *---------------------------------------------------------------------------
        LOCAL loc_cChave

        loc_cChave = ""

        TRY
            IF SQLEXEC(gnConnHandle, ;
                       "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS nk", ;
                       "crChaveTemp") > 0
                SELECT crChaveTemp
                loc_cChave = ALLTRIM(TRANSFORM(crChaveTemp.nk))
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            * Fallback local se SQL Server nao disponivel
        ENDTRY

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(STRTRAN(STRTRAN(STRTRAN(TRANSFORM(DATETIME()), "/", ""), " ", ""), ":", "") + ;
                              SYS(3) + SYS(3), 20)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    PROCEDURE Inserir()
    *===========================================================================
    * Insere UM registro individual de SigPrFnc usando as propriedades this_*.
    * Chamado internamente por SalvarAlteracoes ou standalone via CarregarDoCursor.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cChave

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCpros)
                MsgAviso("Produto n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
                            IF EMPTY(loc_cChave)
                                loc_cChave = THIS.GerarCidChaves()
                                THIS.this_cCidChaves = loc_cChave
                            ENDIF

                            loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                       "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                       "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                       "VALUES (" + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cIfors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cReffs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cMoevs)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nPvens, 2) + ", " + ;
                                       IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodcors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodtams)) + ")"

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao inserir fornecedor do produto no SQL Server.", ;
                                        "Erro em Inserir")
                            ELSE
                                THIS.RegistrarAuditoria("INCLUSAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE Atualizar()
    *===========================================================================
    * Atualiza UM registro individual de SigPrFnc pela chave primaria CidChaves.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada. N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                        "vel atualizar.", "Erro em Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cSQL = "UPDATE SigPrFnc SET " + ;
                                       "cPros = "    + EscaparSQL(ALLTRIM(THIS.this_cCpros))    + ", " + ;
                                       "iFors = "    + EscaparSQL(ALLTRIM(THIS.this_cIfors))    + ", " + ;
                                       "Reffs = "    + EscaparSQL(ALLTRIM(THIS.this_cReffs))    + ", " + ;
                                       "MoeVs = "    + EscaparSQL(ALLTRIM(THIS.this_cMoevs))    + ", " + ;
                                       "PVens = "    + FormatarNumeroSQL(THIS.this_nPvens, 2)   + ", " + ;
                                       "DtValid = "  + IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       "Situas = "   + FormatarNumeroSQL(THIS.this_nSituas, 0)  + ", " + ;
                                       "Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       "CodCors = "  + EscaparSQL(ALLTRIM(THIS.this_cCodcors))  + ", " + ;
                                       "CodTams = "  + EscaparSQL(ALLTRIM(THIS.this_cCodtams))  + " " + ;
                                       "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao atualizar fornecedor do produto no SQL Server.", ;
                                        "Erro em Atualizar")
                            ELSE
                                THIS.RegistrarAuditoria("ALTERACAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    * Executa DELETE de UM registro individual pela chave CidChaves.
    * Chamado por BusinessBase.Excluir() (PUBLIC).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada.", "Erro em ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("EXCLUSAO")

                loc_cSQL = "DELETE FROM SigPrFnc WHERE CidChaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir fornecedor do produto no SQL Server.", ;
                            "Erro em ExecutarExclusao")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE LiberarCursores()
    *===========================================================================
    * Libera todos os cursores do BO. Chamar no Destroy do Form.
    *---------------------------------------------------------------------------
        TRY
            IF USED("crSigPrFnc")
                TABLEREVERT(.T., "crSigPrFnc")
                USE IN crSigPrFnc
            ENDIF
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF
            IF USED("crAuxDupli")
                USE IN crAuxDupli
            ENDIF
            IF USED("crChaveTemp")
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LiberarCursores")
        ENDTRY
    ENDPROC

ENDDEFINE

