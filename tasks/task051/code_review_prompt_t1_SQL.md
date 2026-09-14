# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, DTENTS, VENCS, EMPS, NOTAS, GRCLIS, ICLIS, GRUPOS, CONTAS, NUMS, UMOVS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  SelectOnEntry = .F.
  HideSelection = .F.
  SelectedForeColor = 255,255,255
  SelectedItemForeColor = 255,255,255
  SelectedItemBackColor = 0,0,128
  DeleteMark = .F.
  Column1.ControlSource = "TmpOpera.Flag"
  Column2.ControlSource = "TmpOpera.Operacaos"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
select CsRelatorio
		.SqlExecute([Select * From SigCdOpt],'crSigCdOpt')
Select crSigCdOpt
	Insert Into TmpOpera From Memvar
Select TmpOpera
lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
Select LocalParac
insert into CsCabecalho (NomeEmpresa,Titulo,Periodo,Emissor,Destino) ;
vSql=[select a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, ]+;
	 [from SigCqChm a, SigChe b ]+;
ThisForm.poDatamgr.SqlExecute(vSql,"SqlTmp0")
Select a.nums, Space(50) as RClis, Max(a.valors) as valors, Max(a.vencs) as vencs, Max(a.dtents) as dtents, ;
  from SqlTmp0 a, tmpopera d ;
	Select CsTemporario
		Select CsRelatorio
		Select crSigCheH
		SELECT crSigCdCli
		Select CsTemporario
	Select CsRelatorio
		SELECT crSigCdCli
		SELECT csRelatorio
select CsRelatorio
select CsRelatorio
UpDate TmpOpera Set Flag=.t.
UpDate tmpopera Set Flag=.F.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrechp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2289 linhas total):

*-- Linhas 453 a 556:
453:             RETURN
454:         ENDIF
455: 
456:         SELECT (loc_cCursorOp)
457:         COUNT TO loc_nFlagadas FOR Flag
458:         IF loc_nFlagadas = 0
459:             MsgAviso("Selecione ao menos uma opera" + CHR(231) + CHR(227) + ;
460:                      "o antes de exportar.", "Excel")
461:             RETURN
462:         ENDIF
463: 
464:         IF loc_oRel.this_nNrTipo = 2
465:             loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
466:                            FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
467:                            " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
468:         ELSE
469:             loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
470:                            FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
471:                            " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
472:         ENDIF
473: 
474:         loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmpresa)), "", ;
475:                                " AND a.emps = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmpresa)))
476:         loc_cVerOpcao    = IIF(loc_oRel.this_nNrOpcao = 1, ;
477:                                " AND NOT a.notas = " + EscaparSQL(SPACE(6)), ;
478:                            IIF(loc_oRel.this_nNrOpcao = 2, ;
479:                                " AND a.notas = " + EscaparSQL(SPACE(6)), ""))
480:         loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiGrupo)), "", ;
481:                                " AND b.grclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiGrupo)))
482:         loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiConta)), "", ;
483:                                " AND b.iclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiConta)))
484:         loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesGrupo)), "", ;
485:                                " AND b.grupos = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesGrupo)))
486:         loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesConta)), "", ;
487:                                " AND b.contas = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesConta)))
488: 
489:         IF USED("cursor_4c_XlsTmp0")
490:             USE IN cursor_4c_XlsTmp0
491:         ENDIF
492: 
493:         loc_cSQL = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
494:                    "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
495:                    "b.valors, b.emps, b.umovs " + ;
496:                    "FROM SigCqChm a, SigChe b WHERE a.nums = b.nums"
497:         loc_cSQL = loc_cSQL + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
498:                    loc_cVerEmiGrupo + loc_cVerEmiConta + ;
499:                    loc_cVerDesGrupo + loc_cVerDesConta + ;
500:                    " ORDER BY a.nums, b.vencs, b.valors"
501: 
502:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XlsTmp0")
503:         IF loc_nResult < 0
504:             MsgErro("Erro ao buscar dados para exporta" + CHR(231) + CHR(227) + "o Excel.", ;
505:                     "Formsigrechp")
506:             RETURN
507:         ENDIF
508: 
509:         IF USED("cursor_4c_XlsTmp")
510:             USE IN cursor_4c_XlsTmp
511:         ENDIF
512: 
513:         SELECT a.nums, SPACE(50) AS RClis, ;
514:                MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
515:                MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
516:                MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
517:                MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
518:                MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
519:                MAX(a.emps) AS emps, MAX(a.umovs) AS umovs ;
520:           FROM cursor_4c_XlsTmp0 a, (loc_cCursorOp) d ;
521:          WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
522:          GROUP BY 1, 2 ;
523:          ORDER BY 3 ;
524:           INTO CURSOR cursor_4c_XlsTmp READWRITE
525: 
526:         IF USED("cursor_4c_XlsTmp0")
527:             USE IN cursor_4c_XlsTmp0
528:         ENDIF
529: 
530:         IF !USED("cursor_4c_XlsTmp") OR RECCOUNT("cursor_4c_XlsTmp") = 0
531:             IF USED("cursor_4c_XlsTmp")
532:                 USE IN cursor_4c_XlsTmp
533:             ENDIF
534:             MsgAviso("Nenhum registro encontrado para os filtros selecionados.", "Excel")
535:             RETURN
536:         ENDIF
537: 
538:         loc_cArquivo = ADDBS(SYS(2023)) + "SigReChp_" + DTOS(DATE()) + "_" + ;
539:                        STRTRAN(TIME(), ":", "") + ".xls"
540: 
541:         SELECT cursor_4c_XlsTmp
542:         COPY TO (loc_cArquivo) TYPE XLS
543: 
544:         IF USED("cursor_4c_XlsTmp")
545:             USE IN cursor_4c_XlsTmp
546:         ENDIF
547: 
548:         IF FILE(loc_cArquivo)
549:             DECLARE INTEGER ShellExecute IN shell32.dll ;
550:                 INTEGER hndWin, STRING cAction, STRING cFileName, ;
551:                 STRING cParams, STRING cDir, INTEGER nShowWin
552:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
553:             MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
554:         ELSE
555:             MsgErro("Erro ao gerar arquivo Excel.", "Formsigrechp")
556:         ENDIF

