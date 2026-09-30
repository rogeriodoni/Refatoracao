# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRAZOENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GLOBALIZAS, ACESSO, CODTGOPS, RNOPS, OPERS, CITEM2, EMPDOPNUMS, QTBAIXAS, CPROS, NUMPS, DOPES, CITENS

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
		lcQuery = [Select b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, a.Reservas, a.Opers, 0 as  Acesso, b.chkObs, c.carcompos ] + ;
				    [From SigCdOpe a Left Join SigOpCdd b On b.dopes = a.dopes ] + ;
				    [Left Join SigOpCdc c On a.dopes = c.dopes ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOper2') < 1)
		Select TmpOper2
		Select * From TmpOper2 Into Cursor TmpOper ReadWrite
		Select TmpOper
		lcSql = [Select 0 as Acesso, * From SigInTgo ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpTpGop') < 1)
		Select TmpTpGop
		Select * From TmpTpGop Where Acesso = 1 Into Cursor CrTmpTpGop ReadWrite
		Select CrTmpTpGop
Select crSigCdPam
Select TmpOper
=Seek(_lcTpGOp,'CrTmpTpGOp')
Insert Into DbParam (CodTgOps, OpZers, EntPes ) Values ;
Select TmpOper
	lcQuery = [Select Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
	Select TempEest
		oProg.Update(.t.)
		Select TempEestI
			lcQuery = [Select * ] + ;
					    [From SigMvIts ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
			Select TempEsti2
				Select TempEesti
					Insert Into TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, Citens, Notas, Dpros, Reffs) ;
						lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempEestI.CPros]
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
						Select crSigPrMtz
						If Not Seek(TempEestI.Cpros, 'Produtos', 'CPros')
							Insert Into Produtos (Cpros, DPros) Values (TempEestI.Cpros, crSigCdPro.Dpros)
				Select TempEsti2
						Insert Into TmpItens (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, Linhas, ;
							lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TempEestI.CPros]
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
							Select crSigPrMtz
							If Not Seek(TempEestI.Cpros, 'Produtos', 'CPros')
								Insert Into Produtos (Cpros, DPros) Values (TempEestI.Cpros, crSigCdPro.Dpros)
			Insert Into TmpCabec (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, Datas, Entregas, ;
Select TmpOper
	Select * From TmpOper Where CodTgOps = lcCodigo Into Cursor xTmpOper ReadWrite
	Select * From TmpOper Into Cursor xTmpOper ReadWrite
Select xTmpOper
If Not Empty(This.Value) And Not Seek(This.Value, 'xTmpOper', 'Dopes')
	lcSql = [Select Numps From SigOpPic Where Numps = ]+Str(This.Value)
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpOpi') < 1)
If Not Empty(This.Value) And Not Seek(This.Value, 'crTmpTpGop', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1729 linhas total):

*-- Linhas 502 a 520:
502:     *--------------------------------------------------------------------------
503:     * ConfigurarCamposOperacao - preenche o cnt_4c_Operacao (ja criado vazio
504:     * em ConfigurarContainers): codigo da Operacao (Movimentacao) + faixa
505:     * de numero (de/ate). ControlSource fica em branco, igual ao legado -
506:     * o valor eh resolvido por codigo (Valid/lookup), adicionado na Fase 6.
507:     *--------------------------------------------------------------------------
508:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
509:         WITH THIS.cnt_4c_Operacao
510:             *-- Get_Operacao: codigo da operacao/movimentacao (Dopes char(20))
511:             .AddObject("txt_4c_Operacao", "TextBox")
512:             WITH .txt_4c_Operacao
513:                 .Top           = 1
514:                 .Left          = 3
515:                 .Width         = 151
516:                 .Height        = 23
517:                 .FontName      = "Courier New"
518:                 .MaxLength     = 20
519:                 .SpecialEffect = 1
520:                 .Value         = ""

*-- Linhas 628 a 646:
628:     * cnt_4c_Responsavel e cnt_4c_Empresa (ja criados vazios em
629:     * ConfigurarContainers), alem dos labels diretos do form Label6
630:     * ("Conta :"), Label7 ("Vendedor :") e lbl_empresa ("Empresa :").
631:     * ControlSource fica em branco, igual ao legado - o valor eh resolvido
632:     * por lookup (BINDEVENT em ConfigurarBindEvents).
633:     *--------------------------------------------------------------------------
634:     PROTECTED PROCEDURE ConfigurarCamposContas()
635:         LOCAL loc_cEmpPadrao, loc_nResultado
636: 
637:         *-- Label6: "Conta :" (Top=223, Left=95, Width=38)
638:         THIS.AddObject("lbl_4c_Label6", "Label")
639:         WITH THIS.lbl_4c_Label6
640:             .AutoSize  = .T.
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .BackStyle = 0
644:             .Caption   = "Conta :"
645:             .Left      = 95
646:             .Top       = 223

*-- Linhas 817 a 836:
817:                 IF USED("cursor_4c_ChkEmpPad")
818:                     USE IN cursor_4c_ChkEmpPad
819:                 ENDIF
820:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
821:                     "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpPadrao), ;
822:                     "cursor_4c_ChkEmpPad")
823:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpPad") AND RECCOUNT("cursor_4c_ChkEmpPad") > 0
824:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpPad.Razas)
825:                 ENDIF
826:                 IF USED("cursor_4c_ChkEmpPad")
827:                     USE IN cursor_4c_ChkEmpPad
828:                 ENDIF
829:             ENDIF
830:         ENDIF
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * ConfigurarCamposPrevisaoOp - preenche os containers cnt_4c_Previsao
835:     * (data de previsao de entrega + data de geracao) e cnt_4c_Op (numero
836:     * manual da O.P.), ja criados vazios em ConfigurarContainers. Os valores

*-- Linhas 1324 a 1343:
1324:                 IF USED("cursor_4c_ChkOper")
1325:                     USE IN cursor_4c_ChkOper
1326:                 ENDIF
1327:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1328:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor) + ;
1329:                     " AND Globalizas IN (1,2)", "cursor_4c_ChkOper")
1330:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkOper") AND RECCOUNT("cursor_4c_ChkOper") > 0
1331:                     IF USED("cursor_4c_ChkOper")
1332:                         USE IN cursor_4c_ChkOper
1333:                     ENDIF
1334:                     RETURN
1335:                 ENDIF
1336:                 IF USED("cursor_4c_ChkOper")
1337:                     USE IN cursor_4c_ChkOper
1338:                 ENDIF
1339:             ENDIF
1340: 
1341:             THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
1342:                 "Movimenta" + CHR(231) + CHR(227) + "o", loc_cValor, ;
1343:                 .txt_4c_Operacao, .NULL., "Globalizas IN (1,2)")

