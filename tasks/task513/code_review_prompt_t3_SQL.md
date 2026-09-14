# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (12)
- [GRID-SQL] Campo 'dopps' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'tpops' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cgrus' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'opers' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'mercs' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contaorig' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcors' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, DOPPS, TPOPS, MERCS, GRUPOS, CONTAS, CONTAORIG, CODCORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, DOPPS, TPOPS, MERCS, GRUPOS, CONTAS, CONTAORIG, CODCORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'INATIVAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, DOPPS, TPOPS, MERCS, GRUPOS, CONTAS, CONTAORIG, CODCORS

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
  ControlSource = "crSigCdRpo.cgrus"
  ControlSource = "crSigCdRpo.dopps"
  ControlSource = "crSigCdRpo.TpOps"
  ControlSource = "crSigCdRpo.mercs"
  ControlSource = "crSigCdRpo.Grupos"
  ControlSource = "crSigCdRpo.Opers"
  ControlSource = "crSigCdRpo.Exclus"
  ControlSource = ""
  ControlSource = "crSigCdRpo.Contas"
  ControlSource = "crSigCdRpo.CodCors"
  ControlSource = "crSigCdRpo.ContaOrig"
lcQryOpt = [Select * From SigCdRpo ]
		If ThisForm.poDataMgr.SqlExecute([Select Dopes From SigCdOpe ],'CrOpe') < 1
		Select CrOpe
			Insert Into TmpOpe (Dopps ) Values (CrOpe.Dopes )
		If ThisForm.poDataMgr.SqlExecute([Select Dopps From SigCdOpd ],'Cropp') < 1
		Select CrOpp
			Insert Into TmpOpe (Dopps ) Values (Cropp.dopps )
