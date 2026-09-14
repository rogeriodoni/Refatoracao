# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, SITUAS, EMPS, ACESSO, DATAS, MARCA, DOPPS, NENVS, TPOPS, LCEDN, EMPDNPS, NOPS, CONTADS, CPROS, CGRUS, ICLIS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
		lcQuery = [Select Codigos, Descrs ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdGcr') < 1)
		Select CrSigCdGcr
		lcQuery = [Select Cods, Descs ] + ;
				    [From SigOpOpt ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigOpOpt') < 1)
		Select CrSigOpOpt
		lcQuery = [Select IClis, RClis, Inativas ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdCli') < 1)
		Select CrSigCdCli
		lcSql = [Select 0 as Acesso, * From SigInTgo ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpTpGop') < 1)
		Select TmpTpGop
		Select * From TmpTpGop Where Acesso = 1 Into Cursor CrTmpTpGop ReadWrite
		Select CrTmpTpGop
If ThisForm.poDataMgr.SqlExecute([Select 0 As Marca, DopPs, ndopps, CodTgOps From SigCdOpd ],'CsSigCdOpd') < 1
Select CsSigCdOpd
		Delete
Select CsSigCdOpd
	.GrdTipo.Column1.ControlSource = 'CsSigCdOpd.Marca'
	.GrdTipo.Column3.ControlSource = 'CsSigCdOpd.Dopps'
lStrQuery = [Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs,]+;
			  [From SigCdNec a, SigCdNei b ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpNens') < 1
Select CsSigCdOpd
Select * From CsSigCdOpd Where Marca > 0 And Iif(!Empty(lcTGOp),CodTgOps = lcTGOp, .t. ) Into Cursor csLocalMc
	Select a.* From TmpNens a, CsSigCdOpd b ;
	Select a.* From TmpNens a, CsSigCdOpd b ;
	Select Distinct Empdnps From CrSigCdNec Where Nenvs = lnEnvelope Into Cursor crEnvelope
Select CrSigCdNec
		loBarra.Update(.T.)
			Select crEnvelope
				lcQuery = [Select Case When c.globalizas = 1 Then d.Iclis Else e.Iclis End as Iclis, ] +;
							[From sigoppic a inner join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] +;
							[inner join SigCdOpe c on b.Dopes = c.Dopes ] +;
							[inner join SigCdCli d on b.ContaOs = d.Iclis ] +;
							[inner join SigCdCli e on b.ContaDs = e.Iclis ] +;
				lcQuery = [Select Case When c.globalizas = 1 Then d.Iclis Else e.Iclis End as Iclis, ] +;
							[From SigPdMvf f Inner Join sigoppic a  On f.Nops = a.Nops inner join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] +;
							[inner join SigCdOpe c on b.Dopes = c.Dopes ] +;
							[inner join SigCdCli d on b.ContaOs = d.Iclis ] +;
							[inner join SigCdCli e on b.ContaDs = e.Iclis ] +;
			If Thisform.PodataMgr.SqlExecute(lcQuery,'LocalCli') < 1
		lcQuery = [Select a.CPros,a.DPros,a.CGrus,a.CUnis,a.CUniPs,b.Mercs From SigCdPro a, SigCdGrp b Where a.CPros = ']+CrSigCdNec.CMats+[' And a.Cgrus = b.Cgrus ]
		If Thisform.PodataMgr.SqlExecute(lcQuery,'CrSigCdPro') < 1
		Select CrSigCdPro
			lcQuery = [Select top 1 a.Cpros, b.DPros ] + ;
					    [From SigOpPic a Inner join SigCdPro b on a.Cpros = b.Cpros Where Nops = ?crSigCdNec.Nops]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select TmpRelat
			If Not Seek(Dtos(CrSigCdNec.Datas) + lcPed + Str(lnEnv,10) + CrSigCdNec.cMats )
				Insert Into TmpRelat (Datas, Operacaos, Nenvs, CMats, Dpros, Cunis, CPros, DDPros, Fators ) ;
			Select TmpRelat
			If Not Seek(lcGrp + lcCta + lcTpOps + CrSigCdPro.Cunis + CrSigCdPro.CuniPs + CrSigCdNec.CMats + lcPed + Str(lnEnv,10) )
				Insert Into TmpRelat (Fase, Iclis, RClis, CMats, Dpros, CPros, DDPros, TpOps, Cunis, Operacaos, Nenvs, Datas, Fators, CuniPs) ;
			If Not Seek(Replicate(Chr(255), 20) + lcTpOps + CrSigCdPro.Cunis + CrSigCdPro.CuniPs + CrSigCdNec.CMats)
				Insert Into TmpRelat (Fase, Iclis, RClis, CMats, TpOps, Cunis, CuniPs ) ;
	lStrQuery = [Select a.RClis, a.Cpfs ]+;
				  [From SigCdCli a ] + ;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalCli') < 1
	Select LocalCli
Insert Into dbCabecalho (Titulo, SubTitulo, NomeEmpresa, ImpFuncs) Values (lcCab, lcSub, lcEmp, ThisForm.chkFuncs.Value)
Select TmpRelat
	Select CrSigCdGcr
	If Not Seek(This.Value)
	Select CrSigCdCli
	If Not Seek(This.Value)
	Select CrSigCdCli
	If Not Seek(This.Value)
Select CsSigCdOpd
Select CsSigCdOpd
	Select CrSigOpOpt
	If Not Seek(This.Value)
	Select CrSigCdGcr
	If Not Seek(This.Value)
If Not Empty(This.Value) And Not Seek(This.Value, 'crTmpTpGop', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDpD.prg) - TRECHOS RELEVANTES PARA PASS SQL (2628 linhas total):

*-- Linhas 54 a 72:
54:             ENDIF
55:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
56: 
57:             *-- BO faz SQLEXEC no Init - pular em modo de validacao de UI (gnConnHandle=-1)
58:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                 THIS.this_oRelatorio = CREATEOBJECT("SigReDpDBO")
60:                 IF VARTYPE(THIS.this_oRelatorio) != "O"
61:                     MsgErro("Erro ao criar SigReDpDBO", "Erro")
62:                     loc_lContinuar = .F.
63:                 ENDIF
64:             ENDIF
65: 
66:             IF loc_lContinuar
67:                 THIS.ConfigurarCabecalho()
68:                 THIS.ConfigurarBotoes()
69:                 THIS.ConfigurarPageFrame()
70:                 THIS.ConfigurarPaginaLabels()
71:                 THIS.ConfigurarPaginaControles()
72:                 THIS.ConfigurarContainerOperacoes()

*-- Linhas 994 a 1012:
994:                 .Height       = 247
995:                 .ColumnCount  = 2
996:                 .AllowRowSizing = .F.
997:                 .DeleteMark   = .F.
998:                 .GridLines    = 3
999:                 .HeaderHeight = 0
1000:                 .RowHeight    = 18
1001:                 .ScrollBars   = 2
1002:                 .RecordMark   = .F.
1003:                 .FontName     = "Tahoma"
1004:                 .GridLineColor = RGB(238, 238, 238)
1005:                 .TabStop      = .F.
1006:                 .Panel        = 1
1007:                 .Visible      = .T.
1008: 
1009:                 WITH .Column1
1010:                     .Width     = 15
1011:                     .Alignment = 0
1012:                     .Enabled   = .T.

*-- Linhas 1019 a 1047:
1019:                         .FontName  = "Tahoma"
1020:                     ENDWITH
1021:                     .CurrentControl = "chk_4c_Marca"
1022:                     .ControlSource  = "CsSigCdOpd.Marca"
1023:                     WITH .Header1
1024:                         .Caption   = ""
1025:                         .FontName  = "Tahoma"
1026:                         .ForeColor = RGB(90, 90, 90)
1027:                     ENDWITH
1028:                 ENDWITH
1029: 
1030:                 WITH .Column2
1031:                     .Width         = 220
1032:                     .ControlSource = "CsSigCdOpd.Dopps"
1033:                     .Enabled       = .T.
1034:                     .ReadOnly      = .T.
1035:                     .Sparse        = .F.
1036:                     WITH .Header1
1037:                         .Caption   = "Descrs"
1038:                         .FontName  = "Tahoma"
1039:                         .ForeColor = RGB(90, 90, 90)
1040:                     ENDWITH
1041:                     WITH .Text1
1042:                         .Enabled     = .T.
1043:                         .ReadOnly    = .T.
1044:                         .ForeColor   = RGB(0, 0, 0)
1045:                         .BackColor   = RGB(255, 255, 255)
1046:                         .FontName    = "Tahoma"
1047:                     ENDWITH

*-- Linhas 1207 a 1225:
1207:                 LOCAL loc_nCount
1208:                 loc_nCount = IIF(USED("CrTmpTpGop"), RECCOUNT("CrTmpTpGop"), 0)
1209:                 IF loc_nCount >= 1
1210:                     SELECT CrTmpTpGop
1211:                     GO TOP
1212:                     loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(CrTmpTpGop.Codigos)
1213:                 ELSE
1214:                     loc_oPg.txt_4c_TpGOp.Value = ""
1215:                 ENDIF
1216:                 loc_oPg.txt_4c_TpGOp.Enabled = (loc_nCount > 1)
1217:             ENDIF
1218: 
1219:         CATCH TO loc_oErro
1220:             MsgErro(loc_oErro.Message, "FormSigReDpD.LimparCampos")
1221:         ENDTRY
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * Habilita/desabilita campos Conta e DGrupo conforme preenchimento do Grupo

*-- Linhas 1340 a 1369:
1340:             IF VARTYPE(loc_oForm) = "O"
1341:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1342:                     IF USED("cursor_4c_BuscaGrupo")
1343:                         SELECT cursor_4c_BuscaGrupo
1344:                         IF !EOF()
1345:                             loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1346:                             loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1347:                         ENDIF
1348:                     ENDIF
1349:                 ELSE
1350:                     loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1351:                     loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1352:                     loc_oForm.Show()
1353:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1354:                         SELECT cursor_4c_BuscaGrupo
1355:                         IF !EOF()
1356:                             loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1357:                             loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1358:                         ENDIF
1359:                     ENDIF
1360:                 ENDIF
1361:                 IF USED("cursor_4c_BuscaGrupo")
1362:                     USE IN cursor_4c_BuscaGrupo
1363:                 ENDIF
1364:                 THIS.AtualizarEstadoConta()
1365:                 loc_oForm.Release()
1366:             ENDIF
1367:         CATCH TO loc_oErro
1368:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupo")
1369:         ENDTRY

*-- Linhas 1383 a 1412:
1383:             IF VARTYPE(loc_oForm) = "O"
1384:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1385:                     IF USED("cursor_4c_BuscaDGrupo")
1386:                         SELECT cursor_4c_BuscaDGrupo
1387:                         IF !EOF()
1388:                             loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.Codigos)
1389:                             loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.Descrs)
1390:                         ENDIF
1391:                     ENDIF
1392:                 ELSE
1393:                     loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1394:                     loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1395:                     loc_oForm.Show()
1396:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDGrupo")
1397:                         SELECT cursor_4c_BuscaDGrupo
1398:                         IF !EOF()
1399:                             loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.Codigos)
1400:                             loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.Descrs)
1401:                         ENDIF
1402:                     ENDIF
1403:                 ENDIF
1404:                 IF USED("cursor_4c_BuscaDGrupo")
1405:                     USE IN cursor_4c_BuscaDGrupo
1406:                 ENDIF
1407:                 THIS.AtualizarEstadoConta()
1408:                 loc_oForm.Release()
1409:             ENDIF
1410:         CATCH TO loc_oErro
1411:             MsgErro(loc_oErro.Message, "AbrirBuscaDGrupo")
1412:         ENDTRY

*-- Linhas 1426 a 1455:
1426:             IF VARTYPE(loc_oForm) = "O"
1427:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1428:                     IF USED("cursor_4c_BuscaConta")
1429:                         SELECT cursor_4c_BuscaConta
1430:                         IF !EOF()
1431:                             loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1432:                             loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1433:                         ENDIF
1434:                     ENDIF
1435:                 ELSE
1436:                     loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1437:                     loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1438:                     loc_oForm.Show()
1439:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1440:                         SELECT cursor_4c_BuscaConta
1441:                         IF !EOF()
1442:                             loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1443:                             loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1444:                         ENDIF
1445:                     ENDIF
1446:                 ENDIF
1447:                 IF USED("cursor_4c_BuscaConta")
1448:                     USE IN cursor_4c_BuscaConta
1449:                 ENDIF
1450:                 THIS.AtualizarEstadoConta()
1451:                 loc_oForm.Release()
1452:             ENDIF
1453:         CATCH TO loc_oErro
1454:             MsgErro(loc_oErro.Message, "AbrirBuscaConta")
1455:         ENDTRY

*-- Linhas 1469 a 1498:
1469:             IF VARTYPE(loc_oForm) = "O"
1470:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1471:                     IF USED("cursor_4c_BuscaDConta")
1472:                         SELECT cursor_4c_BuscaDConta
1473:                         IF !EOF()
1474:                             loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaDConta.IClis)
1475:                             loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaDConta.RClis)
1476:                         ENDIF
1477:                     ENDIF
1478:                 ELSE
1479:                     loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1480:                     loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1481:                     loc_oForm.Show()
1482:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
1483:                         SELECT cursor_4c_BuscaDConta
1484:                         IF !EOF()
1485:                             loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaDConta.IClis)
1486:                             loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaDConta.RClis)
1487:                         ENDIF
1488:                     ENDIF
1489:                 ENDIF
1490:                 IF USED("cursor_4c_BuscaDConta")
1491:                     USE IN cursor_4c_BuscaDConta
1492:                 ENDIF
1493:                 THIS.AtualizarEstadoConta()
1494:                 loc_oForm.Release()
1495:             ENDIF
1496:         CATCH TO loc_oErro
1497:             MsgErro(loc_oErro.Message, "AbrirBuscaDConta")
1498:         ENDTRY

