# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2728 linhas total):

*-- Linhas 24 a 42:
24: 
25:     this_oBusinessObject = .NULL.
26:     this_cMensagemErro   = ""
27:     this_lAllSelected    = .T.
28:     this_lInCol5         = .F.
29:     this_nAntValAtu      = 0
30: 
31:     *==========================================================================
32:     * Init
33:     *==========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *==========================================================================
39:     * Destroy - Libera cursores de trabalho
40:     *==========================================================================
41:     PROCEDURE Destroy()
42:         LOCAL loc_aCursors, loc_nI

*-- Linhas 77 a 120:
77:                         USE IN cursor_4c_Produtos
78:                     ENDIF
79:                     SET NULL ON
80:                     CREATE CURSOR cursor_4c_Produtos ( ;
81:                         lMarca  N(1)    NULL, ;
82:                         CPros   C(14)   NULL, ;
83:                         DPros   C(40)   NULL, ;
84:                         ValAnt  N(14,2) NULL, ;
85:                         ValAtu  N(14,2) NULL, ;
86:                         fCustos N(8,3)  NULL, ;
87:                         MoePcs  C(3)    NULL, ;
88:                         CustoFs N(12,3) NULL, ;
89:                         Manual  N(1)    NULL  ;
90:                     )
91:                     SET NULL OFF
92:                     INDEX ON CPros TAG CPros
93:                     SELECT cursor_4c_Produtos
94:                     SET ORDER TO
95:                     GO TOP
96: 
97:                     *-- Cursor de produtos temp (SigCdPro) vazio
98:                     IF USED("cursor_4c_TmpPro")
99:                         USE IN cursor_4c_TmpPro
100:                     ENDIF
101:                     LOCAL loc_nR
102:                     loc_nR = SQLEXEC(gnConnHandle, ;
103:                         "SELECT * FROM SigCdPro WHERE 0 = 1", "cursor_4c_TmpPro")
104:                     IF loc_nR > 0
105:                         SELECT cursor_4c_TmpPro
106:                         INDEX ON CPros TAG CPros
107:                         GO TOP
108:                     ENDIF
109: 
110:                     THIS.ConfigurarPageFrame()
111:                     THIS.Caption = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
112:                     THIS.ConfigurarPaginaLista()
113:                     THIS.ConfigurarPaginaDados()
114: 
115:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
116:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
117: 
118:                     THIS.TornarControlesVisiveis(THIS)
119: 
120:                     *-- Visibilidade inicial por tipo (Tipo 1 = Variacao)

*-- Linhas 996 a 1014:
996:             .HeaderHeight = 20
997:             .RowHeight    = 16
998:             .ScrollBars   = 2
999:             .DeleteMark   = .F.
1000:             .RecordMark   = .F.
1001:             .GridLines    = 3
1002:             .ColumnCount  = 5
1003: 
1004:             *-- Column1: CheckBox de selecao (lMarca)
1005:             WITH .Column1
1006:                 .Width         = 20
1007:                 .Alignment     = 3
1008:                 .Movable       = .F.
1009:                 .Resizable     = .F.
1010:                 .Sparse        = .F.
1011:                 .FontName      = "Verdana"
1012:                 .FontSize      = 8
1013:                 .Header1.Caption   = ""
1014:                 .Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"

