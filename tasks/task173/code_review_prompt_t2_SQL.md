# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IDIOMA, OBSCOMPRAS, DPROS

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
  Column1.ControlSource = "crProdutos.CPros"
  Column2.ControlSource = "crProdutos.Portugues"
  Column3.ControlSource = "crProdutos.Traduzido"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
Select crProdutos
	oProg.Update(.t.)
	lcQuery = [Update SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Update SigCdPro)])
	lcQuery = [Delete From SigPrPrt Where CPros = '] + lcPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Delete SigPrPrt)], 10000)
lcQuery = [Select CPros ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPrdTraduz]) < 1)
Select crPrdTraduz
	oProg.Update(.t.)
		lcQuery = [Select a.CPros, a.CGrus, a.CodCors, b.DGrus, b.Mercs, b.MontaGrDs, c.Descs ] + ;
				    [From SigCdPro a ] + ;
				    [Left Join SigCdGrp b On b.CGrus = a.CGrus ] + ;
				    [Left Join SigCdCor c On c.Cods = a.CodCors ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select crSigCdDic
			Insert Into crProdutos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
Select crProdutos
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1299 linhas total):

*-- Linhas 72 a 90:
72: 
73:             *-- Cursor placeholder de produtos (sera populado pelo BtnSelecionarClick)
74:             SET NULL ON
75:             CREATE CURSOR cursor_4c_Produtos ;
76:                 (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
77:                  DscCompras M(4) NULL, ObsCompras M(4) NULL)
78:             SET NULL OFF
79: 
80:             *-- Configuracao base do form (Picture, dimensoes, Caption reforcados)
81:             *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
82:             *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
83:             THIS.ConfigurarPageFrame()
84: 
85:             *-- Configurar controles visuais
86:             THIS.ConfigurarCabecalho()
87:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89:             THIS.ConfigurarPaginaLista()
90:             THIS.ConfigurarPaginaDados()

*-- Linhas 356 a 374:
356:             .Height        = 24
357:             .MaxLength     = 14
358:             .Value         = ""
359:             .SelectOnEntry = .T.
360:             .Visible       = .T.
361:         ENDWITH
362: 
363:         *-- Label "ate" - original Left=345, Top=138
364:         THIS.AddObject("lbl_4c_Ate", "Label")
365:         WITH THIS.lbl_4c_Ate
366:             .AutoSize  = .F.
367:             .Width     = 30
368:             .Height    = 20
369:             .Left      = 431
370:             .Top       = 140
371:             .Caption   = "at" + CHR(233)
372:             .FontBold  = .T.
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8

*-- Linhas 388 a 406:
388:             .Height        = 24
389:             .MaxLength     = 14
390:             .Value         = ""
391:             .SelectOnEntry = .T.
392:             .Visible       = .T.
393:         ENDWITH
394: 
395:         *-- Label "Grupo de Produto :" - original Left=505, Top=138
396:         THIS.AddObject("lbl_4c_Grupo", "Label")
397:         WITH THIS.lbl_4c_Grupo
398:             .AutoSize  = .F.
399:             .Width     = 130
400:             .Height    = 20
401:             .Left      = 631
402:             .Top       = 140
403:             .Caption   = "Grupo de Produto :"
404:             .FontBold  = .T.
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8

