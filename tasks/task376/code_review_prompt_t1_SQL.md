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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1966 linhas total):

*-- Linhas 447 a 465:
447:                 .HighlightBackColor = RGB(255, 255, 255)
448:                 .HighlightForeColor = RGB(15, 41, 104)
449:                 .HighlightStyle     = 2
450:                 .DeleteMark         = .F.
451:                 .RecordMark         = .F.
452:                 .RowHeight          = 18
453:                 .ScrollBars         = 3
454:                 .GridLines          = 3
455:                 .Visible            = .T.
456:             ENDWITH
457: 
458:             THIS.TornarControlesVisiveis(loc_oPagina)
459: 
460:         CATCH TO loc_oErro
461:             MsgErro("Erro ao configurar P" + CHR(225) + "gina Lista:" + CHR(13) + ;
462:                     loc_oErro.Message, "Erro")
463:         ENDTRY
464:     ENDPROC
465: 

*-- Linhas 770 a 788:
770:                 .HighlightBackColor = RGB(255, 255, 255)
771:                 .HighlightForeColor = RGB(15, 41, 104)
772:                 .HighlightStyle     = 2
773:                 .DeleteMark         = .F.
774:                 .RecordMark         = .F.
775:                 .RowHeight          = 18
776:                 .ScrollBars         = 2
777:                 .GridLines          = 3
778:                 .Visible            = .T.
779:             ENDWITH
780:             WITH loc_oPagina.grd_4c_GrdLoc.Column1
781:                 .Width    = 80
782:                 .ReadOnly = .T.
783:                 .Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
784:             ENDWITH
785:             WITH loc_oPagina.grd_4c_GrdLoc.Column2
786:                 .Width    = 60
787:                 .ReadOnly = .F.
788:                 .Header1.Caption = "Qtde."

*-- Linhas 1039 a 1063:
1039:                     loc_oGrid.RecordSource = loc_cCursor
1040:                     loc_oGrid.ColumnCount  = 7
1041: 
1042:                     loc_oGrid.Column1.ControlSource = loc_cCursor + ".cods"
1043:                     loc_oGrid.Column2.ControlSource = loc_cCursor + ".datas"
1044:                     loc_oGrid.Column3.ControlSource = loc_cCursor + ".vends"
1045:                     loc_oGrid.Column4.ControlSource = loc_cCursor + ".desvends"
1046:                     loc_oGrid.Column5.ControlSource = loc_cCursor + ".locals"
1047:                     loc_oGrid.Column6.ControlSource = loc_cCursor + ".dlocals"
1048:                     loc_oGrid.Column7.ControlSource = loc_cCursor + ".conferido"
1049: 
1050:                     loc_oGrid.Column1.Width = 80
1051:                     loc_oGrid.Column2.Width = 90
1052:                     loc_oGrid.Column3.Width = 70
1053:                     loc_oGrid.Column4.Width = 200
1054:                     loc_oGrid.Column5.Width = 80
1055:                     loc_oGrid.Column6.Width = 200
1056:                     loc_oGrid.Column7.Width = 60
1057: 
1058:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1059:                     loc_oGrid.Column2.Header1.Caption = "Data"
1060:                     loc_oGrid.Column3.Header1.Caption = "Vend"
1061:                     loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
1062:                     loc_oGrid.Column5.Header1.Caption = "Local"
1063:                     loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"

*-- Linhas 1166 a 1184:
1166:             IF USED("csSigCdCnI")
1167:                 USE IN csSigCdCnI
1168:             ENDIF
1169:             CREATE CURSOR csSigCdCnI (Locals C(10), QtdCtg N(5,0), Qtde N(10,2))
1170: 
1171:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1172:             IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1173:                 loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1174:                 loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1175:                 loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1176:                 loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1177:                 loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1178:                 loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1179:                 loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1180:                 loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1181:                 loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1182:                 loc_oPg2.grd_4c_GrdLoc.Refresh()
1183:             ENDIF
1184: 

*-- Linhas 1199 a 1217:
1199:         TRY
1200:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1201:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1202:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1203:                 loc_cCodigo = ALLTRIM(cods)
1204:             ENDIF
1205: 
1206:             IF EMPTY(loc_cCodigo)
1207:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1208:             ELSE
1209:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1210:                     THIS.this_cModoAtual = "VISUALIZAR"
1211:                     THIS.BOParaForm()
1212:                     THIS.HabilitarCampos(.F.)
1213:                     THIS.AlternarPagina(2)
1214:                 ENDIF
1215:             ENDIF
1216:         CATCH TO loc_oErro
1217:             MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1228 a 1246:
1228:         TRY
1229:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1230:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1231:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1232:                 loc_cCodigo = ALLTRIM(cods)
1233:             ENDIF
1234: 
1235:             IF EMPTY(loc_cCodigo)
1236:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1237:             ELSE
1238:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1239:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1240:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1241:                     ELSE
1242:                         THIS.this_oBusinessObject.EditarRegistro()
1243:                         THIS.this_cModoAtual = "ALTERAR"
1244:                         THIS.BOParaForm()
1245:                         THIS.HabilitarCampos(.T.)
1246:                         THIS.AlternarPagina(2)