*-- Linhas 1512 a 1542:
1512:             IF VARTYPE(loc_oForm) = "O"
1513:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1514:                     IF USED("cursor_4c_BuscaCGru")
1515:                         SELECT cursor_4c_BuscaCGru
1516:                         IF !EOF()
1517:                             loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaCGru.CGrus)
1518:                             loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaCGru.DGrus)
1519:                             loc_oPg.txt_4c_GetDGru.Enabled = .F.
1520:                         ENDIF
1521:                     ENDIF
1522:                 ELSE
1523:                     loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1524:                     loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1525:                     loc_oForm.Show()
1526:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCGru")
1527:                         SELECT cursor_4c_BuscaCGru
1528:                         IF !EOF()
1529:                             loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaCGru.CGrus)
1530:                             loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaCGru.DGrus)
1531:                             loc_oPg.txt_4c_GetDGru.Enabled = .F.
1532:                         ENDIF
1533:                     ENDIF
1534:                 ENDIF
1535:                 IF USED("cursor_4c_BuscaCGru")
1536:                     USE IN cursor_4c_BuscaCGru
1537:                 ENDIF
1538:                 loc_oForm.Release()
1539:             ENDIF
1540:         CATCH TO loc_oErro
1541:             MsgErro(loc_oErro.Message, "AbrirBuscaCGru")
1542:         ENDTRY

