# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '280'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.
- [MADDCOLUNA] Chamada mAddColuna com parametro numerico '280'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS GRID (1824 linhas total):

*-- Linhas 1455 a 1538:
1455:                        ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value), ;
1456:                        "Empresa")
1457:         IF VARTYPE(loc_oFrm) = "O"
1458:             loc_oFrm.mAddColuna("cemps", "C" + CHR(243) + "digo", 80)
1459:             loc_oFrm.mAddColuna("razas", "Raz" + CHR(227) + "o Social", 280)
1460:             loc_oFrm.Show()
1461:             IF THIS.this_lSelecionou
1462:                 loc_oCnt.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
1463:                 loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
1464:                 USE IN cursor_4c_BuscaEmp
1465:             ENDIF
1466:             loc_oFrm.Release()
1467:             loc_oFrm = .NULL.
1468:         ENDIF
1469:     ENDPROC
1470: 
1471:     PROTECTED PROCEDURE AbrirLookupOperacao()
1472:         LOCAL loc_oFrm, loc_oCnt
1473:         loc_oCnt = THIS.cnt_4c_Container1
1474:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
1475:                        "cursor_4c_BuscaOpe", "Dopes", ;
1476:                        ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value), ;
1477:                        "Opera" + CHR(231) + CHR(227) + "o")
1478:         IF VARTYPE(loc_oFrm) = "O"
1479:             loc_oFrm.mAddColuna("Dopes", "Opera" + CHR(231) + CHR(227) + "o", 300)
1480:             loc_oFrm.Show()
1481:             IF THIS.this_lSelecionou
1482:                 loc_oCnt.txt_4c__nm_operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1483:                 USE IN cursor_4c_BuscaOpe
1484:             ENDIF
1485:             loc_oFrm.Release()
1486:             loc_oFrm = .NULL.
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     PROTECTED PROCEDURE AbrirLookupGrupo()
1491:         LOCAL loc_oFrm, loc_oCnt
1492:         loc_oCnt = THIS.cnt_4c_Container1
1493:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1494:                        "cursor_4c_BuscaGrupo", "codigos", ;
1495:                        ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
1496:                        "Grupo")
1497:         IF VARTYPE(loc_oFrm) = "O"
1498:             loc_oFrm.mAddColuna("codigos", "C" + CHR(243) + "digo", 80)
1499:             loc_oFrm.mAddColuna("descrs",  "Descri" + CHR(231) + CHR(227) + "o", 280)
1500:             loc_oFrm.Show()
1501:             IF THIS.this_lSelecionou
1502:                 loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
1503:                 loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
1504:                 USE IN cursor_4c_BuscaGrupo
1505:             ENDIF
1506:             loc_oFrm.Release()
1507:             loc_oFrm = .NULL.
1508:         ENDIF
1509:     ENDPROC
1510: 
1511:     PROTECTED PROCEDURE AbrirLookupConta()
1512:         LOCAL loc_oFrm, loc_oCnt, loc_cGrupo
1513:         loc_oCnt   = THIS.cnt_4c_Container1
1514:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1515:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1516:                        IIF(EMPTY(loc_cGrupo), "SigCdCli", ;
1517:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo)), ;
1518:                        "cursor_4c_BuscaConta", "iclis", ;
1519:                        ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
1520:                        "Conta")
1521:         IF VARTYPE(loc_oFrm) = "O"
1522:             loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
1523:             loc_oFrm.mAddColuna("rclis", "Nome", 280)
1524:             loc_oFrm.Show()
1525:             IF THIS.this_lSelecionou
1526:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
1527:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1528:                 USE IN cursor_4c_BuscaConta
1529:                 THIS.PreencherCpfPorConta()
1530:             ENDIF
1531:             loc_oFrm.Release()
1532:             loc_oFrm = .NULL.
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     PROTECTED PROCEDURE AbrirLookupResps()
1537:         LOCAL loc_oFrm, loc_oCnt, loc_cGrpVens
1538:         loc_oCnt    = THIS.cnt_4c_Container1

*-- Linhas 1544 a 1584:
1544:                        ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
1545:                        "Respons" + CHR(225) + "vel")
1546:         IF VARTYPE(loc_oFrm) = "O"
1547:             loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
1548:             loc_oFrm.mAddColuna("rclis", "Nome", 280)
1549:             loc_oFrm.Show()
1550:             IF THIS.this_lSelecionou
1551:                 loc_oCnt.txt_4c__resps.Value  = ALLTRIM(cursor_4c_BuscaResp.iclis)
1552:                 loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1553:                 USE IN cursor_4c_BuscaResp
1554:             ENDIF
1555:             loc_oFrm.Release()
1556:             loc_oFrm = .NULL.
1557:         ENDIF
1558:     ENDPROC
1559: 
1560:     PROTECTED PROCEDURE AbrirLookupMoeda()
1561:         LOCAL loc_oFrm, loc_oCnt
1562:         loc_oCnt = THIS.cnt_4c_Container1
1563:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1564:                        "cursor_4c_BuscaMoeda", "cmoes", ;
1565:                        ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value), ;
1566:                        "Moeda")
1567:         IF VARTYPE(loc_oFrm) = "O"
1568:             loc_oFrm.mAddColuna("cmoes", "C" + CHR(243) + "digo", 80)
1569:             loc_oFrm.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
1570:             loc_oFrm.Show()
1571:             IF THIS.this_lSelecionou
1572:                 loc_oCnt.txt_4c_cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1573:                 loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1574:                 USE IN cursor_4c_BuscaMoeda
1575:             ENDIF
1576:             loc_oFrm.Release()
1577:             loc_oFrm = .NULL.
1578:         ENDIF
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * PreencherCpfPorConta - Consulta SigCdCli para popular campo CPF
1583:     * apos selecionar uma conta.
1584:     *==========================================================================

