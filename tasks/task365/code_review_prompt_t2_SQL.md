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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfi.prg) - TRECHOS RELEVANTES PARA PASS SQL (1723 linhas total):

*-- Linhas 316 a 334:
316:             .Width              = 890
317:             .Height             = 498
318:             .ColumnCount        = 5
319:             .DeleteMark         = .F.
320:             .RecordMark         = .F.
321:             .RowHeight          = 16
322:             .ScrollBars         = 2
323:             .GridLines          = 3
324:             .GridLineColor      = RGB(238, 238, 238)
325:             .HighlightBackColor = RGB(255, 255, 255)
326:             .HighlightForeColor = RGB(15, 41, 104)
327:             .HighlightStyle     = 2
328:             .ForeColor          = RGB(90, 90, 90)
329:             .BackColor          = RGB(255, 255, 255)
330:             .FontName           = "Verdana"
331:             .FontSize           = 8
332:             .Visible            = .T.
333:         ENDWITH
334: 

*-- Linhas 829 a 856:
829:                 loc_oGrid.ColumnCount  = 10
830: 
831:                 WITH loc_oGrid
832:                     .Column1.ControlSource  = "cursor_4c_Dados.grupos"
833:                     .Column2.ControlSource  = "cursor_4c_Dados.ests"
834:                     .Column3.ControlSource  = "cursor_4c_Dados.icms"
835:                     .Column4.ControlSource  = "cursor_4c_Dados.tpicms"
836:                     .Column5.ControlSource  = "cursor_4c_Dados.tptribs"
837:                     .Column6.ControlSource  = "cursor_4c_Dados.cfops"
838:                     .Column7.ControlSource  = "cursor_4c_Dados.issqn"
839:                     .Column8.ControlSource  = "cursor_4c_Dados.itemls"
840:                     .Column9.ControlSource  = "cursor_4c_Dados.codtrib"
841:                     .Column10.ControlSource = "cursor_4c_Dados.natope"
842:                     .Column1.Width  = 40
843:                     .Column2.Width  = 40
844:                     .Column3.Width  = 60
845:                     .Column4.Width  = 40
846:                     .Column5.Width  = 80
847:                     .Column6.Width  = 60
848:                     .Column7.Width  = 60
849:                     .Column8.Width  = 100
850:                     .Column9.Width  = 130
851:                     .Column10.Width = 40
852:                     *-- Headers APOS RecordSource (obrigatorio)
853:                     .Column1.Header1.Caption  = "Grupo"
854:                     .Column2.Header1.Caption  = "Estado"
855:                     .Column3.Header1.Caption  = "Aliq. (%)"
856:                     .Column4.Header1.Caption  = "Tipo"

*-- Linhas 968 a 996:
968:             IF VARTYPE(loc_oBusca) = "O"
969:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
970:                     IF USED("cursor_4c_BuscaGrp")
971:                         SELECT cursor_4c_BuscaGrp
972:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
973:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
974:                     ENDIF
975:                 ELSE
976:                     IF !loc_oBusca.this_lAchouRegistro
977:                     loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
978:                     loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
979:                     loc_oBusca.Show()
980:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
981:                         SELECT cursor_4c_BuscaGrp
982:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
983:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
984:                     ELSE
985:                         loc_oPagina.txt_4c_Cgru.Value = ""
986:                         loc_oPagina.txt_4c_Dgru.Value = ""
987:                     ENDIF
988:                     ENDIF
989:                 ENDIF
990:                 loc_oBusca.Release()
991:             ENDIF
992: 
993:             IF USED("cursor_4c_BuscaGrp")
994:                 USE IN cursor_4c_BuscaGrp
995:             ENDIF
996: 

*-- Linhas 1026 a 1054:
1026:             IF VARTYPE(loc_oBusca) = "O"
1027:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1028:                     IF USED("cursor_4c_BuscaGrp")
1029:                         SELECT cursor_4c_BuscaGrp
1030:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
1031:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
1032:                     ENDIF
1033:                 ELSE
1034:                     IF !loc_oBusca.this_lAchouRegistro
1035:                     loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1036:                     loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
1037:                     loc_oBusca.Show()
1038:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1039:                         SELECT cursor_4c_BuscaGrp
1040:                         loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
1041:                         loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
1042:                     ELSE
1043:                         loc_oPagina.txt_4c_Cgru.Value = ""
1044:                         loc_oPagina.txt_4c_Dgru.Value = ""
1045:                     ENDIF
1046:                     ENDIF
1047:                 ENDIF
1048:                 loc_oBusca.Release()
1049:             ENDIF
1050: 
1051:             IF USED("cursor_4c_BuscaGrp")
1052:                 USE IN cursor_4c_BuscaGrp
1053:             ENDIF
1054: 