*-- Linhas 1073 a 1104:
1073:             ENDWITH
1074:         ENDWITH
1075: 
1076:         *-- CheckBox em Column1 DEVE ser adicionado ANTES do ControlSource (regra Error 1767)
1077:         THIS.grd_4c_Produtos.Column1.AddObject("Check1", "CheckBox")
1078:         THIS.grd_4c_Produtos.Column1.Check1.Caption = ""
1079:         THIS.grd_4c_Produtos.Column1.Check1.Value   = 0
1080:         THIS.grd_4c_Produtos.Column1.CurrentControl = "Check1"
1081: 
1082:         *-- Define RecordSource FORA do WITH para evitar auto-bind sobrescrever ControlSources
1083:         THIS.grd_4c_Produtos.ColumnCount = 5
1084:         THIS.grd_4c_Produtos.RecordSource = "cursor_4c_Produtos"
1085:         THIS.grd_4c_Produtos.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1086:         THIS.grd_4c_Produtos.Column2.ControlSource = "cursor_4c_Produtos.CPros"
1087:         THIS.grd_4c_Produtos.Column3.ControlSource = "cursor_4c_Produtos.DPros"
1088:         THIS.grd_4c_Produtos.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1089:         THIS.grd_4c_Produtos.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1090: 
1091:         *-- Caption e ReadOnly do Column5 conforme acesso VMANUAL
1092:         LOCAL loc_lLibValAtu
1093:         loc_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
1094:         IF loc_lLibValAtu
1095:             THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
1096:             THIS.grd_4c_Produtos.Column5.ReadOnly = .F.
1097:         ELSE
1098:             THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
1099:             THIS.grd_4c_Produtos.Column5.Header1.Picture = gc_4c_CaminhoIcones + "lock.bmp"
1100:             THIS.grd_4c_Produtos.Column5.ReadOnly = .T.
1101:         ENDIF
1102: 
1103:         *-- Column2 come?a ReadOnly (modo normal; auditor inverte)
1104:         THIS.grd_4c_Produtos.Column2.ReadOnly = .T.

*-- Linhas 1155 a 1186:
1155: 
1156:         *-- Zera o cursor do grid de produtos
1157:         IF USED("cursor_4c_Produtos")
1158:             SELECT cursor_4c_Produtos
1159:             IF RECCOUNT() > 0
1160:                 ZAP
1161:             ENDIF
1162:         ENDIF
1163: 
1164:         *-- Desabilita o botao Atualizar (fica ativo apenas apos Processar)
1165:         IF VARTYPE(THIS.cmg_4c_Acao) = "O"
1166:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
1167:             THIS.cmg_4c_Acao.Buttons(2).Refresh
1168:         ENDIF
1169: 
1170:         *-- Reseta selecao global do header (checkbox da coluna 1)
1171:         THIS.this_lAllSelected = .T.
1172:         THIS.this_lInCol5      = .F.
1173:         THIS.this_nAntValAtu   = 0
1174: 
1175:         IF loc_nModo = 1
1176:             *-- Reset COMPLETO: limpa TODOS os campos de filtro/parametros
1177:             IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
1178:                 THIS.txt_4c_CdGrupo.Value  = ""
1179:             ENDIF
1180:             IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
1181:                 THIS.txt_4c_AteGrupo.Value = ""
1182:             ENDIF
1183:             IF VARTYPE(THIS.txt_4c_Col)      = "O"
1184:                 THIS.txt_4c_Col.Value      = ""
1185:             ENDIF
1186:             IF VARTYPE(THIS.txt_4c_Conta)    = "O"