*-- Linhas 1364 a 1383:
1364:                 IF USED("cursor_4c_ChkTpGOp")
1365:                     USE IN cursor_4c_ChkTpGOp
1366:                 ENDIF
1367:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1368:                     "SELECT Codigos FROM SigInTgo WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1369:                     "cursor_4c_ChkTpGOp")
1370:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkTpGOp") AND RECCOUNT("cursor_4c_ChkTpGOp") > 0
1371:                     IF USED("cursor_4c_ChkTpGOp")
1372:                         USE IN cursor_4c_ChkTpGOp
1373:                     ENDIF
1374:                     RETURN
1375:                 ENDIF
1376:                 IF USED("cursor_4c_ChkTpGOp")
1377:                     USE IN cursor_4c_ChkTpGOp
1378:                 ENDIF
1379:             ENDIF
1380: 
1381:             THIS.AbrirLookupCanonico("SigInTgo", "Codigos", "Descs", ;
1382:                 "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP", loc_cValor, ;
1383:                 .txt_4c_TpGOp, .NULL.)

*-- Linhas 1411 a 1430:
1411:             IF USED("cursor_4c_ChkGrupo")
1412:                 USE IN cursor_4c_ChkGrupo
1413:             ENDIF
1414:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1415:                 "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1416:                 "cursor_4c_ChkGrupo")
1417:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkGrupo") AND RECCOUNT("cursor_4c_ChkGrupo") > 0
1418:                 IF USED("cursor_4c_ChkGrupo")
1419:                     USE IN cursor_4c_ChkGrupo
1420:                 ENDIF
1421:                 RETURN
1422:             ENDIF
1423:             IF USED("cursor_4c_ChkGrupo")
1424:                 USE IN cursor_4c_ChkGrupo
1425:             ENDIF
1426:         ENDIF
1427: 
1428:         THIS.AbrirLookupCanonico("SigCdGcr", "Codigos", "Descrs", ;
1429:             "Grupo de Conta", loc_cValor, par_oTxtGrupo, .NULL.)
1430:     ENDPROC

