# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 1, MARCAS, EMPS, CODS, CONFERIDO, EMPOS, LOCALIZAS, CPROS, CONTAS, ESTOS, GRUPOS, ICLIS, JOBS, USUARS, INATIVAS

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
  ControlSource = "crSigCdCnl.Vends"
  ControlSource = "crSigCdCnl.DesVends"
  ControlSource = "crSigCdCnl.Cods"
  DeleteMark = .F.
  ControlSource = "crSigCdCnl.Qtds"
lnOldSel = Select()
Select &pcCursor.
Select cidchaves, Cods, Descs, 0 as Marcas, Space(4) as Codigo From &pcCursor. Where 1=0 Into Cursor CrAux ReadWrite
Select &pcCursor.	
		Select CrAux
			Select &pcCurDest.
			Select CrAux	
Select &pcNivAnt.
Select(lnOldSel)
	lcQryCnl = [select a.*, b.rclis as desvends, c.descricaos as dlocals ] + ;
				[from sigcdcnl a ] + ;
				[join sigcdcli b on a.vends = b.iclis ] + ;
				[left join SigPrLcl c on a.locals = c.codigos ] + ;
	lcSqlCdCni = [Select * From SigCdCnI Where Cods = ?lcCods]
		lcQuery = [Select * From SigLcNv1]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel1])
		lcQuery = [Select * From SigLcNv2]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel2])
		lcQuery = [Select * From SigLcNv3]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel3])
		lcQuery = [Select * From SigLcNv4]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel4])
		Select csNivel1
		Select *, Space(4) as Codigo From csNivel1 Where 1=0 Into Cursor crSigLcNv1 ReadWrite
		Select csNivel2
		Select *, Space(4) as Codigo From csNivel2 Where 1=0 Into Cursor crSigLcNv2 ReadWrite
		Select csNivel3
		Select *, Space(4) as Codigo From csNivel3 Where 1=0 Into Cursor crSigLcNv3 ReadWrite
		Select csNivel4
		Select *, Space(4) as Codigo From csNivel4 Where 1=0 Into Cursor crSigLcNv4 ReadWrite
