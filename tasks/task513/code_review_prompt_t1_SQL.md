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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRop.prg) - TRECHOS RELEVANTES PARA PASS SQL (1958 linhas total):

*-- Linhas 337 a 355:
337:             .HighlightBackColor = RGB(255, 255, 255)
338:             .HighlightForeColor = RGB(15, 41, 104)
339:             .HighlightStyle     = 2
340:             .DeleteMark         = .F.
341:             .RecordMark         = .F.
342:             .RowHeight          = 16
343:             .ScrollBars         = 2
344:             .Visible            = .T.
345:         ENDWITH
346: 
347:         THIS.TornarControlesVisiveis(loc_oPagina)
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
352:     * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
353:     * Compensação PageFrame.Top=-31: todos os Tops somam +31
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 868 a 898:
868:             ELSE
869:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
870: 
871:                 IF THIS.this_oBusinessObject.Buscar("")
872:                     loc_oGrid.ColumnCount = 9
873:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
874: 
875:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopps"
876:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tpops"
877:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
878:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.opers"
879:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.mercs"
880:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
881:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"
882:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.contaorig"
883:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.codcors"
884: 
885:                     loc_oGrid.Column1.Width = 150
886:                     loc_oGrid.Column2.Width = 120
887:                     loc_oGrid.Column3.Width = 80
888:                     loc_oGrid.Column4.Width = 60
889:                     loc_oGrid.Column5.Width = 80
890:                     loc_oGrid.Column6.Width = 80
891:                     loc_oGrid.Column7.Width = 100
892:                     loc_oGrid.Column8.Width = 100
893:                     loc_oGrid.Column9.Width = 60
894: 
895:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
896:                     loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
897:                     loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
898:                     loc_oGrid.Column4.Header1.Caption = "Op.Est."

*-- Linhas 985 a 1059:
985:     *==========================================================================
986:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
987:     *==========================================================================
988:     PROCEDURE BtnVisualizarClick()
989:         LOCAL loc_cChave
990:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
991:             MsgAviso("Selecione um registro na lista.")
992:             RETURN
993:         ENDIF
994:         SELECT cursor_4c_Dados
995:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
996:         IF EMPTY(loc_cChave)
997:             MsgAviso("Selecione um registro na lista.")
998:             RETURN
999:         ENDIF
1000:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1001:             THIS.this_cModoAtual = "VISUALIZAR"
1002:             THIS.BOParaForm()
1003:             THIS.HabilitarCampos(.F.)
1004:             THIS.AjustarBotoesPorModo()
1005:             THIS.AlternarPagina(2)
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * BtnAlterarClick - Abre registro selecionado para edição
1011:     *==========================================================================
1012:     PROCEDURE BtnAlterarClick()
1013:         LOCAL loc_cChave
1014:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1015:             MsgAviso("Selecione um registro na lista.")
1016:             RETURN
1017:         ENDIF
1018:         SELECT cursor_4c_Dados
1019:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1020:         IF EMPTY(loc_cChave)
1021:             MsgAviso("Selecione um registro na lista.")
1022:             RETURN
1023:         ENDIF
1024:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1025:             THIS.this_oBusinessObject.EditarRegistro()
1026:             THIS.this_cModoAtual = "ALTERAR"
1027:             THIS.BOParaForm()
1028:             THIS.HabilitarCampos(.T.)
1029:             THIS.AjustarBotoesPorModo()
1030:             THIS.AlternarPagina(2)
1031:         ENDIF
1032:     ENDPROC
1033: 
1034:     *==========================================================================
1035:     * BtnExcluirClick - Exclui registro selecionado após confirmação
1036:     *==========================================================================
1037:     PROCEDURE BtnExcluirClick()
1038:         LOCAL loc_cChave, loc_lConfirmado
1039:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1040:             MsgAviso("Selecione um registro na lista.")
1041:             RETURN
1042:         ENDIF
1043:         SELECT cursor_4c_Dados
1044:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1045:         IF EMPTY(loc_cChave)
1046:             MsgAviso("Selecione um registro na lista.")
1047:             RETURN
1048:         ENDIF
1049:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1050:         IF !loc_lConfirmado
1051:             RETURN
1052:         ENDIF
1053:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1054:             IF THIS.this_oBusinessObject.Excluir()
1055:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1056:                 THIS.CarregarLista()
1057:             ENDIF
1058:         ENDIF
1059:     ENDPROC

