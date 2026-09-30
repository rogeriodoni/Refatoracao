# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE

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
If ThisForm.poDataMgr.SqlExecute([Select MarkUpCVs,GrPadFors From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdPac ],'CrSigCdPac') < 1
Select CrSigCdPac
If ThisForm.poDataMgr.SqlExecute([Select CGrus,Arreds From SigCdGrp ],'CrSigCdGrp') < 1
Select CrSigCdGrp
Select CrProdutos
	.Column1.ControlSource = 'CrProdutos.lMarca'
	.Column2.ControlSource = 'CrProdutos.CPros'
	.Column3.ControlSource = 'CrProdutos.DPros'
	.Column4.ControlSource = 'CrProdutos.ValAnt'
	.Column5.ControlSource = 'CrProdutos.ValAtu'
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where 0 = 1 ],'TmpPro') < 1
Select TmpPro
lStrQuery = [Select * From SigCdPro ]+;
			Iif(ThisForm.chkIgnorar.Value = 1, [ ], [ And Cpros Not in (Select Distinct cpros From SigPrCpo) ]) + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
Select TmpPro
Select TmpPro
	loBarra.Update(.T.)
	Insert Into CrProdutos From MemVar
Select CrProdutos
	Select * From CrProdutos Where lMarca = 1 Order By CPros Into Cursor CsProdutos ReadWrite
	Select CsProdutos
	Select CsProdutos
		loBarra.Update(.T.,'Produto: ' + CsProdutos.CPros)
		If Seek(CsProdutos.CPros,'TmpPro','CPros')
			Select TmpPro
			Insert Into CrSigCdPrc From MemVar
			Insert Into CrSigCdPro From MemVar
			If ThisForm.poDataMgr.SqlExecute([Select * From SigPrCpo Where CPros = ']+m.CPros+[' ],'TmpCompo') < 1
			Select TmpCompo
				Insert Into CrSigPrCp2 From MemVar
				Select TmpCompo
			If ThisForm.poDataMgr.SqlExecute([Delete From SigPrPrt Where CPros = '] + m.CPros + [' ], []) < 1
				lStrQuery = [Delete From SigPrPmi Where CPros = '] + CsProdutos.CPros + [']
				If ThisForm.poDataMgr.SqlExecute(lStrQuery, '') < 1
				lStrQuery = [Select * From SigPrPmi Where CPros = ']+CsProdutos.CPros+[' And Promos = ']+lcPromo+[' ]
				If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPromI') < 1
				Select TmpPromI
					Insert Into CrSigPrPmi (CPros,Pecas,Promos,CBars,Datas,CIdChaves,PromoPro,DtAlts) ;
		Select CsProdutos
		Select crSigCdPro
			lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+crSigCdPro.cGrus+[' Order By nFaixaFins]
			If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
			Select csSigCdPsg
					Select crSigCdPro
					Select crSigCdPro
	loBarraFim.Update(.T.,'SigCdPro (1/4)...')
	Select CrSigCdPro
	Select CrSigCdPrc
	Select * From CrSigCdPro Into Cursor CsSelecao
	Select CsSelecao
			If Not ThisForm.poDataMgr.Update('CrSigCdPro')
		Insert Into CrSigCdPro From Memvar 
	llOk = llOk And ThisForm.poDataMgr.Update('CrSigCdPro')
		loBarraFim.Update(.T.,'SigCdPrc (2/4)...')
		Select * From CrSigCdPrc Into Cursor CsSelecao
		Select CsSelecao
				If Not ThisForm.poDataMgr.Update('CrSigCdPrc')
			Insert Into CrSigCdPrc From Memvar 
		llOk = llOk And ThisForm.poDataMgr.Update('CrSigCdPrc')
		loBarraFim.Update(.T.,'SigPrCp2 (3/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrCp2')
		loBarraFim.Update(.T.,'SigPrPmi (4/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrPmi')
Select CrProdutos
lcSql = [Select FigJpgs From SigCdPro Where Cpros = ']+CrProdutos.cpros+[']
If ThisForm.PodataMgr.Sqlexecute(lcSql,'CsTmpPro') < 1
Select CsTmpPro
Select CrProdutos
	Update CrProdutos Set lMarca = 1
	Update CrProdutos Set lMarca = 0
	Select CqSigCdPro
		Insert Into TmpPro From MemVar
		Select TmpPro
		Select CrProdutos
			Select CrProdutos
				Insert Into CrProdutos From MemVar
			Select CrProdutos
	Select CrProdutos
		Insert Into CrProdutos From MemVar
	Select CrProdutos
		Insert Into CrProdutos From MemVar
		Select CrProdutos
		Delete From CrProdutos
		Select CrProdutos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2181 linhas total):