*-- Linhas 1084 a 1119:
1084: 
1085:     *--------------------------------------------------------------------------
1086:     * ConfigurarGradeOperacoes - Cria grid de selecao de operacoes (GradeOpera)
1087:     * Regra critica: AddObject("Check1") ANTES de CurrentControl e ControlSource
1088:     * Original: GradeOpera Top=146, Left=249, Width=178, Height=89 -> Page: Top=61
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE ConfigurarGradeOperacoes(par_oPagina)
1091:         LOCAL loc_oGrid, loc_cCursor
1092:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
1093: 
1094:         par_oPagina.AddObject("grd_4c_Opera", "Grid")
1095:         loc_oGrid = par_oPagina.grd_4c_Opera
1096: 
1097:         WITH loc_oGrid
1098:             .Top                = 61
1099:             .Left               = 249
1100:             .Width              = 178
1101:             .Height             = 89
1102:             .ColumnCount        = 2
1103:             .RecordMark         = .F.
1104:             .DeleteMark         = .F.
1105:             .ScrollBars         = 2
1106:             .RowHeight          = 16
1107:             .FontName           = "Verdana"
1108:             .FontSize           = 8
1109:             .GridLineColor      = RGB(238, 238, 238)
1110:             .HighlightStyle     = 2
1111:             .HighlightBackColor = RGB(255, 255, 255)
1112:             .HighlightForeColor = RGB(15, 41, 104)
1113:             .AllowHeaderSizing  = .F.
1114:             .AllowRowSizing     = .F.
1115:             .Visible            = .T.
1116:         ENDWITH
1117: 
1118:         *-- Column1: CheckBox para Flag (selecao da operacao)
1119:         WITH loc_oGrid.Column1