*-- Linhas 1556 a 1586:
1556:             IF VARTYPE(loc_oForm) = "O"
1557:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1558:                     IF USED("cursor_4c_BuscaDGru")
1559:                         SELECT cursor_4c_BuscaDGru
1560:                         IF !EOF()
1561:                             loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaDGru.CGrus)
1562:                             loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaDGru.DGrus)
1563:                             loc_oPg.txt_4c_GetDGru.Enabled = .F.
1564:                         ENDIF
1565:                     ENDIF
1566:                 ELSE
1567:                     loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1568:                     loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1569:                     loc_oForm.Show()
1570:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDGru")
1571:                         SELECT cursor_4c_BuscaDGru
1572:                         IF !EOF()
1573:                             loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaDGru.CGrus)
1574:                             loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaDGru.DGrus)
1575:                             loc_oPg.txt_4c_GetDGru.Enabled = .F.
1576:                         ENDIF
1577:                     ENDIF
1578:                 ENDIF
1579:                 IF USED("cursor_4c_BuscaDGru")
1580:                     USE IN cursor_4c_BuscaDGru
1581:                 ENDIF
1582:                 loc_oForm.Release()
1583:             ENDIF
1584:         CATCH TO loc_oErro
1585:             MsgErro(loc_oErro.Message, "AbrirBuscaDGru")
1586:         ENDTRY

*-- Linhas 1600 a 1629:
1600:             IF VARTYPE(loc_oForm) = "O"
1601:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1602:                     IF USED("cursor_4c_BuscaGgrp")
1603:                         SELECT cursor_4c_BuscaGgrp
1604:                         IF !EOF()
1605:                             loc_oPg.txt_4c_GetGgrp.Value  = ALLTRIM(cursor_4c_BuscaGgrp.Codigos)
1606:                             loc_oPg.txt_4c_GetDGgrp.Value = ALLTRIM(cursor_4c_BuscaGgrp.Descs)
1607:                         ENDIF
1608:                     ENDIF
1609:                 ELSE
1610:                     loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1611:                     loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1612:                     loc_oForm.Show()
1613:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGgrp")
1614:                         SELECT cursor_4c_BuscaGgrp
1615:                         IF !EOF()
1616:                             loc_oPg.txt_4c_GetGgrp.Value  = ALLTRIM(cursor_4c_BuscaGgrp.Codigos)
1617:                             loc_oPg.txt_4c_GetDGgrp.Value = ALLTRIM(cursor_4c_BuscaGgrp.Descs)
1618:                         ENDIF
1619:                     ENDIF
1620:                 ENDIF
1621:                 IF USED("cursor_4c_BuscaGgrp")
1622:                     USE IN cursor_4c_BuscaGgrp
1623:                 ENDIF
1624:                 loc_oForm.Release()
1625:             ENDIF
1626:         CATCH TO loc_oErro
1627:             MsgErro(loc_oErro.Message, "AbrirBuscaGgrp")
1628:         ENDTRY
1629:     ENDPROC

*-- Linhas 1635 a 1673:
1635:         LOCAL loc_oForm, loc_oPg, loc_oErro, loc_cFiltro
1636:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1637:         loc_cFiltro = "Situas < 2 AND (Emps = ' ' OR Emps = " + ;
1638:             EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
1639:         TRY
1640:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
1641:                 gnConnHandle, "SigOpOpt", "cursor_4c_BuscaTpOps", ;
1642:                 "Cods", ALLTRIM(loc_oPg.txt_4c_GetTpOps.Value), ;
1643:                 "Selecionar Tipo de Opera" + CHR(231) + CHR(227) + "o", ;
1644:                 .F., .F., loc_cFiltro)
1645:             IF VARTYPE(loc_oForm) = "O"
1646:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1647:                     IF USED("cursor_4c_BuscaTpOps")
1648:                         SELECT cursor_4c_BuscaTpOps
1649:                         IF !EOF()
1650:                             loc_oPg.txt_4c_GetTpOps.Value = ALLTRIM(cursor_4c_BuscaTpOps.Cods)
1651:                         ENDIF
1652:                     ENDIF
1653:                 ELSE
1654:                     loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1655:                     loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1656:                     loc_oForm.Show()
1657:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTpOps")
1658:                         SELECT cursor_4c_BuscaTpOps
1659:                         IF !EOF()
1660:                             loc_oPg.txt_4c_GetTpOps.Value = ALLTRIM(cursor_4c_BuscaTpOps.Cods)
1661:                         ENDIF
1662:                     ENDIF
1663:                 ENDIF
1664:                 IF USED("cursor_4c_BuscaTpOps")
1665:                     USE IN cursor_4c_BuscaTpOps
1666:                 ENDIF
1667:                 loc_oForm.Release()
1668:             ENDIF
1669:         CATCH TO loc_oErro
1670:             MsgErro(loc_oErro.Message, "AbrirBuscaTpOps")
1671:         ENDTRY
1672:     ENDPROC
1673: 

*-- Linhas 1685 a 1714:
1685:             IF VARTYPE(loc_oForm) = "O"
1686:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1687:                     IF USED("cursor_4c_BuscaCodCli")
1688:                         SELECT cursor_4c_BuscaCodCli
1689:                         IF !EOF()
1690:                             loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaCodCli.IClis)
1691:                             loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaCodCli.RClis)
1692:                         ENDIF
1693:                     ENDIF
1694:                 ELSE
1695:                     loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1696:                     loc_oForm.mAddColuna("RClis", "", "Nome")
1697:                     loc_oForm.Show()
1698:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCodCli")
1699:                         SELECT cursor_4c_BuscaCodCli
1700:                         IF !EOF()
1701:                             loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaCodCli.IClis)
1702:                             loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaCodCli.RClis)
1703:                         ENDIF
1704:                     ENDIF
1705:                 ENDIF
1706:                 IF USED("cursor_4c_BuscaCodCli")
1707:                     USE IN cursor_4c_BuscaCodCli
1708:                 ENDIF
1709:                 *-- Quando cliente preenchido: desabilita detalhe/produtos
1710:                 THIS.AtualizarEstadoCodCli()
1711:                 loc_oForm.Release()
1712:             ENDIF
1713:         CATCH TO loc_oErro
1714:             MsgErro(loc_oErro.Message, "AbrirBuscaCodCli")

*-- Linhas 1729 a 1758:
1729:             IF VARTYPE(loc_oForm) = "O"
1730:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1731:                     IF USED("cursor_4c_BuscaDescCli")
1732:                         SELECT cursor_4c_BuscaDescCli
1733:                         IF !EOF()
1734:                             loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaDescCli.IClis)
1735:                             loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaDescCli.RClis)
1736:                         ENDIF
1737:                     ENDIF
1738:                 ELSE
1739:                     loc_oForm.mAddColuna("RClis", "", "Nome")
1740:                     loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1741:                     loc_oForm.Show()
1742:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDescCli")
1743:                         SELECT cursor_4c_BuscaDescCli
1744:                         IF !EOF()
1745:                             loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaDescCli.IClis)
1746:                             loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaDescCli.RClis)
1747:                         ENDIF
1748:                     ENDIF
1749:                 ENDIF
1750:                 IF USED("cursor_4c_BuscaDescCli")
1751:                     USE IN cursor_4c_BuscaDescCli
1752:                 ENDIF
1753:                 THIS.AtualizarEstadoCodCli()
1754:                 loc_oForm.Release()
1755:             ENDIF
1756:         CATCH TO loc_oErro
1757:             MsgErro(loc_oErro.Message, "AbrirBuscaDescCli")
1758:         ENDTRY