lcSql = [Select Dgrus From SigCdGrp Where Cgrus = ']+CrSigCdRpo.Cgrus+[']
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalGru') < 0
Select crSigCdRpo
		lcQuery = [Select cIdChaves ] + ;
				    [From SigCdRpo ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
If Not Seek(This.Value,'TmpOpe','Dopps')
	lcQuery = [Select Cods, Descs, pFalhas, Grupos ] + ;
				[From SigOpOpt ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOpt') < 1)
	Select TmpOpt
	If Not Seek(This.Value)
select crSigCdRpo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1961 linhas total):

*-- Linhas 340 a 358:
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .Visible            = .T.
348:         ENDWITH
349: 
350:         THIS.TornarControlesVisiveis(loc_oPagina)
351:     ENDPROC
352: 
353:     *==========================================================================
354:     * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
355:     * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
356:     * Compensação PageFrame.Top=-31: todos os Tops somam +31
357:     *==========================================================================
358:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 871 a 901:
871:             ELSE
872:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
873: 
874:                 IF THIS.this_oBusinessObject.Buscar("")
875:                     loc_oGrid.ColumnCount = 9
876:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
877: 
878:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopps"
879:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tpops"
880:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
881:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.opers"
882:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.mercs"
883:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
884:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"
885:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.contaorig"
886:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.codcors"
887: 
888:                     loc_oGrid.Column1.Width = 150
889:                     loc_oGrid.Column2.Width = 120
890:                     loc_oGrid.Column3.Width = 80
891:                     loc_oGrid.Column4.Width = 60
892:                     loc_oGrid.Column5.Width = 80
893:                     loc_oGrid.Column6.Width = 80
894:                     loc_oGrid.Column7.Width = 100
895:                     loc_oGrid.Column8.Width = 100
896:                     loc_oGrid.Column9.Width = 60
897: 
898:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
899:                     loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
900:                     loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
901:                     loc_oGrid.Column4.Header1.Caption = "Op.Est."

*-- Linhas 988 a 1062:
988:     *==========================================================================
989:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
990:     *==========================================================================
991:     PROCEDURE BtnVisualizarClick()
992:         LOCAL loc_cChave
993:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
994:             MsgAviso("Selecione um registro na lista.")
995:             RETURN
996:         ENDIF
997:         SELECT cursor_4c_Dados
998:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
999:         IF EMPTY(loc_cChave)
1000:             MsgAviso("Selecione um registro na lista.")
1001:             RETURN
1002:         ENDIF
1003:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1004:             THIS.this_cModoAtual = "VISUALIZAR"
1005:             THIS.BOParaForm()
1006:             THIS.HabilitarCampos(.F.)
1007:             THIS.AjustarBotoesPorModo()
1008:             THIS.AlternarPagina(2)
1009:         ENDIF
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * BtnAlterarClick - Abre registro selecionado para edição
1014:     *==========================================================================
1015:     PROCEDURE BtnAlterarClick()
1016:         LOCAL loc_cChave
1017:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1018:             MsgAviso("Selecione um registro na lista.")
1019:             RETURN
1020:         ENDIF
1021:         SELECT cursor_4c_Dados
1022:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1023:         IF EMPTY(loc_cChave)
1024:             MsgAviso("Selecione um registro na lista.")
1025:             RETURN
1026:         ENDIF
1027:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1028:             THIS.this_oBusinessObject.EditarRegistro()
1029:             THIS.this_cModoAtual = "ALTERAR"
1030:             THIS.BOParaForm()
1031:             THIS.HabilitarCampos(.T.)
1032:             THIS.AjustarBotoesPorModo()
1033:             THIS.AlternarPagina(2)
1034:         ENDIF
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * BtnExcluirClick - Exclui registro selecionado após confirmação
1039:     *==========================================================================
1040:     PROCEDURE BtnExcluirClick()
1041:         LOCAL loc_cChave, loc_lConfirmado
1042:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1043:             MsgAviso("Selecione um registro na lista.")
1044:             RETURN
1045:         ENDIF
1046:         SELECT cursor_4c_Dados
1047:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1048:         IF EMPTY(loc_cChave)
1049:             MsgAviso("Selecione um registro na lista.")
1050:             RETURN
1051:         ENDIF
1052:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1053:         IF !loc_lConfirmado
1054:             RETURN
1055:         ENDIF
1056:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1057:             IF THIS.this_oBusinessObject.Excluir()
1058:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1059:                 THIS.CarregarLista()
1060:             ENDIF
1061:         ENDIF
1062:     ENDPROC

*-- Linhas 1133 a 1174:
1133: 
1134:         *-- Carregar descrição do Grupo de Produto via SigCdGrp
1135:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus))
1136:             loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1137:                 EscaparSQL(THIS.this_oBusinessObject.this_cCgrus)
1138:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
1139:             IF loc_nResult >= 0 AND USED("cursor_4c_GrupoDesc") AND !EOF("cursor_4c_GrupoDesc")
1140:                 SELECT cursor_4c_GrupoDesc
1141:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GrupoDesc.DGrus)
1142:             ELSE
1143:                 loc_oPagina.txt_4c__ds_grupo.Value = ""
1144:             ENDIF
1145:             IF USED("cursor_4c_GrupoDesc")
1146:                 USE IN cursor_4c_GrupoDesc
1147:             ENDIF
1148:         ELSE
1149:             loc_oPagina.txt_4c__ds_grupo.Value = ""
1150:         ENDIF
1151: 
1152:         *-- Carregar descrição do Grupo Contábil via SigCdGcr
1153:         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1154:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1155:             loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
1156:                 EscaparSQL(THIS.this_oBusinessObject.this_cGrupos)
1157:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposDesc")
1158:             IF loc_nResult >= 0 AND USED("cursor_4c_GruposDesc") AND !EOF("cursor_4c_GruposDesc")
1159:                 SELECT cursor_4c_GruposDesc
1160:                 loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_GruposDesc.Descrs)
1161:             ELSE
1162:                 loc_oPagina.txt_4c_Dgrupos.Value = ""
1163:             ENDIF
1164:             IF USED("cursor_4c_GruposDesc")
1165:                 USE IN cursor_4c_GruposDesc
1166:             ENDIF
1167:         ELSE
1168:             loc_oPagina.txt_4c_Dgrupos.Value = ""
1169:         ENDIF
1170:     ENDPROC
1171: 
1172:     *==========================================================================
1173:     * LimparCampos - Limpa todos os campos da Page2
1174:     *==========================================================================