*-- Linhas 1126 a 1158:
1126:         loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1127:         loc_oGrid.Column1.Check1.Caption  = ""
1128:         loc_oGrid.Column1.CurrentControl  = "Check1"
1129:         loc_oGrid.Column1.ControlSource   = loc_cCursor + ".Flag"
1130: 
1131:         *-- Column2: TextBox somente leitura para Operacaos
1132:         WITH loc_oGrid.Column2
1133:             .Width    = 149
1134:             .FontName = "Verdana"
1135:             .FontSize = 8
1136:             .ReadOnly = .T.
1137:         ENDWITH
1138:         loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1139:         loc_oGrid.Column2.ControlSource   = loc_cCursor + ".Operacaos"
1140: 
1141:         IF USED(loc_cCursor)
1142:             loc_oGrid.RecordSource = loc_cCursor
1143:             SELECT (loc_cCursor)
1144:             GO TOP
1145:         ENDIF
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     * BOParaForm - Sincroniza valores do BO com os controles de Page1
1150:     *--------------------------------------------------------------------------
1151:     PROTECTED PROCEDURE BOParaForm()
1152:         LOCAL loc_oPagina, loc_oRel
1153:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1154:             RETURN
1155:         ENDIF
1156:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1157:             RETURN
1158:         ENDIF

*-- Linhas 1223 a 1241:
1223:             RETURN
1224:         ENDIF
1225:         TRY
1226:             SELECT (loc_cCursor)
1227:             loc_nRecno = RECNO()
1228:             REPLACE ALL Flag WITH .T. IN (loc_cCursor)
1229:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1230:                 GOTO loc_nRecno IN (loc_cCursor)
1231:             ENDIF
1232:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1233:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1234:             ENDIF
1235:         CATCH TO loc_oErro
1236:             MsgErro(loc_oErro.Message, "Formsigrechp.SelecionarTodosClick")
1237:         ENDTRY
1238:     ENDPROC
1239: 
1240:     *--------------------------------------------------------------------------
1241:     * DeselecionarTodosClick - Marca Flag=.F. em todas as operacoes

*-- Linhas 1251 a 1269:
1251:             RETURN
1252:         ENDIF
1253:         TRY
1254:             SELECT (loc_cCursor)
1255:             loc_nRecno = RECNO()
1256:             REPLACE ALL Flag WITH .F. IN (loc_cCursor)
1257:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1258:                 GOTO loc_nRecno IN (loc_cCursor)
1259:             ENDIF
1260:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1261:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1262:             ENDIF
1263:         CATCH TO loc_oErro
1264:             MsgErro(loc_oErro.Message, "Formsigrechp.DeselecionarTodosClick")
1265:         ENDTRY
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * TeclaEmpresaCd/Ds - KeyPress handlers para campos de Empresa

*-- Linhas 1313 a 1335:
1313:             IF USED("cursor_4c_EmpVal")
1314:                 USE IN cursor_4c_EmpVal
1315:             ENDIF
1316:             loc_cSql    = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
1317:                           EscaparSQL(loc_cCod)
1318:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1319:             IF loc_nResult > 0
1320:                 SELECT cursor_4c_EmpVal
1321:                 IF !EOF()
1322:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1323:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1324:                     ENDIF
1325:                 ELSE
1326:                     MsgAviso("Empresa " + CHR(39) + loc_cCod + CHR(39) + ;
1327:                              " n" + CHR(227) + "o encontrada.", "Empresa")
1328:                     loc_oPagina.txt_4c_CdEmpresa.Value = ""
1329:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1330:                         loc_oPagina.txt_4c_DsEmpresa.Value = ""
1331:                     ENDIF
1332:                 ENDIF
1333:                 USE IN cursor_4c_EmpVal
1334:             ENDIF
1335:         CATCH TO loc_oErro

*-- Linhas 1360 a 1383:
1360:             IF USED("cursor_4c_EmpVal")
1361:                 USE IN cursor_4c_EmpVal
1362:             ENDIF
1363:             loc_cSql    = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp " + ;
1364:                           "WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1365:                           " ORDER BY cEmps"
1366:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1367:             IF loc_nResult > 0
1368:                 SELECT cursor_4c_EmpVal
1369:                 IF !EOF()
1370:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1371:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.cEmps)
1372:                     ENDIF
1373:                     loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1374:                 ENDIF
1375:                 USE IN cursor_4c_EmpVal
1376:             ENDIF
1377:         CATCH TO loc_oErro
1378:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmpresa")
1379:         ENDTRY
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * TeclaDesGrupoCd/Ds - KeyPress handlers para Grupo Destino

