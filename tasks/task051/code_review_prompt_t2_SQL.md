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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrechp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2324 linhas total):

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

*-- Linhas 1119 a 1154:
1119: 
1120:     *--------------------------------------------------------------------------
1121:     * ConfigurarGradeOperacoes - Cria grid de selecao de operacoes (GradeOpera)
1122:     * Regra critica: AddObject("Check1") ANTES de CurrentControl e ControlSource
1123:     * Original: GradeOpera Top=146, Left=249, Width=178, Height=89 -> Page: Top=61
1124:     *--------------------------------------------------------------------------
1125:     PROTECTED PROCEDURE ConfigurarGradeOperacoes(par_oPagina)
1126:         LOCAL loc_oGrid, loc_cCursor
1127:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
1128: 
1129:         par_oPagina.AddObject("grd_4c_Opera", "Grid")
1130:         loc_oGrid = par_oPagina.grd_4c_Opera
1131: 
1132:         WITH loc_oGrid
1133:             .Top                = 61
1134:             .Left               = 249
1135:             .Width              = 178
1136:             .Height             = 89
1137:             .ColumnCount        = 2
1138:             .RecordMark         = .F.
1139:             .DeleteMark         = .F.
1140:             .ScrollBars         = 2
1141:             .RowHeight          = 16
1142:             .FontName           = "Verdana"
1143:             .FontSize           = 8
1144:             .GridLineColor      = RGB(238, 238, 238)
1145:             .HighlightStyle     = 2
1146:             .HighlightBackColor = RGB(255, 255, 255)
1147:             .HighlightForeColor = RGB(15, 41, 104)
1148:             .AllowHeaderSizing  = .F.
1149:             .AllowRowSizing     = .F.
1150:             .Visible            = .T.
1151:         ENDWITH
1152: 
1153:         *-- Column1: CheckBox para Flag (selecao da operacao)
1154:         WITH loc_oGrid.Column1

*-- Linhas 1161 a 1193:
1161:         loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1162:         loc_oGrid.Column1.Check1.Caption  = ""
1163:         loc_oGrid.Column1.CurrentControl  = "Check1"
1164:         loc_oGrid.Column1.ControlSource   = loc_cCursor + ".Flag"
1165: 
1166:         *-- Column2: TextBox somente leitura para Operacaos
1167:         WITH loc_oGrid.Column2
1168:             .Width    = 149
1169:             .FontName = "Verdana"
1170:             .FontSize = 8
1171:             .ReadOnly = .T.
1172:         ENDWITH
1173:         loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1174:         loc_oGrid.Column2.ControlSource   = loc_cCursor + ".Operacaos"
1175: 
1176:         IF USED(loc_cCursor)
1177:             loc_oGrid.RecordSource = loc_cCursor
1178:             SELECT (loc_cCursor)
1179:             GO TOP
1180:         ENDIF
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * BOParaForm - Sincroniza valores do BO com os controles de Page1
1185:     *--------------------------------------------------------------------------
1186:     PROTECTED PROCEDURE BOParaForm()
1187:         LOCAL loc_oPagina, loc_oRel
1188:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1189:             RETURN
1190:         ENDIF
1191:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1192:             RETURN
1193:         ENDIF

*-- Linhas 1258 a 1276:
1258:             RETURN
1259:         ENDIF
1260:         TRY
1261:             SELECT (loc_cCursor)
1262:             loc_nRecno = RECNO()
1263:             REPLACE ALL Flag WITH .T. IN (loc_cCursor)
1264:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1265:                 GOTO loc_nRecno IN (loc_cCursor)
1266:             ENDIF
1267:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1268:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1269:             ENDIF
1270:         CATCH TO loc_oErro
1271:             MsgErro(loc_oErro.Message, "Formsigrechp.SelecionarTodosClick")
1272:         ENDTRY
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * DeselecionarTodosClick - Marca Flag=.F. em todas as operacoes

*-- Linhas 1286 a 1304:
1286:             RETURN
1287:         ENDIF
1288:         TRY
1289:             SELECT (loc_cCursor)
1290:             loc_nRecno = RECNO()
1291:             REPLACE ALL Flag WITH .F. IN (loc_cCursor)
1292:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1293:                 GOTO loc_nRecno IN (loc_cCursor)
1294:             ENDIF
1295:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1296:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1297:             ENDIF
1298:         CATCH TO loc_oErro
1299:             MsgErro(loc_oErro.Message, "Formsigrechp.DeselecionarTodosClick")
1300:         ENDTRY
1301:     ENDPROC
1302: 
1303:     *--------------------------------------------------------------------------
1304:     * TeclaEmpresaCd/Ds - KeyPress handlers para campos de Empresa