*-- Linhas 1226 a 1251:
1226: 
1227:         IF EMPTY(loc_cDopp)
1228:             RETURN
1229:         ENDIF
1230: 
1231:         *-- Verificar em cursor_4c_Dados (já carregado) antes de abrir browse
1232:         IF USED("cursor_4c_Dados")
1233:             SELECT cursor_4c_Dados
1234:             LOCATE FOR UPPER(ALLTRIM(dopps)) = UPPER(loc_cDopp)
1235:             IF FOUND()
1236:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_Dados.dopps)
1237:                 RETURN
1238:             ENDIF
1239:         ENDIF
1240: 
1241:         THIS.AbrirBuscaDopp()
1242:     ENDPROC
1243: 
1244:     *==========================================================================
1245:     * TeclaPressionadaDopp - Captura F4 em txt_4c_Dopp para abrir busca
1246:     *==========================================================================
1247:     PROCEDURE TeclaPressionadaDopp(par_nKeyCode, par_nShiftAltCtrl)
1248:         IF par_nKeyCode = 63
1249:             THIS.AbrirBuscaDopp()
1250:         ENDIF
1251:     ENDPROC

*-- Linhas 1257 a 1287:
1257:     PROCEDURE AbrirBuscaDopp()
1258:         LOCAL loc_cSQL, loc_nResult, loc_oBusca
1259:         TRY
1260:             loc_cSQL = "SELECT DISTINCT RTRIM(Dopps) AS Dopps" + ;
1261:                 " FROM SigCdRpo ORDER BY Dopps"
1262:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDopp")
1263: 
1264:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaDopp")
1265:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1266:                 IF VARTYPE(loc_oBusca) = "O"
1267:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDopp"
1268:                     loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1269:                     loc_oBusca.mAddColuna("Dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
1270:                     loc_oBusca.Show()
1271:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDopp")
1272:                         SELECT cursor_4c_BuscaDopp
1273:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_BuscaDopp.Dopps)
1274:                     ENDIF
1275:                     loc_oBusca.Release()
1276:                 ENDIF
1277:             ELSE
1278:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1279:                     CHR(13) + CapturarErroSQL(), "Erro SQL")
1280:             ENDIF
1281:         CATCH TO loc_oErro
1282:             MsgErro("Erro ao abrir busca de opera" + CHR(231) + CHR(245) + "es:" + ;
1283:                 CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaDopp")
1284:         ENDTRY
1285:         IF USED("cursor_4c_BuscaDopp")
1286:             USE IN cursor_4c_BuscaDopp
1287:         ENDIF

*-- Linhas 1300 a 1324:
1300:         ENDIF
1301: 
1302:         TRY
1303:             loc_cSQL = "SELECT Cods FROM SigOpOpt" + ;
1304:                 " WHERE RTRIM(Cods) = " + EscaparSQL(loc_cTpop) + ;
1305:                 " AND NOT Situas = 2"
1306:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTpop")
1307: 
1308:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkTpop")
1309:                 SELECT cursor_4c_ChkTpop
1310:                 IF !EOF("cursor_4c_ChkTpop")
1311:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_ChkTpop.Cods)
1312:                 ELSE
1313:                     USE IN cursor_4c_ChkTpop
1314:                     THIS.AbrirBuscaTpop()
1315:                 ENDIF
1316:                 IF USED("cursor_4c_ChkTpop")
1317:                     USE IN cursor_4c_ChkTpop
1318:                 ENDIF
1319:             ELSE
1320:                 MsgErro("Erro ao validar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1321:             ENDIF
1322:         CATCH TO loc_oErro
1323:             MsgErro("Erro ao validar tipo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarTpop")
1324:         ENDTRY

*-- Linhas 1342 a 1373:
1342:         loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)
1343: 
1344:         TRY
1345:             loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt" + ;
1346:                 " WHERE NOT Situas = 2 ORDER BY Cods"
1347:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTpop")
1348: 
1349:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaTpop")
1350:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1351:                 IF VARTYPE(loc_oBusca) = "O"
1352:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpop"
1353:                     loc_oBusca.this_cTitulo = "Tipos de Opera" + CHR(231) + CHR(227) + "o"
1354:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
1355:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1356:                     loc_oBusca.Show()
1357:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpop")
1358:                         SELECT cursor_4c_BuscaTpop
1359:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_BuscaTpop.Cods)
1360:                     ENDIF
1361:                     loc_oBusca.Release()
1362:                 ENDIF
1363:             ELSE
1364:                 MsgErro("Erro ao carregar tipos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1365:             ENDIF
1366:         CATCH TO loc_oErro
1367:             MsgErro("Erro ao abrir busca de tipos:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaTpop")
1368:         ENDTRY
1369:         IF USED("cursor_4c_BuscaTpop")
1370:             USE IN cursor_4c_BuscaTpop
1371:         ENDIF
1372:     ENDPROC
1373: 

*-- Linhas 1419 a 1437:
1419:                 ENDIF
1420: 
1421:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
1422:                     SELECT cursor_4c_BuscaCgru
1423:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
1424:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
1425:                 ELSE
1426:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = " "
1427:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1428:                 ENDIF
1429:                 loc_oBusca.Release()
1430:             ENDIF
1431:         CATCH TO loc_oErro
1432:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCgru")
1433:         ENDTRY
1434:         IF USED("cursor_4c_BuscaCgru")
1435:             USE IN cursor_4c_BuscaCgru
1436:         ENDIF
1437:     ENDPROC

*-- Linhas 1463 a 1481:
1463:                 ENDIF
1464: 
1465:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDsGrp")
1466:                     SELECT cursor_4c_BuscaDsGrp
1467:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaDsGrp.CGrus)
1468:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaDsGrp.DGrus)
1469:                 ELSE
1470:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ""
1471:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1472:                 ENDIF
1473:                 loc_oBusca.Release()
1474:             ENDIF
1475:         CATCH TO loc_oErro
1476:             MsgErro("Erro ao buscar grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
1477:                 CHR(13) + loc_oErro.Message, "FormRop.ValidarDsGrupo")
1478:         ENDTRY
1479:         IF USED("cursor_4c_BuscaDsGrp")
1480:             USE IN cursor_4c_BuscaDsGrp
1481:         ENDIF

