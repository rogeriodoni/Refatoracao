# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CLFISCALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS

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
  ControlSource = "crSigCdcfi.grupos"
  ControlSource = "crSigCdcfi.natope"
  ControlSource = "crSigCdcfi.sittricms"
  ControlSource = "crSigCdcfi.tptribs"
  ControlSource = "crSigCdcfi.tpicms"
  ControlSource = "crSigCdcfi.icms"
  ControlSource = "crSigCdcfi.ests"
  ControlSource = "crSigCdcfi.cfops"
  ControlSource = "crSigCdcfi.itemls"
  ControlSource = "crSigCdcfi.CodTrib"
  ControlSource = "crSigCdcfi.issqn"
  ControlSource = "crSigCdcfi.clfiscals"
	If Thisform.PoDatamgr.SQLExecute([Select Dgrus from SigCdGrp where Cgrus = '] + CrSigCdcfi.Grupos + [' ],'CrSigCdGrp') < 0
	Select CrSigCdcfi
Select CrSigCdcfi
Select CrSigCdcfi
Select CrSigCdcfi
Select CrSigCdcfi
Select CrSigCdcfi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfi.prg) - TRECHOS RELEVANTES PARA PASS SQL (1721 linhas total):

*-- Linhas 314 a 332:
314:             .Width              = 890
315:             .Height             = 498
316:             .ColumnCount        = 5
317:             .DeleteMark         = .F.
318:             .RecordMark         = .F.
319:             .RowHeight          = 16
320:             .ScrollBars         = 2
321:             .GridLines          = 3
322:             .GridLineColor      = RGB(238, 238, 238)
323:             .HighlightBackColor = RGB(255, 255, 255)
324:             .HighlightForeColor = RGB(15, 41, 104)
325:             .HighlightStyle     = 2
326:             .ForeColor          = RGB(90, 90, 90)
327:             .BackColor          = RGB(255, 255, 255)
328:             .FontName           = "Verdana"
329:             .FontSize           = 8
330:             .Visible            = .T.
331:         ENDWITH
332: 

*-- Linhas 827 a 854:
827:                 loc_oGrid.ColumnCount  = 10
828: 
829:                 WITH loc_oGrid
830:                     .Column1.ControlSource  = "cursor_4c_Dados.grupos"
831:                     .Column2.ControlSource  = "cursor_4c_Dados.ests"
832:                     .Column3.ControlSource  = "cursor_4c_Dados.icms"
833:                     .Column4.ControlSource  = "cursor_4c_Dados.tpicms"
834:                     .Column5.ControlSource  = "cursor_4c_Dados.tptribs"
835:                     .Column6.ControlSource  = "cursor_4c_Dados.cfops"
836:                     .Column7.ControlSource  = "cursor_4c_Dados.issqn"
837:                     .Column8.ControlSource  = "cursor_4c_Dados.itemls"
838:                     .Column9.ControlSource  = "cursor_4c_Dados.codtrib"
839:                     .Column10.ControlSource = "cursor_4c_Dados.natope"
840:                     .Column1.Width  = 40
841:                     .Column2.Width  = 40
842:                     .Column3.Width  = 60
843:                     .Column4.Width  = 40
844:                     .Column5.Width  = 80
845:                     .Column6.Width  = 60
846:                     .Column7.Width  = 60
847:                     .Column8.Width  = 100
848:                     .Column9.Width  = 130
849:                     .Column10.Width = 40
850:                     *-- Headers APOS RecordSource (obrigatorio)
851:                     .Column1.Header1.Caption  = "Grupo"
852:                     .Column2.Header1.Caption  = "Estado"
853:                     .Column3.Header1.Caption  = "Aliq. (%)"
854:                     .Column4.Header1.Caption  = "Tipo"

*-- Linhas 966 a 994:
966:             IF VARTYPE(loc_oBusca) = "O"
967:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
968:                     IF USED("cursor_4c_BuscaGrp")
969:                         SELECT cursor_4c_BuscaGrp
970:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
971:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
972:                     ENDIF
973:                 ELSE
974:                     IF !loc_oBusca.this_lAchouRegistro
975:                     loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
976:                     loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
977:                     loc_oBusca.Show()
978:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
979:                         SELECT cursor_4c_BuscaGrp
980:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
981:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
982:                     ELSE
983:                         loc_oPagina.txt_4c_Cgru.Value = ""
984:                         loc_oPagina.txt_4c_Dgru.Value = ""
985:                     ENDIF
986:                     ENDIF
987:                 ENDIF
988:                 loc_oBusca.Release()
989:             ENDIF
990: 
991:             IF USED("cursor_4c_BuscaGrp")
992:                 USE IN cursor_4c_BuscaGrp
993:             ENDIF
994: 