*-- Linhas 1432 a 1454:
1432:             IF USED("cursor_4c_GrpDesVal")
1433:                 USE IN cursor_4c_GrpDesVal
1434:             ENDIF
1435:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1436:                           EscaparSQL(loc_cCod)
1437:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1438:             IF loc_nResult > 0
1439:                 SELECT cursor_4c_GrpDesVal
1440:                 IF !EOF()
1441:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1442:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1443:                     ENDIF
1444:                 ELSE
1445:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1446:                              " n" + CHR(227) + "o encontrado.", "Grupo/Destino")
1447:                     loc_oPagina.txt_4c_CdDesGrupo.Value = ""
1448:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1449:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ""
1450:                     ENDIF
1451:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1452:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
1453:                     ENDIF
1454:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)

*-- Linhas 1485 a 1508:
1485:             IF USED("cursor_4c_GrpDesVal")
1486:                 USE IN cursor_4c_GrpDesVal
1487:             ENDIF
1488:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1489:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1490:                           " ORDER BY Codigos"
1491:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1492:             IF loc_nResult > 0
1493:                 SELECT cursor_4c_GrpDesVal
1494:                 IF !EOF()
1495:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1496:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Codigos)
1497:                     ENDIF
1498:                     loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1499:                 ENDIF
1500:                 USE IN cursor_4c_GrpDesVal
1501:             ENDIF
1502:         CATCH TO loc_oErro
1503:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesGrupo")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *--------------------------------------------------------------------------
1508:     * TeclaDesContaCd/Ds - KeyPress handlers para Conta Destino

*-- Linhas 1553 a 1578:
1553:             IF USED("cursor_4c_CliVal")
1554:                 USE IN cursor_4c_CliVal
1555:             ENDIF
1556:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1557:                        EscaparSQL(loc_cCod)
1558:             IF !EMPTY(loc_cGrupo)
1559:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1560:             ENDIF
1561:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1562:             IF loc_nResult > 0
1563:                 SELECT cursor_4c_CliVal
1564:                 IF !EOF()
1565:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1566:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1567:                     ENDIF
1568:                 ELSE
1569:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1570:                              " inv" + CHR(225) + "lida.", "Conta/Destino")
1571:                     loc_oPagina.txt_4c_CdDesConta.Value = ""
1572:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1573:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1574:                     ENDIF
1575:                 ENDIF
1576:                 USE IN cursor_4c_CliVal
1577:             ENDIF
1578:         CATCH TO loc_oErro

*-- Linhas 1605 a 1631:
1605:             IF USED("cursor_4c_CliVal")
1606:                 USE IN cursor_4c_CliVal
1607:             ENDIF
1608:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1609:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1610:             IF !EMPTY(loc_cGrupo)
1611:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1612:             ENDIF
1613:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1614:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1615:             IF loc_nResult > 0
1616:                 SELECT cursor_4c_CliVal
1617:                 IF !EOF()
1618:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1619:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_CliVal.Iclis)
1620:                     ENDIF
1621:                     loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1622:                 ENDIF
1623:                 USE IN cursor_4c_CliVal
1624:             ENDIF
1625:         CATCH TO loc_oErro
1626:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesConta")
1627:         ENDTRY
1628:     ENDPROC
1629: 
1630:     *--------------------------------------------------------------------------
1631:     * TeclaEmiGrupoCd/Ds - KeyPress handlers para Grupo Emissor

*-- Linhas 1680 a 1702:
1680:             IF USED("cursor_4c_GrpEmiVal")
1681:                 USE IN cursor_4c_GrpEmiVal
1682:             ENDIF
1683:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1684:                           EscaparSQL(loc_cCod)
1685:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1686:             IF loc_nResult > 0
1687:                 SELECT cursor_4c_GrpEmiVal
1688:                 IF !EOF()
1689:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1690:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1691:                     ENDIF
1692:                 ELSE
1693:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1694:                              " n" + CHR(227) + "o encontrado.", "Grupo/Emissor")
1695:                     loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
1696:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1697:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
1698:                     ENDIF
1699:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1700:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
1701:                     ENDIF
1702:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)