*-- Linhas 1130 a 1171:
1130: 
1131:         *-- Carregar descrição do Grupo de Produto via SigCdGrp
1132:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus))
1133:             loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1134:                 EscaparSQL(THIS.this_oBusinessObject.this_cCgrus)
1135:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
1136:             IF loc_nResult >= 0 AND USED("cursor_4c_GrupoDesc") AND !EOF("cursor_4c_GrupoDesc")
1137:                 SELECT cursor_4c_GrupoDesc
1138:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GrupoDesc.DGrus)
1139:             ELSE
1140:                 loc_oPagina.txt_4c__ds_grupo.Value = ""
1141:             ENDIF
1142:             IF USED("cursor_4c_GrupoDesc")
1143:                 USE IN cursor_4c_GrupoDesc
1144:             ENDIF
1145:         ELSE
1146:             loc_oPagina.txt_4c__ds_grupo.Value = ""
1147:         ENDIF
1148: 
1149:         *-- Carregar descrição do Grupo Contábil via SigCdGcr
1150:         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1151:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1152:             loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
1153:                 EscaparSQL(THIS.this_oBusinessObject.this_cGrupos)
1154:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposDesc")
1155:             IF loc_nResult >= 0 AND USED("cursor_4c_GruposDesc") AND !EOF("cursor_4c_GruposDesc")
1156:                 SELECT cursor_4c_GruposDesc
1157:                 loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_GruposDesc.Descrs)
1158:             ELSE
1159:                 loc_oPagina.txt_4c_Dgrupos.Value = ""
1160:             ENDIF
1161:             IF USED("cursor_4c_GruposDesc")
1162:                 USE IN cursor_4c_GruposDesc
1163:             ENDIF
1164:         ELSE
1165:             loc_oPagina.txt_4c_Dgrupos.Value = ""
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * LimparCampos - Limpa todos os campos da Page2
1171:     *==========================================================================

*-- Linhas 1223 a 1248:
1223: 
1224:         IF EMPTY(loc_cDopp)
1225:             RETURN
1226:         ENDIF
1227: 
1228:         *-- Verificar em cursor_4c_Dados (já carregado) antes de abrir browse
1229:         IF USED("cursor_4c_Dados")
1230:             SELECT cursor_4c_Dados
1231:             LOCATE FOR UPPER(ALLTRIM(dopps)) = UPPER(loc_cDopp)
1232:             IF FOUND()
1233:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_Dados.dopps)
1234:                 RETURN
1235:             ENDIF
1236:         ENDIF
1237: 
1238:         THIS.AbrirBuscaDopp()
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * TeclaPressionadaDopp - Captura F4 em txt_4c_Dopp para abrir busca
1243:     *==========================================================================
1244:     PROCEDURE TeclaPressionadaDopp(par_nKeyCode, par_nShiftAltCtrl)
1245:         IF par_nKeyCode = 63
1246:             THIS.AbrirBuscaDopp()
1247:         ENDIF
1248:     ENDPROC