*-- Linhas 420 a 501:
420:             .Height        = 24
421:             .MaxLength     = 3
422:             .Value         = ""
423:             .SelectOnEntry = .T.
424:             .Visible       = .T.
425:         ENDWITH
426:     ENDPROC
427: 
428:     *==========================================================================
429:     PROTECTED PROCEDURE ConfigurarGrade()
430:     *==========================================================================
431:         THIS.AddObject("grd_4c_Dados", "Grid")
432:         WITH THIS.grd_4c_Dados
433:             .Top                = 164
434:             .Left               = 19
435:             .Width              = 961
436:             .Height             = 343
437:             .ColumnCount        = 3
438:             .FontSize           = 8
439:             .FontName           = "Verdana"
440:             .AllowHeaderSizing  = .F.
441:             .AllowRowSizing     = .F.
442:             .DeleteMark         = .F.
443:             .RecordMark         = .F.
444:             .HeaderHeight       = 17
445:             .RowHeight          = 17
446:             .ScrollBars         = 2
447:             .ReadOnly           = .T.
448:             .HighlightStyle     = 2
449:             .HighlightBackColor = RGB(255,255,255)
450:             .HighlightForeColor = RGB(15,41,104)
451:             .GridLineColor      = RGB(238,238,238)
452:             .RecordSource       = "cursor_4c_Produtos"
453:             .Column1.ControlSource = "cursor_4c_Produtos.CPros"
454:             .Column2.ControlSource = "cursor_4c_Produtos.Portugues"
455:             .Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
456: 
457:             WITH .Column1
458:                 .Width         = 135
459:                 .FontSize      = 8
460:                 .ControlSource = "cursor_4c_Produtos.CPros"
461:                 .ReadOnly      = .T.
462:                 WITH .Header1
463:                     .Caption   = "C" + CHR(243) + "digo"
464:                     .FontName  = "Tahoma"
465:                     .FontSize  = 8
466:                     .Alignment = 2
467:                 ENDWITH
468:             ENDWITH
469: 
470:             WITH .Column2
471:                 .Width         = 363
472:                 .FontSize      = 8
473:                 .ControlSource = "cursor_4c_Produtos.Portugues"
474:                 .ReadOnly      = .T.
475:                 WITH .Header1
476:                     .Caption   = "Portugu" + CHR(234) + "s"
477:                     .FontName  = "Tahoma"
478:                     .FontSize  = 8
479:                     .Alignment = 2
480:                 ENDWITH
481:             ENDWITH
482: 
483:             WITH .Column3
484:                 .Width         = 427
485:                 .FontSize      = 8
486:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
487:                 .ReadOnly      = .T.
488:                 WITH .Header1
489:                     .Caption   = "Traduzido"
490:                     .FontName  = "Tahoma"
491:                     .FontSize  = 8
492:                     .Alignment = 2
493:                 ENDWITH
494:             ENDWITH
495: 
496:             .Visible = .T.
497:         ENDWITH
498:     ENDPROC
499: 
500:     *==========================================================================
501:     PROCEDURE VincularEventos()

*-- Linhas 587 a 631:
587:         ENDIF
588: 
589:         *-- Tenta match exato primeiro
590:         loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE RTRIM(CPros) = " + ;
591:                    EscaparSQL(loc_cVal)
592:         IF USED("cursor_4c_BuscaProTmp")
593:             USE IN cursor_4c_BuscaProTmp
594:         ENDIF
595:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProTmp") > 0 AND ;
596:            !EOF("cursor_4c_BuscaProTmp")
597:             SELECT cursor_4c_BuscaProTmp
598:             loc_cCodigo    = ALLTRIM(CPros)
599:             loc_lEncontrou = .T.
600:         ENDIF
601:         IF USED("cursor_4c_BuscaProTmp")
602:             USE IN cursor_4c_BuscaProTmp
603:         ENDIF
604: 
605:         IF !loc_lEncontrou
606:             TRY
607:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
608:                     "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
609:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
610:                 IF VARTYPE(loc_oBusca) = "O"
611:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
612:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
613:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
614:                     loc_oBusca.Show()
615:                     IF USED("cursor_4c_BuscaPro") AND loc_oBusca.this_lSelecionou
616:                         SELECT cursor_4c_BuscaPro
617:                         loc_cCodigo    = ALLTRIM(CPros)
618:                         loc_lEncontrou = .T.
619:                     ENDIF
620:                     IF USED("cursor_4c_BuscaPro")
621:                         USE IN cursor_4c_BuscaPro
622:                     ENDIF
623:                 ENDIF
624:             CATCH TO loc_oErro
625:                 MsgErro("Erro na busca de produto: " + loc_oErro.Message, "Erro")
626:             ENDTRY
627:         ENDIF
628: 
629:         IF loc_lEncontrou
630:             DO CASE
631:                 CASE par_cCampo = "CProsI"