*-- Linhas 1733 a 1756:
1733:             IF USED("cursor_4c_GrpEmiVal")
1734:                 USE IN cursor_4c_GrpEmiVal
1735:             ENDIF
1736:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1737:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1738:                           " ORDER BY Codigos"
1739:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1740:             IF loc_nResult > 0
1741:                 SELECT cursor_4c_GrpEmiVal
1742:                 IF !EOF()
1743:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
1744:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Codigos)
1745:                     ENDIF
1746:                     loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1747:                 ENDIF
1748:                 USE IN cursor_4c_GrpEmiVal
1749:             ENDIF
1750:         CATCH TO loc_oErro
1751:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiGrupo")
1752:         ENDTRY
1753:     ENDPROC
1754: 
1755:     *--------------------------------------------------------------------------
1756:     * TeclaEmiContaCd/Ds - KeyPress handlers para Conta Emissor

*-- Linhas 1801 a 1826:
1801:             IF USED("cursor_4c_EmiCliVal")
1802:                 USE IN cursor_4c_EmiCliVal
1803:             ENDIF
1804:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1805:                        EscaparSQL(loc_cCod)
1806:             IF !EMPTY(loc_cGrupo)
1807:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1808:             ENDIF
1809:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1810:             IF loc_nResult > 0
1811:                 SELECT cursor_4c_EmiCliVal
1812:                 IF !EOF()
1813:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1814:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1815:                     ENDIF
1816:                 ELSE
1817:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1818:                              " inv" + CHR(225) + "lida.", "Conta/Emissor")
1819:                     loc_oPagina.txt_4c_CdEmiConta.Value = ""
1820:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1821:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
1822:                     ENDIF
1823:                 ENDIF
1824:                 USE IN cursor_4c_EmiCliVal
1825:             ENDIF
1826:         CATCH TO loc_oErro

*-- Linhas 1853 a 1879:
1853:             IF USED("cursor_4c_EmiCliVal")
1854:                 USE IN cursor_4c_EmiCliVal
1855:             ENDIF
1856:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1857:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1858:             IF !EMPTY(loc_cGrupo)
1859:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1860:             ENDIF
1861:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1862:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1863:             IF loc_nResult > 0
1864:                 SELECT cursor_4c_EmiCliVal
1865:                 IF !EOF()
1866:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1867:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.Iclis)
1868:                     ENDIF
1869:                     loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1870:                 ENDIF
1871:                 USE IN cursor_4c_EmiCliVal
1872:             ENDIF
1873:         CATCH TO loc_oErro
1874:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiConta")
1875:         ENDTRY
1876:     ENDPROC
1877: 
1878:     *--------------------------------------------------------------------------
1879:     * AlternarPagina - Navega entre paginas do PageFrame

*-- Linhas 1912 a 1930:
1912:             loc_oBusca.Show()
1913:             IF loc_oBusca.this_lSelecionou
1914:                 IF USED("cursor_4c_BuscaEmp")
1915:                     SELECT cursor_4c_BuscaEmp
1916:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1917:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1918:                     ENDIF
1919:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1920:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1921:                     ENDIF
1922:                 ENDIF
1923:             ENDIF
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmpresa")
1926:         ENDTRY
1927:         IF USED("cursor_4c_BuscaEmp")
1928:             USE IN cursor_4c_BuscaEmp
1929:         ENDIF
1930:         IF VARTYPE(loc_oBusca) = "O"

*-- Linhas 1957 a 1975:
1957:             loc_oBusca.Show()
1958:             IF loc_oBusca.this_lSelecionou
1959:                 IF USED("cursor_4c_BuscaDesGrp")
1960:                     SELECT cursor_4c_BuscaDesGrp
1961:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1962:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Codigos)
1963:                     ENDIF
1964:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1965:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Descrs)
1966:                     ENDIF
1967:                     *-- Limpa conta destino pois depende do grupo
1968:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1969:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
1970:                     ENDIF
1971:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1972:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1973:                     ENDIF
1974:                 ENDIF
1975:             ENDIF

*-- Linhas 2002 a 2033:
2002:             IF EMPTY(loc_cGrupo)
2003:                 loc_cSQL = ""
2004:             ELSE
2005:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2006:             ENDIF
2007:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2008:                 "SigCdCli" + loc_cSQL, ;
2009:                 "cursor_4c_BuscaDesCli", ;
2010:                 "Iclis", ;
2011:                 loc_cCodAtual, ;
2012:                 "Buscar Conta Destino")
2013:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2014:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2015:             loc_oBusca.Show()
2016:             IF loc_oBusca.this_lSelecionou
2017:                 IF USED("cursor_4c_BuscaDesCli")
2018:                     SELECT cursor_4c_BuscaDesCli
2019:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
2020:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.Iclis)
2021:                     ENDIF
2022:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
2023:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.rClis)
2024:                     ENDIF
2025:                 ENDIF
2026:             ENDIF
2027:         CATCH TO loc_oErro
2028:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesConta")
2029:         ENDTRY
2030:         IF USED("cursor_4c_BuscaDesCli")
2031:             USE IN cursor_4c_BuscaDesCli
2032:         ENDIF
2033:         IF VARTYPE(loc_oBusca) = "O"