*-- Linhas 1541 a 1559:
1541:                 ENDIF
1542: 
1543:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGde")
1544:                     SELECT cursor_4c_BuscaGde
1545:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ALLTRIM(cursor_4c_BuscaGde.codigos)
1546:                 ELSE
1547:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ""
1548:                 ENDIF
1549:                 loc_oBusca.Release()
1550:             ENDIF
1551:         CATCH TO loc_oErro
1552:             MsgErro("Erro ao buscar grande grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGde")
1553:         ENDTRY
1554:         IF USED("cursor_4c_BuscaGde")
1555:             USE IN cursor_4c_BuscaGde
1556:         ENDIF
1557:     ENDPROC
1558: 
1559:     *==========================================================================

*-- Linhas 1573 a 1595:
1573:         ENDIF
1574: 
1575:         TRY
1576:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + ;
1577:                 EscaparSQL(loc_cGrupos)
1578:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrupos")
1579:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkGrupos")
1580:                 SELECT cursor_4c_ChkGrupos
1581:                 IF !EOF("cursor_4c_ChkGrupos")
1582:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_ChkGrupos.Codigos)
1583:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_ChkGrupos.Descrs)
1584:                 ELSE
1585:                     loc_lAbriuBusca = .T.
1586:                 ENDIF
1587:                 IF USED("cursor_4c_ChkGrupos")
1588:                     USE IN cursor_4c_ChkGrupos
1589:                 ENDIF
1590:             ELSE
1591:                 MsgErro("Erro ao validar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1592:             ENDIF
1593:         CATCH TO loc_oErro
1594:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarGrupos")
1595:         ENDTRY

*-- Linhas 1631 a 1649:
1631:                 ENDIF
1632: 
1633:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1634:                     SELECT cursor_4c_BuscaGrupos
1635:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupos.Codigos)
1636:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaGrupos.Descrs)
1637:                 ELSE
1638:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1639:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1640:                 ENDIF
1641:                 loc_oBusca.Release()
1642:             ENDIF
1643:         CATCH TO loc_oErro
1644:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGrupos")
1645:         ENDTRY
1646:         IF USED("cursor_4c_BuscaGrupos")
1647:             USE IN cursor_4c_BuscaGrupos
1648:         ENDIF
1649:     ENDPROC