Select crSigCdCnL
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCnl Where Cods = ?lcCods], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCnI Where Cods = ?lcCods], '') < 1)
If llOk And Not Thisform.poDataMgr.Update('crSigCdCnl')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCnl)')
If llOk And Not Thisform.poDataMgr.Update('crSigCdCnI')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCnI)')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCnl Where Cods = ?lcCods], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCnI Where Cods = ?lcCods], '') < 1)
If Not Thisform.poDataMgr.Update('crSigCdCnl')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCnl)')
If llOk And Not Thisform.poDataMgr.Update('crSigCdCnI')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCnI)')
lnOldSel = Select()
lcQuery = [Select localizas as Locals,Sum(Qtde) As qtde, convert(numeric(5,0),0) as QtdCtg, Nivel1s, Nivel2s, Nivel3s, Nivel4s  ] + ;
			[From ( Select localizas,a.grupos,a.contas,a.empos, Count(1) As qtde, ] + ;
			[From SigOpEtq A ] + ;
			[left join (Select Cpros,Cgrus,Mercs,Colecoes,SGrus from SigCdPro) B on b.cpros = a.cpros ] + ;  
			[Select a.locals, a.grupos, a.estos, a.emps, sum(sqtds) as Total, ] + ;
			[From SigMvesl a, SigCdpro b ] + ;  
			[And a.cpros + a.locals not in(select cpros + localizas from sigopetq) ] + ;
If (ThisForm.podatamgr.SqlExecute(lcQuery,[csSigCdCnI])<1)
	Select(lnOldSel)
Select csSigCdCnI
Select crSigCdCnI
	If Seek(crSigCdCnI.Locals,[csSigCdCnI],[Locals])
	Select csSigCdCnI
		If Not Seek(csSigCdCnI.Locals,[crSigCdCnI],[Locals])
			Delete 
		Select csSigCdCnI
Select crSigCdCnI
Select csSigCdCnI
Thisform.pagina.dados.GrdLoc.column1.ControlSource = [csSigCdCnI.Locals]
Thisform.pagina.dados.GrdLoc.column2.ControlSource = [csSigCdCnI.QtdCtg]
Thisform.pagina.dados.GrdLoc.column3.ControlSource = [csSigCdCnI.Qtde] 
Select(lnOldSel)
	Select csSigCdCni
		Select crSigCdCni
		Select csSigCdCni
	Select crSigCdCni
lnOldSel = Select()
lcQuery = [Select localizas as Locals,grupos,contas,empos, Sum(Qtde) As qtde, convert(numeric(5,0),0) as QtdCtg, Space(100) as Descr  ] + ;
			[From ( Select localizas,Space(10) as grupos,Space(10) as contas,a.empos, Count(1) As qtde ] + ;
			[From SigOpEtq A ] + ;
			[left join (Select Cpros,Cgrus,Mercs,Colecoes,SGrus from SigCdPro) B on b.cpros = a.cpros ] + ;  
			[Select a.locals, Space(10) as grupos, Space(10) as estos, a.emps, sum(sqtds) as Total ] + ;
			[From SigMvesl a, SigCdpro b ] + ;  
If (ThisForm.podatamgr.SqlExecute(lcQuery,[csTmpCdCnI])<1)
	Select(lnOldSel)
Select csTmpCdCnI
		Select csNivel3
	Select csTmpCdCnI
Select(lnOldSel)
Select CrSigCdCnl
	Select CrSigCdCnl
		lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigCdCnl'),1,-1)
Select CrSigCdCnl
	Select CrSigCdCnl
		lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigCdCnl'),1,-1)
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
			[Inner Join SigCdAce c on a.Iclis = c.Usuarios ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+This.Value+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVends
	If Seek(This.Value,'CrSigVends','Iclis')
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+lcVends+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVendsf
	If Seek(This.Value,'CrSigVends','Rclis')
Select csSigCdCnI
Select csNivel1
Select csNivel2
Select csNivel3
Select csNivel4
Select csSigCdCnI

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1974 linhas total):

*-- Linhas 451 a 469:
451:                 .HighlightBackColor = RGB(255, 255, 255)
452:                 .HighlightForeColor = RGB(15, 41, 104)
453:                 .HighlightStyle     = 2
454:                 .DeleteMark         = .F.
455:                 .RecordMark         = .F.
456:                 .RowHeight          = 18
457:                 .ScrollBars         = 3
458:                 .GridLines          = 3
459:                 .Visible            = .T.
460:             ENDWITH
461: 
462:             THIS.TornarControlesVisiveis(loc_oPagina)
463: 
464:         CATCH TO loc_oErro
465:             MsgErro("Erro ao configurar P" + CHR(225) + "gina Lista:" + CHR(13) + ;
466:                     loc_oErro.Message, "Erro")
467:         ENDTRY
468:     ENDPROC
469: 

*-- Linhas 774 a 792:
774:                 .HighlightBackColor = RGB(255, 255, 255)
775:                 .HighlightForeColor = RGB(15, 41, 104)
776:                 .HighlightStyle     = 2
777:                 .DeleteMark         = .F.
778:                 .RecordMark         = .F.
779:                 .RowHeight          = 18
780:                 .ScrollBars         = 2
781:                 .GridLines          = 3
782:                 .Visible            = .T.
783:             ENDWITH
784:             WITH loc_oPagina.grd_4c_GrdLoc.Column1
785:                 .Width    = 80
786:                 .ReadOnly = .T.
787:                 .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
788:             ENDWITH
789:             WITH loc_oPagina.grd_4c_GrdLoc.Column2
790:                 .Width    = 60
791:                 .ReadOnly = .F.
792:                 .Header1.Caption = "Qtde."

*-- Linhas 1043 a 1067:
1043:                     loc_oGrid.RecordSource = loc_cCursor
1044:                     loc_oGrid.ColumnCount  = 7
1045: 
1046:                     loc_oGrid.Column1.ControlSource = loc_cCursor + ".cods"
1047:                     loc_oGrid.Column2.ControlSource = loc_cCursor + ".datas"
1048:                     loc_oGrid.Column3.ControlSource = loc_cCursor + ".vends"
1049:                     loc_oGrid.Column4.ControlSource = loc_cCursor + ".desvends"
1050:                     loc_oGrid.Column5.ControlSource = loc_cCursor + ".locals"
1051:                     loc_oGrid.Column6.ControlSource = loc_cCursor + ".dlocals"
1052:                     loc_oGrid.Column7.ControlSource = loc_cCursor + ".conferido"
1053: 
1054:                     loc_oGrid.Column1.Width = 80
1055:                     loc_oGrid.Column2.Width = 90
1056:                     loc_oGrid.Column3.Width = 70
1057:                     loc_oGrid.Column4.Width = 200
1058:                     loc_oGrid.Column5.Width = 80
1059:                     loc_oGrid.Column6.Width = 200
1060:                     loc_oGrid.Column7.Width = 60
1061: 
1062:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1063:                     loc_oGrid.Column2.Header1.Caption = "Data"
1064:                     loc_oGrid.Column3.Header1.Caption = "Vendedor"
1065:                     loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
1066:                     loc_oGrid.Column5.Header1.Caption = "Local"
1067:                     loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"

*-- Linhas 1170 a 1188:
1170:             IF USED("csSigCdCnI")
1171:                 USE IN csSigCdCnI
1172:             ENDIF
1173:             CREATE CURSOR csSigCdCnI (Locals C(10), QtdCtg N(5,0), Qtde N(10,2))
1174: 
1175:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1176:             IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1177:                 loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1178:                 loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1179:                 loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1180:                 loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1181:                 loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1182:                 loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1183:                 loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1184:                 loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1185:                 loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1186:                 loc_oPg2.grd_4c_GrdLoc.Refresh()
1187:             ENDIF
1188: 

*-- Linhas 1203 a 1221:
1203:         TRY
1204:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1205:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1206:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1207:                 loc_cCodigo = ALLTRIM(cods)
1208:             ENDIF
1209: 
1210:             IF EMPTY(loc_cCodigo)
1211:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1212:             ELSE
1213:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1214:                     THIS.this_cModoAtual = "VISUALIZAR"
1215:                     THIS.BOParaForm()
1216:                     THIS.HabilitarCampos(.F.)
1217:                     THIS.AlternarPagina(2)
1218:                 ENDIF
1219:             ENDIF
1220:         CATCH TO loc_oErro
1221:             MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1232 a 1250:
1232:         TRY
1233:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1234:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1235:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1236:                 loc_cCodigo = ALLTRIM(cods)
1237:             ENDIF
1238: 
1239:             IF EMPTY(loc_cCodigo)
1240:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1241:             ELSE
1242:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1243:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1244:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1245:                     ELSE
1246:                         THIS.this_oBusinessObject.EditarRegistro()
1247:                         THIS.this_cModoAtual = "ALTERAR"
1248:                         THIS.BOParaForm()
1249:                         THIS.HabilitarCampos(.T.)
1250:                         THIS.AlternarPagina(2)

*-- Linhas 1266 a 1284:
1266:         TRY
1267:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1268:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1269:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1270:                 loc_cCodigo = ALLTRIM(cods)
1271:             ENDIF
1272: 
1273:             IF EMPTY(loc_cCodigo)
1274:                 MsgAviso("Selecione uma contagem para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1275:             ELSE
1276:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1277:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1278:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada - n" + CHR(227) + "o pode excluir.", ;
1279:                                  "Aten" + CHR(231) + CHR(227) + "o")
1280:                     ELSE
1281:                         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da contagem [" + ;
1282:                                        ALLTRIM(loc_cCodigo) + "] ?", "Exclus" + CHR(227) + "o")
1283:                             IF THIS.this_oBusinessObject.Excluir()
1284:                                 MsgSucesso("Contagem exclu" + CHR(237) + "da com sucesso!", "Sucesso")

*-- Linhas 1311 a 1343:
1311:                 loc_oBusca.Show()
1312: 
1313:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnl")
1314:                     SELECT cursor_4c_BuscaCnl
1315:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCnl.cods)
1316:                 ENDIF
1317: 
1318:                 loc_oBusca.Release()
1319:             ENDIF
1320: 
1321:             IF USED("cursor_4c_BuscaCnl")
1322:                 USE IN cursor_4c_BuscaCnl
1323:             ENDIF
1324: 
1325:             IF !EMPTY(loc_cCodigo)
1326:                 THIS.CarregarLista()
1327:                 IF USED(THIS.this_oBusinessObject.this_cCursorDados)
1328:                     SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1329:                     LOCATE FOR ALLTRIM(cods) == loc_cCodigo
1330:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1331:                 ENDIF
1332:             ENDIF
1333: 
1334:         CATCH TO loc_oErro
1335:             IF USED("cursor_4c_BuscaCnl")
1336:                 USE IN cursor_4c_BuscaCnl
1337:             ENDIF
1338:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
1339:         ENDTRY
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 1359 a 1420:
1359:                 USE IN cursor_4c_Espelho
1360:             ENDIF
1361: 
1362:             loc_cSQL = "SELECT localizas AS Locals, grupos, contas, empos," + ;
1363:                        " SUM(Qtde) AS qtde, CONVERT(numeric(5,0),0) AS QtdCtg," + ;
1364:                        " SPACE(100) AS Descr" + ;
1365:                        " FROM (" + ;
1366:                        " SELECT localizas, SPACE(10) AS grupos, SPACE(10) AS contas, a.empos," + ;
1367:                        " COUNT(1) AS Qtde" + ;
1368:                        " FROM SigOpEtq A" + ;
1369:                        " LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus" + ;
1370:                        " FROM SigCdPro) B ON b.cpros = a.cpros" + ;
1371:                        " WHERE a.empos = " + EscaparSQL(loc_cEmpresa) + ;
1372:                        " AND a.contas NOT IN ('15000','15001','15002','15003')" + ;
1373:                        " GROUP BY localizas, a.empos" + ;
1374:                        " ) AS dados" + ;
1375:                        " GROUP BY localizas, grupos, contas, empos" + ;
1376:                        " ORDER BY localizas"
1377: 
1378:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Espelho") > 0
1379:                 MsgInfo("Espelho gerado com " + LTRIM(STR(RECCOUNT("cursor_4c_Espelho"))) + ;
1380:                         " localiza" + CHR(231) + CHR(245) + "es.", "Espelho")
1381:             ELSE
1382:                 MsgErro("Erro ao gerar espelho: " + CapturarErroSQL(), "Erro SQL")
1383:             ENDIF
1384: 
1385:         CATCH TO loc_oErro
1386:             MsgErro("Erro ao gerar espelho:" + CHR(13) + loc_oErro.Message, "Erro")
1387:         ENDTRY
1388: 
1389:         IF USED("cursor_4c_Espelho")
1390:             USE IN cursor_4c_Espelho
1391:         ENDIF
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * BtnFecharContagemClick - Encerra contagem selecionada (Fecha no legado)
1396:     * Legado: Conferido=1 -> Update -> Commit
1397:     *==========================================================================
1398:     PROCEDURE BtnFecharContagemClick()
1399:         LOCAL loc_cCodigo, loc_oErro
1400:         loc_cCodigo = ""
1401: 
1402:         TRY
1403:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1404:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1405:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1406:                 loc_cCodigo = ALLTRIM(cods)
1407:             ENDIF
1408: 
1409:             IF EMPTY(loc_cCodigo)
1410:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1411:             ELSE
1412:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1413:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1414:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1415:                     ELSE
1416:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Finalizada," + ;
1417:                                        " Deseja encerrar a Contagem ???", ;
1418:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1419:                             IF THIS.this_oBusinessObject.FecharContagem(loc_cCodigo)
1420:                                 THIS.CarregarLista()

*-- Linhas 1430 a 1457:
1430: 
1431:     *==========================================================================
1432:     * BtnAbrirContagemClick - Reabre contagem encerrada (Abre no legado)
1433:     * Legado: Conferido=0 -> Update -> Commit
1434:     *==========================================================================
1435:     PROCEDURE BtnAbrirContagemClick()
1436:         LOCAL loc_cCodigo, loc_oErro
1437:         loc_cCodigo = ""
1438: 
1439:         TRY
1440:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1441:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1442:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1443:                 loc_cCodigo = ALLTRIM(cods)
1444:             ENDIF
1445: 
1446:             IF EMPTY(loc_cCodigo)
1447:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1448:             ELSE
1449:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1450:                     IF THIS.this_oBusinessObject.this_nConferido = 0
1451:                         MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada !!!", ;
1452:                                  "Aten" + CHR(231) + CHR(227) + "o")
1453:                     ELSE
1454:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Aberta Novamente," + ;
1455:                                        " Deseja Continuar a Contagem ???", ;
1456:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1457:                             IF THIS.this_oBusinessObject.ReobrirContagem(loc_cCodigo)