*-- Linhas 666 a 709:
666:         ENDIF
667: 
668:         *-- Tenta match exato primeiro
669:         loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE RTRIM(CGrus) = " + ;
670:                    EscaparSQL(loc_cVal)
671:         IF USED("cursor_4c_BuscaGruTmp")
672:             USE IN cursor_4c_BuscaGruTmp
673:         ENDIF
674:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGruTmp") > 0 AND ;
675:            !EOF("cursor_4c_BuscaGruTmp")
676:             SELECT cursor_4c_BuscaGruTmp
677:             loc_cCodigo    = ALLTRIM(CGrus)
678:             loc_lEncontrou = .T.
679:         ENDIF
680:         IF USED("cursor_4c_BuscaGruTmp")
681:             USE IN cursor_4c_BuscaGruTmp
682:         ENDIF
683: 
684:         IF !loc_lEncontrou
685:             TRY
686:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
687:                     "SigCdGrp", "cursor_4c_BuscaGru", "CGrus", loc_cVal, ;
688:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
689:                 IF VARTYPE(loc_oBusca) = "O"
690:                     loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
691:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
692:                     loc_oBusca.Show()
693:                     IF USED("cursor_4c_BuscaGru") AND loc_oBusca.this_lSelecionou
694:                         SELECT cursor_4c_BuscaGru
695:                         loc_cCodigo    = ALLTRIM(CGrus)
696:                         loc_lEncontrou = .T.
697:                     ENDIF
698:                     IF USED("cursor_4c_BuscaGru")
699:                         USE IN cursor_4c_BuscaGru
700:                     ENDIF
701:                 ENDIF
702:             CATCH TO loc_oErro
703:                 MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
704:             ENDTRY
705:         ENDIF
706: 
707:         IF loc_lEncontrou
708:             THIS.txt_4c_CGrus.Value = loc_cCodigo
709:             THIS.txt_4c_CGrus.Refresh

*-- Linhas 743 a 761:
743:                 loc_oBusca.mAddColuna("CGrus", "", "Grupo")
744:                 loc_oBusca.Show()
745:                 IF USED("cursor_4c_BuscaProDbl") AND loc_oBusca.this_lSelecionou
746:                     SELECT cursor_4c_BuscaProDbl
747:                     loc_cCodigo = ALLTRIM(CPros)
748:                     DO CASE
749:                         CASE par_cCampo = "CProsI"
750:                             THIS.txt_4c_CProsI.Value = loc_cCodigo
751:                             THIS.txt_4c_CProsI.Refresh
752:                             IF EMPTY(THIS.txt_4c_CProsF.Value)
753:                                 THIS.txt_4c_CProsF.Value = loc_cCodigo
754:                                 THIS.txt_4c_CProsF.Refresh
755:                             ENDIF
756:                             THIS.txt_4c_CGrus.Value = ""
757:                             THIS.txt_4c_CGrus.Refresh
758:                         CASE par_cCampo = "CProsF"
759:                             THIS.txt_4c_CProsF.Value = loc_cCodigo
760:                             THIS.txt_4c_CProsF.Refresh
761:                             IF EMPTY(THIS.txt_4c_CProsI.Value)

*-- Linhas 794 a 812:
794:                 loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
795:                 loc_oBusca.Show()
796:                 IF USED("cursor_4c_BuscaGruDbl") AND loc_oBusca.this_lSelecionou
797:                     SELECT cursor_4c_BuscaGruDbl
798:                     loc_cCodigo = ALLTRIM(CGrus)
799:                     THIS.txt_4c_CGrus.Value = loc_cCodigo
800:                     THIS.txt_4c_CGrus.Refresh
801:                     THIS.txt_4c_CProsI.Value = ""
802:                     THIS.txt_4c_CProsI.Refresh
803:                     THIS.txt_4c_CProsF.Value = ""
804:                     THIS.txt_4c_CProsF.Refresh
805:                 ENDIF
806:                 IF USED("cursor_4c_BuscaGruDbl")
807:                     USE IN cursor_4c_BuscaGruDbl
808:                 ENDIF
809:             ENDIF
810:         CATCH TO loc_oErro
811:             MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
812:         ENDTRY