*-- Linhas 1675 a 1693:
1675:                 ENDIF
1676: 
1677:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDgrupos")
1678:                     SELECT cursor_4c_BuscaDgrupos
1679:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaDgrupos.Codigos)
1680:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaDgrupos.Descrs)
1681:                 ELSE
1682:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1683:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1684:                 ENDIF
1685:                 loc_oBusca.Release()
1686:             ENDIF
1687:         CATCH TO loc_oErro
1688:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarDgrupos")
1689:         ENDTRY
1690:         IF USED("cursor_4c_BuscaDgrupos")
1691:             USE IN cursor_4c_BuscaDgrupos
1692:         ENDIF
1693:     ENDPROC

*-- Linhas 1707 a 1729:
1707:         ENDIF
1708: 
1709:         TRY
1710:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1711:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1712:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1713:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
1714:                 SELECT cursor_4c_ChkConta
1715:                 IF !EOF("cursor_4c_ChkConta")
1716:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_ChkConta.IClis)
1717:                 ELSE
1718:                     loc_lAbriuBusca = .T.
1719:                 ENDIF
1720:                 IF USED("cursor_4c_ChkConta")
1721:                     USE IN cursor_4c_ChkConta
1722:                 ENDIF
1723:             ELSE
1724:                 MsgErro("Erro ao validar conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1725:             ENDIF
1726:         CATCH TO loc_oErro
1727:             MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarConta")
1728:         ENDTRY
1729: 

*-- Linhas 1750 a 1781:
1750:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1751: 
1752:         TRY
1753:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1754:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1755:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1756: 
1757:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaConta")
1758:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1759:                 IF VARTYPE(loc_oBusca) = "O"
1760:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1761:                     loc_oBusca.this_cTitulo = "Contas"
1762:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1763:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1764:                     loc_oBusca.Show()
1765:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1766:                         SELECT cursor_4c_BuscaConta
1767:                         loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1768:                     ENDIF
1769:                     loc_oBusca.Release()
1770:                 ENDIF
1771:             ELSE
1772:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1773:             ENDIF
1774:         CATCH TO loc_oErro
1775:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaConta")
1776:         ENDTRY
1777:         IF USED("cursor_4c_BuscaConta")
1778:             USE IN cursor_4c_BuscaConta
1779:         ENDIF
1780:     ENDPROC
1781: 

*-- Linhas 1794 a 1816:
1794:         ENDIF
1795: 
1796:         TRY
1797:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1798:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1799:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkContaOrig")
1800:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkContaOrig")
1801:                 SELECT cursor_4c_ChkContaOrig
1802:                 IF !EOF("cursor_4c_ChkContaOrig")
1803:                     loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_ChkContaOrig.IClis)
1804:                 ELSE
1805:                     loc_lAbriuBusca = .T.
1806:                 ENDIF
1807:                 IF USED("cursor_4c_ChkContaOrig")
1808:                     USE IN cursor_4c_ChkContaOrig
1809:                 ENDIF
1810:             ELSE
1811:                 MsgErro("Erro ao validar conta origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1812:             ENDIF
1813:         CATCH TO loc_oErro
1814:             MsgErro("Erro ao validar conta origem:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarContaOrig")
1815:         ENDTRY
1816: 

*-- Linhas 1837 a 1868:
1837:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1838: 
1839:         TRY
1840:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1841:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1842:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaOrig")
1843: 
1844:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaContaOrig")
1845:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1846:                 IF VARTYPE(loc_oBusca) = "O"
1847:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaContaOrig"
1848:                     loc_oBusca.this_cTitulo = "Contas"
1849:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1850:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1851:                     loc_oBusca.Show()
1852:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOrig")
1853:                         SELECT cursor_4c_BuscaContaOrig
1854:                         loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_BuscaContaOrig.IClis)
1855:                     ENDIF
1856:                     loc_oBusca.Release()
1857:                 ENDIF
1858:             ELSE
1859:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1860:             ENDIF
1861:         CATCH TO loc_oErro
1862:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaContaOrig")
1863:         ENDTRY
1864:         IF USED("cursor_4c_BuscaContaOrig")
1865:             USE IN cursor_4c_BuscaContaOrig
1866:         ENDIF
1867:     ENDPROC
1868: 