*-- Linhas 1413 a 1465:
1413:         IF !USED("cursor_4c_Produtos")
1414:             RETURN
1415:         ENDIF
1416:         IF THIS.this_lAllSelected
1417:             UPDATE cursor_4c_Produtos SET lMarca = 0
1418:             THIS.this_lAllSelected = .F.
1419:         ELSE
1420:             UPDATE cursor_4c_Produtos SET lMarca = 1
1421:             THIS.this_lAllSelected = .T.
1422:         ENDIF
1423:         THIS.grd_4c_Produtos.Refresh
1424:         THIS.Refresh
1425:     ENDPROC
1426: 
1427:     *==========================================================================
1428:     * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
1429:     * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
1430:     *==========================================================================
1431:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1432:         LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros
1433: 
1434:         IF !USED("cursor_4c_Produtos")
1435:             RETURN
1436:         ENDIF
1437:         SELECT cursor_4c_Produtos
1438: 
1439:         *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
1440:         IF par_nColIndex != 5 AND THIS.this_lInCol5
1441:             IF !EOF("cursor_4c_Produtos") AND ;
1442:                NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
1443:                 REPLACE Manual WITH 1 IN cursor_4c_Produtos
1444:                 *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
1445:                 *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
1446:                 IF THIS.this_oBusinessObject.this_lLibValAtu
1447:                     SET ORDER TO
1448:                     GO BOTTOM
1449:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1450:                         INSERT INTO cursor_4c_Produtos ;
1451:                             (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1452:                             VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
1453:                     ENDIF
1454:                     THIS.grd_4c_Produtos.Refresh
1455:                 ENDIF
1456:             ENDIF
1457:             THIS.this_lInCol5 = .F.
1458:         ENDIF
1459:         IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
1460:             THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
1461:             THIS.this_lInCol5    = .T.
1462:         ENDIF
1463: 
1464:         *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
1465:         IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;

*-- Linhas 1476 a 1561:
1476:             IF USED("cursor_4c_FigTmp")
1477:                 USE IN cursor_4c_FigTmp
1478:             ENDIF
1479:             loc_nResult = SQLEXEC(gnConnHandle, ;
1480:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1481:                 EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros)), ;
1482:                 "cursor_4c_FigTmp")
1483:             THIS.img_4c_Foto.Visible = .F.
1484:             THIS.img_4c_Foto.Picture = ""
1485:             IF loc_nResult > 0 AND !EOF("cursor_4c_FigTmp")
1486:                 SELECT cursor_4c_FigTmp
1487:                 IF !ISNULL(cursor_4c_FigTmp.FigJpgs) AND ;
1488:                    !EMPTY(ALLTRIM(NVL(cursor_4c_FigTmp.FigJpgs, "")))
1489:                     CLEAR RESOURCES
1490:                     loc_lcFoto = STRCONV( ;
1491:                         STRTRAN(STRTRAN(STRTRAN( ;
1492:                             cursor_4c_FigTmp.FigJpgs, ;
1493:                             "data:image/png;base64,",  ""), ;
1494:                             "data:image/jpeg;base64,", ""), ;
1495:                             "data:image/jpg;base64,",  ""), 14)
1496:                     STRTOFILE(loc_lcFoto, loc_lcArqFig)
1497:                     THIS.img_4c_Foto.Picture = loc_lcArqFig
1498:                     THIS.img_4c_Foto.Visible = .T.
1499:                 ENDIF
1500:             ENDIF
1501:             IF USED("cursor_4c_FigTmp")
1502:                 USE IN cursor_4c_FigTmp
1503:             ENDIF
1504:         ELSE
1505:             THIS.img_4c_Foto.Visible = .F.
1506:             THIS.img_4c_Foto.Picture = ""
1507:         ENDIF
1508: 
1509:         SELECT cursor_4c_Produtos
1510:     ENDPROC
1511: 
1512:     *==========================================================================
1513:     * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
1514:     * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
1515:     *==========================================================================
1516:     PROCEDURE CarregarProdutoAuditado(par_cCPros)
1517:         LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1518:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
1519: 
1520:         IF EMPTY(ALLTRIM(par_cCPros))
1521:             RETURN
1522:         ENDIF
1523: 
1524:         *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
1525:         IF USED("cursor_4c_ProdAud")
1526:             USE IN cursor_4c_ProdAud
1527:         ENDIF
1528:         loc_nResult = SQLEXEC(gnConnHandle, ;
1529:             "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
1530:             "cursor_4c_ProdAud")
1531:         IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
1532:             IF USED("cursor_4c_ProdAud")
1533:                 USE IN cursor_4c_ProdAud
1534:             ENDIF
1535:             THIS.AbrirBuscaProdutoGrd()
1536:             RETURN
1537:         ENDIF
1538: 
1539:         *-- Insere no cursor_4c_TmpPro se ainda nao existe
1540:         IF USED("cursor_4c_TmpPro")
1541:             IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1542:                 SELECT cursor_4c_ProdAud
1543:                 GO TOP
1544:                 LOCAL loc_oErroIns
1545:                 TRY
1546:                     SELECT cursor_4c_TmpPro
1547:                     APPEND BLANK
1548:                     *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
1549:                     REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
1550:                     REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
1551:                     REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
1552:                     REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
1553:                     REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
1554:                     REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
1555:                     REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
1556:                     REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)
1557:                     REPLACE MoeVs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeVs,    ""))
1558:                     REPLACE MoeCs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCs,    ""))
1559:                     REPLACE MoePcs   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoePcs,   ""))
1560:                     REPLACE MoeCusFs WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCusFs, ""))
1561:                     REPLACE Moedas   WITH ALLTRIM(NVL(cursor_4c_ProdAud.Moedas,   ""))