*-- Linhas 1348 a 1370:
1348:             IF USED("cursor_4c_EmpVal")
1349:                 USE IN cursor_4c_EmpVal
1350:             ENDIF
1351:             loc_cSql    = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
1352:                           EscaparSQL(loc_cCod)
1353:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1354:             IF loc_nResult > 0
1355:                 SELECT cursor_4c_EmpVal
1356:                 IF !EOF()
1357:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1358:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1359:                     ENDIF
1360:                 ELSE
1361:                     MsgAviso("Empresa " + CHR(39) + loc_cCod + CHR(39) + ;
1362:                              " n" + CHR(227) + "o encontrada.", "Empresa")
1363:                     loc_oPagina.txt_4c_CdEmpresa.Value = ""
1364:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1365:                         loc_oPagina.txt_4c_DsEmpresa.Value = ""
1366:                     ENDIF
1367:                 ENDIF
1368:                 USE IN cursor_4c_EmpVal
1369:             ENDIF
1370:         CATCH TO loc_oErro

*-- Linhas 1395 a 1418:
1395:             IF USED("cursor_4c_EmpVal")
1396:                 USE IN cursor_4c_EmpVal
1397:             ENDIF
1398:             loc_cSql    = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp " + ;
1399:                           "WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1400:                           " ORDER BY cEmps"
1401:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1402:             IF loc_nResult > 0
1403:                 SELECT cursor_4c_EmpVal
1404:                 IF !EOF()
1405:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1406:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.cEmps)
1407:                     ENDIF
1408:                     loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1409:                 ENDIF
1410:                 USE IN cursor_4c_EmpVal
1411:             ENDIF
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmpresa")
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * TeclaDesGrupoCd/Ds - KeyPress handlers para Grupo Destino

*-- Linhas 1467 a 1489:
1467:             IF USED("cursor_4c_GrpDesVal")
1468:                 USE IN cursor_4c_GrpDesVal
1469:             ENDIF
1470:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1471:                           EscaparSQL(loc_cCod)
1472:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1473:             IF loc_nResult > 0
1474:                 SELECT cursor_4c_GrpDesVal
1475:                 IF !EOF()
1476:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1477:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1478:                     ENDIF
1479:                 ELSE
1480:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1481:                              " n" + CHR(227) + "o encontrado.", "Grupo/Destino")
1482:                     loc_oPagina.txt_4c_CdDesGrupo.Value = ""
1483:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1484:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ""
1485:                     ENDIF
1486:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1487:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
1488:                     ENDIF
1489:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)

*-- Linhas 1520 a 1543:
1520:             IF USED("cursor_4c_GrpDesVal")
1521:                 USE IN cursor_4c_GrpDesVal
1522:             ENDIF
1523:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1524:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1525:                           " ORDER BY Codigos"
1526:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1527:             IF loc_nResult > 0
1528:                 SELECT cursor_4c_GrpDesVal
1529:                 IF !EOF()
1530:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1531:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Codigos)
1532:                     ENDIF
1533:                     loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1534:                 ENDIF
1535:                 USE IN cursor_4c_GrpDesVal
1536:             ENDIF
1537:         CATCH TO loc_oErro
1538:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesGrupo")
1539:         ENDTRY
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * TeclaDesContaCd/Ds - KeyPress handlers para Conta Destino

*-- Linhas 1588 a 1613:
1588:             IF USED("cursor_4c_CliVal")
1589:                 USE IN cursor_4c_CliVal
1590:             ENDIF
1591:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1592:                        EscaparSQL(loc_cCod)
1593:             IF !EMPTY(loc_cGrupo)
1594:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1595:             ENDIF
1596:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1597:             IF loc_nResult > 0
1598:                 SELECT cursor_4c_CliVal
1599:                 IF !EOF()
1600:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1601:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1602:                     ENDIF
1603:                 ELSE
1604:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1605:                              " inv" + CHR(225) + "lida.", "Conta/Destino")
1606:                     loc_oPagina.txt_4c_CdDesConta.Value = ""
1607:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1608:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1609:                     ENDIF
1610:                 ENDIF
1611:                 USE IN cursor_4c_CliVal
1612:             ENDIF
1613:         CATCH TO loc_oErro

*-- Linhas 1640 a 1666:
1640:             IF USED("cursor_4c_CliVal")
1641:                 USE IN cursor_4c_CliVal
1642:             ENDIF
1643:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1644:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1645:             IF !EMPTY(loc_cGrupo)
1646:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1647:             ENDIF
1648:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1649:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1650:             IF loc_nResult > 0
1651:                 SELECT cursor_4c_CliVal
1652:                 IF !EOF()
1653:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1654:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_CliVal.Iclis)
1655:                     ENDIF
1656:                     loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1657:                 ENDIF
1658:                 USE IN cursor_4c_CliVal
1659:             ENDIF
1660:         CATCH TO loc_oErro
1661:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesConta")
1662:         ENDTRY
1663:     ENDPROC
1664: 
1665:     *--------------------------------------------------------------------------
1666:     * TeclaEmiGrupoCd/Ds - KeyPress handlers para Grupo Emissor

*-- Linhas 1715 a 1737:
1715:             IF USED("cursor_4c_GrpEmiVal")
1716:                 USE IN cursor_4c_GrpEmiVal
1717:             ENDIF
1718:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1719:                           EscaparSQL(loc_cCod)
1720:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1721:             IF loc_nResult > 0
1722:                 SELECT cursor_4c_GrpEmiVal
1723:                 IF !EOF()
1724:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1725:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1726:                     ENDIF
1727:                 ELSE
1728:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1729:                              " n" + CHR(227) + "o encontrado.", "Grupo/Emissor")
1730:                     loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
1731:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1732:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
1733:                     ENDIF
1734:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1735:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
1736:                     ENDIF
1737:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)

*-- Linhas 1768 a 1791:
1768:             IF USED("cursor_4c_GrpEmiVal")
1769:                 USE IN cursor_4c_GrpEmiVal
1770:             ENDIF
1771:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1772:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1773:                           " ORDER BY Codigos"
1774:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1775:             IF loc_nResult > 0
1776:                 SELECT cursor_4c_GrpEmiVal
1777:                 IF !EOF()
1778:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
1779:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Codigos)
1780:                     ENDIF
1781:                     loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1782:                 ENDIF
1783:                 USE IN cursor_4c_GrpEmiVal
1784:             ENDIF
1785:         CATCH TO loc_oErro
1786:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiGrupo")
1787:         ENDTRY
1788:     ENDPROC
1789: 
1790:     *--------------------------------------------------------------------------
1791:     * TeclaEmiContaCd/Ds - KeyPress handlers para Conta Emissor

*-- Linhas 1836 a 1861:
1836:             IF USED("cursor_4c_EmiCliVal")
1837:                 USE IN cursor_4c_EmiCliVal
1838:             ENDIF
1839:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1840:                        EscaparSQL(loc_cCod)
1841:             IF !EMPTY(loc_cGrupo)
1842:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1843:             ENDIF
1844:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1845:             IF loc_nResult > 0
1846:                 SELECT cursor_4c_EmiCliVal
1847:                 IF !EOF()
1848:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1849:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1850:                     ENDIF
1851:                 ELSE
1852:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1853:                              " inv" + CHR(225) + "lida.", "Conta/Emissor")
1854:                     loc_oPagina.txt_4c_CdEmiConta.Value = ""
1855:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1856:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
1857:                     ENDIF
1858:                 ENDIF
1859:                 USE IN cursor_4c_EmiCliVal
1860:             ENDIF
1861:         CATCH TO loc_oErro

*-- Linhas 1888 a 1914:
1888:             IF USED("cursor_4c_EmiCliVal")
1889:                 USE IN cursor_4c_EmiCliVal
1890:             ENDIF
1891:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1892:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1893:             IF !EMPTY(loc_cGrupo)
1894:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1895:             ENDIF
1896:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1897:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1898:             IF loc_nResult > 0
1899:                 SELECT cursor_4c_EmiCliVal
1900:                 IF !EOF()
1901:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1902:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.Iclis)
1903:                     ENDIF
1904:                     loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1905:                 ENDIF
1906:                 USE IN cursor_4c_EmiCliVal
1907:             ENDIF
1908:         CATCH TO loc_oErro
1909:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiConta")
1910:         ENDTRY
1911:     ENDPROC
1912: 
1913:     *--------------------------------------------------------------------------
1914:     * AlternarPagina - Navega entre paginas do PageFrame

*-- Linhas 1947 a 1965:
1947:             loc_oBusca.Show()
1948:             IF loc_oBusca.this_lSelecionou
1949:                 IF USED("cursor_4c_BuscaEmp")
1950:                     SELECT cursor_4c_BuscaEmp
1951:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1952:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1953:                     ENDIF
1954:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1955:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1956:                     ENDIF
1957:                 ENDIF
1958:             ENDIF
1959:         CATCH TO loc_oErro
1960:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmpresa")
1961:         ENDTRY
1962:         IF USED("cursor_4c_BuscaEmp")
1963:             USE IN cursor_4c_BuscaEmp
1964:         ENDIF
1965:         IF VARTYPE(loc_oBusca) = "O"

*-- Linhas 1992 a 2010:
1992:             loc_oBusca.Show()
1993:             IF loc_oBusca.this_lSelecionou
1994:                 IF USED("cursor_4c_BuscaDesGrp")
1995:                     SELECT cursor_4c_BuscaDesGrp
1996:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1997:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Codigos)
1998:                     ENDIF
1999:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
2000:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Descrs)
2001:                     ENDIF
2002:                     *-- Limpa conta destino pois depende do grupo
2003:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
2004:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
2005:                     ENDIF
2006:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
2007:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
2008:                     ENDIF
2009:                 ENDIF
2010:             ENDIF

*-- Linhas 2037 a 2068:
2037:             IF EMPTY(loc_cGrupo)
2038:                 loc_cSQL = ""
2039:             ELSE
2040:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2041:             ENDIF
2042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2043:                 "SigCdCli" + loc_cSQL, ;
2044:                 "cursor_4c_BuscaDesCli", ;
2045:                 "Iclis", ;
2046:                 loc_cCodAtual, ;
2047:                 "Buscar Conta Destino")
2048:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2049:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2050:             loc_oBusca.Show()
2051:             IF loc_oBusca.this_lSelecionou
2052:                 IF USED("cursor_4c_BuscaDesCli")
2053:                     SELECT cursor_4c_BuscaDesCli
2054:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
2055:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.Iclis)
2056:                     ENDIF
2057:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
2058:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.rClis)
2059:                     ENDIF
2060:                 ENDIF
2061:             ENDIF
2062:         CATCH TO loc_oErro
2063:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesConta")
2064:         ENDTRY
2065:         IF USED("cursor_4c_BuscaDesCli")
2066:             USE IN cursor_4c_BuscaDesCli
2067:         ENDIF
2068:         IF VARTYPE(loc_oBusca) = "O"

*-- Linhas 2095 a 2113:
2095:             loc_oBusca.Show()
2096:             IF loc_oBusca.this_lSelecionou
2097:                 IF USED("cursor_4c_BuscaEmiGrp")
2098:                     SELECT cursor_4c_BuscaEmiGrp
2099:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
2100:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Codigos)
2101:                     ENDIF
2102:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
2103:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Descrs)
2104:                     ENDIF
2105:                     *-- Limpa conta emissor pois depende do grupo
2106:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2107:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
2108:                     ENDIF
2109:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2110:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
2111:                     ENDIF
2112:                 ENDIF
2113:             ENDIF

*-- Linhas 2288 a 2319:
2288:             IF EMPTY(loc_cGrupo)
2289:                 loc_cSQL = ""
2290:             ELSE
2291:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2292:             ENDIF
2293:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2294:                 "SigCdCli" + loc_cSQL, ;
2295:                 "cursor_4c_BuscaEmiCli", ;
2296:                 "Iclis", ;
2297:                 loc_cCodAtual, ;
2298:                 "Buscar Conta Emissor")
2299:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2300:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2301:             loc_oBusca.Show()
2302:             IF loc_oBusca.this_lSelecionou
2303:                 IF USED("cursor_4c_BuscaEmiCli")
2304:                     SELECT cursor_4c_BuscaEmiCli
2305:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2306:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.Iclis)
2307:                     ENDIF
2308:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2309:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.rClis)
2310:                     ENDIF
2311:                 ENDIF
2312:             ENDIF
2313:         CATCH TO loc_oErro
2314:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiConta")
2315:         ENDTRY
2316:         IF USED("cursor_4c_BuscaEmiCli")
2317:             USE IN cursor_4c_BuscaEmiCli
2318:         ENDIF
2319:         IF VARTYPE(loc_oBusca) = "O"


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