*-- Linhas 2060 a 2078:
2060:             loc_oBusca.Show()
2061:             IF loc_oBusca.this_lSelecionou
2062:                 IF USED("cursor_4c_BuscaEmiGrp")
2063:                     SELECT cursor_4c_BuscaEmiGrp
2064:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
2065:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Codigos)
2066:                     ENDIF
2067:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
2068:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Descrs)
2069:                     ENDIF
2070:                     *-- Limpa conta emissor pois depende do grupo
2071:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2072:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
2073:                     ENDIF
2074:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2075:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
2076:                     ENDIF
2077:                 ENDIF
2078:             ENDIF

*-- Linhas 2253 a 2284:
2253:             IF EMPTY(loc_cGrupo)
2254:                 loc_cSQL = ""
2255:             ELSE
2256:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2257:             ENDIF
2258:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2259:                 "SigCdCli" + loc_cSQL, ;
2260:                 "cursor_4c_BuscaEmiCli", ;
2261:                 "Iclis", ;
2262:                 loc_cCodAtual, ;
2263:                 "Buscar Conta Emissor")
2264:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2265:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2266:             loc_oBusca.Show()
2267:             IF loc_oBusca.this_lSelecionou
2268:                 IF USED("cursor_4c_BuscaEmiCli")
2269:                     SELECT cursor_4c_BuscaEmiCli
2270:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2271:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.Iclis)
2272:                     ENDIF
2273:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2274:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.rClis)
2275:                     ENDIF
2276:                 ENDIF
2277:             ENDIF
2278:         CATCH TO loc_oErro
2279:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiConta")
2280:         ENDTRY
2281:         IF USED("cursor_4c_BuscaEmiCli")
2282:             USE IN cursor_4c_BuscaEmiCli
2283:         ENDIF
2284:         IF VARTYPE(loc_oBusca) = "O"


### BO (C:\4c\projeto\app\classes\sigrechpBO.prg):
*==============================================================================
* SIGRECHPBO.PRG
* Business Object: SigReChp - Cheques em aberto
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Tabela principal: SigCqChm + SigChe (join)
* FRX: SigReChp.frx
*==============================================================================

