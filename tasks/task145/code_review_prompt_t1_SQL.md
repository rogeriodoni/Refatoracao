# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRODNS, LIBRPQS, FATORS, CESTOS, CUNIS, CUNIPS, CMATS, PESO2S, PESOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRODNS, LIBRPQS, FATORS, CESTOS, CUNIS, CUNIPS, CMATS, PESO2S, PESOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRODNS, LIBRPQS, FATORS, CESTOS, CUNIS, CUNIPS, CMATS, PESO2S, PESOS

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
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "tmpDistrib.cdescs"
Select xNensi
Select xNensi
	Insert Into TmpDistrib (Nops, Nenvs, Qtd2s, Peso2s, Pesof2s, CUnis, CMats, CDescs, CGrus, Qtds, Pesos, ;
Select TmpDistrib
	.Column8.ControlSource   = 'TmpDistrib.Marca'
	.Column1.ControlSource   = 'TmpDistrib.NOps'
	.Column2.ControlSource   = 'TmpDistrib.cMats'
	.Column5.ControlSource   = 'TmpDistrib.Qtds'
	.Column4.ControlSource   = 'TmpDistrib.CUnis'
	.Column9.ControlSource   = 'TmpDistrib.Pesos'
	.Column6.ControlSource   = 'TmpDistrib.cUnips'
	.Column3.ControlSource   = 'TmpDistrib.Pesofs'
	.Column7.ControlSource   = 'TmpDistrib.Qtd2s'
	.Column10.ControlSource   = 'TmpDistrib.Peso2s'
	.Column11.ControlSource   = 'TmpDistrib.Pesof2s'
		Select TmpDistrib
			Select TmpDistrib
	Select TmpDistrib
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+TmpDistrib.cunis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
lcSql = [Select cEstos, Fators, QtEqualPs From SigCdUni Where cunis = ']+TmpDistrib.cuniPs+[']
ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni2')
		Select TmpDistrib
		Select TmpDistrib
			Select TmpDistrib
		Select TmpDistrib
			Select TmpDistrib
Select TmpDistrib
	Select xNensi
	If Seek(Str(TmpDistrib.Nops,10)+TmpDistrib.Cmats)
Select xNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp4.prg) - TRECHOS RELEVANTES PARA PASS SQL (1485 linhas total):

*-- Linhas 307 a 325:
307:             .Height           = 417
308:             .ColumnCount      = 11
309:             .RecordMark       = .F.
310:             .DeleteMark       = .F.
311:             .GridLineColor    = RGB(238, 238, 238)
312:             .FontName         = "Verdana"
313:             .FontSize         = 8
314:             .HighlightStyle   = 2
315:             .HighlightBackColor = RGB(255, 255, 255)
316:             .HighlightForeColor = RGB(15, 41, 104)
317:             .RowHeight        = 16
318:             .ScrollBars       = 2
319:             .Visible          = .T.
320:         ENDWITH
321: 
322:         *-- Column1: Industrializacao (ColumnOrder=2, ReadOnly, Courier New, formato numerico)
323:         WITH loc_oGrade.Column1
324:             .ColumnOrder = 2
325:             .Width       = 110

*-- Linhas 542 a 619:
542: 
543:     *--------------------------------------------------------------------------
544:     * CarregarGrade - Vincula grd_4c_Dados ao cursor TmpDistrib
545:     * ColumnCount ANTES de RecordSource; headers REDEFINIDOS apos ControlSource
546:     *--------------------------------------------------------------------------
547:     PROTECTED PROCEDURE CarregarGrade()
548:         LOCAL loc_oGrade, loc_cTitulo
549: 
550:         IF !USED("TmpDistrib") OR VARTYPE(THIS.grd_4c_Dados) != "O"
551:             RETURN
552:         ENDIF
553: 
554:         loc_oGrade = THIS.grd_4c_Dados
555: 
556:         SELECT TmpDistrib
557:         GO TOP
558: 
559:         WITH loc_oGrade
560:             .ColumnCount  = 11
561:             .RecordSource = "TmpDistrib"
562: 
563:             *-- ControlSources (Column8/CheckBox: APOS CurrentControl ja setado em ConfigurarGrade)
564:             .Column8.ControlSource  = "TmpDistrib.Marca"
565:             .Column1.ControlSource  = "TmpDistrib.Nops"
566:             .Column2.ControlSource  = "TmpDistrib.CMats"
567:             .Column5.ControlSource  = "TmpDistrib.Qtds"
568:             .Column4.ControlSource  = "TmpDistrib.CUnis"
569:             .Column9.ControlSource  = "TmpDistrib.Pesos"
570:             .Column6.ControlSource  = "TmpDistrib.cUnips"
571:             .Column3.ControlSource  = "TmpDistrib.Pesofs"
572:             .Column7.ControlSource  = "TmpDistrib.Qtd2s"
573:             .Column10.ControlSource = "TmpDistrib.Peso2s"
574:             .Column11.ControlSource = "TmpDistrib.Pesof2s"
575: 
576:             *-- Caption dinamico da Column1 (vem do form pai quando disponivel)
577:             loc_cTitulo = "Industrializa" + CHR(231) + CHR(227) + "o"
578:             IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
579:                 IF PEMSTATUS(THIS.this_oParentForm, "Titulo", 5)
580:                     loc_cTitulo = ALLTRIM(THIS.this_oParentForm.Titulo)
581:                 ENDIF
582:             ENDIF
583:             .Column1.Header1.Caption = loc_cTitulo
584: 
585:             *-- Redefine cabecalhos obrigatorios apos RecordSource/ControlSource
586:             .Column2.Header1.Caption  = "Componente"
587:             .Column3.Header1.Caption  = "Peso Fabr"
588:             .Column4.Header1.Caption  = "Unid."
589:             .Column5.Header1.Caption  = "Qtde"
590:             .Column6.Header1.Caption  = "Unid."
591:             .Column7.Header1.Caption  = "Qtde"
592:             .Column8.Header1.Caption  = ""
593:             .Column9.Header1.Caption  = "Peso"
594:             .Column10.Header1.Caption = "Peso"
595:             .Column11.Header1.Caption = "Peso Fabr"
596: 
597:             .Refresh()
598:         ENDWITH
599: 
600:         *-- Preenche campos do rodape com dados do primeiro registro
601:         IF RECCOUNT("TmpDistrib") > 0
602:             SELECT TmpDistrib
603:             IF VARTYPE(THIS.txt_4c_Descr) = "O"
604:                 THIS.txt_4c_Descr.ControlSource = "TmpDistrib.CDescs"
605:                 THIS.txt_4c_Descr.Refresh()
606:             ENDIF
607:             IF VARTYPE(THIS.txt_4c_Cor) = "O"
608:                 THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
609:                 THIS.txt_4c_Cor.Refresh()
610:             ENDIF
611:             IF VARTYPE(THIS.txt_4c_Tam) = "O"
612:                 THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
613:                 THIS.txt_4c_Tam.Refresh()
614:             ENDIF
615:         ENDIF
616:     ENDPROC
617: 
618:     *--------------------------------------------------------------------------
619:     * ConfigurarRodape - Labels e TextBoxes do rodape: Descricao, Cor, Tamanho