*-- Linhas 1493 a 1519:
1493:             *-- Carregar itens (csSigCdCnI) via SQL com aliasing correto para SalvarItens
1494:             IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
1495:                 LOCAL loc_cSQLItens
1496:                 loc_cSQLItens = "SELECT locals AS Locals, qtds AS QtdCtg, estoque AS Qtde" + ;
1497:                                 " FROM sigcdcni WHERE cods = " + ;
1498:                                 EscaparSQL(THIS.this_oBusinessObject.this_cCodigo) + ;
1499:                                 " ORDER BY locals"
1500:                 IF USED("csSigCdCnI")
1501:                     USE IN csSigCdCnI
1502:                 ENDIF
1503:                 IF SQLEXEC(gnConnHandle, loc_cSQLItens, "csSigCdCnI") > 0
1504:                     SELECT csSigCdCnI
1505:                     GO TOP
1506:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1507:                         loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1508:                         loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1509:                         loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1510:                         loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1511:                         loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1512:                         loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1513:                         loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1514:                         loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1515:                         loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1516:                         loc_oPg2.grd_4c_GrdLoc.Refresh()
1517:                     ENDIF
1518:                 ENDIF
1519:             ENDIF

*-- Linhas 1718 a 1736:
1718:             loc_nOrdem = loc_oPg2.opt_4c_OptOrdem.Value
1719: 
1720:             IF USED("csSigCdCnI")
1721:                 SELECT csSigCdCnI
1722:                 SET ORDER TO
1723:                 DO CASE
1724:                 CASE loc_nOrdem = 1
1725:                     SET ORDER TO Locals
1726:                 CASE loc_nOrdem = 2
1727:                     SET ORDER TO Nivel2s
1728:                 CASE loc_nOrdem = 3
1729:                     SET ORDER TO Nivel3s
1730:                 CASE loc_nOrdem = 4
1731:                     SET ORDER TO Nivel4s
1732:                 ENDCASE
1733:                 GO TOP IN csSigCdCnI
1734: 
1735:                 *-- Atualizar grid de itens (adicionado na Fase 6)
1736:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)