*-- Linhas 1572 a 1590:
1572: 
1573:         *-- Calcula novo preco conforme tipo
1574:         IF USED("cursor_4c_TmpPro") AND SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1575:             SELECT cursor_4c_TmpPro
1576:             GO TOP
1577:             loc_nTipo     = THIS.opt_4c_Tipo.Value
1578:             loc_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
1579:             loc_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
1580: 
1581:             DO CASE
1582:             CASE loc_nTipo = 1
1583:                 loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
1584:                               (NVL(cursor_4c_TmpPro.PVens, 0) * loc_nVariacao / 100)
1585:             CASE loc_nTipo = 2
1586:                 loc_nValAtu = THIS.this_oBusinessObject.CalcPreco(loc_nMarkUp2)
1587:             CASE loc_nTipo = 3
1588:                 loc_nCotId = fBuscarCotacao( ;
1589:                     ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
1590:                 loc_nCotVd = fBuscarCotacao( ;

*-- Linhas 1599 a 1691:
1599:             ENDCASE
1600: 
1601:             *-- Atualiza registro corrente em cursor_4c_Produtos
1602:             SELECT cursor_4c_Produtos
1603:             REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros, ""))
1604:             REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros, ""))
1605:             REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
1606:             REPLACE ValAtu  WITH loc_nValAtu
1607:             REPLACE lMarca  WITH 1
1608:             REPLACE Manual  WITH 0
1609:             REPLACE fCustos WITH NVL(cursor_4c_TmpPro.fCustos, 0)
1610:             REPLACE CustoFs WITH NVL(cursor_4c_TmpPro.CustoFs, 0)
1611:             REPLACE MoePcs  WITH ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, ""))
1612: 
1613:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
1614: 
1615:             *-- Adiciona linha vazia abaixo se nao houver
1616:             IF !THIS.this_oBusinessObject.this_lLibValAtu
1617:                 SELECT cursor_4c_Produtos
1618:                 SET ORDER TO
1619:                 GO BOTTOM
1620:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1621:                     INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1622:                         VALUES (0, SPACE(14), SPACE(40), 0, 0)
1623:                 ENDIF
1624:                 SELECT cursor_4c_Produtos
1625:                 THIS.grd_4c_Produtos.Refresh
1626:             ENDIF
1627:         ENDIF
1628: 
1629:         IF USED("cursor_4c_ProdAud")
1630:             USE IN cursor_4c_ProdAud
1631:         ENDIF
1632:     ENDPROC
1633: 
1634:     *==========================================================================
1635:     * ChkAuditadoClick - Alterna modo de entrada manual de produtos
1636:     *==========================================================================
1637:     PROCEDURE ChkAuditadoClick()
1638:         IF THIS.chk_4c_Auditado.Value = 1
1639:             *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
1640:             IF USED("cursor_4c_Produtos")
1641:                 LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
1642:                 loc_lMarca_v = 0
1643:                 loc_cCPros_v = SPACE(14)
1644:                 loc_cDPros_v = SPACE(40)
1645:                 loc_nValAtu_v = 0
1646:                 loc_nValAnt_v = 0
1647:                 INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1648:                     VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
1649:                 SELECT cursor_4c_Produtos
1650:                 SET ORDER TO
1651:                 GO TOP
1652:             ENDIF
1653:             THIS.txt_4c_CdGrupo.Enabled  = .F.
1654:             THIS.txt_4c_AteGrupo.Enabled = .F.
1655:             THIS.txt_4c_Col.Enabled      = .F.
1656:             THIS.txt_4c_Moeda.Enabled    = .F.
1657:             THIS.txt_4c_MarkUp1.Enabled  = .F.
1658:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
1659:             THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
1660:             THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
1661:             THIS.grd_4c_Produtos.Column2.SetFocus
1662:             THIS.grd_4c_Produtos.Refresh
1663:         ELSE
1664:             *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
1665:             IF USED("cursor_4c_Produtos")
1666:                 DELETE FROM cursor_4c_Produtos
1667:             ENDIF
1668:             THIS.txt_4c_CdGrupo.Enabled  = .T.
1669:             THIS.txt_4c_AteGrupo.Enabled = .T.
1670:             THIS.txt_4c_Col.Enabled      = .T.
1671:             THIS.txt_4c_Moeda.Enabled    = .T.
1672:             THIS.txt_4c_MarkUp1.Enabled  = .T.
1673:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
1674:             THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
1675:             THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
1676:             SELECT cursor_4c_Produtos
1677:             SET ORDER TO CPros
1678:             GO TOP
1679:             THIS.grd_4c_Produtos.Refresh
1680:             THIS.txt_4c_CdGrupo.SetFocus
1681:         ENDIF
1682:     ENDPROC
1683: 
1684:     *==========================================================================
1685:     * Lookup helpers
1686:     *==========================================================================
1687: 
1688:     *-- Helper generico para SigCdMoe
1689:     PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
1690:         LOCAL loc_cValor, loc_oForm
1691:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