*-- Linhas 1262 a 1280:
1262:         TRY
1263:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1264:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1265:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1266:                 loc_cCodigo = ALLTRIM(cods)
1267:             ENDIF
1268: 
1269:             IF EMPTY(loc_cCodigo)
1270:                 MsgAviso("Selecione uma contagem para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1271:             ELSE
1272:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1273:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1274:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada - n" + CHR(227) + "o pode excluir.", ;
1275:                                  "Aten" + CHR(231) + CHR(227) + "o")
1276:                     ELSE
1277:                         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da contagem [" + ;
1278:                                        ALLTRIM(loc_cCodigo) + "] ?", "Exclus" + CHR(227) + "o")
1279:                             IF THIS.this_oBusinessObject.Excluir()
1280:                                 MsgSucesso("Contagem exclu" + CHR(237) + "da com sucesso!", "Sucesso")

*-- Linhas 1307 a 1339:
1307:                 loc_oBusca.Show()
1308: 
1309:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnl")
1310:                     SELECT cursor_4c_BuscaCnl
1311:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCnl.cods)
1312:                 ENDIF
1313: 
1314:                 loc_oBusca.Release()
1315:             ENDIF
1316: 
1317:             IF USED("cursor_4c_BuscaCnl")
1318:                 USE IN cursor_4c_BuscaCnl
1319:             ENDIF
1320: 
1321:             IF !EMPTY(loc_cCodigo)
1322:                 THIS.CarregarLista()
1323:                 IF USED(THIS.this_oBusinessObject.this_cCursorDados)
1324:                     SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1325:                     LOCATE FOR ALLTRIM(cods) == loc_cCodigo
1326:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1327:                 ENDIF
1328:             ENDIF
1329: 
1330:         CATCH TO loc_oErro
1331:             IF USED("cursor_4c_BuscaCnl")
1332:                 USE IN cursor_4c_BuscaCnl
1333:             ENDIF
1334:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
1335:         ENDTRY
1336:     ENDPROC
1337: 
1338:     *==========================================================================
1339:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 1355 a 1416:
1355:                 USE IN cursor_4c_Espelho
1356:             ENDIF
1357: 
1358:             loc_cSQL = "SELECT localizas AS Locals, grupos, contas, empos," + ;
1359:                        " SUM(Qtde) AS qtde, CONVERT(numeric(5,0),0) AS QtdCtg," + ;
1360:                        " SPACE(100) AS Descr" + ;
1361:                        " FROM (" + ;
1362:                        " SELECT localizas, SPACE(10) AS grupos, SPACE(10) AS contas, a.empos," + ;
1363:                        " COUNT(1) AS Qtde" + ;
1364:                        " FROM SigOpEtq A" + ;
1365:                        " LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus" + ;
1366:                        " FROM SigCdPro) B ON b.cpros = a.cpros" + ;
1367:                        " WHERE a.empos = " + EscaparSQL(loc_cEmpresa) + ;
1368:                        " AND a.contas NOT IN ('15000','15001','15002','15003')" + ;
1369:                        " GROUP BY localizas, a.empos" + ;
1370:                        " ) AS dados" + ;
1371:                        " GROUP BY localizas, grupos, contas, empos" + ;
1372:                        " ORDER BY localizas"
1373: 
1374:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Espelho") > 0
1375:                 MsgInfo("Espelho gerado com " + LTRIM(STR(RECCOUNT("cursor_4c_Espelho"))) + ;
1376:                         " localiza" + CHR(231) + CHR(245) + "es.", "Espelho")
1377:             ELSE
1378:                 MsgErro("Erro ao gerar espelho: " + CapturarErroSQL(), "Erro SQL")
1379:             ENDIF
1380: 
1381:         CATCH TO loc_oErro
1382:             MsgErro("Erro ao gerar espelho:" + CHR(13) + loc_oErro.Message, "Erro")
1383:         ENDTRY
1384: 
1385:         IF USED("cursor_4c_Espelho")
1386:             USE IN cursor_4c_Espelho
1387:         ENDIF
1388:     ENDPROC
1389: 
1390:     *==========================================================================
1391:     * BtnFecharContagemClick - Encerra contagem selecionada (Fecha no legado)
1392:     * Legado: Conferido=1 -> Update -> Commit
1393:     *==========================================================================
1394:     PROCEDURE BtnFecharContagemClick()
1395:         LOCAL loc_cCodigo, loc_oErro
1396:         loc_cCodigo = ""
1397: 
1398:         TRY
1399:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1400:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1401:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1402:                 loc_cCodigo = ALLTRIM(cods)
1403:             ENDIF
1404: 
1405:             IF EMPTY(loc_cCodigo)
1406:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1407:             ELSE
1408:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1409:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1410:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1411:                     ELSE
1412:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Finalizada," + ;
1413:                                        " Deseja encerrar a Contagem ???", ;
1414:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1415:                             IF THIS.this_oBusinessObject.FecharContagem(loc_cCodigo)
1416:                                 THIS.CarregarLista()