DEFINE CLASS sigrechpBO AS RelatorioBase

    *-- Filtro: tipo de data (1=Data Vencimento, 2=Data Operacao)
    this_nNrTipo            = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: opcao de nota (1=Sim/com nota, 2=Nao/sem nota, 3=Ambos)
    this_nNrOpcao           = 3

    *-- Filtro: emissor - grupo contabil
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""

    *-- Filtro: emissor - conta contabil
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro: destino - grupo contabil
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""

    *-- Filtro: destino - conta contabil
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *-- Filtro: ordem de classificacao e index selecionado
    this_cNmOrdem           = ""
    this_nOrdemIdx          = 1

    *-- Filtro: imprimir follow-up
    this_lImpFollow         = .F.

    *-- Captions dinamicos do opt_nr_opcao (carregados de SigCdPac)
    this_cCapOpcao1         = ""
    this_cCapOpcao2         = ""
    this_cCapOpcao3         = ""

    *-- Cursores de trabalho
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorTemp        = "cursor_4c_Temp"

    *-- Variaveis de cabecalho do relatorio
    this_cNomeEmpresa       = ""
    this_cTitulo            = ""
    this_cPeriodo           = ""
    this_cEmissor           = ""
    this_cDestino           = ""

    *-- Caminho do arquivo FRX
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReChp.frx"
            THIS.this_dDtInicial       = DATE()
            THIS.this_dDtFinal         = DATE()
            THIS.this_nNrTipo          = 1
            THIS.this_nNrOpcao         = 3
            THIS.this_nOrdemIdx        = 1
            THIS.this_cTitulo          = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            THIS.this_cCapOpcao1       = "Sim"
            THIS.this_cCapOpcao2       = "N" + CHR(227) + "o"
            THIS.this_cCapOpcao3       = "Ambos"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega captions do opt_nr_opcao de SigCdPac
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    THIS.this_cCapOpcao1 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcS)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcS), "Sim")
                    THIS.this_cCapOpcao2 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcN)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cCapOpcao3 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcA)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcA), "Ambos")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes DB/TR de SigCdOpt
    * Cria cursor_4c_Operacoes com Flag (L) e Operacaos (C15)
    * Chamado pelo Form em InicializarForm() para popular o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_cOpc
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorOperacoes) (Flag L, Operacaos C(15))

            loc_cSql = "SELECT Operacaos FROM SigCdOpt " + ;
                       "WHERE Tipos = 'DB' OR Tipos = 'TR' " + ;
                       "ORDER BY Operacaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_OpcLoad")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + ;
                                          "es de SigCdOpt"
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_OpcLoad
            SCAN
                loc_cOpc = ALLTRIM(Operacaos)
                INSERT INTO (THIS.this_cCursorOperacoes) (Flag, Operacaos) ;
                    VALUES (.F., loc_cOpc)
            ENDSCAN

            IF USED("cursor_4c_OpcLoad")
                USE IN cursor_4c_OpcLoad
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_nFlagadas
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cCursorFinal

        loc_lSucesso = .F.
        TRY
            *-- Valida periodo
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtInicial > THIS.this_dDtFinal
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Valida operacoes selecionadas
            IF !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(245) + ;
                                          "es n" + CHR(227) + "o carregadas"
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            COUNT TO loc_nFlagadas FOR Flag
            IF loc_nFlagadas = 0
                THIS.this_cMensagemErro = "Selecione ao menos uma opera" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- Clausula WHERE: tipo de data (Vencimento=1 ou Operacao=2)
            IF THIS.this_nNrTipo = 2
                loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- Clausula WHERE: empresa (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            *-- Clausula WHERE: opcao de nota (1=com nota, 2=sem nota, 3=ambos)
            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND NOT a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                loc_cVerOpcao = ""
                ENDIF
            ENDIF

            *-- Clausula WHERE: grupo emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND b.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF

            *-- Clausula WHERE: conta emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND b.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Clausula WHERE: grupo destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesGrupo))
                loc_cVerDesGrupo = ""
            ELSE
                loc_cVerDesGrupo = " AND b.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesGrupo))
            ENDIF

            *-- Clausula WHERE: conta destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesConta))
                loc_cVerDesConta = ""
            ELSE
                loc_cVerDesConta = " AND b.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesConta))
            ENDIF

            *-- 1. Query SQL Server: SigCqChm JOIN SigChe com todos os filtros
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            loc_cSql = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
                       "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
                       "b.valors, b.emps, b.umovs, ' ' AS Hists " + ;
                       "FROM SigCqChm a, SigChe b " + ;
                       "WHERE a.nums = b.nums"
            loc_cSql = loc_cSql + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                       loc_cVerDesGrupo + loc_cVerDesConta + ;
                       " ORDER BY a.nums, a.numlotes, a.dtents, " + ;
                       "b.grclis, b.iclis, b.vencs, b.bancos, " + ;
                       "b.agencias, b.ncontas, b.ncheques, b.valors, b.emps, b.umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SqlTmp0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques"
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Join VFP local com operacoes selecionadas -> cursor resultado
            *-- ImpFollow: resultado vai para cursor_4c_Temp; senao: vai para CsRelatorio
            loc_cCursorFinal = IIF(THIS.this_lImpFollow, THIS.this_cCursorTemp, "CsRelatorio")

            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF THIS.this_lImpFollow AND USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            *-- SELECT com ORDER BY dinamico baseado no indice do combobox de ordem
            DO CASE
                CASE THIS.this_nOrdemIdx = 2
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 4 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                CASE THIS.this_nOrdemIdx = 3
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 5 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                OTHERWISE
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 3 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
            ENDCASE

            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            *-- 3. Preenche rClis e opcionalmente Hists
            IF THIS.this_lImpFollow
                THIS.ProcessarComFollowUp()
            ELSE
                THIS.BuscarClientes()
            ENDIF

            SELECT CsRelatorio
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientes - Preenche rClis em CsRelatorio via SigCdCli (sem FollowUp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarClientes()
        LOCAL loc_cSqlC, loc_nResult, loc_cIclis
        TRY
            SELECT CsRelatorio
            SCAN
                loc_cIclis = ALLTRIM(CsRelatorio.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliB")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliB
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliB.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliB
                    ENDIF
                    SELECT CsRelatorio
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.BuscarClientes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComFollowUp - Cria CsRelatorio com Hists e rClis do SigCheH/SigCdCli
    * Usado quando ImpFollow = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComFollowUp()
        LOCAL loc_cSqlH, loc_cSqlC, loc_nResult, loc_cNums, loc_cIclis
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            CREATE CURSOR CsRelatorio (Nums C(8), Numlotes N(8,0), dtents D, ;
                                       GrClis C(10), Iclis C(10), Vencs D, ;
                                       Bancos C(3), Agencias C(4), nContas C(10), ;
                                       nCheques C(6), Valors N(12,2), Emps C(3), ;
                                       Umovs C(15), Hists C(76), RClis C(50))

            SELECT (THIS.this_cCursorTemp)
            SCAN
                SCATTER MEMVAR MEMO

                SELECT CsRelatorio
                APPEND BLANK
                GATHER MEMVAR MEMO

                *-- Busca historico do cheque em SigCheH
                loc_cNums = ALLTRIM(m.Nums)
                loc_cSqlH = "SELECT TOP 1 Hists FROM SigCheH WHERE Nums = " + ;
                            EscaparSQL(loc_cNums)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlH, "cursor_4c_CheH")
                IF loc_nResult > 0
                    SELECT cursor_4c_CheH
                    IF !EOF()
                        REPLACE CsRelatorio.Hists WITH ALLTRIM(cursor_4c_CheH.Hists) ;
                                IN CsRelatorio
                    ENDIF
                    USE IN cursor_4c_CheH
                ENDIF

                *-- Busca razao social do cliente em SigCdCli
                loc_cIclis = ALLTRIM(m.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliF")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliF
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliF.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliF
                    ENDIF
                ENDIF

                SELECT (THIS.this_cCursorTemp)
            ENDSCAN

            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.ProcessarComFollowUp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp
        LOCAL loc_cNomeEmpresa, loc_cTipoData, loc_cPeriodo, loc_cEmissor, loc_cDestino

        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF THIS.this_nNrTipo = 2
                loc_cTipoData = "Data da Movimenta" + CHR(231) + CHR(227) + "o: "
            ELSE
                loc_cTipoData = "Data de Vencimento: "
            ENDIF

            loc_cPeriodo = loc_cTipoData + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdEmiConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiConta))

            loc_cDestino = "Grupo / Conta Destino  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdDesGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdDesConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesConta))

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(80), Operacao C(80), ;
                                       Emissor C(80), Destino C(80))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, ;
                        loc_cPeriodo, loc_cEmissor, loc_cDestino)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdemIdx, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";DES="  + ALLTRIM(THIS.this_cCdDesGrupo) + "/" + ALLTRIM(THIS.this_cCdDesConta) + ;
                     ";FLW="  + IIF(THIS.this_lImpFollow, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de cursor de preset
    * par_cAliasCursor: nome do cursor com colunas dos filtros previamente usados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF
                    IF TYPE("m.cCdDesGrupo") = "C"
                        THIS.this_cCdDesGrupo = ALLTRIM(m.cCdDesGrupo)
                    ENDIF
                    IF TYPE("m.cDsDesGrupo") = "C"
                        THIS.this_cDsDesGrupo = ALLTRIM(m.cDsDesGrupo)
                    ENDIF
                    IF TYPE("m.cCdDesConta") = "C"
                        THIS.this_cCdDesConta = ALLTRIM(m.cCdDesConta)
                    ENDIF
                    IF TYPE("m.cDsDesConta") = "C"
                        THIS.this_cDsDesConta = ALLTRIM(m.cDsDesConta)
                    ENDIF
                    IF TYPE("m.nOrdemIdx") = "N"
                        THIS.this_nOrdemIdx = m.nOrdemIdx
                    ENDIF
                    IF TYPE("m.lImpFollow") = "L"
                        THIS.this_lImpFollow = m.lImpFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