*-- Linhas 1764 a 1783:
1764:         IF EMPTY(loc_cVal)
1765:             RETURN
1766:         ENDIF
1767:         loc_nR = SQLEXEC(gnConnHandle, ;
1768:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1769:             "cursor_4c_ValGrp")
1770:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1771:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1772:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1773:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1774:             ENDIF
1775:         ELSE
1776:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1777:             THIS.txt_4c_CdGrupo.Value = ""
1778:             THIS.AbrirBuscaCdGrupo()
1779:         ENDIF
1780:         IF USED("cursor_4c_ValGrp")
1781:             USE IN cursor_4c_ValGrp
1782:         ENDIF
1783:     ENDPROC

*-- Linhas 1828 a 1847:
1828:         IF EMPTY(loc_cVal)
1829:             RETURN
1830:         ENDIF
1831:         loc_nR = SQLEXEC(gnConnHandle, ;
1832:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1833:             "cursor_4c_ValGrp")
1834:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1835:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1836:         ELSE
1837:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1838:             THIS.txt_4c_AteGrupo.Value = ""
1839:             THIS.AbrirBuscaAteGrupo()
1840:         ENDIF
1841:         IF USED("cursor_4c_ValGrp")
1842:             USE IN cursor_4c_ValGrp
1843:         ENDIF
1844:     ENDPROC
1845: 
1846:     *==========================================================================
1847:     * Lookups - SigCdCol

*-- Linhas 1889 a 1908:
1889:         IF EMPTY(loc_cVal)
1890:             RETURN
1891:         ENDIF
1892:         loc_nR = SQLEXEC(gnConnHandle, ;
1893:             "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
1894:             "cursor_4c_ValCol")
1895:         IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
1896:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
1897:         ELSE
1898:             MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
1899:             THIS.txt_4c_Col.Value = ""
1900:             THIS.AbrirBuscaCol()
1901:         ENDIF
1902:         IF USED("cursor_4c_ValCol")
1903:             USE IN cursor_4c_ValCol
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     *==========================================================================
1908:     * Lookups - SigCdMoe (Moeda - Tipo 2)

*-- Linhas 1927 a 1946:
1927:         IF EMPTY(loc_cVal)
1928:             RETURN
1929:         ENDIF
1930:         loc_nR = SQLEXEC(gnConnHandle, ;
1931:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1932:             "cursor_4c_ValMoe")
1933:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1934:             THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1935:         ELSE
1936:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1937:             THIS.txt_4c_Moeda.Value = ""
1938:             THIS.AbrirBuscaMoeda()
1939:         ENDIF
1940:         IF USED("cursor_4c_ValMoe")
1941:             USE IN cursor_4c_ValMoe
1942:         ENDIF
1943:     ENDPROC
1944: 
1945:     *==========================================================================
1946:     * Lookups - SigCdMoe (Moecs)