*-- Linhas 1772 a 1799:
1772:             IF VARTYPE(loc_oForm) = "O"
1773:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1774:                     IF USED("cursor_4c_BuscaDopps")
1775:                         SELECT cursor_4c_BuscaDopps
1776:                         IF !EOF()
1777:                             loc_oPg.txt_4c_GetDopes.Value = ALLTRIM(cursor_4c_BuscaDopps.DopPs)
1778:                         ENDIF
1779:                     ENDIF
1780:                 ELSE
1781:                     loc_oForm.mAddColuna("DopPs", "", "Movimenta" + CHR(231) + CHR(227) + "o")
1782:                     loc_oForm.Show()
1783:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDopps")
1784:                         SELECT cursor_4c_BuscaDopps
1785:                         IF !EOF()
1786:                             loc_oPg.txt_4c_GetDopes.Value = ALLTRIM(cursor_4c_BuscaDopps.DopPs)
1787:                         ENDIF
1788:                     ENDIF
1789:                 ENDIF
1790:                 IF USED("cursor_4c_BuscaDopps")
1791:                     USE IN cursor_4c_BuscaDopps
1792:                 ENDIF
1793:                 *-- Atualiza visibilidade do container de operacoes
1794:                 loc_oPg.cnt_4c_Ope.Visible = EMPTY(ALLTRIM(loc_oPg.txt_4c_GetDopes.Value))
1795:                 loc_oPg.cnt_4c_Ope.Refresh()
1796:                 loc_oForm.Release()
1797:             ENDIF
1798:         CATCH TO loc_oErro
1799:             MsgErro(loc_oErro.Message, "AbrirBuscaDopps")

*-- Linhas 1814 a 1842:
1814:             IF VARTYPE(loc_oForm) = "O"
1815:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1816:                     IF USED("cursor_4c_BuscaTpGOp")
1817:                         SELECT cursor_4c_BuscaTpGOp
1818:                         IF !EOF()
1819:                             loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_BuscaTpGOp.Codigos)
1820:                         ENDIF
1821:                     ENDIF
1822:                 ELSE
1823:                     loc_oForm.mAddColuna("Codigos", "XXXXXXXXXX", "Codigo")
1824:                     loc_oForm.mAddColuna("Descs",   " ",          "Descricao")
1825:                     loc_oForm.Show()
1826:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTpGOp")
1827:                         SELECT cursor_4c_BuscaTpGOp
1828:                         IF !EOF()
1829:                             loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_BuscaTpGOp.Codigos)
1830:                         ENDIF
1831:                     ENDIF
1832:                 ENDIF
1833:                 IF USED("cursor_4c_BuscaTpGOp")
1834:                     USE IN cursor_4c_BuscaTpGOp
1835:                 ENDIF
1836:                 loc_oForm.Release()
1837:             ENDIF
1838:         CATCH TO loc_oErro
1839:             MsgErro(loc_oErro.Message, "AbrirBuscaTpGOp")
1840:         ENDTRY
1841:     ENDPROC
1842: 

*-- Linhas 1893 a 1911:
1893:                 RETURN
1894:             ENDIF
1895:             IF USED("CrTmpTpGop")
1896:                 SELECT CrTmpTpGop
1897:                 SET ORDER TO Codigos
1898:                 IF !SEEK(loc_cVal)
1899:                     THIS.AbrirBuscaTpGOp()
1900:                 ENDIF
1901:             ENDIF
1902:         ENDIF
1903:     ENDPROC
1904: 
1905:     PROCEDURE TeclaGetDopes(par_nKeyCode, par_nShiftAltCtrl)
1906:         LOCAL loc_oPg, loc_cVal
1907:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1908:         IF par_nKeyCode = 115
1909:             THIS.AbrirBuscaDopps()
1910:             RETURN
1911:         ENDIF

