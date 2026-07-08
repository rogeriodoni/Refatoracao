# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1593: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg) - TRECHOS RELEVANTES PARA PASS GRID (3786 linhas total):

*-- Linhas 532 a 552:
532:         ENDWITH
533: 
534:         *-- Grid de Grupos (grdgrupos)
535:         loc_oP1.AddObject("grd_4c_Grupos", "Grid")
536:         WITH loc_oP1.grd_4c_Grupos
537:             .ColumnCount      = 2
538:             .FontName         = "Tahoma"
539:             .AllowHeaderSizing = .F.
540:             .AllowRowSizing   = .F.
541:             .DeleteMark       = .F.
542:             .GridLines        = 3
543:             .Height           = 344
544:             .Left             = 372
545:             .Panel            = 1
546:             .ScrollBars       = 2
547:             .SplitBar         = .F.
548:             .TabIndex         = 11
549:             .Top              = 236
550:             .Width            = 202
551:             .GridLineColor    = RGB(238,238,238)
552:             .Themes           = .F.

*-- Linhas 621 a 641:
621:         loc_oP2 = THIS.pgf_4c_Principal.pgdados
622: 
623:         *-- Grid de Operacoes (grdope)
624:         loc_oP2.AddObject("grd_4c_Dados", "Grid")
625:         WITH loc_oP2.grd_4c_Dados
626:             .ColumnCount       = 8
627:             .FontName          = "Tahoma"
628:             .AllowHeaderSizing = .F.
629:             .AllowRowSizing    = .F.
630:             .DeleteMark        = .F.
631:             .Height            = 382
632:             .Left              = 9
633:             .Panel             = 1
634:             .RecordMark        = .F.
635:             .ScrollBars        = 2
636:             .SplitBar          = .F.
637:             .TabIndex          = 1
638:             .Top               = 152
639:             .Width             = 981
640:             .GridLineColor     = RGB(238,238,238)
641:             .Themes            = .F.

*-- Linhas 915 a 937:
915:         loc_oP1.txt_4c_CdEmpConv.Visible          = .T.
916:         loc_oP1.txt_4c_DsEmpConv.Visible          = .T.
917:         loc_oP1.lbl_4c_LblGrupos.Visible          = .T.
918:         loc_oP1.grd_4c_Grupos.Visible             = .T.
919:         loc_oP1.cgp_4c_MarcaFiltro.Visible        = .T.
920: 
921:         loc_oP2 = loc_oPgf.pgdados
922:         loc_oP2.grd_4c_Dados.Visible              = .T.
923:         loc_oP2.cgp_4c_Encerrar.Visible           = .T.
924:         loc_oP2.cgp_4c_Acoes.Visible              = .T.
925:         loc_oP2.lbl_4c_Protestar.Visible          = .T.
926:         loc_oP2.spn_4c_Dias.Visible               = .T.
927:         loc_oP2.lbl_4c_Dias.Visible               = .T.
928:         loc_oP2.cgp_4c_MarcaDados.Visible         = .T.
929:     ENDPROC
930: 
931:     *==========================================================================
932:     * ConfigurarBINDEVENTs - Liga eventos aos handlers do form
933:     *==========================================================================
934:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
935:         LOCAL loc_oP1, loc_oP2
936: 
937:         loc_oP1 = THIS.pgf_4c_Principal.pgfiltro

*-- Linhas 969 a 1007:
969:         BINDEVENT(loc_oP2.cgp_4c_MarcaDados.Command2, "Click", THIS, "ClickDesmarcarOper")
970: 
971:         *-- Headers do grid de operacoes (clique para ordenar)
972:         BINDEVENT(loc_oP2.grd_4c_Dados.Column3.Header1, "Click", THIS, "ClickHeaderVencs")
973:         BINDEVENT(loc_oP2.grd_4c_Dados.Column4.Header1, "Click", THIS, "ClickHeaderValors")
974:         BINDEVENT(loc_oP2.grd_4c_Dados.Column6.Header1, "Click", THIS, "ClickHeaderHisto")
975:         BINDEVENT(loc_oP2.grd_4c_Dados.Column7.Header1, "Click", THIS, "ClickHeaderRclis")
976:     ENDPROC
977: 
978:     *==========================================================================
979:     * InicializarValores - Carrega dados iniciais (grupos, etc.)
980:     *==========================================================================
981:     PROTECTED PROCEDURE InicializarValores()
982:         LOCAL loc_oGrd
983: 
984:         IF THIS.this_oBusinessObject.BuscarGrupos()
985:             loc_oGrd = THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos
986:             loc_oGrd.ColumnCount = 2
987:             loc_oGrd.RecordSource      = "cursor_4c_Grupos"
988:             loc_oGrd.Column1.ControlSource = "cursor_4c_Grupos.marca"
989:             loc_oGrd.Column2.ControlSource = "cursor_4c_Grupos.descrs"
990:             loc_oGrd.Column1.Header1.Caption = ""
991:             loc_oGrd.Column2.Header1.Caption = "Grupos"
992:             loc_oGrd.Column2.Header1.Alignment = 2
993:             loc_oGrd.Refresh()
994:         ENDIF
995: 
996:         THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * HANDLERS DE VALIDACAO DOS CAMPOS DE FILTRO
1001:     *==========================================================================
1002: 
1003:     PROCEDURE ValidarCdEmpresa()
1004:         LOCAL loc_cCod, loc_cSQL
1005:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value)
1006:         IF EMPTY(loc_cCod)
1007:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""