*-- Linhas 1060 a 1263:
1060:         loc_cPrF = PADR(ALLTRIM(THIS.txt_4c_CProsF.Value), 14)
1061: 
1062:         IF !EMPTY(loc_cGru)
1063:             loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
1064:                        "WHERE CGrus = " + EscaparSQL(PADR(loc_cGru, 3)) + ;
1065:                        " ORDER BY CPros"
1066:         ELSE
1067:             loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
1068:                        "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + ;
1069:                        " AND " + EscaparSQL(loc_cPrF) + ;
1070:                        " ORDER BY CPros"
1071:         ENDIF
1072: 
1073:         IF USED("cursor_4c_PrdTraduz")
1074:             USE IN cursor_4c_PrdTraduz
1075:         ENDIF
1076: 
1077:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz") < 1
1078:             MsgErro("Falha ao carregar produtos.", "Erro")
1079:             RETURN
1080:         ENDIF
1081: 
1082:         loc_nRecs = RECCOUNT("cursor_4c_PrdTraduz")
1083:         IF loc_nRecs = 0
1084:             MsgAviso("Nenhum produto encontrado com os filtros informados.", "Aviso")
1085:             USE IN cursor_4c_PrdTraduz
1086:             RETURN
1087:         ENDIF
1088: 
1089:         loc_oProg = .NULL.
1090:         TRY
1091:             loc_oProg = CREATEOBJECT("fwprogressbar", ;
1092:                 "Processando Tradu" + CHR(231) + CHR(245) + "es...", loc_nRecs)
1093:             IF VARTYPE(loc_oProg) = "O"
1094:                 loc_oProg.Show
1095:             ENDIF
1096:         CATCH TO loc_oErro
1097:             loc_oProg = .NULL.
1098:         ENDTRY
1099: 
1100:         SELECT cursor_4c_PrdTraduz
1101:         GO TOP
1102:         SCAN
1103:             loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.CPros)
1104:             loc_cDes = ""
1105:             loc_cIni = ""
1106:             loc_nGrD = 0
1107: 
1108:             IF VARTYPE(loc_oProg) = "O"
1109:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1110:                 loc_oProg.Update(.T.)
1111:             ENDIF
1112: 
1113:             IF !EMPTY(loc_cPro)
1114:                 *-- Busca descricao do grupo e cor do produto
1115:                 loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, b.DGrus, " + ;
1116:                            "b.Mercs, b.MontaGrDs, c.Descs " + ;
1117:                            "FROM SigCdPro a " + ;
1118:                            "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
1119:                            "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
1120:                            "WHERE a.CPros = " + EscaparSQL(loc_cPro)
1121: 
1122:                 IF USED("cursor_4c_LocalPro")
1123:                     USE IN cursor_4c_LocalPro
1124:                 ENDIF
1125: 
1126:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0 AND ;
1127:                    !EOF("cursor_4c_LocalPro")
1128:                     SELECT cursor_4c_LocalPro
1129:                     loc_cIni = ALLTRIM(NVL(DGrus, "")) + " " + ALLTRIM(NVL(Descs, ""))
1130:                     loc_cIni = ALLTRIM(loc_cIni)
1131:                     loc_nGrD = NVL(MontaGrDs, 0)
1132:                 ENDIF
1133: 
1134:                 IF USED("cursor_4c_LocalPro")
1135:                     USE IN cursor_4c_LocalPro
1136:                 ENDIF
1137: 
1138:                 *-- Usa descricao montada quando MontaGrDs=1 (flag de montagem)
1139:                 IF loc_nGrD != 0 AND !EMPTY(loc_cIni)
1140:                     loc_cDes = loc_cIni
1141:                 ENDIF
1142: 
1143:                 IF !EMPTY(loc_cDes)
1144:                     *-- Traduz para ingles usando SigCdDic (ordenado por expressao mais longa)
1145:                     loc_cIng = loc_cDes
1146: 
1147:                     IF USED("cursor_4c_Dicionario")
1148:                         SELECT cursor_4c_Dicionario
1149:                         GO TOP
1150:                         SCAN
1151:                             loc_cIng = STRTRAN(loc_cIng, ;
1152:                                 ALLTRIM(cursor_4c_Dicionario.Expressao), ;
1153:                                 ALLTRIM(cursor_4c_Dicionario.Traducao))
1154:                         ENDSCAN
1155:                     ENDIF
1156: 
1157:                     *-- Remove aspas simples/duplas para evitar problemas no SQL futuro
1158:                     loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
1159:                     loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")
1160: 
1161:                     *-- Insere no cursor (APPEND BLANK seguro para campos memo)
1162:                     SELECT cursor_4c_Produtos
1163:                     APPEND BLANK
1164:                     REPLACE cursor_4c_Produtos.CPros      WITH loc_cPro, ;
1165:                             cursor_4c_Produtos.Portugues  WITH loc_cDes, ;
1166:                             cursor_4c_Produtos.Traduzido  WITH loc_cIng, ;
1167:                             cursor_4c_Produtos.DscCompras WITH loc_cIng, ;
1168:                             cursor_4c_Produtos.ObsCompras WITH loc_cDes
1169:                 ENDIF
1170:             ENDIF
1171: 
1172:             *-- Restaura contexto do SCAN externo
1173:             SELECT cursor_4c_PrdTraduz
1174:             THIS.grd_4c_Dados.Refresh
1175:         ENDSCAN
1176: 
1177:         IF USED("cursor_4c_PrdTraduz")
1178:             USE IN cursor_4c_PrdTraduz
1179:         ENDIF
1180: 
1181:         IF VARTYPE(loc_oProg) = "O"
1182:             loc_oProg.Complete
1183:         ENDIF
1184: 
1185:         SELECT cursor_4c_Produtos
1186:         GO TOP
1187:         IF !EOF("cursor_4c_Produtos")
1188:             THIS.cmd_4c_BtnAtualizar.Enabled = .T.
1189:         ENDIF
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     PROTECTED PROCEDURE Gravacao()
1194:     *  Grava descricoes: UPDATE SigCdPro + DELETE SigPrPrt por produto
1195:     *==========================================================================
1196:         LOCAL loc_lOk, loc_cPro, loc_cSQL, loc_oProg, loc_nRecs
1197:         LOCAL loc_nResult, loc_oErro
1198:         loc_lOk = .T.
1199: 
1200:         SELECT cursor_4c_Produtos
1201:         loc_nRecs = RECCOUNT("cursor_4c_Produtos")
1202: 
1203:         IF loc_nRecs = 0
1204:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
1205:                      " produtos para gravar.", "Aviso")
1206:             RETURN
1207:         ENDIF
1208: 
1209:         loc_oProg = .NULL.
1210:         TRY
1211:             loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nRecs)
1212:             IF VARTYPE(loc_oProg) = "O"
1213:                 loc_oProg.Show
1214:             ENDIF
1215:         CATCH TO loc_oErro
1216:             loc_oProg = .NULL.
1217:         ENDTRY
1218: 
1219:         SELECT cursor_4c_Produtos
1220:         GO TOP
1221:         SCAN WHILE loc_lOk
1222:             loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1223: 
1224:             IF VARTYPE(loc_oProg) = "O"
1225:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1226:                 loc_oProg.Update(.T.)
1227:             ENDIF
1228: 
1229:             *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
1230:             loc_cSQL = "UPDATE SigCdPro " + ;
1231:                        "SET DscCompras = " + ;
1232:                            EscaparSQL(ALLTRIM(cursor_4c_Produtos.DscCompras)) + ", " + ;
1233:                        "ObsCompras = " + ;
1234:                            EscaparSQL(ALLTRIM(cursor_4c_Produtos.ObsCompras)) + ", " + ;
1235:                        "DPros = " + ;
1236:                            EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + ;
1237:                        " WHERE CPros = " + EscaparSQL(loc_cPro)
1238: 
1239:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1240:             IF loc_nResult < 1
1241:                 MsgErro("Falha ao gravar produto " + loc_cPro + " em SigCdPro.", "Erro")
1242:                 loc_lOk = .F.
1243:                 LOOP
1244:             ENDIF
1245: 
1246:             *-- DELETE FROM SigPrPrt (remove produto da fila de processamento)
1247:             loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
1248:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1249:             IF loc_nResult < 1
1250:                 MsgErro("Falha ao remover produto " + loc_cPro + " de SigPrPrt.", "Erro")
1251:                 loc_lOk = .F.
1252:             ENDIF
1253:         ENDSCAN
1254: 
1255:         IF VARTYPE(loc_oProg) = "O"
1256:             loc_oProg.Complete
1257:         ENDIF
1258: 
1259:         IF loc_lOk
1260:             MsgInfo("Foram gravados " + ALLTRIM(STR(loc_nRecs)) + " produtos!", ;
1261:                     "Processamento Conclu" + CHR(237) + "do!")
1262:         ELSE
1263:             MsgAviso("Ocorreu um erro com a grava" + CHR(231) + CHR(227) + ;


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SIGPRDSCBO.PRG - Business Object para Montagem de Descricao de Produtos
* Tabela principal: SigCdPro
* Form operacional: processa descricoes/traducoes de produtos em lote
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *-- Filtros de selecao
    this_cCProsI     = ""   && Codigo produto inicial (filtro intervalo)
    this_cCProsF     = ""   && Codigo produto final (filtro intervalo)
    this_cCGrus      = ""   && Codigo grupo de produto (filtro alternativo)

    *-- Propriedades do produto corrente (linha selecionada na grade)
    this_cCPros      = ""   && Codigo do produto (CPros)
    this_cDPros      = ""   && Descricao do produto (DPros)
    this_cCGrusProd  = ""   && Grupo do produto (CGrus)
    this_cCodCors    = ""   && Codigo da cor (CodCors)
    this_cPortugues  = ""   && Descricao montada em Portugues
    this_cTraduzido  = ""   && Descricao traduzida (Ingles)
    this_cDscCompras = ""   && Descricao para compras (DscCompras)
    this_cObsCompras = ""   && Observacao para compras (ObsCompras)

    *--------------------------------------------------------------------------
    * INIT - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT("SigCdPro")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCPros      = TratarNulo(CPros,      "C")
                THIS.this_cDPros      = TratarNulo(DPros,      "C")
                THIS.this_cCGrusProd  = TratarNulo(CGrus,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cDscCompras = TratarNulo(DscCompras, "C")
                THIS.this_cObsCompras = TratarNulo(ObsCompras, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Seleciona produtos conforme filtros para a grade
    * Popula cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lResultado, loc_cSQL, loc_cFiltro, loc_cPrI, loc_cPrF, loc_cGru
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT CPros, '' AS Portugues, '' AS Traduzido, " + ;
                       "ISNULL(DscCompras,'') AS DscCompras, " + ;
                       "ISNULL(ObsCompras,'') AS ObsCompras " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar produtos"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Produtos")
                TABLEREVERT(.T., "cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ;
                (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
                 DscCompras M(4) NULL, ObsCompras M(4) NULL)
            SET NULL OFF

            IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
                SELECT cursor_4c_Produtos
                APPEND FROM DBF("cursor_4c_ProdutosTemp")
            ENDIF

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDescricoes - Monta descricoes em Portugues e traduz para Ingles
    * Usa crSigCdDic (dicionario) e SigCdGrp/SigCdCor para montar descricao
    * Popula colunas Portugues/Traduzido de cursor_4c_Produtos
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDescricoes()
        LOCAL loc_lResultado, loc_cSQL, loc_cPro, loc_cDes, loc_cIng
        LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cFiltro
        LOCAL loc_cDGrus, loc_cDescs, loc_nMontaGrDs
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "a.CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "a.CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                       "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                       "FROM SigCdPro a " + ;
                       "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                       "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY a.CPros"

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfoTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar informa" + CHR(231) + CHR(245) + "es dos produtos"
                loc_lResultado = .F.
            ENDIF

            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            ZAP

            SELECT cursor_4c_ProdInfoTemp
            GO TOP
            DO WHILE !EOF("cursor_4c_ProdInfoTemp")
                loc_cPro    = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.CPros,   ""))
                loc_cDGrus  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.DGrus,   ""))
                loc_cDescs  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.Descs,   ""))
                loc_nMontaGrDs = NVL(cursor_4c_ProdInfoTemp.MontaGrDs, 0)

                IF !EMPTY(loc_cPro)
                    *-- Monta descricao base: Grupo + Cor
                    loc_cDes = ALLTRIM(loc_cDGrus + " " + loc_cDescs)

                    IF !EMPTY(loc_cDes)
                        *-- Aplica dicionario de traducao
                        loc_cIng = loc_cDes
                        IF USED("cursor_4c_Dicionario")
                            SELECT cursor_4c_Dicionario
                            GO TOP
                            DO WHILE !EOF("cursor_4c_Dicionario")
                                loc_cIng = STRTRAN(loc_cIng, ;
                                    ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                    ALLTRIM(cursor_4c_Dicionario.Traducao))
                                SKIP IN cursor_4c_Dicionario
                            ENDDO
                        ENDIF

                        *-- Limpa caracteres especiais para SQL
                        loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                        loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                        SELECT cursor_4c_Produtos
                        INSERT INTO cursor_4c_Produtos ;
                            (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                            VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
                    ENDIF
                ENDIF

                SKIP IN cursor_4c_ProdInfoTemp
            ENDDO

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDicionario - Carrega SigCdDic (Ingles) em cursor_4c_Dicionario
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDicionario()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"

            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                THIS.this_cMensagemErro = "Falha ao carregar dicion" + CHR(225) + "rio"
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - Atualiza SigCdPro e limpa SigPrPrt em lote
    * Percorre cursor_4c_Produtos e faz UPDATE em cada produto
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes(par_oProgressBar)
        LOCAL loc_lResultado, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_cPortugues, loc_cTraduzido, loc_cDscCompras, loc_cObsCompras
        loc_lResultado = .F.
        loc_lOks = .T.

        TRY
            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            DO WHILE !EOF("cursor_4c_Produtos") AND loc_lOks
                loc_cPro         = ALLTRIM(NVL(cursor_4c_Produtos.CPros,       ""))
                loc_cPortugues   = ALLTRIM(NVL(cursor_4c_Produtos.Portugues,   ""))
                loc_cTraduzido   = ALLTRIM(NVL(cursor_4c_Produtos.Traduzido,   ""))
                loc_cDscCompras  = ALLTRIM(NVL(cursor_4c_Produtos.DscCompras,  ""))
                loc_cObsCompras  = ALLTRIM(NVL(cursor_4c_Produtos.ObsCompras,  ""))

                IF VARTYPE(par_oProgressBar) = "O"
                    par_oProgressBar.SubTitulo.Caption = "Produto : " + loc_cPro
                    par_oProgressBar.Update(.T.)
                ENDIF

                *-- UPDATE SigCdPro
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(loc_cDscCompras) + ", " + ;
                           "ObsCompras = " + EscaparSQL(loc_cObsCompras) + ", " + ;
                           "DPros = '" + PADR(loc_cPortugues, 40) + "' " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar produto " + loc_cPro
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE SigPrPrt
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt para " + loc_cPro
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SKIP IN cursor_4c_Produtos
                ELSE
                    EXIT
                ENDIF
            ENDDO

            loc_lResultado = loc_lOks
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (CPros)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCPros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel: form operacional nao cria produtos novos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza descricoes de um produto individual em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCPros)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdPro " + ;
                       "SET DscCompras = " + EscaparSQL(THIS.this_cDscCompras) + ", " + ;
                       "ObsCompras = " + EscaparSQL(THIS.this_cObsCompras) + ", " + ;
                       "DPros = '" + PADR(ALLTRIM(THIS.this_cPortugues), 40) + "' " + ;
                       "WHERE CPros = '" + ALLTRIM(THIS.this_cCPros) + "'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Falha ao atualizar produto " + ALLTRIM(THIS.this_cCPros)
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria("A")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cCProsI     = ""
        THIS.this_cCProsF     = ""
        THIS.this_cCGrus      = ""
        THIS.this_cCPros      = ""
        THIS.this_cDPros      = ""
        THIS.this_cCGrusProd  = ""
        THIS.this_cCodCors    = ""
        THIS.this_cPortugues  = ""
        THIS.this_cTraduzido  = ""
        THIS.this_cDscCompras = ""
        THIS.this_cObsCompras = ""
        THIS.this_cMensagemErro = ""
    ENDPROC

ENDDEFINE