*-- Linhas 1917 a 1935:
1917:                 RETURN
1918:             ENDIF
1919:             IF USED("CsSigCdOpd")
1920:                 SELECT CsSigCdOpd
1921:                 SET ORDER TO Dopps
1922:                 IF SEEK(UPPER(PADR(loc_cVal, 20)))
1923:                     loc_oPg.cnt_4c_Ope.Visible = .F.
1924:                 ELSE
1925:                     MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o inv" + ;
1926:                         CHR(225) + "lida ou sem acesso!", "Aviso")
1927:                     loc_oPg.txt_4c_GetDopes.Value = ""
1928:                     loc_oPg.cnt_4c_Ope.Visible = .T.
1929:                 ENDIF
1930:                 loc_oPg.cnt_4c_Ope.Refresh()
1931:             ENDIF
1932:         ENDIF
1933:     ENDPROC
1934: 
1935:     PROCEDURE TeclaGetGrupo(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1947 a 1965:
1947:                 RETURN
1948:             ENDIF
1949:             IF USED("CrSigCdGcr")
1950:                 SELECT CrSigCdGcr
1951:                 SET ORDER TO BalCodigo
1952:                 IF SEEK(loc_cVal)
1953:                     loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(CrSigCdGcr.Codigos)
1954:                     loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(CrSigCdGcr.Descrs)
1955:                 ELSE
1956:                     THIS.AbrirBuscaGrupo()
1957:                 ENDIF
1958:             ELSE
1959:                 THIS.AbrirBuscaGrupo()
1960:             ENDIF
1961:             THIS.AtualizarEstadoConta()
1962:         ENDIF
1963:     ENDPROC
1964: 
1965:     PROCEDURE TeclaGetDGrupo(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1977 a 1995:
1977:                 RETURN
1978:             ENDIF
1979:             IF USED("CrSigCdGcr")
1980:                 SELECT CrSigCdGcr
1981:                 SET ORDER TO BalDescrs
1982:                 IF SEEK(loc_cVal)
1983:                     loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(CrSigCdGcr.Codigos)
1984:                     loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(CrSigCdGcr.Descrs)
1985:                 ELSE
1986:                     THIS.AbrirBuscaDGrupo()
1987:                 ENDIF
1988:             ELSE
1989:                 THIS.AbrirBuscaDGrupo()
1990:             ENDIF
1991:             THIS.AtualizarEstadoConta()
1992:         ENDIF
1993:     ENDPROC
1994: 
1995:     PROCEDURE TeclaGetConta(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2007 a 2025:
2007:                 RETURN
2008:             ENDIF
2009:             IF USED("CrSigCdCli")
2010:                 SELECT CrSigCdCli
2011:                 SET ORDER TO BalCodigo
2012:                 IF SEEK(loc_cVal)
2013:                     loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(CrSigCdCli.IClis)
2014:                     loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(CrSigCdCli.RClis)
2015:                 ELSE
2016:                     THIS.AbrirBuscaConta()
2017:                 ENDIF
2018:             ELSE
2019:                 THIS.AbrirBuscaConta()
2020:             ENDIF
2021:             THIS.AtualizarEstadoConta()
2022:         ENDIF
2023:     ENDPROC
2024: 
2025:     PROCEDURE TeclaGetDConta(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2037 a 2055:
2037:                 RETURN
2038:             ENDIF
2039:             IF USED("CrSigCdCli")
2040:                 SELECT CrSigCdCli
2041:                 SET ORDER TO BalNome
2042:                 IF SEEK(loc_cVal)
2043:                     loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(CrSigCdCli.IClis)
2044:                     loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(CrSigCdCli.RClis)
2045:                 ELSE
2046:                     THIS.AbrirBuscaDConta()
2047:                 ENDIF
2048:             ELSE
2049:                 THIS.AbrirBuscaDConta()
2050:             ENDIF
2051:             THIS.AtualizarEstadoConta()
2052:         ENDIF
2053:     ENDPROC
2054: 
2055:     PROCEDURE TeclaGetGgrp(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2085 a 2110:
2085:                 loc_oPg.txt_4c_GetDGru.Enabled = .T.
2086:                 RETURN
2087:             ENDIF
2088:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2089:                 EscaparSQL(loc_cVal)
2090:             IF USED("cursor_4c_ValCGru")
2091:                 USE IN cursor_4c_ValCGru
2092:             ENDIF
2093:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCGru")
2094:             IF loc_nResult > 0 AND !EOF("cursor_4c_ValCGru")
2095:                 SELECT cursor_4c_ValCGru
2096:                 loc_oPg.txt_4c_GetCGru.Value   = ALLTRIM(cursor_4c_ValCGru.CGrus)
2097:                 loc_oPg.txt_4c_GetDGru.Value   = ALLTRIM(cursor_4c_ValCGru.DGrus)
2098:                 loc_oPg.txt_4c_GetDGru.Enabled = .F.
2099:             ELSE
2100:                 THIS.AbrirBuscaCGru()
2101:             ENDIF
2102:             IF USED("cursor_4c_ValCGru")
2103:                 USE IN cursor_4c_ValCGru
2104:             ENDIF
2105:         ENDIF
2106:     ENDPROC
2107: 
2108:     PROCEDURE TeclaGetDGru(par_nKeyCode, par_nShiftAltCtrl)
2109:         LOCAL loc_oPg, loc_cVal
2110:         loc_oPg = THIS.pgf_4c_Paginas.Page1

*-- Linhas 2136 a 2154:
2136:                 RETURN
2137:             ENDIF
2138:             IF USED("CrSigOpOpt")
2139:                 SELECT CrSigOpOpt
2140:                 SET ORDER TO Cods
2141:                 IF !SEEK(loc_cVal)
2142:                     THIS.AbrirBuscaTpOps()
2143:                 ENDIF
2144:             ELSE
2145:                 THIS.AbrirBuscaTpOps()
2146:             ENDIF
2147:         ENDIF
2148:     ENDPROC
2149: 
2150:     PROCEDURE TeclaGetCodCli(par_nKeyCode, par_nShiftAltCtrl)
2151:         LOCAL loc_oPg, loc_cVal
2152:         loc_oPg = THIS.pgf_4c_Paginas.Page1
2153:         IF par_nKeyCode = 115
2154:             THIS.AbrirBuscaCodCli()

*-- Linhas 2162 a 2180:
2162:                 RETURN
2163:             ENDIF
2164:             IF USED("CrSigCdCli")
2165:                 SELECT CrSigCdCli
2166:                 SET ORDER TO BalCodigo
2167:                 IF SEEK(loc_cVal)
2168:                     loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(CrSigCdCli.IClis)
2169:                     loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(CrSigCdCli.RClis)
2170:                 ELSE
2171:                     THIS.AbrirBuscaCodCli()
2172:                 ENDIF
2173:             ELSE
2174:                 THIS.AbrirBuscaCodCli()
2175:             ENDIF
2176:             THIS.AtualizarEstadoCodCli()
2177:         ENDIF
2178:     ENDPROC
2179: 
2180:     PROCEDURE TeclaGetDescCli(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2192 a 2210:
2192:                 RETURN
2193:             ENDIF
2194:             IF USED("CrSigCdCli")
2195:                 SELECT CrSigCdCli
2196:                 SET ORDER TO BalNome
2197:                 IF SEEK(loc_cVal)
2198:                     loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(CrSigCdCli.IClis)
2199:                     loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(CrSigCdCli.RClis)
2200:                 ELSE
2201:                     THIS.AbrirBuscaDescCli()
2202:                 ENDIF
2203:             ELSE
2204:                 THIS.AbrirBuscaDescCli()
2205:             ENDIF
2206:             THIS.AtualizarEstadoCodCli()
2207:         ENDIF
2208:     ENDPROC
2209: 
2210:     *==========================================================================

*-- Linhas 2349 a 2376:
2349: 
2350:     PROCEDURE BtnSelecionarTudoClick()
2351:         IF USED("CsSigCdOpd")
2352:             SELECT CsSigCdOpd
2353:             REPLACE ALL Marca WITH 1
2354:             GO TOP
2355:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Ope.grd_4c_Dados.Refresh()
2356:         ENDIF
2357:     ENDPROC
2358: 
2359:     PROCEDURE BtnLimparSelecaoClick()
2360:         IF USED("CsSigCdOpd")
2361:             SELECT CsSigCdOpd
2362:             REPLACE ALL Marca WITH 0
2363:             GO TOP
2364:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Ope.grd_4c_Dados.Refresh()
2365:         ENDIF
2366:     ENDPROC
2367: 
2368:     *==========================================================================
2369:     * HANDLERS DOS BOTOES DE RELATORIO
2370:     *==========================================================================
2371: 
2372:     PROCEDURE BtnVisualizarClick()
2373:         IF !THIS.ValidarFiltros()
2374:             RETURN
2375:         ENDIF
2376:         THIS.FormParaRelatorio()


### BO (C:\4c\projeto\app\classes\SigReDpDBO.prg):
*==============================================================================
* SIGREDPDBO.PRG
* BO para relatorio de analise de producao por dopps (SigReDpD)
*
* Herda de RelatorioBase
* Carrega cursores de referencia para lookups e processamento do relatorio
*==============================================================================

DEFINE CLASS SigReDpDBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro movimentacao / DopPs
    this_cDopp            = ""
    this_nNumes           = 0

    *-- Filtro grupo balancete (SigCdGcr.Codigos / Descrs)
    this_cGrupoGcr        = ""
    this_cDGrupoGcr       = ""

    *-- Filtro conta balancete (SigCdCli.IClis / RClis)
    this_cCodConta        = ""
    this_cNomeConta       = ""

    *-- Filtro cliente producao (SigCdCli.IClis / RClis) - get_codcli/get_desccli
    this_cCodCli          = ""
    this_cDescCli         = ""

    *-- Filtro grupo materia prima (SigCdGrp.CGrus / DGrus)
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro grande grupo (SigCdGpr.Codigos / Descs)
    this_cGgrp            = ""
    this_cDGgrp           = ""

    *-- Filtro tipo operacao (SigOpOpt.Cods)
    this_cTpOps           = ""

    *-- Filtro envelope e numero de OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro tipo geracao OP (SigInTgo.Codigos) - auto-preenchido se apenas 1 opcao
    this_cTpGOp           = ""

    *-- Flags de impressao (correspondem aos checkboxes do form)
    this_lImprimeTpMat    = .F.
    this_lAnalisarDestino = .F.
    this_lImprimeDopes    = .F.
    this_lDetalhar        = .F.
    this_lImprimeValor    = .F.
    this_lImprimeProdutos = .F.
    this_lImprimeFuncs    = .F.
    this_lRelatorio       = .F.
    this_lImprimeQtdPes   = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de referencia para lookups e processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Grupos de balancete (lookup Get_grupo / get_dgrupo)
                IF USED("CrSigCdGcr")
                    USE IN CrSigCdGcr
                ENDIF
                loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGcr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de balancete"
                    EXIT
                ENDIF
                SELECT CrSigCdGcr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                *-- Tipos de operacao (lookup Get_TpOps)
                IF USED("CrSigOpOpt")
                    USE IN CrSigOpOpt
                ENDIF
                loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt " + ;
                           "WHERE Situas < 2 AND (Emps = ' ' OR Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpOpt")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                        CHR(231) + CHR(227) + "o"
                    EXIT
                ENDIF
                SELECT CrSigOpOpt
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs

                *-- Clientes de balancete (lookup Get_conta / Get_dconta / get_codcli)
                IF USED("CrSigCdCli")
                    USE IN CrSigCdCli
                ENDIF
                loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCli")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes"
                    EXIT
                ENDIF
                SELECT CrSigCdCli
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome

                *-- Parametros SigCdPam (GrTrans filtra grupo transito no processamento)
                IF USED("CrSigCdPam")
                    USE IN CrSigCdPam
                ENDIF
                loc_cSQL = "SELECT GrTrans FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPam")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                    EXIT
                ENDIF
                SELECT CrSigCdPam
                GO TOP

                *-- Tipos de geracao OP com filtro de acesso do usuario (SigInTgo)
                IF USED("cursor_4c_TmpTpGop")
                    USE IN cursor_4c_TmpTpGop
                ENDIF
                loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGop")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de gera" + ;
                        CHR(231) + CHR(227) + "o OP"
                    EXIT
                ENDIF
                THIS.FiltrarAcessosTpGop()

                *-- Operacoes de producao com filtro de acesso (SigCdOpd)
                *-- INDEX criado ANTES do filtro (replicando ordem do legado)
                IF USED("CsSigCdOpd")
                    USE IN CsSigCdOpd
                ENDIF
                loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCdOpd")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF
                SELECT CsSigCdOpd
                INDEX ON Dopps TAG Dopps
                THIS.FiltrarAcessosOperacoes()
                SELECT CsSigCdOpd
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Init")
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosTpGop - Filtra tipos de geracao OP por acesso do usuario
    * Replica: fChecaAcesso('SIGPRGLOT', Codigos) do legado
    * Se apenas 1 tipo com acesso, pre-preenche this_cTpGOp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosTpGop()
        LOCAL loc_oErro

        TRY
            SELECT cursor_4c_TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(cursor_4c_TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN cursor_4c_TmpTpGop
                ENDIF
            ENDSCAN

            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM cursor_4c_TmpTpGop WHERE Acesso = 1 ;
                INTO CURSOR CrTmpTpGop READWRITE
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            IF RECCOUNT("CrTmpTpGop") = 1
                SELECT CrTmpTpGop
                GO TOP
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            IF USED("cursor_4c_TmpTpGop")
                USE IN cursor_4c_TmpTpGop
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosTpGop")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosOperacoes - Remove operacoes sem acesso do usuario
    * Replica: fChecaAcesso('P'+padl(ndopps,8,'0')) do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosOperacoes()
        LOCAL loc_oErro

        TRY
            SELECT CsSigCdOpd
            SCAN
                IF !fChecaAcesso("P" + PADL(CsSigCdOpd.ndopps, 8, "0"))
                    DELETE
                ENDIF
            ENDSCAN
            SELECT CsSigCdOpd
            GO TOP

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CrSigOpOpt")
            USE IN CrSigOpOpt
        ENDIF
        IF USED("CrSigCdCli")
            USE IN CrSigCdCli
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrTmpTpGop")
            USE IN CrTmpTpGop
        ENDIF
        IF USED("CsSigCdOpd")
            USE IN CsSigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpTpGop")
            USE IN cursor_4c_TmpTpGop
        ENDIF
        THIS.LimparCursoresTemp()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao dos filtros para auditoria
    *
    * Relatorio nao possui chave primaria de registro. Esta funcao monta
    * uma "chave" concatenando os principais filtros aplicados, usada
    * pelo log de auditoria para identificar qual configuracao foi executada.
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = "DT=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cGrupoGcr)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "GRP=" + ALLTRIM(THIS.this_cGrupoGcr)
        ENDIF
        IF !EMPTY(THIS.this_cCodConta)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "CTA=" + ALLTRIM(THIS.this_cCodConta)
        ENDIF
        IF !EMPTY(THIS.this_cDopp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "DOPP=" + ALLTRIM(THIS.this_cDopp)
        ENDIF
        IF !EMPTY(THIS.this_cTpGOp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "TGOP=" + ALLTRIM(THIS.this_cTpGOp)
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente persistida
    * (ex: historico de execucoes). Mapeia colunas do cursor para as
    * propriedades this_* deste BO, validando tipos antes de atribuir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("DtInicial") = "D"
                    THIS.this_dDtInicial = NVL(EVALUATE("DtInicial"), {})
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                IF TYPE("Dopp") = "C"
                    THIS.this_cDopp = ALLTRIM(NVL(EVALUATE("Dopp"), ""))
                ENDIF
                IF TYPE("Numes") = "N"
                    THIS.this_nNumes = NVL(EVALUATE("Numes"), 0)
                ENDIF
                IF TYPE("GrupoGcr") = "C"
                    THIS.this_cGrupoGcr = ALLTRIM(NVL(EVALUATE("GrupoGcr"), ""))
                ENDIF
                IF TYPE("CodConta") = "C"
                    THIS.this_cCodConta = ALLTRIM(NVL(EVALUATE("CodConta"), ""))
                ENDIF
                IF TYPE("CodCli") = "C"
                    THIS.this_cCodCli = ALLTRIM(NVL(EVALUATE("CodCli"), ""))
                ENDIF
                IF TYPE("CGru") = "C"
                    THIS.this_cCGru = ALLTRIM(NVL(EVALUATE("CGru"), ""))
                ENDIF
                IF TYPE("Ggrp") = "C"
                    THIS.this_cGgrp = ALLTRIM(NVL(EVALUATE("Ggrp"), ""))
                ENDIF
                IF TYPE("TpOps") = "C"
                    THIS.this_cTpOps = ALLTRIM(NVL(EVALUATE("TpOps"), ""))
                ENDIF
                IF TYPE("Envelope") = "N"
                    THIS.this_nEnvelope = NVL(EVALUATE("Envelope"), 0)
                ENDIF
                IF TYPE("Nop") = "N"
                    THIS.this_nNop = NVL(EVALUATE("Nop"), 0)
                ENDIF
                IF TYPE("TpGOp") = "C"
                    THIS.this_cTpGOp = ALLTRIM(NVL(EVALUATE("TpGOp"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio para rastreabilidade
    * de quem executou o relatorio de Analise de Producao por DopPs e com
    * quais filtros (datas, grupos, contas, dopp, tipo geracao OP).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL("SigReDpD") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio An" + CHR(225) + ;
                                  "lise Produ" + CHR(231) + CHR(227) + "o por DopPs") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX conforme opcoes selecionadas
    * Replica logica de selecao dos 8 relatorios (SigReDp1 a SigReDp8)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cFRX
        IF THIS.this_lDetalhar
            IF THIS.this_lImprimeValor
                IF THIS.this_lRelatorio
                    loc_cFRX = "SigReDp7"
                ELSE
                    loc_cFRX = "SigReDp6"
                ENDIF
            ELSE
                IF THIS.this_lImprimeProdutos
                    loc_cFRX = "SigReDp5"
                ELSE
                    loc_cFRX = "SigReDp1"
                ENDIF
            ENDIF
        ELSE
            IF THIS.this_lImprimeDopes
                loc_cFRX = "SigReDp2"
            ELSE
                IF THIS.this_lImprimeValor
                    loc_cFRX = "SigReDp4"
                ELSE
                    IF THIS.this_lImprimeQtdPes
                        loc_cFRX = "SigReDp8"
                    ELSE
                        loc_cFRX = "SigReDp3"
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursoresTemp - Fecha cursores temporarios criados em PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresTemp()
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        IF USED("CrSigCdNec")
            USE IN CrSigCdNec
        ENDIF
        IF USED("csLocalMc")
            USE IN csLocalMc
        ENDIF
        IF USED("crEnvelope")
            USE IN crEnvelope
        ENDIF
        IF USED("LocalCli")
            USE IN LocalCli
        ENDIF
        IF USED("LocalPro")
            USE IN LocalPro
        ENDIF
        IF USED("CrTmpCli")
            USE IN CrTmpCli
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentacoes e monta TmpRelat para relatorio
    * Replica: PROCEDURE processamento do legado (SIGREDPD)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp
        LOCAL loc_dDatai, loc_dDataf, loc_cDataFimSQL
        LOCAL loc_cDopp, loc_nNumes
        LOCAL loc_lImprimeTpMat, loc_lDestino
        LOCAL loc_cTpOpt, loc_lDope, loc_lDopeDt
        LOCAL loc_nEnvelope, loc_nOp, loc_nOpI, loc_nOpF
        LOCAL loc_cCodCli, loc_cTGOp
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv
        LOCAL loc_cPro, loc_cDpr
        LOCAL loc_lAbortarScan

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                THIS.this_cMensagemErro = ""
                THIS.LimparCursoresTemp()

                *-- Capturar valores dos filtros das propriedades
                loc_cGrupo        = ALLTRIM(THIS.this_cGrupoGcr)
                loc_cConta        = ALLTRIM(THIS.this_cCodConta)
                loc_cGruMat       = ALLTRIM(THIS.this_cCGru)
                loc_cGgrp         = ALLTRIM(THIS.this_cGgrp)
                loc_dDatai        = THIS.this_dDtInicial
                loc_dDataf        = THIS.this_dDtFinal
                loc_cDopp         = ALLTRIM(THIS.this_cDopp)
                loc_nNumes        = THIS.this_nNumes
                loc_lImprimeTpMat = THIS.this_lImprimeTpMat
                loc_lDestino      = THIS.this_lAnalisarDestino
                loc_cTpOpt        = ALLTRIM(THIS.this_cTpOps)
                loc_lDope         = THIS.this_lImprimeDopes
                loc_lDopeDt       = THIS.this_lDetalhar
                loc_nEnvelope     = THIS.this_nEnvelope
                loc_nOp           = THIS.this_nNop
                loc_nOpI          = (loc_nOp * 10000) + 1
                loc_nOpF          = (loc_nOp * 10000) + 9999
                loc_cCodCli       = ALLTRIM(THIS.this_cCodCli)
                loc_cTGOp         = ALLTRIM(THIS.this_cTpGOp)

                *-- Data final com 23:59:59 para cobrir todo o dia (replica fDtoSQL do legado)
                loc_cDataFimSQL = "'" + ;
                    PADL(YEAR(loc_dDataf),  4, "0") + "-" + ;
                    PADL(MONTH(loc_dDataf), 2, "0") + "-" + ;
                    PADL(DAY(loc_dDataf),   2, "0") + " 23:59:59'"

                *-- Criar cursor de resultado do processamento
                CREATE CURSOR TmpRelat (;
                    Fase c(10), IClis c(10), RClis c(50), CMats c(14), ;
                    DPros c(40), CPros c(14), DDPros c(40), Qtde n(12,3), ;
                    TpOps c(15), CUnis c(3), Operacaos c(31), Nenvs n(10), ;
                    Datas D, Pesos n(12,3), Valor n(12,2), Fators n(12,3), ;
                    Peso2s n(12,3), CUniPs c(3))
                INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats ;
                    TAG Operacao
                INDEX ON Fase + IClis + TpOps + CUnis + CUniPs + CMats + ;
                    Operacaos + STR(Nenvs,10) TAG FFuncMat

                *-- SQL principal: SigCdNec (cabecalho) x SigCdNei (itens)
                loc_cSQL = ;
                    "SELECT a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs," + ;
                    "a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                    "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.peso2s,b.Fators," + ;
                    "b.Servicos,b.Cats,b.Empdnps " + ;
                    "FROM SigCdNec a, SigCdNei b " + ;
                    "WHERE a.Datas BETWEEN " + FormatarDataSQL(loc_dDatai) + ;
                    " AND " + loc_cDataFimSQL + " AND "

                IF !EMPTY(loc_cGrupo)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.GrupoOs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cConta)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.ContaDs = " + EscaparSQL(loc_cConta) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.ContaOs = " + EscaparSQL(loc_cConta) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cDopp)
                    loc_cSQL = loc_cSQL + "a.Dopps = " + EscaparSQL(loc_cDopp) + " AND "
                ENDIF

                IF loc_nNumes > 0
                    loc_cSQL = loc_cSQL + "a.NumPs = " + FormatarNumeroSQL(loc_nNumes) + " AND "
                ENDIF

                loc_cSQL = loc_cSQL + "a.EmpDNPs = b.EmpDNPs ORDER BY a.cIdChaves"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = ;
                        "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF

                *-- Filtrar operacoes marcadas no grid + tipo geracao OP
                SELECT * FROM CsSigCdOpd ;
                    WHERE Marca > 0 ;
                    AND IIF(!EMPTY(loc_cTGOp), CodTgOps = loc_cTGOp, .T.) ;
                    INTO CURSOR csLocalMc READWRITE
                GO TOP IN csLocalMc

                *-- Cruzar movimentacoes com operacoes selecionadas
                IF EMPTY(loc_cDopp) AND !EOF("csLocalMc")
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs AND b.Marca > 0 ;
                        INTO CURSOR CrSigCdNec READWRITE
                ELSE
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs ;
                        AND IIF(!EMPTY(loc_cTGOp), b.CodTgOps = loc_cTGOp, .T.) ;
                        INTO CURSOR CrSigCdNec READWRITE
                ENDIF

                *-- Filtro por envelope especifico
                IF loc_nEnvelope > 0
                    SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                        WHERE Nenvs = loc_nEnvelope ;
                        INTO CURSOR crEnvelope READWRITE
                ENDIF

                SELECT CrSigCdNec
                INDEX ON DTOS(Datas) + CIdChaves TAG Datas
                SET ORDER TO Datas
                GO TOP IN CrSigCdNec

                *-- Processar cada registro de movimentacao
                loc_lAbortarScan = .F.
                IF RECCOUNT("CrSigCdNec") > 0
                    SELECT CrSigCdNec
                    SCAN
                        *-- Filtro tipo material/operacao
                        IF !EMPTY(loc_cTpOpt) AND ;
                                ALLTRIM(CrSigCdNec.TpOps) <> ALLTRIM(loc_cTpOpt)
                            LOOP
                        ENDIF

                        *-- Filtro por envelope
                        IF loc_nEnvelope > 0
                            SELECT crEnvelope
                            LOCATE FOR ALLTRIM(Empdnps) = ALLTRIM(CrSigCdNec.Empdnps)
                            IF EOF("crEnvelope")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Filtro por numero de OP
                        IF loc_nOp > 0 AND ;
                                !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF

                        *-- Filtro por cliente especifico
                        IF !EMPTY(loc_cCodCli)
                            LOCAL loc_cQLCli
                            IF !EMPTY(CrSigCdNec.Nops) AND CrSigCdNec.Nops <> 0
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM sigoppic a " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE a.Nops = " + ;
                                    FormatarNumeroSQL(CrSigCdNec.Nops) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ELSE
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM SigPdMvf f " + ;
                                    "INNER JOIN sigoppic a ON f.Nops = a.Nops " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE f.EmpDnPs = " + ;
                                    EscaparSQL(ALLTRIM(CrSigCdNec.EmpDnPs)) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ENDIF
                            IF USED("LocalCli")
                                USE IN LocalCli
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLCli, "LocalCli") < 1
                                THIS.this_cMensagemErro = "Erro ao verificar cliente"
                                loc_lAbortarScan = .T.
                                EXIT
                            ENDIF
                            IF EOF("LocalCli")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Ignorar servicos sem OP vinculada
                        IF CrSigCdNec.Servicos AND ;
                                !EMPTY(CrSigCdNec.Nenvs) AND ;
                                EMPTY(ALLTRIM(CrSigCdNec.Cats))
                            LOOP
                        ENDIF

                        *-- Buscar descricao e grupo do material
                        LOCAL loc_cQLPro
                        loc_cQLPro = ;
                            "SELECT a.CPros,a.DPros,a.CGrus,a.CUnis,a.CUniPs,b.Mercs " + ;
                            "FROM SigCdPro a, SigCdGrp b " + ;
                            "WHERE a.CPros = " + ;
                            EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                            " AND a.Cgrus = b.Cgrus"
                        IF USED("CrSigCdPro")
                            USE IN CrSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cQLPro, "CrSigCdPro") < 1
                            THIS.this_cMensagemErro = "Erro ao buscar produto"
                            loc_lAbortarScan = .T.
                            EXIT
                        ENDIF
                        SELECT CrSigCdPro

                        *-- Filtro grupo materia prima
                        IF !EMPTY(loc_cGruMat) AND ;
                                ALLTRIM(CrSigCdPro.CGrus) <> ALLTRIM(loc_cGruMat)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Filtro grande grupo
                        IF !EMPTY(loc_cGgrp) AND ;
                                ALLTRIM(CrSigCdPro.Mercs) <> ALLTRIM(loc_cGgrp)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Montar variaveis de agrupamento
                        loc_cTpOps = IIF(loc_lImprimeTpMat, ;
                            CrSigCdNec.TpOps, SPACE(15))
                        loc_cGrp = IIF(loc_lDestino, ;
                            CrSigCdNec.GrupoDs, CrSigCdNec.GrupoOs)
                        loc_cCta = IIF(loc_lDestino, ;
                            CrSigCdNec.Contads, CrSigCdNec.ContaOs)
                        loc_cPed = PADR(IIF(loc_lDope, ;
                            ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                            ALLTRIM(STR(CrSigCdNec.Numps,10)), " "), 31)
                        loc_nEnv = IIF(loc_lDope, CrSigCdNec.Nenvs, 0)

                        *-- Filtrar grupo de transito (configurado em SigCdPam)
                        IF USED("CrSigCdPam") AND ;
                                ALLTRIM(loc_cGrp) = ALLTRIM(CrSigCdPam.GrTrans)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Buscar produto da OP (apenas quando necessario)
                        loc_cPro = ""
                        loc_cDpr = ""
                        IF !EMPTY(CrSigCdNec.Nops) AND ;
                                CrSigCdNec.Nops <> 0 AND ;
                                THIS.this_lImprimeProdutos
                            LOCAL loc_cQLOpPro
                            loc_cQLOpPro = ;
                                "SELECT TOP 1 a.Cpros, b.DPros " + ;
                                "FROM SigOpPic a " + ;
                                "INNER JOIN SigCdPro b ON a.Cpros = b.Cpros " + ;
                                "WHERE Nops = " + ;
                                FormatarNumeroSQL(CrSigCdNec.Nops)
                            IF USED("LocalPro")
                                USE IN LocalPro
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLOpPro, "LocalPro") > 0
                                GO TOP IN LocalPro
                                IF !EOF("LocalPro")
                                    loc_cDpr = ALLTRIM(LocalPro.DPros)
                                    loc_cPro = ALLTRIM(LocalPro.Cpros)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Inserir/acumular em TmpRelat
                        SELECT TmpRelat
                        IF loc_lDopeDt
                            *-- Modo detalhado: agrupa por DopPs + data
                            LOCAL loc_cPedDt, loc_nEnvDt
                            loc_cPedDt = ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                                ALLTRIM(STR(CrSigCdNec.Numps,10))
                            loc_nEnvDt = CrSigCdNec.Nops
                            SET ORDER TO Operacao
                            IF !SEEK(DTOS(CrSigCdNec.Datas) + ;
                                    PADR(loc_cPedDt,31) + ;
                                    STR(loc_nEnvDt,10) + ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14))
                                INSERT INTO TmpRelat ;
                                    (Datas, Operacaos, Nenvs, CMats, Dpros, ;
                                    Cunis, CPros, DDPros, Fators) ;
                                    VALUES (CrSigCdNec.Datas, loc_cPedDt, ;
                                    loc_nEnvDt, ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPro, loc_cDpr, CrSigCdNec.Fators)
                            ENDIF
                            REPLACE Qtde  WITH Qtde  + CrSigCdNec.Qtds, ;
                                    Pesos WITH Pesos + CrSigCdNec.Pesos
                            REPLACE Valor WITH Valor + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ELSE
                            *-- Modo resumido: agrupa por grupo/conta/material
                            SET ORDER TO FFuncMat
                            IF !SEEK(loc_cGrp + loc_cCta + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats + loc_cPed + ;
                                    STR(loc_nEnv,10))
                                *-- Buscar nome da conta para exibicao
                                LOCAL loc_cRClis, loc_cQLCli2
                                loc_cRClis = ""
                                loc_cQLCli2 = ;
                                    "SELECT IClis, RClis FROM SigCdCli " + ;
                                    "WHERE IClis = " + ;
                                    EscaparSQL(ALLTRIM(loc_cCta))
                                IF USED("CrTmpCli")
                                    USE IN CrTmpCli
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQLCli2, "CrTmpCli") > 0
                                    SELECT CrTmpCli
                                    IF !EOF("CrTmpCli")
                                        loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                                    ENDIF
                                ENDIF
                                SELECT TmpRelat
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, Dpros, CPros, ;
                                    DDPros, TpOps, Cunis, Operacaos, Nenvs, ;
                                    Datas, Fators, CuniPs) ;
                                    VALUES (loc_cGrp, loc_cCta, loc_cRClis, ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    loc_cPro, loc_cDpr, loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPed, loc_nEnv, CrSigCdNec.Datas, ;
                                    CrSigCdNec.Fators, ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)

                            *-- Linha de total geral por material
                            SET ORDER TO FFuncMat
                            IF !SEEK(REPLICATE(CHR(255),20) + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats)
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, TpOps, ;
                                    Cunis, CuniPs) ;
                                    VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ENDIF

                        SELECT CrSigCdNec
                    ENDSCAN
                ENDIF

                IF loc_lAbortarScan
                    EXIT
                ENDIF

                *-- Montar cabecalho do relatorio
                loc_cCab = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
                loc_cSub = IIF(THIS.this_lRelatorio, "", ;
                    IIF(loc_lDestino, "Por Destino", "Por Origem") + " - ") + ;
                    "Per" + CHR(237) + "odo : " + ;
                    ALLTRIM(DTOC(loc_dDatai)) + ;
                    " at" + CHR(233) + " " + ALLTRIM(DTOC(loc_dDataf))

                IF USED("CrSigCdEmp")
                    USE IN CrSigCdEmp
                ENDIF
                LOCAL loc_cQLEmp
                loc_cQLEmp = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                    "WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                SQLEXEC(gnConnHandle, loc_cQLEmp, "CrSigCdEmp")
                loc_cEmp = go_4c_Sistema.cCodEmpresa + " - "
                IF USED("CrSigCdEmp") AND !EOF("CrSigCdEmp")
                    loc_cEmp = loc_cEmp + ALLTRIM(CrSigCdEmp.Razas)
                ENDIF

                IF THIS.this_lImprimeFuncs AND !EMPTY(loc_cConta)
                    LOCAL loc_cQLFuncs
                    loc_cQLFuncs = ;
                        "SELECT a.RClis, a.Cpfs FROM SigCdCli a " + ;
                        "WHERE a.IClis = " + EscaparSQL(PADR(loc_cConta,10))
                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cQLFuncs, "LocalCli") < 1
                        THIS.this_cMensagemErro = ;
                            "Erro ao buscar funcion" + CHR(225) + "rio"
                        EXIT
                    ENDIF
                    SELECT LocalCli
                    GO TOP IN LocalCli
                    IF !EOF("LocalCli")
                        loc_cSub = loc_cSub + CHR(13) + CHR(13) + ;
                            "NOME: " + ALLTRIM(LocalCli.RClis) + ;
                            " / CPF: " + ALLTRIM(LocalCli.Cpfs)
                    ENDIF
                ENDIF

                CREATE CURSOR dbCabecalho ;
                    (Titulo c(100), SubTitulo c(200), NomeEmpresa c(100), ImpFuncs L)
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa, ImpFuncs) ;
                    VALUES (loc_cCab, loc_cSub, loc_cEmp, THIS.this_lImprimeFuncs)

                SELECT TmpRelat
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em tela (preview)
    * Replica: PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    * par_lComDialogo: .T. = abre dialogo de impressora, .F. = imprime direto
    * Replica: PROCEDURE impressao (prompt) e documento (direto) do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComDialogo)
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX, loc_lDialogo

        loc_lSucesso = .F.
        loc_lDialogo = IIF(PCOUNT() >= 1, par_lComDialogo, .F.)

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