*-- Linhas 1254 a 1284:
1254:     PROCEDURE AbrirBuscaDopp()
1255:         LOCAL loc_cSQL, loc_nResult, loc_oBusca
1256:         TRY
1257:             loc_cSQL = "SELECT DISTINCT RTRIM(Dopps) AS Dopps" + ;
1258:                 " FROM SigCdRpo ORDER BY Dopps"
1259:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDopp")
1260: 
1261:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaDopp")
1262:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1263:                 IF VARTYPE(loc_oBusca) = "O"
1264:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDopp"
1265:                     loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1266:                     loc_oBusca.mAddColuna("Dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
1267:                     loc_oBusca.Show()
1268:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDopp")
1269:                         SELECT cursor_4c_BuscaDopp
1270:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_BuscaDopp.Dopps)
1271:                     ENDIF
1272:                     loc_oBusca.Release()
1273:                 ENDIF
1274:             ELSE
1275:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1276:                     CHR(13) + CapturarErroSQL(), "Erro SQL")
1277:             ENDIF
1278:         CATCH TO loc_oErro
1279:             MsgErro("Erro ao abrir busca de opera" + CHR(231) + CHR(245) + "es:" + ;
1280:                 CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaDopp")
1281:         ENDTRY
1282:         IF USED("cursor_4c_BuscaDopp")
1283:             USE IN cursor_4c_BuscaDopp
1284:         ENDIF

*-- Linhas 1297 a 1321:
1297:         ENDIF
1298: 
1299:         TRY
1300:             loc_cSQL = "SELECT Cods FROM SigOpOpt" + ;
1301:                 " WHERE RTRIM(Cods) = " + EscaparSQL(loc_cTpop) + ;
1302:                 " AND NOT Situas = 2"
1303:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTpop")
1304: 
1305:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkTpop")
1306:                 SELECT cursor_4c_ChkTpop
1307:                 IF !EOF("cursor_4c_ChkTpop")
1308:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_ChkTpop.Cods)
1309:                 ELSE
1310:                     USE IN cursor_4c_ChkTpop
1311:                     THIS.AbrirBuscaTpop()
1312:                 ENDIF
1313:                 IF USED("cursor_4c_ChkTpop")
1314:                     USE IN cursor_4c_ChkTpop
1315:                 ENDIF
1316:             ELSE
1317:                 MsgErro("Erro ao validar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             MsgErro("Erro ao validar tipo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarTpop")
1321:         ENDTRY

*-- Linhas 1339 a 1370:
1339:         loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)
1340: 
1341:         TRY
1342:             loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt" + ;
1343:                 " WHERE NOT Situas = 2 ORDER BY Cods"
1344:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTpop")
1345: 
1346:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaTpop")
1347:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1348:                 IF VARTYPE(loc_oBusca) = "O"
1349:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpop"
1350:                     loc_oBusca.this_cTitulo = "Tipos de Opera" + CHR(231) + CHR(227) + "o"
1351:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
1352:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1353:                     loc_oBusca.Show()
1354:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpop")
1355:                         SELECT cursor_4c_BuscaTpop
1356:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_BuscaTpop.Cods)
1357:                     ENDIF
1358:                     loc_oBusca.Release()
1359:                 ENDIF
1360:             ELSE
1361:                 MsgErro("Erro ao carregar tipos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1362:             ENDIF
1363:         CATCH TO loc_oErro
1364:             MsgErro("Erro ao abrir busca de tipos:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaTpop")
1365:         ENDTRY
1366:         IF USED("cursor_4c_BuscaTpop")
1367:             USE IN cursor_4c_BuscaTpop
1368:         ENDIF
1369:     ENDPROC
1370: 

*-- Linhas 1416 a 1434:
1416:                 ENDIF
1417: 
1418:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
1419:                     SELECT cursor_4c_BuscaCgru
1420:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
1421:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
1422:                 ELSE
1423:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = " "
1424:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1425:                 ENDIF
1426:                 loc_oBusca.Release()
1427:             ENDIF
1428:         CATCH TO loc_oErro
1429:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCgru")
1430:         ENDTRY
1431:         IF USED("cursor_4c_BuscaCgru")
1432:             USE IN cursor_4c_BuscaCgru
1433:         ENDIF
1434:     ENDPROC

*-- Linhas 1460 a 1478:
1460:                 ENDIF
1461: 
1462:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDsGrp")
1463:                     SELECT cursor_4c_BuscaDsGrp
1464:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaDsGrp.CGrus)
1465:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaDsGrp.DGrus)
1466:                 ELSE
1467:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ""
1468:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1469:                 ENDIF
1470:                 loc_oBusca.Release()
1471:             ENDIF
1472:         CATCH TO loc_oErro
1473:             MsgErro("Erro ao buscar grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
1474:                 CHR(13) + loc_oErro.Message, "FormRop.ValidarDsGrupo")
1475:         ENDTRY
1476:         IF USED("cursor_4c_BuscaDsGrp")
1477:             USE IN cursor_4c_BuscaDsGrp
1478:         ENDIF

*-- Linhas 1538 a 1556:
1538:                 ENDIF
1539: 
1540:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGde")
1541:                     SELECT cursor_4c_BuscaGde
1542:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ALLTRIM(cursor_4c_BuscaGde.codigos)
1543:                 ELSE
1544:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ""
1545:                 ENDIF
1546:                 loc_oBusca.Release()
1547:             ENDIF
1548:         CATCH TO loc_oErro
1549:             MsgErro("Erro ao buscar grande grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGde")
1550:         ENDTRY
1551:         IF USED("cursor_4c_BuscaGde")
1552:             USE IN cursor_4c_BuscaGde
1553:         ENDIF
1554:     ENDPROC
1555: 
1556:     *==========================================================================

*-- Linhas 1570 a 1592:
1570:         ENDIF
1571: 
1572:         TRY
1573:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + ;
1574:                 EscaparSQL(loc_cGrupos)
1575:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrupos")
1576:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkGrupos")
1577:                 SELECT cursor_4c_ChkGrupos
1578:                 IF !EOF("cursor_4c_ChkGrupos")
1579:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_ChkGrupos.Codigos)
1580:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_ChkGrupos.Descrs)
1581:                 ELSE
1582:                     loc_lAbriuBusca = .T.
1583:                 ENDIF
1584:                 IF USED("cursor_4c_ChkGrupos")
1585:                     USE IN cursor_4c_ChkGrupos
1586:                 ENDIF
1587:             ELSE
1588:                 MsgErro("Erro ao validar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1589:             ENDIF
1590:         CATCH TO loc_oErro
1591:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarGrupos")
1592:         ENDTRY

*-- Linhas 1628 a 1646:
1628:                 ENDIF
1629: 
1630:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1631:                     SELECT cursor_4c_BuscaGrupos
1632:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupos.Codigos)
1633:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaGrupos.Descrs)
1634:                 ELSE
1635:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1636:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1637:                 ENDIF
1638:                 loc_oBusca.Release()
1639:             ENDIF
1640:         CATCH TO loc_oErro
1641:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGrupos")
1642:         ENDTRY
1643:         IF USED("cursor_4c_BuscaGrupos")
1644:             USE IN cursor_4c_BuscaGrupos
1645:         ENDIF
1646:     ENDPROC

*-- Linhas 1672 a 1690:
1672:                 ENDIF
1673: 
1674:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDgrupos")
1675:                     SELECT cursor_4c_BuscaDgrupos
1676:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaDgrupos.Codigos)
1677:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaDgrupos.Descrs)
1678:                 ELSE
1679:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1680:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1681:                 ENDIF
1682:                 loc_oBusca.Release()
1683:             ENDIF
1684:         CATCH TO loc_oErro
1685:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarDgrupos")
1686:         ENDTRY
1687:         IF USED("cursor_4c_BuscaDgrupos")
1688:             USE IN cursor_4c_BuscaDgrupos
1689:         ENDIF
1690:     ENDPROC

*-- Linhas 1704 a 1726:
1704:         ENDIF
1705: 
1706:         TRY
1707:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1708:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1709:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1710:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
1711:                 SELECT cursor_4c_ChkConta
1712:                 IF !EOF("cursor_4c_ChkConta")
1713:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_ChkConta.IClis)
1714:                 ELSE
1715:                     loc_lAbriuBusca = .T.
1716:                 ENDIF
1717:                 IF USED("cursor_4c_ChkConta")
1718:                     USE IN cursor_4c_ChkConta
1719:                 ENDIF
1720:             ELSE
1721:                 MsgErro("Erro ao validar conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1722:             ENDIF
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarConta")
1725:         ENDTRY
1726: 

*-- Linhas 1747 a 1778:
1747:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1748: 
1749:         TRY
1750:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1751:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1752:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1753: 
1754:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaConta")
1755:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1756:                 IF VARTYPE(loc_oBusca) = "O"
1757:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1758:                     loc_oBusca.this_cTitulo = "Contas"
1759:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1760:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1761:                     loc_oBusca.Show()
1762:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1763:                         SELECT cursor_4c_BuscaConta
1764:                         loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1765:                     ENDIF
1766:                     loc_oBusca.Release()
1767:                 ENDIF
1768:             ELSE
1769:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1770:             ENDIF
1771:         CATCH TO loc_oErro
1772:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaConta")
1773:         ENDTRY
1774:         IF USED("cursor_4c_BuscaConta")
1775:             USE IN cursor_4c_BuscaConta
1776:         ENDIF
1777:     ENDPROC
1778: 

*-- Linhas 1791 a 1813:
1791:         ENDIF
1792: 
1793:         TRY
1794:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1795:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1796:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkContaOrig")
1797:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkContaOrig")
1798:                 SELECT cursor_4c_ChkContaOrig
1799:                 IF !EOF("cursor_4c_ChkContaOrig")
1800:                     loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_ChkContaOrig.IClis)
1801:                 ELSE
1802:                     loc_lAbriuBusca = .T.
1803:                 ENDIF
1804:                 IF USED("cursor_4c_ChkContaOrig")
1805:                     USE IN cursor_4c_ChkContaOrig
1806:                 ENDIF
1807:             ELSE
1808:                 MsgErro("Erro ao validar conta origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1809:             ENDIF
1810:         CATCH TO loc_oErro
1811:             MsgErro("Erro ao validar conta origem:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarContaOrig")
1812:         ENDTRY
1813: 

*-- Linhas 1834 a 1865:
1834:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1835: 
1836:         TRY
1837:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1838:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1839:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaOrig")
1840: 
1841:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaContaOrig")
1842:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1843:                 IF VARTYPE(loc_oBusca) = "O"
1844:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaContaOrig"
1845:                     loc_oBusca.this_cTitulo = "Contas"
1846:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1847:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1848:                     loc_oBusca.Show()
1849:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOrig")
1850:                         SELECT cursor_4c_BuscaContaOrig
1851:                         loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_BuscaContaOrig.IClis)
1852:                     ENDIF
1853:                     loc_oBusca.Release()
1854:                 ENDIF
1855:             ELSE
1856:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1857:             ENDIF
1858:         CATCH TO loc_oErro
1859:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaContaOrig")
1860:         ENDTRY
1861:         IF USED("cursor_4c_BuscaContaOrig")
1862:             USE IN cursor_4c_BuscaContaOrig
1863:         ENDIF
1864:     ENDPROC
1865: 

*-- Linhas 1910 a 1928:
1910:                 ENDIF
1911: 
1912:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
1913:                     SELECT cursor_4c_BuscaCor
1914:                     loc_oPagina.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
1915:                 ELSE
1916:                     loc_oPagina.txt_4c_Cor.Value = ""
1917:                 ENDIF
1918:                 loc_oBusca.Release()
1919:             ENDIF
1920:         CATCH TO loc_oErro
1921:             MsgErro("Erro ao buscar cor:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCor")
1922:         ENDTRY
1923:         IF USED("cursor_4c_BuscaCor")
1924:             USE IN cursor_4c_BuscaCor
1925:         ENDIF
1926:     ENDPROC
1927: 
1928:     *==========================================================================


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

