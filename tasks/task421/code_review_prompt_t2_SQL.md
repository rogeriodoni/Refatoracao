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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1523 linhas total):

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

*-- Linhas 465 a 560:
465:                 .FontName           = "Tahoma"
466:                 .FontSize           = 8
467:                 .RowHeight          = 17
468:                 .DeleteMark         = .F.
469:                 .RecordMark         = .F.
470:                 .ScrollBars         = 2
471:                 .AllowHeaderSizing  = .F.
472:                 .AllowRowSizing     = .F.
473:                 .AllowCellSelection = .T.
474:                 .GridLineColor      = RGB(238, 238, 238)
475:                 .HighlightBackColor = RGB(255, 255, 255)
476:                 .HighlightForeColor = RGB(15, 41, 104)
477:                 .HighlightStyle     = 2
478:             ENDWITH
479: 
480:             *-- Column1: iFors (Codigo Fornecedor) ColumnOrder=1
481:             WITH loc_oGrid.Column1
482:                 .Width         = 108
483:                 .ColumnOrder   = 1
484:                 .Movable       = .F.
485:                 .Resizable     = .F.
486:                 .FontName      = "Tahoma"
487:                 .FontSize      = 8
488:                 .ControlSource = "crSigPrFnc.iFors"
489:                 .ReadOnly      = !THIS.this_lModoEdicao
490:             ENDWITH
491:             WITH loc_oGrid.Column1.Header1
492:                 .Caption   = "C" + CHR(243) + "digo"
493:                 .Alignment = 2
494:                 .FontName  = "Tahoma"
495:                 .FontSize  = 8
496:                 .ForeColor = RGB(90, 90, 90)
497:             ENDWITH
498: 
499:             *-- Column2: rClis (Razao Social) ColumnOrder=2
500:             WITH loc_oGrid.Column2
501:                 .Width         = 334
502:                 .ColumnOrder   = 2
503:                 .Movable       = .F.
504:                 .Resizable     = .F.
505:                 .FontName      = "Tahoma"
506:                 .FontSize      = 8
507:                 .ControlSource = "crSigPrFnc.rClis"
508:                 .ReadOnly      = !THIS.this_lModoEdicao
509:             ENDWITH
510:             WITH loc_oGrid.Column2.Header1
511:                 .Caption   = "Raz" + CHR(227) + "o Social"
512:                 .Alignment = 2
513:                 .FontName  = "Tahoma"
514:                 .FontSize  = 8
515:                 .ForeColor = RGB(90, 90, 90)
516:             ENDWITH
517: 
518:             *-- Column3: Reffs (Ref. Fornecedor) ColumnOrder=3
519:             WITH loc_oGrid.Column3
520:                 .Width         = 140
521:                 .ColumnOrder   = 3
522:                 .Movable       = .F.
523:                 .Resizable     = .F.
524:                 .FontName      = "Tahoma"
525:                 .FontSize      = 8
526:                 .ControlSource = "crSigPrFnc.Reffs"
527:                 .ReadOnly      = !THIS.this_lModoEdicao
528:             ENDWITH
529:             WITH loc_oGrid.Column3.Header1
530:                 .Caption   = "Ref. Fornecedor"
531:                 .Alignment = 2
532:                 .FontName  = "Tahoma"
533:                 .FontSize  = 8
534:                 .ForeColor = RGB(90, 90, 90)
535:             ENDWITH
536: 
537:             *-- Column4: MoeVs (Moeda) ColumnOrder=8
538:             WITH loc_oGrid.Column4
539:                 .Width         = 31
540:                 .ColumnOrder   = 8
541:                 .Movable       = .F.
542:                 .Resizable     = .F.
543:                 .FontName      = "Tahoma"
544:                 .FontSize      = 8
545:                 .ControlSource = "crSigPrFnc.MoeVs"
546:                 .ReadOnly      = !THIS.this_lModoEdicao
547:             ENDWITH
548:             WITH loc_oGrid.Column4.Text1
549:                 .ForeColor   = RGB(0, 0, 0)
550:                 .BackColor   = RGB(255, 255, 255)
551:                 .BorderStyle = 0
552:                 .Margin      = 0
553:             ENDWITH
554:             WITH loc_oGrid.Column4.Header1
555:                 .Caption   = "Moe"
556:                 .Alignment = 2
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 8
559:                 .ForeColor = RGB(90, 90, 90)
560:             ENDWITH