*-- Linhas 1024 a 1052:
1024:             IF VARTYPE(loc_oBusca) = "O"
1025:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1026:                     IF USED("cursor_4c_BuscaGrp")
1027:                         SELECT cursor_4c_BuscaGrp
1028:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
1029:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
1030:                     ENDIF
1031:                 ELSE
1032:                     IF !loc_oBusca.this_lAchouRegistro
1033:                     loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1034:                     loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
1035:                     loc_oBusca.Show()
1036:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1037:                         SELECT cursor_4c_BuscaGrp
1038:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
1039:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
1040:                     ELSE
1041:                         loc_oPagina.txt_4c_Cgru.Value = ""
1042:                         loc_oPagina.txt_4c_Dgru.Value = ""
1043:                     ENDIF
1044:                     ENDIF
1045:                 ENDIF
1046:                 loc_oBusca.Release()
1047:             ENDIF
1048: 
1049:             IF USED("cursor_4c_BuscaGrp")
1050:                 USE IN cursor_4c_BuscaGrp
1051:             ENDIF
1052: 

*-- Linhas 1081 a 1108:
1081:             IF VARTYPE(loc_oBusca) = "O"
1082:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1083:                     IF USED("cursor_4c_BuscaUfs")
1084:                         SELECT cursor_4c_BuscaUfs
1085:                         loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
1086:                     ENDIF
1087:                 ELSE
1088:                     IF !loc_oBusca.this_lAchouRegistro
1089:                     loc_oBusca.mAddColuna("estados", "", "Estado")
1090:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1091:                     loc_oBusca.Show()
1092:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfs")
1093:                         SELECT cursor_4c_BuscaUfs
1094:                         loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
1095:                     ELSE
1096:                         loc_oPagina.txt_4c_Estado.Value = ""
1097:                     ENDIF
1098:                     ENDIF
1099:                 ENDIF
1100:                 loc_oBusca.Release()
1101:             ENDIF
1102: 
1103:             IF USED("cursor_4c_BuscaUfs")
1104:                 USE IN cursor_4c_BuscaUfs
1105:             ENDIF
1106: 
1107:         CATCH TO loc_oErro
1108:             MsgErro("Erro em ValidarEstado:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1135 a 1162:
1135:             IF VARTYPE(loc_oBusca) = "O"
1136:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1137:                     IF USED("cursor_4c_BuscaTri")
1138:                         SELECT cursor_4c_BuscaTri
1139:                         loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
1140:                     ENDIF
1141:                 ELSE
1142:                     IF !loc_oBusca.this_lAchouRegistro
1143:                     loc_oBusca.mAddColuna("Tipos", "", "Tipo")
1144:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1145:                     loc_oBusca.Show()
1146:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
1147:                         SELECT cursor_4c_BuscaTri
1148:                         loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
1149:                     ELSE
1150:                         loc_oPagina.txt_4c_TpTrib.Value = ""
1151:                     ENDIF
1152:                     ENDIF
1153:                 ENDIF
1154:                 loc_oBusca.Release()
1155:             ENDIF
1156: 
1157:             IF USED("cursor_4c_BuscaTri")
1158:                 USE IN cursor_4c_BuscaTri
1159:             ENDIF
1160: 
1161:         CATCH TO loc_oErro
1162:             MsgErro("Erro em ValidarTpTrib:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1190 a 1218:
1190:             IF VARTYPE(loc_oBusca) = "O"
1191:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1192:                     IF USED("cursor_4c_BuscaIcm")
1193:                         SELECT cursor_4c_BuscaIcm
1194:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1195:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1196:                     ENDIF
1197:                 ELSE
1198:                     IF !loc_oBusca.this_lAchouRegistro
1199:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1200:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1201:                     loc_oBusca.Show()
1202:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
1203:                         SELECT cursor_4c_BuscaIcm
1204:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1205:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1206:                     ELSE
1207:                         loc_oPagina.txt_4c_Sittricm.Value  = ""
1208:                         loc_oPagina.txt_4c_Dsittricm.Value = ""
1209:                     ENDIF
1210:                     ENDIF
1211:                 ENDIF
1212:                 loc_oBusca.Release()
1213:             ENDIF
1214: 
1215:             IF USED("cursor_4c_BuscaIcm")
1216:                 USE IN cursor_4c_BuscaIcm
1217:             ENDIF
1218: 

*-- Linhas 1252 a 1280:
1252:             IF VARTYPE(loc_oBusca) = "O"
1253:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1254:                     IF USED("cursor_4c_BuscaIcm")
1255:                         SELECT cursor_4c_BuscaIcm
1256:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1257:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1258:                     ENDIF
1259:                 ELSE
1260:                     IF !loc_oBusca.this_lAchouRegistro
1261:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1262:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1263:                     loc_oBusca.Show()
1264:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
1265:                         SELECT cursor_4c_BuscaIcm
1266:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1267:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1268:                     ELSE
1269:                         loc_oPagina.txt_4c_Dsittricm.Value = ""
1270:                     ENDIF
1271:                     ENDIF
1272:                 ENDIF
1273:                 loc_oBusca.Release()
1274:             ENDIF
1275: 
1276:             IF USED("cursor_4c_BuscaIcm")
1277:                 USE IN cursor_4c_BuscaIcm
1278:             ENDIF
1279: 
1280:         CATCH TO loc_oErro

*-- Linhas 1307 a 1334:
1307:             IF VARTYPE(loc_oBusca) = "O"
1308:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1309:                     IF USED("cursor_4c_BuscaCfo")
1310:                         SELECT cursor_4c_BuscaCfo
1311:                         loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
1312:                     ENDIF
1313:                 ELSE
1314:                     IF !loc_oBusca.this_lAchouRegistro
1315:                     loc_oBusca.mAddColuna("codigos",    "", "CFOP")
1316:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1317:                     loc_oBusca.Show()
1318:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
1319:                         SELECT cursor_4c_BuscaCfo
1320:                         loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
1321:                     ELSE
1322:                         loc_oPagina.txt_4c_Cfop.Value = ""
1323:                     ENDIF
1324:                     ENDIF
1325:                 ENDIF
1326:                 loc_oBusca.Release()
1327:             ENDIF
1328: 
1329:             IF USED("cursor_4c_BuscaCfo")
1330:                 USE IN cursor_4c_BuscaCfo
1331:             ENDIF
1332: 
1333:         CATCH TO loc_oErro
1334:             MsgErro("Erro em ValidarCfop:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1361 a 1388:
1361:             IF VARTYPE(loc_oBusca) = "O"
1362:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1363:                     IF USED("cursor_4c_BuscaClf")
1364:                         SELECT cursor_4c_BuscaClf
1365:                         loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
1366:                     ENDIF
1367:                 ELSE
1368:                     IF !loc_oBusca.this_lAchouRegistro
1369:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1370:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1371:                     loc_oBusca.Show()
1372:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
1373:                         SELECT cursor_4c_BuscaClf
1374:                         loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
1375:                     ELSE
1376:                         loc_oPagina.txt_4c_Clfiscals.Value = ""
1377:                     ENDIF
1378:                     ENDIF
1379:                 ENDIF
1380:                 loc_oBusca.Release()
1381:             ENDIF
1382: 
1383:             IF USED("cursor_4c_BuscaClf")
1384:                 USE IN cursor_4c_BuscaClf
1385:             ENDIF
1386: 
1387:         CATCH TO loc_oErro
1388:             MsgErro("Erro em ValidarClfiscals:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1428 a 1471:
1428:                 IF USED("cursor_4c_BofGrp")
1429:                     USE IN cursor_4c_BofGrp
1430:                 ENDIF
1431:                 loc_cSQL = "SELECT Dgrus FROM SigCdGrp WHERE Cgrus = " + ;
1432:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1433:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofGrp")
1434:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofGrp") > 0
1435:                     SELECT cursor_4c_BofGrp
1436:                     loc_cDgrus = ALLTRIM(Dgrus)
1437:                 ENDIF
1438:                 IF USED("cursor_4c_BofGrp")
1439:                     USE IN cursor_4c_BofGrp
1440:                 ENDIF
1441:             CATCH TO loc_oErro
1442:                 MsgErro("Erro ao carregar descricao do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
1443:             ENDTRY
1444:         ENDIF
1445: 
1446:         *-- Descricao da situacao tributaria (SigCdIcm.Descricaos - nao armazenada em SIGCDCFI)
1447:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
1448:             TRY
1449:                 IF USED("cursor_4c_BofIcm")
1450:                     USE IN cursor_4c_BofIcm
1451:                 ENDIF
1452:                 loc_cSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + ;
1453:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
1454:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofIcm")
1455:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofIcm") > 0
1456:                     SELECT cursor_4c_BofIcm
1457:                     loc_cDsittricms = ALLTRIM(Descricaos)
1458:                 ENDIF
1459:                 IF USED("cursor_4c_BofIcm")
1460:                     USE IN cursor_4c_BofIcm
1461:                 ENDIF
1462:             CATCH TO loc_oErro
1463:                 MsgErro("Erro ao carregar descricao sit. tributaria:" + CHR(13) + loc_oErro.Message, "Erro")
1464:             ENDTRY
1465:         ENDIF
1466: 
1467:         loc_oPagina.txt_4c_Cgru.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1468:         loc_oPagina.txt_4c_Dgru.Value      = loc_cDgrus
1469:         loc_oPagina.txt_4c_Estado.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEsts)
1470:         loc_oPagina.txt_4c_Icm.Value       = THIS.this_oBusinessObject.this_nIcms
1471:         loc_oPagina.txt_4c_Tpicm.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTpicms)

*-- Linhas 1565 a 1583:
1565:             RETURN
1566:         ENDIF
1567: 
1568:         SELECT cursor_4c_Dados
1569:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1570: 
1571:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1572:             THIS.this_oBusinessObject.EditarRegistro()
1573:             THIS.this_cModoAtual = "ALTERAR"
1574:             THIS.BOParaForm()
1575:             THIS.HabilitarCampos(.T.)
1576:             THIS.AlternarPagina(2)
1577:         ELSE
1578:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1579:         ENDIF
1580:     ENDPROC
1581: 
1582:     *--------------------------------------------------------------------------
1583:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao

*-- Linhas 1593 a 1611:
1593:             RETURN
1594:         ENDIF
1595: 
1596:         SELECT cursor_4c_Dados
1597:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1598: 
1599:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1600:             THIS.this_cModoAtual = "VISUALIZAR"
1601:             THIS.BOParaForm()
1602:             THIS.HabilitarCampos(.F.)
1603:             THIS.AlternarPagina(2)
1604:         ELSE
1605:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1606:         ENDIF
1607:     ENDPROC
1608: 
1609:     *--------------------------------------------------------------------------
1610:     * BtnExcluirClick - Exclui registro selecionado
1611:     *--------------------------------------------------------------------------

*-- Linhas 1625 a 1643:
1625:             RETURN
1626:         ENDIF
1627: 
1628:         SELECT cursor_4c_Dados
1629:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1630: 
1631:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1632:             IF THIS.this_oBusinessObject.Excluir()
1633:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1634:                 THIS.CarregarLista()
1635:             ENDIF
1636:         ELSE
1637:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1638:         ENDIF
1639:     ENDPROC
1640: 
1641:     *--------------------------------------------------------------------------
1642:     * BtnBuscarClick - Recarrega lista completa
1643:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\cfiBO.prg):
*==============================================================================
* cfiBO.prg - Business Object para ICMS Cupom Fiscal (SIGCDCFI)
*==============================================================================
* Tabela : SIGCDCFI
* PK     : cidchaves char(20) - gerado via SYS(2015)
* Regra  : unicidade por grupos + ests + clfiscals (ChkRegister original)
*==============================================================================

DEFINE CLASS cfiBO AS BusinessBase

    *-- Chave primaria
    this_cCidchaves  = ""

    *-- Campos da tabela SIGCDCFI
    this_cEsts       = ""   && char(2)  - Estado (FK SigCdUfs.Estados)
    this_cGrupos     = ""   && char(3)  - Grupo (FK SigCdGrp.Cgrus)
    this_nIcms       = 0    && numeric(5,2) - Aliquota ICMS
    this_cTpicms     = ""   && char(1)  - Tipo ICMS: T/S/I/N/F
    this_cTptribs    = ""   && char(4)  - Tipo Tributacao (FK SigPrTri.Tipos)
    this_nOrdicms    = 0    && numeric(2,0) - Ordem ICMS
    this_cSittricms  = ""   && char(3)  - Situacao Tributaria ICMS (FK SigCdIcm.Codigos)
    this_cCfops      = ""   && char(10) - CFOP (FK SigCdCfo.codigos)
    this_cCodtrib    = ""   && char(20) - Codigo Tributacao
    this_nIssqn      = 0    && numeric(5,2) - Aliquota ISSQN
    this_cItemls     = ""   && char(5)  - Item da Lista de Servicos
    this_cNatope     = ""   && char(2)  - Natureza da Operacao
    this_cClfiscals  = ""   && char(10) - Classificacao Fiscal (FK SigCdClf.Codigos)

    *-- Campos de exibicao (lookup - nao armazenados em SIGCDCFI)
    this_cDgrus      = ""   && Descricao do Grupo (SigCdGrp.Dgrus)
    this_cDsittricms = ""   && Descricao Sit. Tributaria (SigCdIcm.Descricaos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SIGCDCFI"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cEsts       = TratarNulo(ests,       "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_nIcms       = TratarNulo(icms,       "N")
            THIS.this_cTpicms     = TratarNulo(tpicms,     "C")
            THIS.this_cTptribs    = TratarNulo(tptribs,    "C")
            THIS.this_nOrdicms    = TratarNulo(ordicms,    "N")
            THIS.this_cSittricms  = TratarNulo(sittricms,  "C")
            THIS.this_cCfops      = TratarNulo(cfops,      "C")
            THIS.this_cCodtrib    = TratarNulo(codtrib,    "C")
            THIS.this_nIssqn      = TratarNulo(issqn,      "N")
            THIS.this_cItemls     = TratarNulo(itemls,     "C")
            THIS.this_cNatope     = TratarNulo(natope,     "C")
            THIS.this_cClfiscals  = TratarNulo(clfiscals,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com filtro opcional
    * par_cFiltro: string WHERE extra (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.ests, a.tpicms"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros de ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela PK (cidchaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidchaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Valida unicidade por grupos+ests+clfiscals
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
    *--------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCDCFI" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos) + ;
                       " AND ests = " + EscaparSQL(THIS.this_cEsts) + ;
                       " AND clfiscals = " + EscaparSQL(THIS.this_cClfiscals)

            IF THIS.this_lNovoRegistro = .F.
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResult >= 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidchaves = LEFT(SYS(2015), 20)

            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCFI" + ;
                           " (cidchaves, ests, grupos, icms, tpicms, tptribs," + ;
                           "  ordicms, sittricms, cfops, codtrib, issqn," + ;
                           "  itemls, natope, clfiscals)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                           EscaparSQL(THIS.this_cEsts)      + ", " + ;
                           EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIcms)   + ", " + ;
                           EscaparSQL(THIS.this_cTpicms)    + ", " + ;
                           EscaparSQL(THIS.this_cTptribs)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdicms) + ", " + ;
                           EscaparSQL(THIS.this_cSittricms) + ", " + ;
                           EscaparSQL(THIS.this_cCfops)     + ", " + ;
                           EscaparSQL(THIS.this_cCodtrib)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIssqn)  + ", " + ;
                           EscaparSQL(THIS.this_cItemls)    + ", " + ;
                           EscaparSQL(THIS.this_cNatope)    + ", " + ;
                           EscaparSQL(THIS.this_cClfiscals) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SIGCDCFI SET" + ;
                           " ests      = " + EscaparSQL(THIS.this_cEsts)      + "," + ;
                           " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + "," + ;
                           " icms      = " + FormatarNumeroSQL(THIS.this_nIcms)   + "," + ;
                           " tpicms    = " + EscaparSQL(THIS.this_cTpicms)    + "," + ;
                           " tptribs   = " + EscaparSQL(THIS.this_cTptribs)   + "," + ;
                           " ordicms   = " + FormatarNumeroSQL(THIS.this_nOrdicms) + "," + ;
                           " sittricms = " + EscaparSQL(THIS.this_cSittricms) + "," + ;
                           " cfops     = " + EscaparSQL(THIS.this_cCfops)     + "," + ;
                           " codtrib   = " + EscaparSQL(THIS.this_cCodtrib)   + "," + ;
                           " issqn     = " + FormatarNumeroSQL(THIS.this_nIssqn)  + "," + ;
                           " itemls    = " + EscaparSQL(THIS.this_cItemls)    + "," + ;
                           " natope    = " + EscaparSQL(THIS.this_cNatope)    + "," + ;
                           " clfiscals = " + EscaparSQL(THIS.this_cClfiscals) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFI" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