*-- Linhas 1913 a 1931:
1913:                 ENDIF
1914: 
1915:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
1916:                     SELECT cursor_4c_BuscaCor
1917:                     loc_oPagina.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
1918:                 ELSE
1919:                     loc_oPagina.txt_4c_Cor.Value = ""
1920:                 ENDIF
1921:                 loc_oBusca.Release()
1922:             ENDIF
1923:         CATCH TO loc_oErro
1924:             MsgErro("Erro ao buscar cor:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCor")
1925:         ENDTRY
1926:         IF USED("cursor_4c_BuscaCor")
1927:             USE IN cursor_4c_BuscaCor
1928:         ENDIF
1929:     ENDPROC
1930: 
1931:     *==========================================================================


### BO (C:\4c\projeto\app\classes\RopBO.prg):
*==============================================================================
* RopBO.prg
*
* Business Object para Cadastro de Restricoes Por Operacao
* Tabela: SigCdRpo
* Herda de: BusinessBase
*
* Colunas da tabela SigCdRpo:
*   cidchaves  char(20)    PK - Chave unica gerada via NEWID
*   cgrus      char(3)     Grupo de Produto
*   dopps      char(20)    Operacao de Producao
*   doptpgrus  char(48)    Composto: Dopp+TpOp+Cgru+Mercs+Grupos
*   tpops      char(15)    Tipo de Material/Operacao
*   mercs      char(3)     Grande Grupo
*   opers      char(1)     Operacao Estoque (E/S)
*   grupos     char(10)    Grupo de Conta Contabil
*   exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
*   contas     char(10)    Conta Destino
*   codcors    char(4)     Codigo da Cor
*   contaorig  char(10)    Conta Origem
*==============================================================================

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdRpo)
    this_cCidChaves  = ""   && cidchaves  char(20)    PK
    this_cCgrus      = ""   && cgrus      char(3)     Grupo de Produto
    this_cDopps      = ""   && dopps      char(20)    Operacao
    this_cDoptpgrus  = ""   && doptpgrus  char(48)    Composto (auto-gerado)
    this_cTpops      = ""   && tpops      char(15)    Tipo de Material
    this_cMercs      = ""   && mercs      char(3)     Grande Grupo
    this_cOpers      = ""   && opers      char(1)     Op.Estoque E/S
    this_cGrupos     = ""   && grupos     char(10)    Grupo Conta
    this_nExclus     = 2    && exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
    this_cContas     = ""   && contas     char(10)    Conta Destino
    this_cCodcors    = ""   && codcors    char(4)     Cor
    this_cContaorig  = ""   && contaorig  char(10)    Conta Origem

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCgrus      = TratarNulo(cgrus,      "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_cDoptpgrus  = TratarNulo(doptpgrus,  "C")
                THIS.this_cTpops      = TratarNulo(tpops,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cOpers      = TratarNulo(opers,      "C")
                THIS.this_cGrupos     = TratarNulo(grupos,     "C")
                THIS.this_nExclus     = TratarNulo(exclus,     "N")
                THIS.this_cContas     = TratarNulo(contas,     "C")
                THIS.this_cCodcors    = TratarNulo(codcors,    "C")
                THIS.this_cContaorig  = TratarNulo(contaorig,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves  = ""
        THIS.this_cCgrus      = ""
        THIS.this_cDopps      = ""
        THIS.this_cDoptpgrus  = ""
        THIS.this_cTpops      = ""
        THIS.this_cMercs      = ""
        THIS.this_cOpers      = ""
        THIS.this_cGrupos     = ""
        THIS.this_nExclus     = 2
        THIS.this_cContas     = ""
        THIS.this_cCodcors    = ""
        THIS.this_cContaorig  = ""
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(THIS.this_cTpops) AND EMPTY(THIS.this_cCgrus) AND ;
               EMPTY(THIS.this_cMercs) AND EMPTY(THIS.this_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo de Material Ou " + ;
                    "Grupo de Produto Ou Grande Grupo Ou Grupo Conta")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite Apenas [E] ou [S] ou [ ] !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido
            IF THIS.VerificarDuplicidade()
                MsgAviso("Restri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica restricao ja cadastrada com mesmos campos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRpo" + ;
                " WHERE Dopps    = " + EscaparSQL(THIS.this_cDopps) + ;
                " AND   TpOps    = " + EscaparSQL(THIS.this_cTpops) + ;
                " AND   CGrus    = " + EscaparSQL(THIS.this_cCgrus) + ;
                " AND   Mercs    = " + EscaparSQL(THIS.this_cMercs) + ;
                " AND   Grupos   = " + EscaparSQL(THIS.this_cGrupos) + ;
                " AND   Contas   = " + EscaparSQL(THIS.this_cContas) + ;
                " AND   ContaOrig= " + EscaparSQL(THIS.this_cContaorig) + ;
                " AND   CodCors  = " + EscaparSQL(THIS.this_cCodcors) + ;
                " AND   cidchaves <> " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RopBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult, loc_cSQL
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RopBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RopBO.Inserir")
            ELSE
                THIS.this_cDoptpgrus = LEFT( ;
                    ALLTRIM(THIS.this_cDopps)  + ;
                    ALLTRIM(THIS.this_cTpops)  + ;
                    ALLTRIM(THIS.this_cCgrus)  + ;
                    ALLTRIM(THIS.this_cMercs)  + ;
                    ALLTRIM(THIS.this_cGrupos) + ;
                    SPACE(48), 48)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdRpo (
                        cidchaves, cgrus, dopps, doptpgrus, tpops,
                        mercs, opers, grupos, exclus, contas, codcors, contaorig
                    ) VALUES (
                        <<EscaparSQL(THIS.this_cCidChaves)>>,
                        <<EscaparSQL(THIS.this_cCgrus)>>,
                        <<EscaparSQL(THIS.this_cDopps)>>,
                        <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                        <<EscaparSQL(THIS.this_cTpops)>>,
                        <<EscaparSQL(THIS.this_cMercs)>>,
                        <<EscaparSQL(THIS.this_cOpers)>>,
                        <<EscaparSQL(THIS.this_cGrupos)>>,
                        <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                        <<EscaparSQL(THIS.this_cContas)>>,
                        <<EscaparSQL(THIS.this_cCodcors)>>,
                        <<EscaparSQL(THIS.this_cContaorig)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDoptpgrus = LEFT( ;
                ALLTRIM(THIS.this_cDopps)  + ;
                ALLTRIM(THIS.this_cTpops)  + ;
                ALLTRIM(THIS.this_cCgrus)  + ;
                ALLTRIM(THIS.this_cMercs)  + ;
                ALLTRIM(THIS.this_cGrupos) + ;
                SPACE(48), 48)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdRpo SET
                    cgrus      = <<EscaparSQL(THIS.this_cCgrus)>>,
                    dopps      = <<EscaparSQL(THIS.this_cDopps)>>,
                    doptpgrus  = <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                    tpops      = <<EscaparSQL(THIS.this_cTpops)>>,
                    mercs      = <<EscaparSQL(THIS.this_cMercs)>>,
                    opers      = <<EscaparSQL(THIS.this_cOpers)>>,
                    grupos     = <<EscaparSQL(THIS.this_cGrupos)>>,
                    exclus     = <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodcors)>>,
                    contaorig  = <<EscaparSQL(THIS.this_cContaorig)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas para o grid (ordem identica ao legado)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        dopps     C(20), ;
                        tpops     C(15), ;
                        cgrus     C(3),  ;
                        opers     C(1),  ;
                        mercs     C(3),  ;
                        grupos    C(10), ;
                        contas    C(10), ;
                        contaorig C(10), ;
                        codcors   C(4),  ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT dopps, tpops, cgrus, opers, mercs," + ;
                    " grupos, contas, contaorig, codcors, cidchaves" + ;
                    " FROM SigCdRpo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dopps, tpops, cgrus"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cgrus, dopps, doptpgrus, tpops," + ;
                " mercs, opers, grupos, exclus, contas, codcors, contaorig" + ;
                " FROM SigCdRpo WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