*-- Linhas 567 a 585:
567:                 .Resizable     = .F.
568:                 .FontName      = "Tahoma"
569:                 .FontSize      = 8
570:                 .ControlSource = "crSigPrFnc.PVens"
571:                 .InputMask     = "9,999,999.99"
572:                 .ReadOnly      = !THIS.this_lModoEdicao
573:             ENDWITH
574:             WITH loc_oGrid.Column5.Text1
575:                 .Format      = "K"
576:                 .InputMask   = "9,999,999.99"
577:                 .ForeColor   = RGB(0, 0, 0)
578:                 .BackColor   = RGB(255, 255, 255)
579:                 .BorderStyle = 0
580:                 .Margin      = 0
581:             ENDWITH
582:             WITH loc_oGrid.Column5.Header1
583:                 .Caption   = "Pre" + CHR(231) + "o de Custo"
584:                 .Alignment = 2
585:                 .FontName  = "Tahoma"

*-- Linhas 595 a 613:
595:                 .Resizable     = .F.
596:                 .FontName      = "Tahoma"
597:                 .FontSize      = 8
598:                 .ControlSource = "crSigPrFnc.DtValid"
599:                 .ReadOnly      = !THIS.this_lModoEdicao
600:             ENDWITH
601:             WITH loc_oGrid.Column6.Text1
602:                 .ForeColor   = RGB(0, 0, 0)
603:                 .BackColor   = RGB(255, 255, 255)
604:                 .BorderStyle = 0
605:                 .Margin      = 0
606:                 .NullDisplay = "  /  /    "
607:             ENDWITH
608:             WITH loc_oGrid.Column6.Header1
609:                 .Caption   = "Validade"
610:                 .Alignment = 2
611:                 .FontName  = "Tahoma"
612:                 .FontSize  = 8
613:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 620 a 638:
620:                 .FontName      = "Tahoma"
621:                 .FontSize      = 8
622:                 .Sparse        = .F.
623:                 .ControlSource = "crSigPrFnc.Situas"
624:                 .ReadOnly      = !THIS.this_lModoEdicao
625:             ENDWITH
626:             loc_oGrid.Column7.AddObject("Check1", "CheckBox")
627:             WITH loc_oGrid.Column7
628:                 .CurrentControl = "Check1"
629:             ENDWITH
630:             WITH loc_oGrid.Column7.Check1
631:                 .Caption   = ""
632:                 .Alignment = 0
633:                 .ReadOnly  = .F.
634:                 .Visible   = .T.
635:                 .Top       = 9
636:                 .Left      = 2
637:                 .Height    = 17
638:                 .Width     = 22

*-- Linhas 654 a 672:
654:                 .Resizable     = .F.
655:                 .FontName      = "Tahoma"
656:                 .FontSize      = 8
657:                 .ControlSource = "crSigPrFnc.Colecoes"
658:                 .ReadOnly      = !THIS.this_lModoEdicao
659:             ENDWITH
660:             WITH loc_oGrid.Column8.Text1
661:                 .ForeColor   = RGB(0, 0, 0)
662:                 .BackColor   = RGB(255, 255, 255)
663:                 .BorderStyle = 0
664:                 .Margin      = 0
665:             ENDWITH
666:             WITH loc_oGrid.Column8.Header1
667:                 .Caption   = "Grupo Venda"
668:                 .Alignment = 2
669:                 .FontName  = "Tahoma"
670:                 .FontSize  = 8
671:                 .ForeColor = RGB(90, 90, 90)
672:             ENDWITH

*-- Linhas 679 a 697:
679:                 .Resizable     = .F.
680:                 .FontName      = "Tahoma"
681:                 .FontSize      = 8
682:                 .ControlSource = "crSigPrFnc.CodCors"
683:                 .ReadOnly      = !THIS.this_lModoEdicao
684:             ENDWITH
685:             WITH loc_oGrid.Column9.Text1
686:                 .ForeColor   = RGB(0, 0, 0)
687:                 .BackColor   = RGB(255, 255, 255)
688:                 .BorderStyle = 0
689:                 .Margin      = 0
690:             ENDWITH
691:             WITH loc_oGrid.Column9.Header1
692:                 .Caption   = "Cor"
693:                 .Alignment = 2
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .ForeColor = RGB(90, 90, 90)
697:             ENDWITH

*-- Linhas 704 a 722:
704:                 .Resizable     = .F.
705:                 .FontName      = "Tahoma"
706:                 .FontSize      = 8
707:                 .ControlSource = "crSigPrFnc.CodTams"
708:                 .ReadOnly      = !THIS.this_lModoEdicao
709:             ENDWITH
710:             WITH loc_oGrid.Column10.Text1
711:                 .ForeColor   = RGB(0, 0, 0)
712:                 .BackColor   = RGB(255, 255, 255)
713:                 .BorderStyle = 0
714:                 .Margin      = 0
715:             ENDWITH
716:             WITH loc_oGrid.Column10.Header1
717:                 .Caption   = "Tam"
718:                 .Alignment = 2
719:                 .FontName  = "Tahoma"
720:                 .FontSize  = 8
721:                 .ForeColor = RGB(90, 90, 90)
722:             ENDWITH