*-- Linhas 1083 a 1110:
1083:             IF VARTYPE(loc_oBusca) = "O"
1084:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1085:                     IF USED("cursor_4c_BuscaUfs")
1086:                         SELECT cursor_4c_BuscaUfs
1087:                         loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
1088:                     ENDIF
1089:                 ELSE
1090:                     IF !loc_oBusca.this_lAchouRegistro
1091:                     loc_oBusca.mAddColuna("estados", "", "Estado")
1092:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1093:                     loc_oBusca.Show()
1094:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfs")
1095:                         SELECT cursor_4c_BuscaUfs
1096:                         loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
1097:                     ELSE
1098:                         loc_oPagina.txt_4c_Estado.Value = ""
1099:                     ENDIF
1100:                     ENDIF
1101:                 ENDIF
1102:                 loc_oBusca.Release()
1103:             ENDIF
1104: 
1105:             IF USED("cursor_4c_BuscaUfs")
1106:                 USE IN cursor_4c_BuscaUfs
1107:             ENDIF
1108: 
1109:         CATCH TO loc_oErro
1110:             MsgErro("Erro em ValidarEstado:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1137 a 1164:
1137:             IF VARTYPE(loc_oBusca) = "O"
1138:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1139:                     IF USED("cursor_4c_BuscaTri")
1140:                         SELECT cursor_4c_BuscaTri
1141:                         loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
1142:                     ENDIF
1143:                 ELSE
1144:                     IF !loc_oBusca.this_lAchouRegistro
1145:                     loc_oBusca.mAddColuna("Tipos", "", "Tipo")
1146:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1147:                     loc_oBusca.Show()
1148:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
1149:                         SELECT cursor_4c_BuscaTri
1150:                         loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
1151:                     ELSE
1152:                         loc_oPagina.txt_4c_TpTrib.Value = ""
1153:                     ENDIF
1154:                     ENDIF
1155:                 ENDIF
1156:                 loc_oBusca.Release()
1157:             ENDIF
1158: 
1159:             IF USED("cursor_4c_BuscaTri")
1160:                 USE IN cursor_4c_BuscaTri
1161:             ENDIF
1162: 
1163:         CATCH TO loc_oErro
1164:             MsgErro("Erro em ValidarTpTrib:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1192 a 1220:
1192:             IF VARTYPE(loc_oBusca) = "O"
1193:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1194:                     IF USED("cursor_4c_BuscaIcm")
1195:                         SELECT cursor_4c_BuscaIcm
1196:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1197:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1198:                     ENDIF
1199:                 ELSE
1200:                     IF !loc_oBusca.this_lAchouRegistro
1201:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1202:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1203:                     loc_oBusca.Show()
1204:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
1205:                         SELECT cursor_4c_BuscaIcm
1206:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1207:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1208:                     ELSE
1209:                         loc_oPagina.txt_4c_Sittricm.Value  = ""
1210:                         loc_oPagina.txt_4c_Dsittricm.Value = ""
1211:                     ENDIF
1212:                     ENDIF
1213:                 ENDIF
1214:                 loc_oBusca.Release()
1215:             ENDIF
1216: 
1217:             IF USED("cursor_4c_BuscaIcm")
1218:                 USE IN cursor_4c_BuscaIcm
1219:             ENDIF
1220: 

*-- Linhas 1254 a 1282:
1254:             IF VARTYPE(loc_oBusca) = "O"
1255:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1256:                     IF USED("cursor_4c_BuscaIcm")
1257:                         SELECT cursor_4c_BuscaIcm
1258:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1259:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1260:                     ENDIF
1261:                 ELSE
1262:                     IF !loc_oBusca.this_lAchouRegistro
1263:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1264:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1265:                     loc_oBusca.Show()
1266:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
1267:                         SELECT cursor_4c_BuscaIcm
1268:                         loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
1269:                         loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
1270:                     ELSE
1271:                         loc_oPagina.txt_4c_Dsittricm.Value = ""
1272:                     ENDIF
1273:                     ENDIF
1274:                 ENDIF
1275:                 loc_oBusca.Release()
1276:             ENDIF
1277: 
1278:             IF USED("cursor_4c_BuscaIcm")
1279:                 USE IN cursor_4c_BuscaIcm
1280:             ENDIF
1281: 
1282:         CATCH TO loc_oErro

*-- Linhas 1309 a 1336:
1309:             IF VARTYPE(loc_oBusca) = "O"
1310:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1311:                     IF USED("cursor_4c_BuscaCfo")
1312:                         SELECT cursor_4c_BuscaCfo
1313:                         loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
1314:                     ENDIF
1315:                 ELSE
1316:                     IF !loc_oBusca.this_lAchouRegistro
1317:                     loc_oBusca.mAddColuna("codigos",    "", "CFOP")
1318:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1319:                     loc_oBusca.Show()
1320:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
1321:                         SELECT cursor_4c_BuscaCfo
1322:                         loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
1323:                     ELSE
1324:                         loc_oPagina.txt_4c_Cfop.Value = ""
1325:                     ENDIF
1326:                     ENDIF
1327:                 ENDIF
1328:                 loc_oBusca.Release()
1329:             ENDIF
1330: 
1331:             IF USED("cursor_4c_BuscaCfo")
1332:                 USE IN cursor_4c_BuscaCfo
1333:             ENDIF
1334: 
1335:         CATCH TO loc_oErro
1336:             MsgErro("Erro em ValidarCfop:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1363 a 1390:
1363:             IF VARTYPE(loc_oBusca) = "O"
1364:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1365:                     IF USED("cursor_4c_BuscaClf")
1366:                         SELECT cursor_4c_BuscaClf
1367:                         loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
1368:                     ENDIF
1369:                 ELSE
1370:                     IF !loc_oBusca.this_lAchouRegistro
1371:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1372:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1373:                     loc_oBusca.Show()
1374:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
1375:                         SELECT cursor_4c_BuscaClf
1376:                         loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
1377:                     ELSE
1378:                         loc_oPagina.txt_4c_Clfiscals.Value = ""
1379:                     ENDIF
1380:                     ENDIF
1381:                 ENDIF
1382:                 loc_oBusca.Release()
1383:             ENDIF
1384: 
1385:             IF USED("cursor_4c_BuscaClf")
1386:                 USE IN cursor_4c_BuscaClf
1387:             ENDIF
1388: 
1389:         CATCH TO loc_oErro
1390:             MsgErro("Erro em ValidarClfiscals:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1430 a 1473:
1430:                 IF USED("cursor_4c_BofGrp")
1431:                     USE IN cursor_4c_BofGrp
1432:                 ENDIF
1433:                 loc_cSQL = "SELECT Dgrus FROM SigCdGrp WHERE Cgrus = " + ;
1434:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1435:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofGrp")
1436:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofGrp") > 0
1437:                     SELECT cursor_4c_BofGrp
1438:                     loc_cDgrus = ALLTRIM(Dgrus)
1439:                 ENDIF
1440:                 IF USED("cursor_4c_BofGrp")
1441:                     USE IN cursor_4c_BofGrp
1442:                 ENDIF
1443:             CATCH TO loc_oErro
1444:                 MsgErro("Erro ao carregar descricao do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
1445:             ENDTRY
1446:         ENDIF
1447: 
1448:         *-- Descricao da situacao tributaria (SigCdIcm.Descricaos - nao armazenada em SIGCDCFI)
1449:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
1450:             TRY
1451:                 IF USED("cursor_4c_BofIcm")
1452:                     USE IN cursor_4c_BofIcm
1453:                 ENDIF
1454:                 loc_cSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + ;
1455:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
1456:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofIcm")
1457:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofIcm") > 0
1458:                     SELECT cursor_4c_BofIcm
1459:                     loc_cDsittricms = ALLTRIM(Descricaos)
1460:                 ENDIF
1461:                 IF USED("cursor_4c_BofIcm")
1462:                     USE IN cursor_4c_BofIcm
1463:                 ENDIF
1464:             CATCH TO loc_oErro
1465:                 MsgErro("Erro ao carregar descricao sit. tributaria:" + CHR(13) + loc_oErro.Message, "Erro")
1466:             ENDTRY
1467:         ENDIF
1468: 
1469:         loc_oPagina.txt_4c_Cgru.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1470:         loc_oPagina.txt_4c_Dgru.Value      = loc_cDgrus
1471:         loc_oPagina.txt_4c_Estado.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEsts)
1472:         loc_oPagina.txt_4c_Icm.Value       = THIS.this_oBusinessObject.this_nIcms
1473:         loc_oPagina.txt_4c_Tpicm.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTpicms)

*-- Linhas 1567 a 1585:
1567:             RETURN
1568:         ENDIF
1569: 
1570:         SELECT cursor_4c_Dados
1571:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1572: 
1573:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1574:             THIS.this_oBusinessObject.EditarRegistro()
1575:             THIS.this_cModoAtual = "ALTERAR"
1576:             THIS.BOParaForm()
1577:             THIS.HabilitarCampos(.T.)
1578:             THIS.AlternarPagina(2)
1579:         ELSE
1580:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1581:         ENDIF
1582:     ENDPROC
1583: 
1584:     *--------------------------------------------------------------------------
1585:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao

*-- Linhas 1595 a 1613:
1595:             RETURN
1596:         ENDIF
1597: 
1598:         SELECT cursor_4c_Dados
1599:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1600: 
1601:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1602:             THIS.this_cModoAtual = "VISUALIZAR"
1603:             THIS.BOParaForm()
1604:             THIS.HabilitarCampos(.F.)
1605:             THIS.AlternarPagina(2)
1606:         ELSE
1607:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1608:         ENDIF
1609:     ENDPROC
1610: 
1611:     *--------------------------------------------------------------------------
1612:     * BtnExcluirClick - Exclui registro selecionado
1613:     *--------------------------------------------------------------------------

*-- Linhas 1627 a 1645:
1627:             RETURN
1628:         ENDIF
1629: 
1630:         SELECT cursor_4c_Dados
1631:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1632: 
1633:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1634:             IF THIS.this_oBusinessObject.Excluir()
1635:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1636:                 THIS.CarregarLista()
1637:             ENDIF
1638:         ELSE
1639:             MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
1640:         ENDIF
1641:     ENDPROC
1642: 
1643:     *--------------------------------------------------------------------------
1644:     * BtnBuscarClick - Recarrega lista completa
1645:     *--------------------------------------------------------------------------


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