*-- Linhas 1426 a 1453:
1426: 
1427:     *==========================================================================
1428:     * BtnAbrirContagemClick - Reabre contagem encerrada (Abre no legado)
1429:     * Legado: Conferido=0 -> Update -> Commit
1430:     *==========================================================================
1431:     PROCEDURE BtnAbrirContagemClick()
1432:         LOCAL loc_cCodigo, loc_oErro
1433:         loc_cCodigo = ""
1434: 
1435:         TRY
1436:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1437:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1438:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1439:                 loc_cCodigo = ALLTRIM(cods)
1440:             ENDIF
1441: 
1442:             IF EMPTY(loc_cCodigo)
1443:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1444:             ELSE
1445:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1446:                     IF THIS.this_oBusinessObject.this_nConferido = 0
1447:                         MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada !!!", ;
1448:                                  "Aten" + CHR(231) + CHR(227) + "o")
1449:                     ELSE
1450:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Aberta Novamente," + ;
1451:                                        " Deseja Continuar a Contagem ???", ;
1452:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1453:                             IF THIS.this_oBusinessObject.ReobrirContagem(loc_cCodigo)

*-- Linhas 1489 a 1515:
1489:             *-- Carregar itens (csSigCdCnI) via SQL com aliasing correto para SalvarItens
1490:             IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
1491:                 LOCAL loc_cSQLItens
1492:                 loc_cSQLItens = "SELECT locals AS Locals, qtds AS QtdCtg, estoque AS Qtde" + ;
1493:                                 " FROM sigcdcni WHERE cods = " + ;
1494:                                 EscaparSQL(THIS.this_oBusinessObject.this_cCodigo) + ;
1495:                                 " ORDER BY locals"
1496:                 IF USED("csSigCdCnI")
1497:                     USE IN csSigCdCnI
1498:                 ENDIF
1499:                 IF SQLEXEC(gnConnHandle, loc_cSQLItens, "csSigCdCnI") > 0
1500:                     SELECT csSigCdCnI
1501:                     GO TOP
1502:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1503:                         loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1504:                         loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1505:                         loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1506:                         loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1507:                         loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1508:                         loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1509:                         loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1510:                         loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1511:                         loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1512:                         loc_oPg2.grd_4c_GrdLoc.Refresh()
1513:                     ENDIF
1514:                 ENDIF
1515:             ENDIF

*-- Linhas 1714 a 1732:
1714:             loc_nOrdem = loc_oPg2.opt_4c_OptOrdem.Value
1715: 
1716:             IF USED("csSigCdCnI")
1717:                 SELECT csSigCdCnI
1718:                 SET ORDER TO
1719:                 DO CASE
1720:                 CASE loc_nOrdem = 1
1721:                     SET ORDER TO Locals
1722:                 CASE loc_nOrdem = 2
1723:                     SET ORDER TO Nivel2s
1724:                 CASE loc_nOrdem = 3
1725:                     SET ORDER TO Nivel3s
1726:                 CASE loc_nOrdem = 4
1727:                     SET ORDER TO Nivel4s
1728:                 ENDCASE
1729:                 GO TOP IN csSigCdCnI
1730: 
1731:                 *-- Atualizar grid de itens (adicionado na Fase 6)
1732:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)

*-- Linhas 1762 a 1811:
1762:         ENDIF
1763: 
1764:         TRY
1765:             loc_cSQL = "SELECT a.iclis, a.rclis, a.Emps" + ;
1766:                        " FROM SigCdCli a" + ;
1767:                        " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
1768:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
1769:                        " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1770:                        " AND a.iclis = " + EscaparSQL(loc_cVend)
1771: 
1772:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidVend") > 0 AND ;
1773:                RECCOUNT("cursor_4c_ValidVend") > 0
1774:                 SELECT cursor_4c_ValidVend
1775:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1776:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidVend.rclis)
1777:                 ENDIF
1778:                 THIS.this_oBusinessObject.this_cVends    = loc_cVend
1779:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_ValidVend.rclis)
1780:             ELSE
1781:                 *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
1782:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1783:                     loc_oPg2.txt_4c_DConta.Value = ""
1784:                 ENDIF
1785: 
1786:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1787:                     "SigCdCli", "cursor_4c_BuscaVend", "iclis", loc_cVend, ;
1788:                     "Vendedor")
1789: 
1790:                 IF VARTYPE(loc_oBusca) = "O"
1791:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1792:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1793:                     loc_oBusca.Show()
1794: 
1795:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1796:                         SELECT cursor_4c_BuscaVend
1797:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaVend.iclis)
1798:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1799:                             loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaVend.rclis)
1800:                         ENDIF
1801:                         THIS.this_oBusinessObject.this_cVends    = ALLTRIM(cursor_4c_BuscaVend.iclis)
1802:                         THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_BuscaVend.rclis)
1803:                     ELSE
1804:                         loc_oPg2.txt_4c_Conta.Value = ""
1805:                     ENDIF
1806:                     loc_oBusca.Release()
1807:                 ENDIF
1808: 
1809:                 IF USED("cursor_4c_BuscaVend")
1810:                     USE IN cursor_4c_BuscaVend
1811:                 ENDIF


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