*-- Linhas 1019 a 1038:
1019:             IF USED(loc_cCursor)
1020:                 USE IN (loc_cCursor)
1021:             ENDIF
1022:             IF SQLEXEC(gnConnHandle, "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
1023:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(par_cValor), loc_cCursor) > 0 AND ;
1024:                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1025:                 loc_lAchou = .T.
1026:             ENDIF
1027:             IF USED(loc_cCursor)
1028:                 USE IN (loc_cCursor)
1029:             ENDIF
1030:         CATCH TO loc_oErro
1031:             MsgErro(loc_oErro.Message, "FormSigPrApr.ExisteCodigoNaTabela")
1032:         ENDTRY
1033: 
1034:         RETURN loc_lAchou
1035:     ENDFUNC
1036: 
1037:     *==========================================================================
1038:     * ValidarECompletarMoeda - Helper compartilhado pelos 6 campos de moeda

*-- Linhas 1236 a 1256:
1236:             IF USED("cursor_4c_LkpConta")
1237:                 USE IN cursor_4c_LkpConta
1238:             ENDIF
1239:             IF SQLEXEC(gnConnHandle, ;
1240:                     "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cValor) + ;
1241:                     " AND Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)), ;
1242:                     "cursor_4c_LkpConta") > 0 AND ;
1243:                USED("cursor_4c_LkpConta") AND RECCOUNT("cursor_4c_LkpConta") > 0
1244:                 THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_LkpConta.IClis)
1245:                 THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_LkpConta.RClis)
1246:                 loc_lAchou = .T.
1247:             ENDIF
1248:             IF USED("cursor_4c_LkpConta")
1249:                 USE IN cursor_4c_LkpConta
1250:             ENDIF
1251:         CATCH TO loc_oErro
1252:             MsgErro(loc_oErro.Message, "FormSigPrApr.TxtContaKeyPress")
1253:         ENDTRY
1254: 
1255:         IF !loc_lAchou
1256:             THIS.AbrirLookupConta()

*-- Linhas 1285 a 1316:
1285:             "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
1286:             ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")), ;
1287:             THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1288:             "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * AbrirLookupContaPorDescricao - Mesmo lookup de Fornecedor, mas com o
1293:     * prefixo digitado em Get_DConta (busca por Razao Social - modo 'D' do
1294:     * fAcessoContas legado).
1295:     *==========================================================================
1296:     PROTECTED PROCEDURE AbrirLookupContaPorDescricao()
1297:         THIS.AbrirLookupCanonico("SigCdCli", "IClis", "RClis", ;
1298:             "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
1299:             ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")), ;
1300:             THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
1301:             "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
1302:     ENDPROC
1303: 
1304:     *==========================================================================
1305:     * TxtPromoKeyPress - Equivalente ao Valid do Get_Promo legado
1306:     * (fwbuscaext contra SigPrPmc). F4 sempre abre o lookup; Enter/Tab valida
1307:     * existencia exata e, se nao achar, abre o mesmo lookup. SigPrPmc.Promos
1308:     * eh PK e descricao ao mesmo tempo (tabela single-column, igual a
1309:     * SigCdOpe.Dopes - regra: nunca inventar segunda coluna de descricao).
1310:     *==========================================================================
1311:     PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1312:         LOCAL loc_cValor, loc_lAchou, loc_oErro
1313: 
1314:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1315:             RETURN
1316:         ENDIF

*-- Linhas 1330 a 1349:
1330:             IF USED("cursor_4c_LkpPromo")
1331:                 USE IN cursor_4c_LkpPromo
1332:             ENDIF
1333:             IF SQLEXEC(gnConnHandle, ;
1334:                     "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cValor), ;
1335:                     "cursor_4c_LkpPromo") > 0 AND ;
1336:                USED("cursor_4c_LkpPromo") AND RECCOUNT("cursor_4c_LkpPromo") > 0
1337:                 THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPromo.Promos)
1338:                 loc_lAchou = .T.
1339:             ENDIF
1340:             IF USED("cursor_4c_LkpPromo")
1341:                 USE IN cursor_4c_LkpPromo
1342:             ENDIF
1343:         CATCH TO loc_oErro
1344:             MsgErro(loc_oErro.Message, "FormSigPrApr.TxtPromoKeyPress")
1345:         ENDTRY
1346: 
1347:         IF !loc_lAchou
1348:             THIS.AbrirLookupPromo()
1349:         ENDIF

*-- Linhas 1476 a 1499:
1476:             .HeaderHeight = 20
1477:             .RowHeight    = 16
1478:             .ScrollBars   = 2
1479:             .DeleteMark   = .F.
1480:             .RecordMark   = .F.
1481: 
1482:             *-- Column1: Marca (lMarca) - CheckBox (regra #18: Column.AddObject
1483:             *-- exige CurrentControl, senao a coluna continua desenhando o Text1)
1484:             .Column1.ControlSource = loc_cCursor + ".lMarca"
1485:             .Column1.Width         = 20
1486:             .Column1.Alignment     = 3
1487:             .Column1.Movable       = .F.
1488:             .Column1.Resizable     = .F.
1489:             .Column1.Sparse        = .F.
1490:             .Column1.ReadOnly      = .F.
1491:         ENDWITH
1492: 
1493:         loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1494:         WITH loc_oGrid.Column1.Check1
1495:             .Caption  = ""
1496:             .AutoSize = .T.
1497:             .Visible  = .T.
1498:         ENDWITH
1499:         loc_oGrid.Column1.CurrentControl   = "Check1"

*-- Linhas 1506 a 1551:
1506: 
1507:         WITH loc_oGrid
1508:             *-- Column2: Produto (CPros)
1509:             .Column2.ControlSource   = loc_cCursor + ".CPros"
1510:             .Column2.Width           = 108
1511:             .Column2.ReadOnly        = .T.
1512:             .Column2.Movable         = .F.
1513:             .Column2.Resizable       = .F.
1514:             .Column2.Header1.Caption = "Produto"
1515: 
1516:             *-- Column3: Descricao (DPros) - legado: When -> .F. (sempre readonly)
1517:             .Column3.ControlSource   = loc_cCursor + ".DPros"
1518:             .Column3.Width           = 350
1519:             .Column3.ReadOnly        = .T.
1520:             .Column3.Movable         = .F.
1521:             .Column3.Resizable       = .F.
1522:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1523: 
1524:             *-- Column4: Preco Anterior (ValAnt) - legado: When -> .F.
1525:             .Column4.ControlSource   = loc_cCursor + ".ValAnt"
1526:             .Column4.Width           = 100
1527:             .Column4.InputMask       = "999,999,999.99"
1528:             .Column4.ReadOnly        = .T.
1529:             .Column4.Movable         = .F.
1530:             .Column4.Resizable       = .F.
1531:             .Column4.Header1.Caption = "Pre" + CHR(231) + "o Anterior"
1532: 
1533:             *-- Column5: Preco Atual (ValAtu) - editavel so com this_lLibValAtu
1534:             *-- (legado: Column5.Text1.ReadOnly = Not ThisForm.LibValAtu +
1535:             *-- Header1.Picture = lock.bmp quando sem permissao)
1536:             .Column5.ControlSource   = loc_cCursor + ".ValAtu"
1537:             .Column5.Width           = 111
1538:             .Column5.InputMask       = "999,999,999.99"
1539:             .Column5.ReadOnly        = !THIS.this_lLibValAtu
1540:             .Column5.Movable         = .F.
1541:             .Column5.Resizable       = .F.
1542:             .Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
1543:             .Column5.Header1.Picture = IIF(THIS.this_lLibValAtu, "", gc_4c_CaminhoIcones + "lock.bmp")
1544:         ENDWITH
1545: 
1546:         *-- Legado: Column1.Header1.Click (toggle marcar/desmarcar todos)
1547:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "GridHeaderMarcaClick")
1548:         *-- Legado: Column1.Check1.When -> Return(!Empty(CrProdutos.CPros)) -
1549:         *-- impede marcar a linha em branco que o modo "Produtos" mantem no
1550:         *-- fim da grade enquanto o codigo ainda nao foi digitado
1551:         BINDEVENT(loc_oGrid.Column1.Check1, "When", THIS, "Column1CheckWhen")

*-- Linhas 1656 a 1685:
1656:     *==========================================================================
1657:     * CarregarLista - Reexibe a grade de conferencia apos popular/esvaziar o
1658:     * cursor de trabalho (regra: popular cursor NAO repinta a grade sozinho -
1659:     * legado: Select CrProdutos / Go Top / ThisForm.Grd_Produto.Refresh).
1660:     * PUBLIC de proposito: TesteAutomatico.prg chama metodos de carga direto
1661:     * no oForm, e metodo PROTECTED falha em runtime mesmo passando no PEMSTATUS.
1662:     *==========================================================================
1663:     PROCEDURE CarregarLista()
1664:         LOCAL loc_oBO, loc_cCursor
1665: 
1666:         loc_oBO = THIS.this_oBusinessObject
1667:         IF VARTYPE(loc_oBO) = "O"
1668:             loc_cCursor = loc_oBO.this_cCursorItens
1669:             IF USED(loc_cCursor)
1670:                 SELECT (loc_cCursor)
1671:                 GO TOP
1672:             ENDIF
1673:         ENDIF
1674: 
1675:         IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
1676:             THIS.grd_4c_Produtos.Refresh()
1677:         ENDIF
1678:     ENDPROC
1679: 
1680:     *==========================================================================
1681:     * GridHeaderMarcaClick - Transcreve o PROCEDURE Click do Column1.Header1
1682:     * legado (marca/desmarca todos os produtos da grade de uma vez).
1683:     *==========================================================================
1684:     PROCEDURE GridHeaderMarcaClick()
1685:         LOCAL loc_oBO, loc_cCursor

*-- Linhas 1698 a 1719:
1698:         ENDIF
1699: 
1700:         IF THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
1701:             UPDATE (loc_cCursor) SET lMarca = 1
1702:             THIS.grd_4c_Produtos.Column1.Header1.Tag = "1"
1703:         ELSE
1704:             UPDATE (loc_cCursor) SET lMarca = 0
1705:             THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
1706:         ENDIF
1707: 
1708:         THIS.grd_4c_Produtos.Refresh()
1709:     ENDPROC
1710: 
1711:     *==========================================================================
1712:     * ColValAtuValid - Transcreve o PROCEDURE Valid do Column5.Text1 legado:
1713:     * marca Manual=1 no cursor quando o usuario altera manualmente o Preco
1714:     * Atual (a insercao de linha em branco no fim, que o legado faz junto
1715:     * disso para o modo de digitacao manual de produto, fica para quando o
1716:     * modo "Produtos"/chkAuditado for wireado, em fase posterior).
1717:     *==========================================================================
1718:     PROCEDURE ColValAtuValid()
1719:         LOCAL loc_oBO, loc_cCursor, loc_nValorNovo, loc_nValorAtual, loc_lAlterado

*-- Linhas 1727 a 1761:
1727:         loc_lAlterado = .F.
1728:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1729:             loc_nValorNovo = THIS.grd_4c_Produtos.Column5.Text1.Value
1730:             SELECT (loc_cCursor)
1731:             loc_nValorAtual = ValAtu
1732:             loc_lAlterado   = (loc_nValorAtual <> loc_nValorNovo)
1733:             IF loc_oBO.this_lLibValAtu AND loc_lAlterado
1734:                 REPLACE Manual WITH 1 IN (loc_cCursor)
1735:             ENDIF
1736: 
1737:             *-- Legado (modo "Produtos"): "If This.Value <> ThisForm.AntValue Or
1738:             *-- Lastkey() = 13" - ao confirmar o Preco Atual de uma linha recem
1739:             *-- preenchida manualmente, insere OUTRA linha em branco no fim e
1740:             *-- desce o cursor para ela (o guard !Empty(CPros) evita duplicar a
1741:             *-- linha em branco quando o usuario so passa pela coluna sem
1742:             *-- preencher produto nenhum)
1743:             IF loc_oBO.this_lAuditado AND (loc_lAlterado OR LASTKEY() = 13)
1744:                 SELECT (loc_cCursor)
1745:                 IF !EMPTY(ALLTRIM(NVL(CPros, "")))
1746:                     INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
1747:                 ENDIF
1748:                 THIS.grd_4c_Produtos.Refresh()
1749:                 KEYBOARD "{DNARROW}"
1750:             ENDIF
1751:         ENDIF
1752: 
1753:         RETURN .T.
1754:     ENDPROC
1755: 
1756:     *==========================================================================
1757:     * Column1CheckWhen - Equivalente ao When do Column1.Check1 legado: impede
1758:     * marcar (Space no Check1) a linha em branco que o modo "Produtos" deixa
1759:     * no fim da grade enquanto o Produto ainda nao foi digitado.
1760:     *==========================================================================
1761:     PROCEDURE Column1CheckWhen()

*-- Linhas 1808 a 1826:
1808:                 IF USED("cursor_4c_LkpProdutoManual")
1809:                     USE IN cursor_4c_LkpProdutoManual
1810:                 ENDIF
1811:                 IF SQLEXEC(gnConnHandle, "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor), ;
1812:                         "cursor_4c_LkpProdutoManual") > 0 AND ;
1813:                    USED("cursor_4c_LkpProdutoManual") AND RECCOUNT("cursor_4c_LkpProdutoManual") > 0
1814:                     loc_lAchou = .T.
1815:                 ENDIF
1816:                 IF USED("cursor_4c_LkpProdutoManual")
1817:                     USE IN cursor_4c_LkpProdutoManual
1818:                 ENDIF
1819:             CATCH TO loc_oErro
1820:                 MsgErro(loc_oErro.Message, "FormSigPrApr.Column2Valid")
1821:             ENDTRY
1822: 
1823:             IF !loc_lAchou
1824:                 THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", "Produtos", loc_cValor, loc_oGrid.Column2.Text1, .NULL.)
1825:             ENDIF
1826:         ENDIF

*-- Linhas 1863 a 1886:
1863:             *-- Legado: sem permissao de editar o Preco Atual (Column5
1864:             *-- ficaria travada), insere OUTRA linha em branco e desce
1865:             *-- direto para ela; COM permissao, deixa o tab natural levar
1866:             *-- para Column5 (o insert/desce fica por conta do
1867:             *-- ColValAtuValid nesse caso, ao confirmar o preco)
1868:             IF !loc_oBO.this_lLibValAtu AND USED(loc_cCursor)
1869:                 SELECT (loc_cCursor)
1870:                 IF !EMPTY(ALLTRIM(NVL(CPros, "")))
1871:                     INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
1872:                 ENDIF
1873:                 loc_oGrid.Refresh()
1874:                 KEYBOARD "{DNARROW}"
1875:             ELSE
1876:                 loc_oGrid.Refresh()
1877:             ENDIF
1878:         ELSE
1879:             MsgAviso("Produto n" + CHR(227) + "o encontrado" + CHR(33) + CHR(33) + CHR(33) + CHR(13) + ;
1880:                 "Reinicie o processo.", "Aten" + CHR(231) + CHR(227) + "o")
1881:         ENDIF
1882:     ENDPROC
1883: 
1884:     *==========================================================================
1885:     * GridAfterRowColChange - Equivalente ao AfterRowColChange do Grd_Produto
1886:     * legado: carrega a foto do produto (SigCdPro.FigJpgs, base64) da linha

*-- Linhas 1916 a 1934:
1916:             IF USED("cursor_4c_FotoProduto")
1917:                 USE IN cursor_4c_FotoProduto
1918:             ENDIF
1919:             SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros), "cursor_4c_FotoProduto")
1920: 
1921:             IF USED("cursor_4c_FotoProduto") AND !EOF("cursor_4c_FotoProduto") AND ;
1922:                !ISNULL(cursor_4c_FotoProduto.FigJpgs) AND !EMPTY(cursor_4c_FotoProduto.FigJpgs)
1923:                 loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1924:                 STRTOFILE(STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoProduto.FigJpgs, ;
1925:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), "data:image/jpg;base64,", ""), 14), ;
1926:                     loc_cArqFig)
1927:                 THIS.img_4c_FigJpg.Picture = loc_cArqFig
1928:                 THIS.img_4c_FigJpg.Visible = .T.
1929:             ENDIF
1930: 
1931:             IF USED("cursor_4c_FotoProduto")
1932:                 USE IN cursor_4c_FotoProduto
1933:             ENDIF
1934:         CATCH TO loc_oErro

*-- Linhas 1994 a 2049:
1994:     * e o modo "Produtos" (inclusao manual de UM item, digitado direto na
1995:     * grade). Ligar o modo desabilita os filtros e a Column1/libera a
1996:     * Column2; desligar devolve o estado normal e remove a linha em branco
1997:     * corrente (legado: "Delete From CrProdutos" sem escopo = so o registro
1998:     * ATUAL, que SET DELETED ON global esconde sem precisar de PACK).
1999:     *==========================================================================
2000:     PROCEDURE ChkAuditadoClick()
2001:         LOCAL loc_oBO, loc_cCursor, loc_oGrid
2002: 
2003:         loc_oBO = THIS.this_oBusinessObject
2004:         IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2005:             RETURN
2006:         ENDIF
2007:         loc_cCursor = loc_oBO.this_cCursorItens
2008:         loc_oGrid   = THIS.grd_4c_Produtos
2009: 
2010:         loc_oBO.this_lAuditado = (THIS.chk_4c_Auditado.Value = 1)
2011: 
2012:         IF loc_oBO.this_lAuditado
2013:             IF USED(loc_cCursor)
2014:                 INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
2015:                 SELECT (loc_cCursor)
2016:                 SET ORDER TO
2017:                 GO TOP
2018:             ENDIF
2019:             THIS.txt_4c_CdGrupo.Enabled  = .F.
2020:             THIS.txt_4c_AteGrupo.Enabled = .F.
2021:             THIS.txt_4c_Colecao.Enabled  = .F.
2022:             THIS.txt_4c_Moeda.Enabled    = .F.
2023:             THIS.txt_4c_MarkUp1.Enabled  = .F.
2024:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2025:                 THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
2026:             ENDIF
2027:             loc_oGrid.Column1.Check1.ReadOnly = .T.
2028:             loc_oGrid.Column2.Text1.ReadOnly  = .F.
2029:             loc_oGrid.Refresh()
2030:             loc_oGrid.Column2.Text1.SetFocus()
2031:         ELSE
2032:             IF USED(loc_cCursor)
2033:                 SELECT (loc_cCursor)
2034:                 DELETE
2035:                 SET ORDER TO CPros
2036:                 GO TOP
2037:             ENDIF
2038:             THIS.txt_4c_CdGrupo.Enabled  = .T.
2039:             THIS.txt_4c_AteGrupo.Enabled = .T.
2040:             THIS.txt_4c_Colecao.Enabled  = .T.
2041:             THIS.txt_4c_Moeda.Enabled    = .T.
2042:             THIS.txt_4c_MarkUp1.Enabled  = .T.
2043:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2044:                 THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
2045:             ENDIF
2046:             loc_oGrid.Column1.Check1.ReadOnly = .F.
2047:             loc_oGrid.Column2.Text1.ReadOnly  = .T.
2048:             loc_oGrid.Refresh()
2049:             THIS.txt_4c_CdGrupo.SetFocus()

*-- Linhas 2091 a 2109:
2091: 
2092:     *==========================================================================
2093:     * BtnAtualizarClick - Transcreve o PROCEDURE Atualiza.Click do legado. A
2094:     * parte de GRAVACAO (snapshot SigCdPrc + recalculo + UPDATE SigCdPro +
2095:     * historico SigPrCp2 + limpeza SigPrPrt/SigPrPmi + vinculo de promocao,
2096:     * tudo numa unica transacao) ja esta implementada em
2097:     * SigPrAprBO.Atualizar() desde a Fase 1/2 - este metodo so precisa
2098:     * acionar o contrato BusinessBase (EditarRegistro()+Salvar()) apos as
2099:     * mesmas duas confirmacoes do legado.
2100:     *
2101:     * BO.Salvar()/Atualizar() ja exibem a falha sozinhos (BusinessBase.
2102:     * ExibirFalha) em caso de erro - nenhum ELSE necessario aqui (regra #20).
2103:     *
2104:     * Legado: "This.Enabled = .F." roda INCONDICIONALMENTE ao final do Click
2105:     * (haja ou nao confirmado a atualizacao) - Atualizar so volta a ligar no
2106:     * proximo Processar bem sucedido.
2107:     *==========================================================================
2108:     PROCEDURE BtnAtualizarClick()
2109:         LOCAL loc_oBO, loc_cCursor, loc_lImprimirEtiquetas

*-- Linhas 2116 a 2134:
2116: 
2117:                 loc_cCursor = loc_oBO.this_cCursorItens
2118:                 IF USED(loc_cCursor)
2119:                     SELECT (loc_cCursor)
2120:                     LOCATE FOR lMarca = 1
2121:                 ENDIF
2122: 
2123:                 IF !USED(loc_cCursor) OR !FOUND()
2124:                     MsgAviso("Nenhum Produto Selecionado" + CHR(33) + CHR(33) + CHR(33), ;
2125:                         "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2126:                     IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
2127:                         THIS.grd_4c_Produtos.SetFocus()
2128:                     ENDIF
2129:                 ELSE
2130:                     loc_lImprimirEtiquetas = MsgConfirma( ;
2131:                         "Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
2132:                     loc_oBO.this_lImprimirEtiquetas = loc_lImprimirEtiquetas
2133: 
2134:                     loc_oBO.EditarRegistro()