*-- Linhas 1965 a 1984:
1965:         IF EMPTY(loc_cVal)
1966:             RETURN
1967:         ENDIF
1968:         loc_nR = SQLEXEC(gnConnHandle, ;
1969:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1970:             "cursor_4c_ValMoe")
1971:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1972:             THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1973:         ELSE
1974:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1975:             THIS.txt_4c_Moecs.Value = ""
1976:             THIS.AbrirBuscaMoecs()
1977:         ENDIF
1978:         IF USED("cursor_4c_ValMoe")
1979:             USE IN cursor_4c_ValMoe
1980:         ENDIF
1981:     ENDPROC
1982: 
1983:     *==========================================================================
1984:     * Lookups - SigCdMoe (MoeCusFs)

*-- Linhas 2003 a 2022:
2003:         IF EMPTY(loc_cVal)
2004:             RETURN
2005:         ENDIF
2006:         loc_nR = SQLEXEC(gnConnHandle, ;
2007:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2008:             "cursor_4c_ValMoe")
2009:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2010:             THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2011:         ELSE
2012:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2013:             THIS.txt_4c_MoeCusFs.Value = ""
2014:             THIS.AbrirBuscaMoeCusFs()
2015:         ENDIF
2016:         IF USED("cursor_4c_ValMoe")
2017:             USE IN cursor_4c_ValMoe
2018:         ENDIF
2019:     ENDPROC
2020: 
2021:     *==========================================================================
2022:     * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)

*-- Linhas 2041 a 2060:
2041:         IF EMPTY(loc_cVal)
2042:             RETURN
2043:         ENDIF
2044:         loc_nR = SQLEXEC(gnConnHandle, ;
2045:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2046:             "cursor_4c_ValMoe")
2047:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2048:             THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2049:         ELSE
2050:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2051:             THIS.txt_4c_Moedas.Value = ""
2052:             THIS.AbrirBuscaMoedas()
2053:         ENDIF
2054:         IF USED("cursor_4c_ValMoe")
2055:             USE IN cursor_4c_ValMoe
2056:         ENDIF
2057:     ENDPROC
2058: 
2059:     *==========================================================================
2060:     * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)

*-- Linhas 2079 a 2098:
2079:         IF EMPTY(loc_cVal)
2080:             RETURN
2081:         ENDIF
2082:         loc_nR = SQLEXEC(gnConnHandle, ;
2083:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2084:             "cursor_4c_ValMoe")
2085:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2086:             THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2087:         ELSE
2088:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2089:             THIS.txt_4c_MoeCusto.Value = ""
2090:             THIS.AbrirBuscaMoeCusto()
2091:         ENDIF
2092:         IF USED("cursor_4c_ValMoe")
2093:             USE IN cursor_4c_ValMoe
2094:         ENDIF
2095:     ENDPROC
2096: 
2097:     *==========================================================================
2098:     * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)

*-- Linhas 2117 a 2136:
2117:         IF EMPTY(loc_cVal)
2118:             RETURN
2119:         ENDIF
2120:         loc_nR = SQLEXEC(gnConnHandle, ;
2121:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2122:             "cursor_4c_ValMoe")
2123:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2124:             THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2125:         ELSE
2126:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2127:             THIS.txt_4c_MoeVs.Value = ""
2128:             THIS.AbrirBuscaMoeVs()
2129:         ENDIF
2130:         IF USED("cursor_4c_ValMoe")
2131:             USE IN cursor_4c_ValMoe
2132:         ENDIF
2133:     ENDPROC
2134: 
2135:     *==========================================================================
2136:     * Lookups - SigPrFti (CFtios = Feitio)