*-- Linhas 1770 a 1819:
1770:         ENDIF
1771: 
1772:         TRY
1773:             loc_cSQL = "SELECT a.iclis, a.rclis, a.Emps" + ;
1774:                        " FROM SigCdCli a" + ;
1775:                        " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
1776:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
1777:                        " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1778:                        " AND a.iclis = " + EscaparSQL(loc_cVend)
1779: 
1780:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidVend") > 0 AND ;
1781:                RECCOUNT("cursor_4c_ValidVend") > 0
1782:                 SELECT cursor_4c_ValidVend
1783:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1784:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidVend.rclis)
1785:                 ENDIF
1786:                 THIS.this_oBusinessObject.this_cVends    = loc_cVend
1787:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_ValidVend.rclis)
1788:             ELSE
1789:                 *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
1790:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1791:                     loc_oPg2.txt_4c_DConta.Value = ""
1792:                 ENDIF
1793: 
1794:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1795:                     "SigCdCli", "cursor_4c_BuscaVend", "iclis", loc_cVend, ;
1796:                     "Vendedor")
1797: 
1798:                 IF VARTYPE(loc_oBusca) = "O"
1799:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1800:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1801:                     loc_oBusca.Show()
1802: 
1803:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1804:                         SELECT cursor_4c_BuscaVend
1805:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaVend.iclis)
1806:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1807:                             loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaVend.rclis)
1808:                         ENDIF
1809:                         THIS.this_oBusinessObject.this_cVends    = ALLTRIM(cursor_4c_BuscaVend.iclis)
1810:                         THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_BuscaVend.rclis)
1811:                     ELSE
1812:                         loc_oPg2.txt_4c_Conta.Value = ""
1813:                     ENDIF
1814:                     loc_oBusca.Release()
1815:                 ENDIF
1816: 
1817:                 IF USED("cursor_4c_BuscaVend")
1818:                     USE IN cursor_4c_BuscaVend
1819:                 ENDIF