*-- Linhas 752 a 770:
752:             RETURN
753:         ENDIF
754: 
755:         SELECT TmpDistrib
756: 
757:         *-- Atualiza campos de exibicao do rodape
758:         IF VARTYPE(THIS.txt_4c_Cor) = "O"
759:             THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
760:             THIS.txt_4c_Cor.Refresh()
761:         ENDIF
762:         IF VARTYPE(THIS.txt_4c_Tam) = "O"
763:             THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
764:             THIS.txt_4c_Tam.Refresh()
765:         ENDIF
766:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
767:             THIS.txt_4c_Descr.Refresh()
768:         ENDIF
769: 
770:         *-- Le flags operacionais do form pai (cursores da datasession compartilhada)

*-- Linhas 789 a 807:
789:             THIS.this_oBusinessObject.BuscarUnidade(ALLTRIM(NVL(TmpDistrib.CUnis, "")), ;
790:                                                      "Fators, CEstos", "cursor_4c_LocalUniARC")
791:             IF USED("cursor_4c_LocalUniARC") AND RECCOUNT("cursor_4c_LocalUniARC") > 0
792:                 SELECT cursor_4c_LocalUniARC
793:                 loc_nFators = NVL(Fators, 0)
794:                 loc_cCEstos = ALLTRIM(NVL(CEstos, ""))
795:             ENDIF
796:         ENDIF
797: 
798:         *-- Editabilidade Column7 (Qtd2s): Fators!=0 E PesoBals!=1 E GrOdns!=1 E Marca
799:         THIS.grd_4c_Dados.Column7.ReadOnly = !(loc_nFators <> 0 AND ;
800:                                                 loc_nPesoBals <> 1 AND ;
801:                                                 loc_nGrOdns <> 1 AND ;
802:                                                 loc_lMarca)
803: 
804:         *-- Editabilidade Column10 (Peso2s): cEstos='3' E cUniPs nao vazio E Marca
805:         THIS.grd_4c_Dados.Column10.ReadOnly = !(loc_cCEstos = "3" AND ;
806:                                                  !EMPTY(loc_cUniPs) AND ;
807:                                                  loc_lMarca)

*-- Linhas 820 a 855:
820:         ENDIF
821:         THIS.grd_4c_Dados.Column11.ReadOnly = !loc_lCol11Edit
822: 
823:         SELECT TmpDistrib
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * Col7ValidarQtd - Valida Qtd2s ao pressionar ENTER ou TAB na Column7
828:     * par_nKeyCode, par_nShiftAltCtrl: parametros obrigatorios do KeyPress
829:     *--------------------------------------------------------------------------
830:     PROCEDURE Col7ValidarQtd(par_nKeyCode, par_nShiftAltCtrl)
831:         LOCAL loc_nNovaQtd, loc_nLibrPqs
832: 
833:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
834:             RETURN
835:         ENDIF
836:         IF !USED("TmpDistrib") OR VARTYPE(THIS.this_oBusinessObject) != "O"
837:             RETURN
838:         ENDIF
839: 
840:         SELECT TmpDistrib
841:         loc_nNovaQtd = NVL(THIS.grd_4c_Dados.Column7.Text1.Value, 0)
842:         loc_nLibrPqs = 0
843:         IF USED("CrSigCdOpd")
844:             loc_nLibrPqs = NVL(CrSigCdOpd.LibrPqs, 0)
845:         ENDIF
846: 
847:         IF !THIS.this_oBusinessObject.ValidarQtdeDesagregada(loc_nNovaQtd, loc_nLibrPqs)
848:             THIS.grd_4c_Dados.Column7.Text1.Value = NVL(TmpDistrib.Qtds, 0)
849:             NODEFAULT
850:         ENDIF
851:         THIS.grd_4c_Dados.Refresh()
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * Col10ValidarPeso - Valida Peso2s ao pressionar ENTER ou TAB na Column10

*-- Linhas 865 a 883:
865:             RETURN
866:         ENDIF
867: 
868:         SELECT TmpDistrib
869:         loc_nNovoPeso = NVL(THIS.grd_4c_Dados.Column10.Text1.Value, 0)
870:         loc_nLibrPqs  = 0
871:         IF USED("CrSigCdOpd")
872:             loc_nLibrPqs = NVL(CrSigCdOpd.LibrPqs, 0)
873:         ENDIF
874: 
875:         IF !THIS.this_oBusinessObject.ValidarPesoDesagregado(loc_nNovoPeso, loc_nLibrPqs)
876:             THIS.grd_4c_Dados.Column10.Text1.Value = NVL(TmpDistrib.Pesos, 0)
877:             NODEFAULT
878:         ENDIF
879:         THIS.grd_4c_Dados.Refresh()
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     * Col11ValidarPesoFabr - Valida Pesof2s ao pressionar ENTER ou TAB na Column11

*-- Linhas 893 a 911:
893:             RETURN
894:         ENDIF
895: 
896:         SELECT TmpDistrib
897:         loc_nNovoPesoF = NVL(THIS.grd_4c_Dados.Column11.Text1.Value, 0)
898:         loc_nLibrPqs   = 0
899:         loc_nPesoBals  = 0
900:         IF USED("CrSigCdOpd")
901:             loc_nLibrPqs  = NVL(CrSigCdOpd.LibrPqs,  0)
902:             loc_nPesoBals = NVL(CrSigCdOpd.PesoBals,  0)
903:         ENDIF
904: 
905:         IF !THIS.this_oBusinessObject.ValidarPesoFabrDesagregado(loc_nNovoPesoF, loc_nLibrPqs, loc_nPesoBals)
906:             THIS.grd_4c_Dados.Column11.Text1.Value = NVL(TmpDistrib.Pesofs, 0)
907:             NODEFAULT
908:         ELSE
909:             IF loc_nPesoBals = 1
910:                 KEYBOARD "{DNARROW}"
911:             ENDIF

*-- Linhas 962 a 1020:
962:             .ReadOnly          = .T.
963:             .Value             = ""
964:             IF USED("tmpnens")
965:                 .ControlSource = "tmpnens.emps"
966:             ENDIF
967:             .Visible           = .T.
968:         ENDWITH
969: 
970:         *-- GetOperacao: descricao da operacao, Left=135, Top=8, Width=156 (ReadOnly)
971:         loc_oContainer.AddObject("txt_4c_Operacao", "TextBox")
972:         WITH loc_oContainer.txt_4c_Operacao
973:             .FontName          = "Tahoma"
974:             .FontSize          = 8
975:             .Left              = 135
976:             .Top               = 8
977:             .Width             = 156
978:             .Height            = 23
979:             .ForeColor         = RGB(0, 0, 0)
980:             .DisabledBackColor = RGB(255, 255, 255)
981:             .ReadOnly          = .T.
982:             .Value             = ""
983:             IF USED("tmpnens")
984:                 .ControlSource = "tmpnens.dopps"
985:             ENDIF
986:             .Visible           = .T.
987:         ENDWITH
988: 
989:         *-- GetCodigo: numero da operacao (formato numerico), Left=293, Top=8, Width=81 (ReadOnly)
990:         loc_oContainer.AddObject("txt_4c_Codigo", "TextBox")
991:         WITH loc_oContainer.txt_4c_Codigo
992:             .FontName          = "Tahoma"
993:             .FontSize          = 8
994:             .Format            = "L"
995:             .InputMask         = "9999999999"
996:             .Left              = 293
997:             .Top               = 8
998:             .Width             = 81
999:             .Height            = 23
1000:             .ForeColor         = RGB(0, 0, 0)
1001:             .DisabledBackColor = RGB(255, 255, 255)
1002:             .ReadOnly          = .T.
1003:             .Value             = 0
1004:             IF USED("tmpnens")
1005:                 .ControlSource = "tmpnens.numps"
1006:             ENDIF
1007:             .Visible           = .T.
1008:         ENDWITH
1009:     ENDPROC
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * ConfigurarShapeDecorativo - Shape decorativo no canto superior direito
1013:     * Original: Shape1 (Top=10, Left=897, Width=90, Height=110, BackStyle=0, BorderStyle=0)
1014:     *--------------------------------------------------------------------------
1015:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
1016:         THIS.AddObject("shp_4c_Decorativo", "Shape")
1017:         WITH THIS.shp_4c_Decorativo
1018:             .Top         = 10
1019:             .Left        = 897
1020:             .Width       = 90

*-- Linhas 1042 a 1060:
1042: 
1043:         *-- Restaura ordem no cursor de producao
1044:         IF USED("xNensi")
1045:             SELECT xNensi
1046:             SET ORDER TO Editar
1047:         ENDIF
1048: 
1049:         *-- Reabilita form pai (Destroy tambem reabilita, mas feito aqui para garantir)
1050:         IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
1051:             THIS.this_oParentForm.Enabled = .T.
1052:         ENDIF
1053: 
1054:         THIS.Release()
1055:     ENDPROC
1056: 
1057:     *--------------------------------------------------------------------------
1058:     * ConfigurarBalanca - Cria e configura o objeto de balanca serial
1059:     * Parametros lidos do cursor crSigCdPam (configuracao global do sistema)
1060:     * Falha graciosamente se a classe fwbalanca nao estiver disponivel

*-- Linhas 1097 a 1157:
1097:             RETURN
1098:         ENDIF
1099: 
1100:         SELECT TmpDistrib
1101:         SCAN
1102:             REPLACE Marca WITH .T.
1103:         ENDSCAN
1104:         GO TOP
1105: 
1106:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1107:             THIS.grd_4c_Dados.Refresh()
1108:         ENDIF
1109: 
1110:         *-- Atualiza editabilidade de colunas conforme registro corrente
1111:         THIS.GradeAfterRowColChange(1)
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * BtnAlterarClick - Inverte o flag Marca do registro corrente
1116:     * Form OPERACIONAL: alterar estado do registro selecionado no grid
1117:     *--------------------------------------------------------------------------
1118:     PROCEDURE BtnAlterarClick()
1119:         IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
1120:             RETURN
1121:         ENDIF
1122: 
1123:         SELECT TmpDistrib
1124:         REPLACE Marca WITH !NVL(TmpDistrib.Marca, .F.)
1125: 
1126:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1127:             THIS.grd_4c_Dados.Refresh()
1128:         ENDIF
1129: 
1130:         THIS.GradeAfterRowColChange(1)
1131:     ENDPROC
1132: 
1133:     *--------------------------------------------------------------------------
1134:     * BtnVisualizarClick - Refresh do grid e do rodape (visualizar registro corrente)
1135:     * Form OPERACIONAL: atualiza exibicao dos dados sem alterar estado
1136:     *--------------------------------------------------------------------------
1137:     PROCEDURE BtnVisualizarClick()
1138:         IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
1139:             RETURN
1140:         ENDIF
1141: 
1142:         SELECT TmpDistrib
1143: 
1144:         IF VARTYPE(THIS.txt_4c_Cor) = "O"
1145:             THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
1146:             THIS.txt_4c_Cor.Refresh()
1147:         ENDIF
1148:         IF VARTYPE(THIS.txt_4c_Tam) = "O"
1149:             THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
1150:             THIS.txt_4c_Tam.Refresh()
1151:         ENDIF
1152:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
1153:             THIS.txt_4c_Descr.Refresh()
1154:         ENDIF
1155:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1156:             THIS.grd_4c_Dados.Refresh()
1157:         ENDIF

*-- Linhas 1166 a 1184:
1166:             RETURN
1167:         ENDIF
1168: 
1169:         SELECT TmpDistrib
1170:         SCAN
1171:             REPLACE Marca   WITH .F., ;
1172:                     Qtd2s   WITH 0, ;
1173:                     Peso2s  WITH 0, ;
1174:                     Pesof2s WITH 0
1175:         ENDSCAN
1176:         GO TOP
1177: 
1178:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1179:             THIS.grd_4c_Dados.Refresh()
1180:         ENDIF
1181: 
1182:         THIS.GradeAfterRowColChange(1)
1183:     ENDPROC
1184: 

*-- Linhas 1248 a 1330:
1248:             RETURN
1249:         ENDIF
1250: 
1251:         SELECT TmpDistrib
1252: 
1253:         THIS.this_oBalanca.Ativa(THIS.grd_4c_Dados.Column11.Text1)
1254: 
1255:         loc_nValorPeso = NVL(THIS.grd_4c_Dados.Column11.Text1.Value, 0)
1256:         IF loc_nValorPeso <> 0 AND LASTKEY() <> 27 AND !THIS.this_oBalanca.TempoEsgotado
1257:             THIS.Col11ValidarPesoFabr(13, 0)
1258:             RETURN
1259:         ENDIF
1260: 
1261:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1262:             THIS.this_oBusinessObject.BuscarUnidade(;
1263:                 ALLTRIM(NVL(TmpDistrib.CUnis,  "")), "Fators, QtEqualPs, CEstos", "LocalUni")
1264:             THIS.this_oBusinessObject.BuscarUnidade(;
1265:                 ALLTRIM(NVL(TmpDistrib.cUniPs, "")), "Fators, QtEqualPs, CEstos", "LocalUni2")
1266: 
1267:             IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
1268:                 SELECT LocalUni
1269:                 loc_nFators    = NVL(Fators, 0)
1270:                 loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")
1271:                 loc_cCEstos    = TratarNulo(CEstos, "C")
1272: 
1273:                 THIS.this_oBusinessObject.BuscarProduto(;
1274:                     ALLTRIM(NVL(TmpDistrib.CMats, "")), "Cgrus", "CrTmpPro")
1275: 
1276:                 IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
1277:                     SELECT CrTmpPro
1278:                     loc_cCGrus = TratarNulo(Cgrus, "C")
1279:                     THIS.this_oBusinessObject.BuscarGrupo(;
1280:                         loc_cCGrus, "TpMovs", "CrTmpGru")
1281: 
1282:                     IF USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
1283:                         SELECT CrTmpGru
1284:                         loc_nTpMovs = NVL(TpMovs, 0)
1285: 
1286:                         SELECT TmpDistrib
1287:                         loc_nDivisor = loc_nValorPeso
1288: 
1289:                         IF (loc_nTpMovs <> 1 AND loc_nFators <> 1) OR ;
1290:                            UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
1291:                             IF loc_nFators <> 0
1292:                                 REPLACE Qtd2s WITH loc_nDivisor / IIF(EMPTY(loc_nFators), 1, loc_nFators)
1293:                             ENDIF
1294:                         ELSE
1295:                             IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
1296:                                 SELECT LocalUni2
1297:                                 loc_nFators2    = NVL(Fators, 0)
1298:                                 loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")
1299: 
1300:                                 SELECT TmpDistrib
1301:                                 IF ALLTRIM(loc_cCEstos) = "3" AND ;
1302:                                    !EMPTY(ALLTRIM(TmpDistrib.cUniPs)) AND ;
1303:                                    ((loc_nTpMovs <> 1 AND loc_nFators2 <> 1) OR ;
1304:                                     UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S")
1305:                                     IF loc_nFators2 <> 0
1306:                                         REPLACE Peso2s WITH loc_nDivisor / IIF(EMPTY(loc_nFators2), 1, loc_nFators2)
1307:                                     ENDIF
1308:                                 ENDIF
1309:                             ENDIF
1310:                         ENDIF
1311:                     ENDIF
1312:                 ENDIF
1313:             ENDIF
1314: 
1315:             SELECT TmpDistrib
1316:         ENDIF
1317: 
1318:         THIS.grd_4c_Dados.Refresh()
1319:         KEYBOARD "{DNARROW}"
1320:     ENDPROC
1321: 
1322:     *--------------------------------------------------------------------------
1323:     * CarregarLista - Atualiza o grid a partir do cursor TmpDistrib
1324:     * Em forms OPERACIONAIS equivale a recarregar a grade de dados
1325:     *--------------------------------------------------------------------------
1326:     PROCEDURE CarregarLista()
1327:         THIS.CarregarGrade()
1328:     ENDPROC
1329: 
1330:     *--------------------------------------------------------------------------

*-- Linhas 1350 a 1368:
1350:     *--------------------------------------------------------------------------
1351:     PROCEDURE BtnEncerrarClick()
1352:         IF USED("xNensi")
1353:             SELECT xNensi
1354:             SET ORDER TO Editar
1355:             IF THIS.this_nRecnoAnt > 0 AND RECCOUNT("xNensi") >= THIS.this_nRecnoAnt
1356:                 GO THIS.this_nRecnoAnt IN xNensi
1357:             ENDIF
1358:         ENDIF
1359: 
1360:         IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
1361:             THIS.this_oParentForm.Enabled = .T.
1362:         ENDIF
1363: 
1364:         THIS.Release()
1365:     ENDPROC
1366: 
1367:     *--------------------------------------------------------------------------
1368:     * BtnSalvarClick - Aplica desagregacao (equivalente ao BtnOkClick)

*-- Linhas 1403 a 1421:
1403:             RETURN
1404:         ENDIF
1405: 
1406:         SELECT TmpDistrib
1407:         IF RECCOUNT("TmpDistrib") > 0
1408:             GO TOP
1409:         ENDIF
1410: 
1411:         IF VARTYPE(THIS.txt_4c_Cor) = "O"
1412:             THIS.txt_4c_Cor.Value = ALLTRIM(NVL(TmpDistrib.CodCors, ""))
1413:             THIS.txt_4c_Cor.Refresh()
1414:         ENDIF
1415:         IF VARTYPE(THIS.txt_4c_Tam) = "O"
1416:             THIS.txt_4c_Tam.Value = ALLTRIM(NVL(TmpDistrib.CodTams, ""))
1417:             THIS.txt_4c_Tam.Refresh()
1418:         ENDIF
1419:         IF VARTYPE(THIS.txt_4c_Descr) = "O"
1420:             THIS.txt_4c_Descr.Refresh()
1421:         ENDIF

*-- Linhas 1446 a 1464:
1446:             RETURN
1447:         ENDIF
1448: 
1449:         SELECT TmpDistrib
1450:         SCAN
1451:             REPLACE Marca   WITH .F., ;
1452:                     Qtd2s   WITH 0,   ;
1453:                     Peso2s  WITH 0,   ;
1454:                     Pesof2s WITH 0
1455:         ENDSCAN
1456:         GO TOP
1457: 
1458:         *-- Limpa campos de exibicao do rodape
1459:         IF VARTYPE(THIS.txt_4c_Cor) = "O"
1460:             THIS.txt_4c_Cor.Value = ""
1461:             THIS.txt_4c_Cor.Refresh()
1462:         ENDIF
1463:         IF VARTYPE(THIS.txt_4c_Tam) = "O"
1464:             THIS.txt_4c_Tam.Value = ""


### BO (C:\4c\projeto\app\classes\SigPdMp4BO.prg):
*-------------------------------------------------------------------------------
* SigPdMp4BO.prg - Business Object: Desagregar Componentes Agregados
* Herda de BusinessBase
* OPERACIONAL: Desagrega itens do cursor xNensi (producao) via TmpDistrib
*-------------------------------------------------------------------------------

DEFINE CLASS SigPdMp4BO AS BusinessBase

    *-- Dados do componente (campos do cursor TmpDistrib)
    this_lMarca       = .F.
    this_nNops        = 0
    this_nNenvs       = 0
    this_cCodPds      = ""
    this_cCMats       = ""
    this_cCUnis       = ""
    this_nQtds        = 0
    this_nPesos       = 0
    this_nPesofs      = 0
    this_cCDescs      = ""
    this_cCGrus       = ""
    this_cTpOps       = ""
    this_cCUniPs      = ""
    this_nQtd2s       = 0
    this_nPeso2s      = 0
    this_nPesof2s     = 0
    this_cCodCors     = ""
    this_cCodTams     = ""

    *-- Contexto do pedido de producao (xNensi)
    this_nRecnoAnt    = 0

    *-- Parametros operacionais lidos de crSigCdOpd
    this_nLibrPqs     = 0
    this_nGrOdns      = 0
    this_nPesoBals    = 0

    *-- Parametros de balanca/unidade padrao lidos de crSigCdPam
    this_cCUnipPads   = ""

    *-- Fatores da unidade principal (SigCdUni - LocalUni)
    this_nFatorsUni   = 0
    this_cQtEqualPs   = ""
    this_cCEstosUni   = ""

    *-- Fatores da unidade secundaria (SigCdUni - LocalUni2)
    this_nFatorsUni2  = 0
    this_cQtEqualPs2  = ""
    this_cCEstosUni2  = ""

    *-- Tipo de movimento do grupo (SigCdGrp - CrTmpGru)
    this_nTpMovs      = 0

    *-- Grupo do componente (SigCdPro - CrTmpPro)
    this_cCGrusPro    = ""

    *-- Peso medio do componente (SigCdPro - CrTmpPro.pesoms)
    this_nPesoMs      = 0

    *-- Alias do cursor fonte (xNensi - producao) a ser desagregado
    this_cAliasFonte  = ""

    *---------------------------------------------------------------------------
    * Init - Configura tabela e chave
    * OPERACIONAL: this_cTabela usado apenas para auditoria (alvo logico = xNensi)
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensi"
        THIS.this_cCampoChave = "Nops"
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna numero da operacao como identificador
    *---------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor TmpDistrib
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lMarca    = NVL(Marca, .F.)
            THIS.this_nNops     = NVL(Nops, 0)
            THIS.this_nNenvs    = NVL(Nenvs, 0)
            THIS.this_cCodPds   = TratarNulo(CodPds, "C")
            THIS.this_cCMats    = TratarNulo(CMats, "C")
            THIS.this_cCUnis    = TratarNulo(CUnis, "C")
            THIS.this_nQtds     = NVL(Qtds, 0)
            THIS.this_nPesos    = NVL(Pesos, 0)
            THIS.this_nPesofs   = NVL(Pesofs, 0)
            THIS.this_cCDescs   = TratarNulo(CDescs, "C")
            THIS.this_cCGrus    = TratarNulo(CGrus, "C")
            THIS.this_cTpOps    = TratarNulo(TpOps, "C")
            THIS.this_cCUniPs   = TratarNulo(cUniPs, "C")
            THIS.this_nQtd2s    = NVL(Qtd2s, 0)
            THIS.this_nPeso2s   = NVL(Peso2s, 0)
            THIS.this_nPesof2s  = NVL(Pesof2s, 0)
            THIS.this_cCodCors  = TratarNulo(CodCors, "C")
            THIS.this_cCodTams  = TratarNulo(CodTams, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarTmpDistrib - Cria cursor TmpDistrib a partir do cursor fonte
    * par_cAliasFonte: alias do cursor de producao (xNensi no legado)
    * Estrutura TmpDistrib identica ao legado (Create Cursor do Init original)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarTmpDistrib(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos
        LOCAL loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus, loc_cCUniPs
        LOCAL loc_cCodCors, loc_cCodTams

        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                IF USED("TmpDistrib")
                    USE IN TmpDistrib
                ENDIF

                SET NULL ON
                CREATE CURSOR TmpDistrib (;
                    Marca    L        NULL,;
                    Nops     N(10,0)  NULL,;
                    Nenvs    N(10,0)  NULL,;
                    CodPds   C(10)    NULL,;
                    CMats    C(14)    NULL,;
                    CUnis    C(3)     NULL,;
                    Qtds     N(10,3)  NULL,;
                    Pesos    N(10,3)  NULL,;
                    Pesofs   N(10,3)  NULL,;
                    CDescs   C(40)    NULL,;
                    CGrus    C(3)     NULL,;
                    TpOps    C(15)    NULL,;
                    cUniPs   C(3)     NULL,;
                    Qtd2s    N(10,3)  NULL,;
                    Peso2s   N(10,3)  NULL,;
                    Pesof2s  N(10,3)  NULL,;
                    CodCors  C(4)     NULL,;
                    CodTams  C(4)     NULL)
                SET NULL OFF

                SELECT (par_cAliasFonte)
                SET ORDER TO NopCMat
                GO TOP

                SCAN
                    IF Visivel
                        LOOP
                    ENDIF

                    loc_nNops    = Nops
                    loc_nNenvs   = Nenvs
                    loc_nQtds    = Qtds
                    loc_nPeso2s  = Peso2s
                    loc_nPesos   = Pesos
                    loc_cCUnis   = CUnis
                    loc_cCMats   = CMats
                    loc_cCDescs  = CDescs
                    loc_cCGrus   = CGrus
                    loc_cCUniPs  = cUniPs
                    loc_cCodCors = CodCors
                    loc_cCodTams = CodTams

                    INSERT INTO TmpDistrib (;
                        Nops, Nenvs, Qtd2s, Peso2s, Pesof2s,;
                        CUnis, CMats, CDescs, CGrus, Qtds, Pesos,;
                        Pesofs, cUniPs, CodCors, CodTams) ;
                    VALUES (;
                        loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus,;
                        loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUniPs, loc_cCodCors, loc_cCodTams)

                    SELECT (par_cAliasFonte)
                ENDSCAN

                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarUnidade - Consulta SigCdUni via SQL e armazena em cursor local
    * par_cCUnis         : codigo da unidade
    * par_cCampos        : lista de campos (ex: "Fators, QtEqualPs, CEstos")
    * par_cCursorDestino : nome do cursor local de destino
    *---------------------------------------------------------------------------
    PROCEDURE BuscarUnidade(par_cCUnis, par_cCampos, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCUnis))
                loc_lSucesso = .F.
            ELSE
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampos + ;
                           " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

                IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        SELECT (par_cCursorDestino)
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarProduto - Consulta SigCdPro via SQL e armazena em cursor local
    * par_cCPros         : codigo do produto/componente
    * par_cCampos        : lista de campos (ex: "Cgrus" ou "pesoms")
    * par_cCursorDestino : nome do cursor local de destino
    *---------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCPros, par_cCampos, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCPros))
                loc_lSucesso = .F.
            ELSE
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampos + ;
                           " FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros))

                IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        SELECT (par_cCursorDestino)
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarGrupo - Consulta SigCdGrp via SQL e armazena em cursor local
    * par_cCGrus         : codigo do grupo
    * par_cCampos        : lista de campos (ex: "TpMovs")
    * par_cCursorDestino : nome do cursor local de destino
    *---------------------------------------------------------------------------
    PROCEDURE BuscarGrupo(par_cCGrus, par_cCampos, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCGrus))
                loc_lSucesso = .F.
            ELSE
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampos + ;
                           " FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(par_cCGrus))

                IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        SELECT (par_cCursorDestino)
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarQtdeDesagregada - Valida e recalcula apos alteracao de Qtd2s (Col 7)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovaQtd : novo valor de Qtd2s digitado pelo usuario
    * par_nLibrPqs : flag LibrPqs do crSigCdOpd (1=permite qtd >= original)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s ou TmpDistrib.Pesos
    *---------------------------------------------------------------------------
    FUNCTION ValidarQtdeDesagregada(par_nNovaQtd, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs, loc_cCGrus, loc_nTpMovs, loc_nPesoMs

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovaQtd >= TmpDistrib.Qtds AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Qtde tem que ser menor do que a original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis, "Fators, QtEqualPs, CEstos", "LocalUni")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators <> 0
                            THIS.BuscarProduto(TmpDistrib.CMats, "Cgrus", "CrTmpPro")

                            IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
                                SELECT CrTmpPro
                                loc_cCGrus = TratarNulo(Cgrus, "C")
                                THIS.BuscarGrupo(loc_cCGrus, "TpMovs", "CrTmpGru")

                                IF USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
                                    SELECT CrTmpGru
                                    loc_nTpMovs = NVL(TpMovs, 0)

                                    IF (loc_nTpMovs <> 1 AND loc_nFators <> 1) OR ;
                                       UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                        SELECT TmpDistrib
                                        REPLACE Pesof2s WITH par_nNovaQtd * loc_nFators
                                    ELSE
                                        IF loc_nFators = 1
                                            THIS.BuscarProduto(TmpDistrib.CMats, "pesoms", "CrTmpPro")
                                            IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
                                                SELECT CrTmpPro
                                                loc_nPesoMs = NVL(pesoms, 0)
                                                SELECT TmpDistrib
                                                REPLACE Pesof2s WITH par_nNovaQtd * loc_nPesoMs
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            THIS.BuscarProduto(TmpDistrib.CMats, "pesoms", "CrTmpPro")
                            IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
                                SELECT CrTmpPro
                                loc_nPesoMs = NVL(pesoms, 0)
                                SELECT TmpDistrib
                                REPLACE Pesos WITH par_nNovaQtd * loc_nPesoMs
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoDesagregado - Valida e recalcula apos alteracao de Peso2s (Col 10)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPeso : novo valor de Peso2s digitado pelo usuario
    * par_nLibrPqs  : flag LibrPqs do crSigCdOpd
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoDesagregado(par_nNovoPeso, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators2, loc_cQtEqualPs2, loc_cCGrus, loc_nTpMovs

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPeso >= TmpDistrib.Pesos AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, ;
                                       "CEstos, Fators, QtEqualPs", "LocalUni2")

                    IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                        SELECT LocalUni2
                        loc_nFators2    = NVL(Fators, 0)
                        loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators2 <> 0
                            THIS.BuscarProduto(TmpDistrib.CMats, "Cgrus", "CrTmpPro")

                            IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
                                SELECT CrTmpPro
                                loc_cCGrus = TratarNulo(Cgrus, "C")
                                THIS.BuscarGrupo(loc_cCGrus, "TpMovs", "CrTmpGru")

                                IF USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
                                    SELECT CrTmpGru
                                    loc_nTpMovs = NVL(TpMovs, 0)

                                    IF (loc_nTpMovs <> 1 AND loc_nFators2 <> 1) OR ;
                                       UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S"
                                        SELECT TmpDistrib
                                        REPLACE Pesof2s WITH par_nNovoPeso * loc_nFators2
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoFabrDesagregado - Valida e recalcula apos alt. Pesof2s (Col 11)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPesoFabr : novo valor de Pesof2s digitado
    * par_nLibrPqs      : flag LibrPqs do crSigCdOpd
    * par_nPesoBals     : flag PesoBals do crSigCdOpd (1=controle por balanca)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Qtd2s ou TmpDistrib.Peso2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoFabrDesagregado(par_nNovoPesoFabr, par_nLibrPqs, par_nPesoBals)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs, loc_cCEstos
        LOCAL loc_nFators2, loc_cQtEqualPs2
        LOCAL loc_cCGrus, loc_nTpMovs, loc_nDivisor

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPesoFabr >= TmpDistrib.Pesofs AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso Fabr tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis,  "Fators, QtEqualPs, CEstos", "LocalUni")
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, "Fators, QtEqualPs, CEstos", "LocalUni2")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")
                        loc_cCEstos    = TratarNulo(CEstos, "C")

                        IF loc_nFators <> 0
                            THIS.BuscarProduto(TmpDistrib.CMats, "Cgrus", "CrTmpPro")

                            IF USED("CrTmpPro") AND RECCOUNT("CrTmpPro") > 0
                                SELECT CrTmpPro
                                loc_cCGrus = TratarNulo(Cgrus, "C")
                                THIS.BuscarGrupo(loc_cCGrus, "TpMovs", "CrTmpGru")

                                IF USED("CrTmpGru") AND RECCOUNT("CrTmpGru") > 0
                                    SELECT CrTmpGru
                                    loc_nTpMovs = NVL(TpMovs, 0)

                                    IF (loc_nTpMovs <> 1 AND loc_nFators <> 1) OR ;
                                       UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                        loc_nDivisor = IIF(EMPTY(loc_nFators), 1, loc_nFators)
                                        SELECT TmpDistrib
                                        REPLACE Qtd2s WITH par_nNovoPesoFabr / loc_nDivisor
                                    ELSE
                                        IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                                            SELECT LocalUni2
                                            loc_nFators2    = NVL(Fators, 0)
                                            loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                                            SELECT TmpDistrib
                                            IF ALLTRIM(loc_cCEstos) = "3" AND ;
                                               !EMPTY(ALLTRIM(TmpDistrib.cUniPs)) AND ;
                                               ((loc_nTpMovs <> 1 AND loc_nFators2 <> 1) OR ;
                                                UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S")
                                                loc_nDivisor = IIF(EMPTY(loc_nFators2), 1, loc_nFators2)
                                                REPLACE Peso2s WITH par_nNovoPesoFabr / loc_nDivisor
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT TmpDistrib
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * SalvarDesagregacao - Aplica desagregacao: atualiza cursor fonte (xNensi)
    * com base nos valores parciais definidos em TmpDistrib (logica do ok.Click)
    * par_cAliasFonte: alias do cursor de producao a ser atualizado
    * Retorna .T. se sucesso
    * Efeito: marca linhas como Visivel=.T., Rateio=3; atualiza qtds/pesos restantes
    *---------------------------------------------------------------------------
    FUNCTION SalvarDesagregacao(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_cCMats
        LOCAL loc_nQtds, loc_nPesos, loc_nPesofs
        LOCAL loc_nQtd2s, loc_nPeso2s, loc_nPesof2s
        LOCAL loc_lMarca

        loc_lSucesso = .F.

        TRY
            IF !USED("TmpDistrib") OR !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                SELECT TmpDistrib
                GO TOP

                SCAN
                    loc_nNops    = TmpDistrib.Nops
                    loc_cCMats   = TmpDistrib.CMats
                    loc_nQtds    = TmpDistrib.Qtds
                    loc_nPesos   = TmpDistrib.Pesos
                    loc_nPesofs  = TmpDistrib.Pesofs
                    loc_nQtd2s   = TmpDistrib.Qtd2s
                    loc_nPeso2s  = TmpDistrib.Peso2s
                    loc_nPesof2s = TmpDistrib.Pesof2s
                    loc_lMarca   = TmpDistrib.Marca

                    SELECT (par_cAliasFonte)
                    SET ORDER TO NopCmat

                    IF SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        SCAN WHILE Nops = loc_nNops AND CMats = loc_cCMats
                            IF Qtds = loc_nQtds AND Peso2s = loc_nPesos AND Pesos = loc_nPesofs
                                REPLACE Visivel WITH .T., Rateio WITH 3
                                IF loc_lMarca
                                    REPLACE Pesos  WITH loc_nPesofs  - loc_nPesof2s, ;
                                            Qtds   WITH loc_nQtds    - loc_nQtd2s, ;
                                            Peso2s WITH loc_nPesos   - loc_nPeso2s
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT TmpDistrib
                ENDSCAN

                SELECT (par_cAliasFonte)
                SET ORDER TO Editar

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * Inserir - Aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: nao existe INSERT em tabela; persistencia eh via cursor xNensi.
    * Pre-condicao: THIS.this_cAliasFonte preenchido pelo Form antes do Salvar().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("DESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Re-aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: equivale a Inserir em forms de movimentacao sobre cursor.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("REDESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao re-aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