*-- Linhas 792 a 810:
792:             IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cCpros)
793:                 THIS.grd_4c_Dados.Refresh()
794:                 IF USED("crSigPrFnc")
795:                     SELECT crSigPrFnc
796:                     GO BOTTOM
797:                 ENDIF
798:                 THIS.grd_4c_Dados.Column1.SetFocus()
799:             ENDIF
800:         CATCH TO loc_oErro
801:             MsgErro(loc_oErro.Message + CHR(13) + ;
802:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
803:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
804:         ENDTRY
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * CmdExcluirClick - Marca linha corrente para exclusao
809:     *==========================================================================
810:     PROCEDURE CmdExcluirClick()

*-- Linhas 831 a 849:
831:             IF !USED("crSigPrFnc")
832:                 RETURN
833:             ENDIF
834:             SELECT crSigPrFnc
835:             IF EOF() OR EMPTY(iFors)
836:                 MsgAviso("Selecione um registro para ser repetido.", ;
837:                          "Aten" + CHR(231) + CHR(227) + "o")
838:                 RETURN
839:             ENDIF
840:             THIS.lbl_4c_LblQtde.Visible = .T.
841:             THIS.txt_4c_Qtde.Visible    = .T.
842:             THIS.shp_4c_ShpQtde.Visible = .T.
843:             THIS.txt_4c_Qtde.Value      = 0
844:             THIS.txt_4c_Qtde.SetFocus()
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message + CHR(13) + ;
847:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
848:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRepetirClick")
849:         ENDTRY

*-- Linhas 902 a 941:
902:             THIS.txt_4c_Qtde.Visible     = .F.
903: 
904:             IF USED("crSigPrFnc")
905:                 SELECT crSigPrFnc
906:             ENDIF
907:             THIS.grd_4c_Dados.Column1.SetFocus()
908:         CATCH TO loc_oErro
909:             MsgErro(loc_oErro.Message + CHR(13) + ;
910:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
911:                     "Procedure: " + loc_oErro.Procedure, "Erro em TxtQtdeKeyPress")
912:         ENDTRY
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * TxtQtdeLostFocus - Oculta area de repeticao ao perder foco
917:     *==========================================================================
918:     PROCEDURE TxtQtdeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
919:         LOCAL loc_oErro
920: 
921:         TRY
922:             THIS.lbl_4c_LblQtde.Visible = .F.
923:             THIS.shp_4c_ShpQtde.Visible  = .F.
924:             THIS.txt_4c_Qtde.Visible     = .F.
925:             IF USED("crSigPrFnc")
926:                 SELECT crSigPrFnc
927:                 THIS.grd_4c_Dados.Column1.SetFocus()
928:             ENDIF
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message, "Erro em TxtQtdeLostFocus")
931:         ENDTRY
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * GrdCol1KeyPress - Lookup Column1 (iFors) em SigCdCli por codigo
936:     *==========================================================================
937:     PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
938: 
939:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
940:             RETURN
941:         ENDIF