*-- Linhas 1460 a 1486:
1460:         loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
1461:         loc_cFiltroExtra = ""
1462:         IF !EMPTY(loc_cGrupo)
1463:             loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
1464:         ENDIF
1465: 
1466:         IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1467:             IF USED("cursor_4c_ChkConta")
1468:                 USE IN cursor_4c_ChkConta
1469:             ENDIF
1470:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1471:                 "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor) + ;
1472:                 IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
1473:                 "cursor_4c_ChkConta")
1474:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkConta") AND RECCOUNT("cursor_4c_ChkConta") > 0
1475:                 par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkConta.Rclis)
1476:                 IF USED("cursor_4c_ChkConta")
1477:                     USE IN cursor_4c_ChkConta
1478:                 ENDIF
1479:                 RETURN
1480:             ENDIF
1481:             IF USED("cursor_4c_ChkConta")
1482:                 USE IN cursor_4c_ChkConta
1483:             ENDIF
1484:         ENDIF
1485: 
1486:         THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;

*-- Linhas 1517 a 1543:
1517:         loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
1518:         loc_cFiltroExtra = ""
1519:         IF !EMPTY(loc_cGrupo)
1520:             loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
1521:         ENDIF
1522: 
1523:         IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1524:             IF USED("cursor_4c_ChkContaD")
1525:                 USE IN cursor_4c_ChkContaD
1526:             ENDIF
1527:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1528:                 "SELECT Iclis, Rclis FROM SigCdCli WHERE Rclis = " + EscaparSQL(loc_cValor) + ;
1529:                 IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
1530:                 "cursor_4c_ChkContaD")
1531:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkContaD") AND RECCOUNT("cursor_4c_ChkContaD") > 0
1532:                 par_oTxtConta.Value  = ALLTRIM(cursor_4c_ChkContaD.Iclis)
1533:                 par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkContaD.Rclis)
1534:                 IF USED("cursor_4c_ChkContaD")
1535:                     USE IN cursor_4c_ChkContaD
1536:                 ENDIF
1537:                 RETURN
1538:             ENDIF
1539:             IF USED("cursor_4c_ChkContaD")
1540:                 USE IN cursor_4c_ChkContaD
1541:             ENDIF
1542:         ENDIF
1543: 

*-- Linhas 1565 a 1584:
1565:                 IF USED("cursor_4c_ChkEmpCod")
1566:                     USE IN cursor_4c_ChkEmpCod
1567:                 ENDIF
1568:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1569:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor), ;
1570:                     "cursor_4c_ChkEmpCod")
1571:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpCod") AND RECCOUNT("cursor_4c_ChkEmpCod") > 0
1572:                     .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpCod.Razas)
1573:                     IF USED("cursor_4c_ChkEmpCod")
1574:                         USE IN cursor_4c_ChkEmpCod
1575:                     ENDIF
1576:                     RETURN
1577:                 ENDIF
1578:                 IF USED("cursor_4c_ChkEmpCod")
1579:                     USE IN cursor_4c_ChkEmpCod
1580:                 ENDIF
1581:             ENDIF
1582: 
1583:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1584:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;

*-- Linhas 1600 a 1619:
1600:                 IF USED("cursor_4c_ChkEmpDesc")
1601:                     USE IN cursor_4c_ChkEmpDesc
1602:                 ENDIF
1603:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1604:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor), ;
1605:                     "cursor_4c_ChkEmpDesc")
1606:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpDesc") AND RECCOUNT("cursor_4c_ChkEmpDesc") > 0
1607:                     .txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Cemps)
1608:                     .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Razas)
1609:                     IF USED("cursor_4c_ChkEmpDesc")
1610:                         USE IN cursor_4c_ChkEmpDesc
1611:                     ENDIF
1612:                     RETURN
1613:                 ENDIF
1614:                 IF USED("cursor_4c_ChkEmpDesc")
1615:                     USE IN cursor_4c_ChkEmpDesc
1616:                 ENDIF
1617:             ENDIF
1618: 
1619:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;

*-- Linhas 1640 a 1659:
1640:                 IF USED("cursor_4c_ChkNop")
1641:                     USE IN cursor_4c_ChkNop
1642:                 ENDIF
1643:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1644:                     "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(loc_nValor, 0), ;
1645:                     "cursor_4c_ChkNop")
1646:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ChkNop") AND RECCOUNT("cursor_4c_ChkNop") > 0
1647:                     MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", ;
1648:                              "Aten" + CHR(231) + CHR(227) + "o")
1649:                     .txt_4c_Nop.Value = 0
1650:                     .txt_4c_Nop.SetFocus
1651:                 ENDIF
1652:                 IF USED("cursor_4c_ChkNop")
1653:                     USE IN cursor_4c_ChkNop
1654:                 ENDIF
1655:             ENDIF
1656:             .Visible     = .T.
1657:         ENDWITH
1658:     ENDPROC
1659: 