*-- Linhas 2177 a 2196:
2177:         IF EMPTY(loc_cVal)
2178:             RETURN
2179:         ENDIF
2180:         loc_nR = SQLEXEC(gnConnHandle, ;
2181:             "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
2182:             "cursor_4c_ValFtio")
2183:         IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
2184:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
2185:         ELSE
2186:             MsgAviso("Feitio n" + CHR(227) + "o encontrado.", "")
2187:             THIS.txt_4c_CFtios.Value = ""
2188:             THIS.AbrirBuscaCFtios()
2189:         ENDIF
2190:         IF USED("cursor_4c_ValFtio")
2191:             USE IN cursor_4c_ValFtio
2192:         ENDIF
2193:     ENDPROC
2194: 
2195:     *==========================================================================
2196:     * Lookups - Fornecedor via fAcessoContas (Conta / DConta)

*-- Linhas 2304 a 2323:
2304:         IF EMPTY(loc_cVal)
2305:             RETURN
2306:         ENDIF
2307:         loc_nR = SQLEXEC(gnConnHandle, ;
2308:             "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
2309:             "cursor_4c_ValPmc")
2310:         IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
2311:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
2312:         ELSE
2313:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
2314:             THIS.txt_4c_Promo.Value = ""
2315:             THIS.AbrirBuscaPromo()
2316:         ENDIF
2317:         IF USED("cursor_4c_ValPmc")
2318:             USE IN cursor_4c_ValPmc
2319:         ENDIF
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a

*-- Linhas 2387 a 2405:
2387:         LOCAL loc_oErro
2388:         TRY
2389:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2390:                 SELECT cursor_4c_Produtos
2391:                 GO TOP
2392:                 THIS.grd_4c_Produtos.Refresh
2393:                 THIS.Refresh
2394:             ELSE
2395:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
2396:                          "para visualizar. Execute o Processar primeiro.", "Aviso")
2397:             ENDIF
2398:         CATCH TO loc_oErro
2399:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2400:         ENDTRY
2401:     ENDPROC
2402: 
2403:     *==========================================================================
2404:     * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
2405:     *   Permite reprocessar com os mesmos parametros mas lista limpa

*-- Linhas 2430 a 2448:
2430:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2431:             RETURN
2432:         ENDIF
2433:         SELECT cursor_4c_Produtos
2434:         loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
2435: 
2436:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2437:             "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
2438:             "Produtos")
2439:         IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2440:             RETURN
2441:         ENDIF
2442: 
2443:         IF !loc_oForm.this_lAchouRegistro
2444:             loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2445:             loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2446:             loc_oForm.Show()
2447:         ENDIF
2448: 

*-- Linhas 2455 a 2478:
2455:         ENDIF
2456: 
2457:         IF !EMPTY(loc_cSelecionado)
2458:             SELECT cursor_4c_Produtos
2459:             REPLACE CPros WITH loc_cSelecionado
2460:             THIS.grd_4c_Produtos.Refresh
2461:             THIS.CarregarProdutoAuditado(loc_cSelecionado)
2462:         ELSE
2463:             SELECT cursor_4c_Produtos
2464:             IF !EOF("cursor_4c_Produtos")
2465:                 REPLACE CPros WITH SPACE(14)
2466:             ENDIF
2467:             THIS.grd_4c_Produtos.Refresh
2468:         ENDIF
2469:         loc_oForm.Release()
2470:     ENDPROC
2471: 
2472:     *==========================================================================
2473:     * FormParaBO - Transfere todos os campos do form para propriedades do BO
2474:     * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
2475:     *==========================================================================
2476:     PROCEDURE FormParaBO()
2477:         LOCAL loc_oBO
2478:         loc_oBO = THIS.this_oBusinessObject

*-- Linhas 2651 a 2669:
2651:     *==========================================================================
2652:     PROCEDURE CarregarLista()
2653:         IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2654:             SELECT cursor_4c_Produtos
2655:             GO TOP
2656:             IF VARTYPE(THIS.grd_4c_Produtos) = "O"
2657:                 THIS.grd_4c_Produtos.Refresh
2658:             ENDIF
2659:         ENDIF
2660:     ENDPROC
2661: 
2662:     *==========================================================================
2663:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
2664:     * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
2665:     * apos reset; habilita Atualizar apos Processar com sucesso.
2666:     * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
2667:     *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
2668:     *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
2669:     *==========================================================================