*-- Linhas 1041 a 1059:
1041:                     loc_cIfors = ALLTRIM(NVL(crFopBuscaCli.iclis, ""))
1042:                     loc_cRClis = ALLTRIM(NVL(crFopBuscaCli.rclis, ""))
1043:                     USE IN crFopBuscaCli
1044:                     SELECT crSigPrFnc
1045:                     REPLACE iFors WITH loc_cIfors, rClis WITH loc_cRClis
1046:                     THIS.grd_4c_Dados.Refresh()
1047:                 ELSE
1048:                     USE IN crFopBuscaCli
1049:                 ENDIF
1050:             ENDIF
1051:         CATCH TO loc_oErro
1052:             MsgErro(loc_oErro.Message + CHR(13) + ;
1053:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1054:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCli")
1055:             IF USED("crFopBuscaCli")
1056:                 USE IN crFopBuscaCli
1057:             ENDIF
1058:         ENDTRY
1059:     ENDPROC

*-- Linhas 1079 a 1097:
1079:                 IF !EOF("crFopBuscaMoe")
1080:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaMoe.CMoes, ""))
1081:                     USE IN crFopBuscaMoe
1082:                     SELECT crSigPrFnc
1083:                     REPLACE MoeVs WITH loc_cCodigo
1084:                     THIS.grd_4c_Dados.Refresh()
1085:                 ELSE
1086:                     USE IN crFopBuscaMoe
1087:                 ENDIF
1088:             ENDIF
1089:         CATCH TO loc_oErro
1090:             MsgErro(loc_oErro.Message + CHR(13) + ;
1091:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1092:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaMoe")
1093:             IF USED("crFopBuscaMoe")
1094:                 USE IN crFopBuscaMoe
1095:             ENDIF
1096:         ENDTRY
1097:     ENDPROC

*-- Linhas 1118 a 1136:
1118:                 IF !EOF("crFopBuscaCol")
1119:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCol.Colecoes, ""))
1120:                     USE IN crFopBuscaCol
1121:                     SELECT crSigPrFnc
1122:                     REPLACE Colecoes WITH loc_cCodigo
1123:                     THIS.grd_4c_Dados.Refresh()
1124:                 ELSE
1125:                     USE IN crFopBuscaCol
1126:                 ENDIF
1127:             ENDIF
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + CHR(13) + ;
1130:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1131:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCol")
1132:             IF USED("crFopBuscaCol")
1133:                 USE IN crFopBuscaCol
1134:             ENDIF
1135:         ENDTRY
1136:     ENDPROC

*-- Linhas 1156 a 1174:
1156:                 IF !EOF("crFopBuscaCor")
1157:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaCor.Cods, ""))
1158:                     USE IN crFopBuscaCor
1159:                     SELECT crSigPrFnc
1160:                     REPLACE CodCors WITH loc_cCodigo
1161:                     THIS.grd_4c_Dados.Refresh()
1162:                 ELSE
1163:                     USE IN crFopBuscaCor
1164:                 ENDIF
1165:             ENDIF
1166:         CATCH TO loc_oErro
1167:             MsgErro(loc_oErro.Message + CHR(13) + ;
1168:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1169:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaCor")
1170:             IF USED("crFopBuscaCor")
1171:                 USE IN crFopBuscaCor
1172:             ENDIF
1173:         ENDTRY
1174:     ENDPROC

*-- Linhas 1230 a 1248:
1230:                 IF !EOF("crFopBuscaTam")
1231:                     loc_cCodigo = ALLTRIM(NVL(crFopBuscaTam.Cods, ""))
1232:                     USE IN crFopBuscaTam
1233:                     SELECT crSigPrFnc
1234:                     REPLACE CodTams WITH loc_cCodigo
1235:                     THIS.grd_4c_Dados.Refresh()
1236:                 ELSE
1237:                     USE IN crFopBuscaTam
1238:                 ENDIF
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message + CHR(13) + ;
1242:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1243:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaTam")
1244:             IF USED("crFopBuscaTam")
1245:                 USE IN crFopBuscaTam
1246:             ENDIF
1247:         ENDTRY
1248:     ENDPROC

*-- Linhas 1475 a 1493:
1475: 
1476:         TRY
1477:             IF USED("crSigPrFnc")
1478:                 SELECT crSigPrFnc
1479:                 ZAP
1480:                 THIS.grd_4c_Dados.Refresh()
1481:             ENDIF
1482:             THIS.this_lHouveIncl = .F.
1483:             THIS.this_lHouveExcl = .F.
1484:         CATCH TO loc_oErro
1485:             MsgErro(loc_oErro.Message + CHR(13) + ;
1486:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1487:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1488:         ENDTRY
1489:     ENDPROC
1490: 
1491:     *==========================================================================
1492:     * FormParaBO - Sincroniza a linha corrente do cursor com as propriedades do BO
1493:     * Neste form OPERACIONAL, a edicao ocorre diretamente nas celulas do grid


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
        LOCAL loc_cIfors, loc_cReffs, loc_cColecoes, loc_nPvens
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

                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_nPvens    = NVL(PVens, 0)

                    SELECT COUNT(*) AS nDupli ;
                        FROM crSigPrFnc a ;
                        WHERE ALLTRIM(a.iFors)    == m.loc_cIfors ;
                          AND ALLTRIM(a.Reffs)    == m.loc_cReffs ;
                          AND ALLTRIM(a.Colecoes) == m.loc_cColecoes ;
                          AND NVL(a.PVens, 0)      = m.loc_nPvens ;
                          AND !DELETED() ;
                        INTO CURSOR crAuxDupli READWRITE

                    SELECT crAuxDupli
                    loc_nDupli = NVL(crAuxDupli.nDupli, 0)
                    USE IN crAuxDupli

                    IF loc_nDupli > 1
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