*-- Linhas 1218 a 1238:
1218:             ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value), ;
1219:             "Buscar Empresa")
1220: 
1221:         loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
1222:         loc_oBusca.mAddColuna("RazSocs", "", "Raz" + CHR(227) + "o Social")
1223:         loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
1224:         loc_oBusca.Show()
1225: 
1226:         IF loc_oBusca.this_lSelecionou
1227:             IF USED("cursor_4c_BuscaEmpresa")
1228:                 SELECT cursor_4c_BuscaEmpresa
1229:                 loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1230:                 loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
1231:             ENDIF
1232:         ENDIF
1233: 
1234:         IF USED("cursor_4c_BuscaEmpresa")
1235:             USE IN cursor_4c_BuscaEmpresa
1236:         ENDIF
1237:         loc_oBusca.Release()
1238:     ENDPROC

*-- Linhas 1252 a 1272:
1252:             ALLTRIM(loc_oP1.txt_4c_CdConta.Value), ;
1253:             "Buscar Conta Banc" + CHR(225) + "ria")
1254: 
1255:         loc_oBusca.mAddColuna("GruContas", "", "C" + CHR(243) + "digo")
1256:         loc_oBusca.mAddColuna("bancos",    "", "Banco")
1257:         loc_oBusca.mAddColuna("NAgencias", "", "Ag" + CHR(234) + "ncia")
1258:         loc_oBusca.Show()
1259: 
1260:         IF loc_oBusca.this_lSelecionou
1261:             IF USED("cursor_4c_BuscaConta")
1262:                 SELECT cursor_4c_BuscaConta
1263:                 loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.GruContas)
1264:                 loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.bancos) + ;
1265:                                                " - Ag" + CHR(234) + " " + ;
1266:                                                ALLTRIM(cursor_4c_BuscaConta.NAgencias)
1267:             ENDIF
1268:         ENDIF
1269: 
1270:         IF USED("cursor_4c_BuscaConta")
1271:             USE IN cursor_4c_BuscaConta
1272:         ENDIF

*-- Linhas 1288 a 1308:
1288:             ALLTRIM(loc_oP1.txt_4c_CdEmpConv.Value), ;
1289:             "Buscar Empresa Conv" + CHR(234) + "nio")
1290: 
1291:         loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
1292:         loc_oBusca.mAddColuna("RazSocs", "", "Raz" + CHR(227) + "o Social")
1293:         loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
1294:         loc_oBusca.Show()
1295: 
1296:         IF loc_oBusca.this_lSelecionou
1297:             IF USED("cursor_4c_BuscaEmpConv")
1298:                 SELECT cursor_4c_BuscaEmpConv
1299:                 loc_oP1.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.Cemps)
1300:                 loc_oP1.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.RazSocs)
1301:             ENDIF
1302:         ENDIF
1303: 
1304:         IF USED("cursor_4c_BuscaEmpConv")
1305:             USE IN cursor_4c_BuscaEmpConv
1306:         ENDIF
1307:         loc_oBusca.Release()
1308:     ENDPROC

*-- Linhas 1417 a 1462:
1417:             SELECT cursor_4c_Grupos
1418:             REPLACE ALL marca WITH .T.
1419:             GO TOP
1420:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1421:         ENDIF
1422:     ENDPROC
1423: 
1424:     PROCEDURE ClickDesmarcarGrupos()
1425:         IF USED("cursor_4c_Grupos")
1426:             SELECT cursor_4c_Grupos
1427:             REPLACE ALL marca WITH .F.
1428:             GO TOP
1429:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     PROCEDURE ClickMarcarOper()
1434:         IF USED("cursor_4c_Filtro")
1435:             SELECT cursor_4c_Filtro
1436:             REPLACE ALL marca WITH .T.
1437:             GO TOP
1438:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1439:         ENDIF
1440:     ENDPROC
1441: 
1442:     PROCEDURE ClickDesmarcarOper()
1443:         IF USED("cursor_4c_Filtro")
1444:             SELECT cursor_4c_Filtro
1445:             REPLACE ALL marca WITH .F.
1446:             GO TOP
1447:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1448:         ENDIF
1449:     ENDPROC
1450: 
1451:     PROCEDURE ClickHeaderVencs()
1452:         IF USED("cursor_4c_Filtro")
1453:             SELECT cursor_4c_Filtro
1454:             INDEX ON vencs TAG vencs
1455:             SET ORDER TO vencs
1456:             THIS.OrdenarGrade()
1457:         ENDIF
1458:     ENDPROC
1459: 
1460:     PROCEDURE ClickHeaderValors()
1461:         IF USED("cursor_4c_Filtro")
1462:             SELECT cursor_4c_Filtro

*-- Linhas 1568 a 1624:
1568:         loc_oP2 = THIS.pgf_4c_Principal.pgdados
1569: 
1570:         IF par_nPagina = 1
1571:             loc_oP2.grd_4c_Dados.RecordSource = ""
1572:             loc_oP1.Enabled = .T.
1573:             loc_oP2.Enabled = .F.
1574:             THIS.pgf_4c_Principal.ActivePage = 1
1575:         ELSE
1576:             loc_oP1.Enabled = .F.
1577:             loc_oP2.Enabled = .T.
1578:             THIS.pgf_4c_Principal.ActivePage = 2
1579:         ENDIF
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * OrdenarGrade - Atualiza o grid de operacoes apos ordenacao
1584:     *==========================================================================
1585:     PROCEDURE OrdenarGrade()
1586:         LOCAL loc_oGrd
1587:         loc_oGrd = THIS.pgf_4c_Principal.pgdados.grd_4c_Dados
1588:         GO BOTTOM IN cursor_4c_Filtro
1589:         GO TOP IN cursor_4c_Filtro
1590:         loc_oGrd.RecordSource = ""
1591:         loc_oGrd.Refresh()
1592:         loc_oGrd.ColumnCount = 8
1593:         loc_oGrd.RecordSource = "cursor_4c_Filtro"
1594:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1595:         loc_oGrd.Refresh()
1596:     ENDPROC
1597: 
1598:     *==========================================================================
1599:     * Processamento - Executa busca com filtros e muda para pagina de dados
1600:     *==========================================================================
1601:     PROCEDURE Processamento()
1602:         LOCAL loc_oP1, loc_oP2, loc_oGrd
1603:         LOCAL loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf
1604:         LOCAL loc_lNaoProc, loc_nPeriodo, loc_cGrupos
1605:         LOCAL loc_oBO
1606: 
1607:         loc_oP1  = THIS.pgf_4c_Principal.pgfiltro
1608:         loc_oP2  = THIS.pgf_4c_Principal.pgdados
1609:         loc_oGrd = loc_oP2.grd_4c_Dados
1610:         loc_oBO  = THIS.this_oBusinessObject
1611: 
1612:         loc_cCdEmp   = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
1613:         loc_cCdConta = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
1614:         loc_dDati    = loc_oP1.txt_4c_Datai.Value
1615:         loc_dDatf    = loc_oP1.txt_4c_Dataf.Value
1616:         loc_lNaoProc = (loc_oP1.opt_4c_Processados.Value = 1)
1617:         loc_nPeriodo = loc_oP1.opt_4c_Periodo.Value
1618: 
1619:         *-- Monta lista de grupos marcados
1620:         loc_cGrupos = "("
1621:         IF USED("cursor_4c_Grupos")
1622:             SELECT cursor_4c_Grupos
1623:             SCAN
1624:                 IF cursor_4c_Grupos.marca

*-- Linhas 1630 a 1680:
1630:         loc_cGrupos = loc_cGrupos + ")"
1631: 
1632:         *-- Limpa grid antes da busca
1633:         loc_oGrd.RecordSource = ""
1634:         loc_oGrd.Refresh()
1635: 
1636:         IF !loc_oBO.BuscarOperacoes(loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf, ;
1637:                                      loc_lNaoProc, loc_nPeriodo, loc_cGrupos)
1638:             RETURN
1639:         ENDIF
1640: 
1641:         IF RECCOUNT("cursor_4c_Filtro") = 0
1642:             MsgAviso("Nenhum dado foi encontrado")
1643:             RETURN
1644:         ENDIF
1645: 
1646:         *-- Liga grid ao cursor
1647:         loc_oGrd.ColumnCount = 8
1648:         loc_oGrd.RecordSource = "cursor_4c_Filtro"
1649:         loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1650:         loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
1651:         loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
1652:         loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
1653:         loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
1654:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1655:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1656:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1657: 
1658:         loc_oGrd.Column1.Header1.Caption = ""
1659:         loc_oGrd.Column2.Header1.Caption = "Data"
1660:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1661:         loc_oGrd.Column4.Header1.Caption = "Valor"
1662:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1663:         loc_oGrd.Column6.Header1.Caption = "Historico"
1664:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1665:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1666: 
1667:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1668:         loc_oGrd.Refresh()
1669: 
1670:         *-- Muda para pagina de dados
1671:         THIS.AlternarPagina(2)
1672:         loc_oP2.cgp_4c_Acoes.Command3.Enabled = .F.
1673:     ENDPROC
1674: 
1675:     *==========================================================================
1676:     * GerarCNAB - Despacha para o metodo CNAB correto baseado no banco
1677:     * pTipo: 'A' = gerar arquivo, 'V' = relatorio/preview, 'I' = boleto
1678:     *==========================================================================
1679:     PROCEDURE GerarCNAB(par_cTipo)
1680:         LOCAL loc_cCdConta, loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdEmpConv

*-- Linhas 1783 a 1801:
1783:             IF USED("cursor_4c_CabRel")
1784:                 USE IN cursor_4c_CabRel
1785:             ENDIF
1786:             CREATE CURSOR cursor_4c_CabRel (titulo C(100), periodo C(100), empresa C(100))
1787:             INSERT INTO cursor_4c_CabRel (titulo, periodo, empresa) ;
1788:                 VALUES ("Dados para gera" + CHR(231) + CHR(227) + "o do CNAB", ;
1789:                         loc_cDataRel, ;
1790:                         loc_cCdEmp + " - " + ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, "")))
1791: 
1792:             IF USED("cursor_4c_Filtro2Rel")
1793:                 USE IN cursor_4c_Filtro2Rel
1794:             ENDIF
1795:             SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2Rel
1796: 
1797:             IF par_cTipo = "V"
1798:                 REPORT FORM sigrecnb PREVIEW
1799:             ENDIF
1800:         ENDIF
1801:     ENDPROC

*-- Linhas 3642 a 3660:
3642:         loc_oP1.txt_4c_DsEmpConv.Enabled   = par_lHabilitar
3643:         loc_oP1.opt_4c_Processados.Enabled = par_lHabilitar
3644:         loc_oP1.opt_4c_Periodo.Enabled     = par_lHabilitar
3645:         loc_oP1.grd_4c_Grupos.Enabled      = par_lHabilitar
3646:         loc_oP1.cgp_4c_MarcaFiltro.Enabled = par_lHabilitar
3647:         loc_oP1.cgp_4c_Filtro.Command1.Enabled = par_lHabilitar
3648:     ENDPROC
3649: 
3650:     *==========================================================================
3651:     * LimparCampos - Zera todos os campos de filtro e o grid de dados
3652:     *==========================================================================
3653:     PROCEDURE LimparCampos()
3654:         LOCAL loc_oP1, loc_oP2
3655: 
3656:         loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
3657:         loc_oP2 = THIS.pgf_4c_Principal.pgdados
3658: 
3659:         loc_oP1.txt_4c_CdEmpresa.Value  = ""
3660:         loc_oP1.txt_4c_DsEmpresa.Value  = ""

*-- Linhas 3672 a 3695:
3672:             SELECT cursor_4c_Grupos
3673:             REPLACE ALL marca WITH .F.
3674:             GO TOP
3675:             loc_oP1.grd_4c_Grupos.Refresh()
3676:         ENDIF
3677: 
3678:         *-- Limpa grid de dados
3679:         loc_oP2.grd_4c_Dados.RecordSource = ""
3680:         loc_oP2.grd_4c_Dados.Refresh()
3681: 
3682:         *-- Fecha cursores de resultado anterior
3683:         LOCAL loc_i
3684:         LOCAL loc_aCur(9)
3685:         loc_aCur(1) = "cursor_4c_Filtro"
3686:         loc_aCur(2) = "crFiltro2"
3687:         loc_aCur(3) = "crFiltro3"
3688:         loc_aCur(4) = "crFiltro4"
3689:         loc_aCur(5) = "crFiltro5"
3690:         loc_aCur(6) = "crFiltro6"
3691:         loc_aCur(7) = "crFiltroTr"
3692:         loc_aCur(8) = "crFiltro20"
3693:         loc_aCur(9) = "crErro"
3694:         FOR loc_i = 1 TO ALEN(loc_aCur)
3695:             IF USED(loc_aCur[loc_i])