### BO (C:\4c\projeto\app\classes\cnlBO.prg):
*===========================================================================
* cnlBO.prg - Business Object para Contagem de Produtos por Localizacao
* Tabela principal: SigCdCnL (cabecalho da contagem)
* Tabela detalhe  : SigCdCnI (itens / localizacoes)
* Criado em: 2026-07-29
*===========================================================================

DEFINE CLASS cnlBO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela     = "SigCdCnL"
    this_cCampoChave = "Cods"

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCnL (schema: sigcdcnl)
    *--------------------------------------------------------------------------

    *-- Chave de negocio (cods char 10) - usada em WHERE das operacoes
    this_cCodigo     = ""

    *-- Chave tecnica interna (cidchaves char 20) - PK fisica
    this_cCidChaves  = ""

    *-- Empresa (emps char 3)
    this_cEmps       = ""

    *-- Vendedor responsavel (vends char 10 - FK SigCdCli.Iclis)
    this_cVends      = ""

    *-- Localizacao principal (locals char 10 - FK SigPrLcl.codigos)
    this_cLocals     = ""

    *-- Data da contagem (datas datetime)
    this_dDatas      = {}

    *-- Ordenacao do grid (qtds numeric 5,0): 0/1=Base, 2=Nvl2, 3=Nvl3, 4=Nvl4
    this_nQtds       = 0

    *-- Status (conferido numeric 1,0): 0=aberta, 1=encerrada
    this_nConferido  = 0

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (resultado de JOINs na query Buscar)
    *--------------------------------------------------------------------------

    *-- Descricao do vendedor (alias desvends = SigCdCli.Rclis)
    this_cDesVends   = ""

    *-- Descricao da localizacao (alias dlocals = SigPrLcl.descricaos)
    this_cDLocals    = ""

    *--------------------------------------------------------------------------
    * Nomes dos cursores de trabalho
    *--------------------------------------------------------------------------

    *-- Cursor de itens criado pelo form (csSigCdCnI)
    this_cCursorItens = "csSigCdCnI"

    *-- Cursor principal da lista (Buscar)
    this_cCursorDados = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnL"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega lista de contagens com JOINs
    * par_cFiltro: condicao SQL adicional (opcional)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.datas DESC, a.cods"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de contagens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigCdCnL pelo Cods
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND a.emps = " + EscaparSQL(loc_cEmpresa)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor posicionado
    * REGRA: SEMPRE SELECT (alias) antes de acessar campos
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(cods,       "C")
            THIS.this_nConferido  = TratarNulo(conferido,  "N")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cLocals     = TratarNulo(locals,     "C")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")
            THIS.this_cVends      = TratarNulo(vends,      "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cDesVends   = TratarNulo(desvends,   "C")
            THIS.this_cDLocals    = TratarNulo(dlocals,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigCdCnL (chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = THIS.ObterNovoCidChaves()
            IF !EMPTY(loc_cCidChaves)
                loc_cCodigo = THIS.ObterProximoCodigo()
                IF !EMPTY(loc_cCodigo)
                    THIS.this_cCidChaves = loc_cCidChaves
                    THIS.this_cCodigo    = loc_cCodigo
                    THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                    THIS.this_nConferido = 0

                    loc_cSQL = "INSERT INTO sigcdcnl" + ;
                               " (cidchaves, cods, conferido, datas, locals, qtds, vends, emps)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                               FormatarNumeroSQL(THIS.this_nConferido) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(THIS.this_cLocals) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                               EscaparSQL(THIS.this_cVends) + ", " + ;
                               EscaparSQL(THIS.this_cEmps)  + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir contagem: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar chave interna da contagem.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCdCnL (vends, locals, qtds)
    * O legado fazia delete+reinsert via cursor; aqui usamos UPDATE direto.
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET" + ;
                       " vends  = " + EscaparSQL(THIS.this_cVends)  + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " qtds   = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " datas  = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de SigCdCnI (itens) + SigCdCnL (cabecalho)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM sigcdcnl" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                           " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir contagem: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SalvarItens - Salva itens do cursor csSigCdCnI em SigCdCnI
    * par_cCursorItens: nome do cursor com colunas Locals, QtdCtg, Qtde
    * par_cCodigo: Cods do cabecalho (SigCdCnL.cods)
    * Mapeamento: sigcdcni.qtds <- csSigCdCnI.QtdCtg (contagem)
    *             sigcdcni.estoque <- csSigCdCnI.Qtde (estoque)
    *==========================================================================
    FUNCTION SalvarItens(par_cCursorItens, par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_nResultado
        LOCAL loc_cLocals, loc_nQtdCtg, loc_nQtde
        loc_lSucesso = .F.

        IF !USED(par_cCursorItens)
            MsgErro("Cursor de itens n" + CHR(227) + "o encontrado: " + par_cCursorItens, "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Limpar itens existentes para este codigo
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- Inserir itens do cursor
                SELECT (par_cCursorItens)
                GO TOP
                loc_lSucesso = .T.

                SCAN WHILE loc_lSucesso
                    *-- Capturar campos ANTES de chamar ObterNovoCidChaves (muda SELECT)
                    loc_cLocals  = ALLTRIM(locals)
                    loc_nQtdCtg  = qtdctg
                    loc_nQtde    = qtde

                    loc_cCidChaves = THIS.ObterNovoCidChaves()
                    IF EMPTY(loc_cCidChaves)
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO sigcdcni" + ;
                                   " (cidchaves, cods, locals, qtds, estoque, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCodigo)    + ", " + ;
                                   EscaparSQL(loc_cLocals)    + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCtg) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtde)   + ", " + ;
                                   EscaparSQL("") + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir item [" + loc_cLocals + "]: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF

                    *-- Restaurar selecao para proxima iteracao do SCAN
                    SELECT (par_cCursorItens)
                ENDSCAN
            ELSE
                MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarItens: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega itens de SigCdCnI para um cursor
    * par_cCodigo: Cods do cabecalho
    * par_cCursorDestino: nome do cursor destino (default: crSigCdCnI)
    *==========================================================================
    FUNCTION CarregarItens(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "crSigCdCnI", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cods, locals, qtds, estoque, mercs" + ;
                       " FROM sigcdcni" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY locals"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FecharContagem - Define Conferido=1 (encerra a contagem)
    *==========================================================================
    FUNCTION FecharContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 1" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao fechar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FecharContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ReobrirContagem - Define Conferido=0 (reabre a contagem encerrada)
    *==========================================================================
    FUNCTION ReobrirContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 0" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao reabrir contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ReobrirContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametrosVendedor - Carrega SigCdPam para obter GrPadVens
    * Replica CursorQuery([SigCdPam], [LocalPam], ...)
    * par_cCursorDestino: nome do cursor destino (default: cursor_4c_LocalPam)
    *==========================================================================
    FUNCTION CarregarParametrosVendedor(par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_LocalPam", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                IF !EOF()
                    loc_lSucesso = !EMPTY(ALLTRIM(GrPadVens))
                ENDIF
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros de vendedor: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametrosVendedor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarVendedores - Carrega vendedores validos para lookup
    * Replica a query dos eventos Valid de getConta/getDConta
    * par_cFiltro    : usuario logado ou valor digitado no campo
    * par_cGrPadVens : grupo padrao de vendedores (de SigCdPam)
    * par_cCursorDestino: cursor de resultado (default: cursor_4c_Vendedores)
    *==========================================================================
    FUNCTION BuscarVendedores(par_cFiltro, par_cGrPadVens, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Vendedores", par_cCursorDestino)
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs," + ;
                       " a.inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
                       " AND a.IClis NOT IN" + ;
                       " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
                       " WHERE c.Jobs NOT IN" + ;
                       " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
                       " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                       " ORDER BY a.iclis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar vendedores: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarVendedores: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoesNivel - Carrega SigLcNv1/2/3/4 para cursor local
    * par_nNivel: 1, 2, 3 ou 4
    * par_cCursorDestino: cursor destino (ex: "csNivel1")
    *==========================================================================
    FUNCTION CarregarLocalizacoesNivel(par_nNivel, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cTabela, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "csNivel" + LTRIM(STR(par_nNivel)), par_cCursorDestino)

        TRY
            DO CASE
            CASE par_nNivel = 1
                loc_cTabela = "SigLcNv1"
            CASE par_nNivel = 2
                loc_cTabela = "SigLcNv2"
            CASE par_nNivel = 3
                loc_cTabela = "SigLcNv3"
            CASE par_nNivel = 4
                loc_cTabela = "SigLcNv4"
            OTHERWISE
                MsgErro("N" + CHR(237) + "vel inv" + CHR(225) + "lido: " + ;
                        LTRIM(STR(par_nNivel)), "Erro")
                loc_lSucesso = .F.
            ENDCASE

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT * FROM " + loc_cTabela

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar " + loc_cTabela + ": " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLocalizacoesNivel: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterNovoCidChaves - Gera novo cidchaves unico (char 20) via NEWID()
    *==========================================================================
    PROTECTED FUNCTION ObterNovoCidChaves()
        LOCAL loc_cChave, loc_lSucesso
        loc_cChave   = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()),'-',''), 20) AS nova_chave", ;
                "cursor_4c_NovaChave") > 0
            IF loc_lSucesso
                SELECT cursor_4c_NovaChave
                loc_cChave = ALLTRIM(nova_chave)
            ELSE
                MsgErro("Erro ao gerar chave interna: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterNovoCidChaves: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NovaChave")
            USE IN cursor_4c_NovaChave
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterProximoCodigo - Gera proximo Cods numerico disponivel em SigCdCnL
    *==========================================================================
    PROTECTED FUNCTION ObterProximoCodigo()
        LOCAL loc_cCodigo, loc_lSucesso
        loc_cCodigo  = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(CAST(cods AS bigint)), 0) + 1 AS proximo FROM sigcdcnl", ;
                "cursor_4c_ProxCod") > 0
            IF loc_lSucesso
                SELECT cursor_4c_ProxCod
                loc_cCodigo = ALLTRIM(STR(cursor_4c_ProxCod.proximo, 10))
            ELSE
                MsgErro("Erro ao obter pr" + CHR(243) + "ximo c" + CHR(243) + "digo: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterProximoCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE

