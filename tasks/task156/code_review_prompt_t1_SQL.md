# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2727 linhas total):

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

*-- Linhas 1412 a 1464:
1412:         IF !USED("cursor_4c_Produtos")
1413:             RETURN
1414:         ENDIF
1415:         IF THIS.this_lAllSelected
1416:             UPDATE cursor_4c_Produtos SET lMarca = 0
1417:             THIS.this_lAllSelected = .F.
1418:         ELSE
1419:             UPDATE cursor_4c_Produtos SET lMarca = 1
1420:             THIS.this_lAllSelected = .T.
1421:         ENDIF
1422:         THIS.grd_4c_Produtos.Refresh
1423:         THIS.Refresh
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
1428:     * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
1429:     *==========================================================================
1430:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1431:         LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros
1432: 
1433:         IF !USED("cursor_4c_Produtos")
1434:             RETURN
1435:         ENDIF
1436:         SELECT cursor_4c_Produtos
1437: 
1438:         *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
1439:         IF par_nColIndex != 5 AND THIS.this_lInCol5
1440:             IF !EOF("cursor_4c_Produtos") AND ;
1441:                NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
1442:                 REPLACE Manual WITH 1 IN cursor_4c_Produtos
1443:                 *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
1444:                 *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
1445:                 IF THIS.this_oBusinessObject.this_lLibValAtu
1446:                     SET ORDER TO
1447:                     GO BOTTOM
1448:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1449:                         INSERT INTO cursor_4c_Produtos ;
1450:                             (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1451:                             VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
1452:                     ENDIF
1453:                     THIS.grd_4c_Produtos.Refresh
1454:                 ENDIF
1455:             ENDIF
1456:             THIS.this_lInCol5 = .F.
1457:         ENDIF
1458:         IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
1459:             THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
1460:             THIS.this_lInCol5    = .T.
1461:         ENDIF
1462: 
1463:         *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
1464:         IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;

*-- Linhas 1475 a 1560:
1475:             IF USED("cursor_4c_FigTmp")
1476:                 USE IN cursor_4c_FigTmp
1477:             ENDIF
1478:             loc_nResult = SQLEXEC(gnConnHandle, ;
1479:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1480:                 EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros)), ;
1481:                 "cursor_4c_FigTmp")
1482:             THIS.img_4c_Foto.Visible = .F.
1483:             THIS.img_4c_Foto.Picture = ""
1484:             IF loc_nResult > 0 AND !EOF("cursor_4c_FigTmp")
1485:                 SELECT cursor_4c_FigTmp
1486:                 IF !ISNULL(cursor_4c_FigTmp.FigJpgs) AND ;
1487:                    !EMPTY(ALLTRIM(NVL(cursor_4c_FigTmp.FigJpgs, "")))
1488:                     CLEAR RESOURCES
1489:                     loc_lcFoto = STRCONV( ;
1490:                         STRTRAN(STRTRAN(STRTRAN( ;
1491:                             cursor_4c_FigTmp.FigJpgs, ;
1492:                             "data:image/png;base64,",  ""), ;
1493:                             "data:image/jpeg;base64,", ""), ;
1494:                             "data:image/jpg;base64,",  ""), 14)
1495:                     STRTOFILE(loc_lcFoto, loc_lcArqFig)
1496:                     THIS.img_4c_Foto.Picture = loc_lcArqFig
1497:                     THIS.img_4c_Foto.Visible = .T.
1498:                 ENDIF
1499:             ENDIF
1500:             IF USED("cursor_4c_FigTmp")
1501:                 USE IN cursor_4c_FigTmp
1502:             ENDIF
1503:         ELSE
1504:             THIS.img_4c_Foto.Visible = .F.
1505:             THIS.img_4c_Foto.Picture = ""
1506:         ENDIF
1507: 
1508:         SELECT cursor_4c_Produtos
1509:     ENDPROC
1510: 
1511:     *==========================================================================
1512:     * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
1513:     * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
1514:     *==========================================================================
1515:     PROCEDURE CarregarProdutoAuditado(par_cCPros)
1516:         LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1517:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
1518: 
1519:         IF EMPTY(ALLTRIM(par_cCPros))
1520:             RETURN
1521:         ENDIF
1522: 
1523:         *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
1524:         IF USED("cursor_4c_ProdAud")
1525:             USE IN cursor_4c_ProdAud
1526:         ENDIF
1527:         loc_nResult = SQLEXEC(gnConnHandle, ;
1528:             "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
1529:             "cursor_4c_ProdAud")
1530:         IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
1531:             IF USED("cursor_4c_ProdAud")
1532:                 USE IN cursor_4c_ProdAud
1533:             ENDIF
1534:             THIS.AbrirBuscaProdutoGrd()
1535:             RETURN
1536:         ENDIF
1537: 
1538:         *-- Insere no cursor_4c_TmpPro se ainda nao existe
1539:         IF USED("cursor_4c_TmpPro")
1540:             IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1541:                 SELECT cursor_4c_ProdAud
1542:                 GO TOP
1543:                 LOCAL loc_oErroIns
1544:                 TRY
1545:                     SELECT cursor_4c_TmpPro
1546:                     APPEND BLANK
1547:                     *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
1548:                     REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
1549:                     REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
1550:                     REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
1551:                     REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
1552:                     REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
1553:                     REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
1554:                     REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
1555:                     REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)
1556:                     REPLACE MoeVs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeVs,    ""))
1557:                     REPLACE MoeCs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCs,    ""))
1558:                     REPLACE MoePcs   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoePcs,   ""))
1559:                     REPLACE MoeCusFs WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCusFs, ""))
1560:                     REPLACE Moedas   WITH ALLTRIM(NVL(cursor_4c_ProdAud.Moedas,   ""))

*-- Linhas 1571 a 1589:
1571: 
1572:         *-- Calcula novo preco conforme tipo
1573:         IF USED("cursor_4c_TmpPro") AND SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1574:             SELECT cursor_4c_TmpPro
1575:             GO TOP
1576:             loc_nTipo     = THIS.opt_4c_Tipo.Value
1577:             loc_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
1578:             loc_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
1579: 
1580:             DO CASE
1581:             CASE loc_nTipo = 1
1582:                 loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
1583:                               (NVL(cursor_4c_TmpPro.PVens, 0) * loc_nVariacao / 100)
1584:             CASE loc_nTipo = 2
1585:                 loc_nValAtu = THIS.this_oBusinessObject.CalcPreco(loc_nMarkUp2)
1586:             CASE loc_nTipo = 3
1587:                 loc_nCotId = fBuscarCotacao( ;
1588:                     ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
1589:                 loc_nCotVd = fBuscarCotacao( ;

*-- Linhas 1598 a 1690:
1598:             ENDCASE
1599: 
1600:             *-- Atualiza registro corrente em cursor_4c_Produtos
1601:             SELECT cursor_4c_Produtos
1602:             REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros, ""))
1603:             REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros, ""))
1604:             REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
1605:             REPLACE ValAtu  WITH loc_nValAtu
1606:             REPLACE lMarca  WITH 1
1607:             REPLACE Manual  WITH 0
1608:             REPLACE fCustos WITH NVL(cursor_4c_TmpPro.fCustos, 0)
1609:             REPLACE CustoFs WITH NVL(cursor_4c_TmpPro.CustoFs, 0)
1610:             REPLACE MoePcs  WITH ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, ""))
1611: 
1612:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
1613: 
1614:             *-- Adiciona linha vazia abaixo se nao houver
1615:             IF !THIS.this_oBusinessObject.this_lLibValAtu
1616:                 SELECT cursor_4c_Produtos
1617:                 SET ORDER TO
1618:                 GO BOTTOM
1619:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1620:                     INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1621:                         VALUES (0, SPACE(14), SPACE(40), 0, 0)
1622:                 ENDIF
1623:                 SELECT cursor_4c_Produtos
1624:                 THIS.grd_4c_Produtos.Refresh
1625:             ENDIF
1626:         ENDIF
1627: 
1628:         IF USED("cursor_4c_ProdAud")
1629:             USE IN cursor_4c_ProdAud
1630:         ENDIF
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * ChkAuditadoClick - Alterna modo de entrada manual de produtos
1635:     *==========================================================================
1636:     PROCEDURE ChkAuditadoClick()
1637:         IF THIS.chk_4c_Auditado.Value = 1
1638:             *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
1639:             IF USED("cursor_4c_Produtos")
1640:                 LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
1641:                 loc_lMarca_v = 0
1642:                 loc_cCPros_v = SPACE(14)
1643:                 loc_cDPros_v = SPACE(40)
1644:                 loc_nValAtu_v = 0
1645:                 loc_nValAnt_v = 0
1646:                 INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1647:                     VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
1648:                 SELECT cursor_4c_Produtos
1649:                 SET ORDER TO
1650:                 GO TOP
1651:             ENDIF
1652:             THIS.txt_4c_CdGrupo.Enabled  = .F.
1653:             THIS.txt_4c_AteGrupo.Enabled = .F.
1654:             THIS.txt_4c_Col.Enabled      = .F.
1655:             THIS.txt_4c_Moeda.Enabled    = .F.
1656:             THIS.txt_4c_MarkUp1.Enabled  = .F.
1657:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
1658:             THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
1659:             THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
1660:             THIS.grd_4c_Produtos.Column2.SetFocus
1661:             THIS.grd_4c_Produtos.Refresh
1662:         ELSE
1663:             *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
1664:             IF USED("cursor_4c_Produtos")
1665:                 DELETE FROM cursor_4c_Produtos
1666:             ENDIF
1667:             THIS.txt_4c_CdGrupo.Enabled  = .T.
1668:             THIS.txt_4c_AteGrupo.Enabled = .T.
1669:             THIS.txt_4c_Col.Enabled      = .T.
1670:             THIS.txt_4c_Moeda.Enabled    = .T.
1671:             THIS.txt_4c_MarkUp1.Enabled  = .T.
1672:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
1673:             THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
1674:             THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
1675:             SELECT cursor_4c_Produtos
1676:             SET ORDER TO CPros
1677:             GO TOP
1678:             THIS.grd_4c_Produtos.Refresh
1679:             THIS.txt_4c_CdGrupo.SetFocus
1680:         ENDIF
1681:     ENDPROC
1682: 
1683:     *==========================================================================
1684:     * Lookup helpers
1685:     *==========================================================================
1686: 
1687:     *-- Helper generico para SigCdMoe
1688:     PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
1689:         LOCAL loc_cValor, loc_oForm
1690:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

*-- Linhas 1763 a 1782:
1763:         IF EMPTY(loc_cVal)
1764:             RETURN
1765:         ENDIF
1766:         loc_nR = SQLEXEC(gnConnHandle, ;
1767:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1768:             "cursor_4c_ValGrp")
1769:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1770:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1771:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1772:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1773:             ENDIF
1774:         ELSE
1775:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1776:             THIS.txt_4c_CdGrupo.Value = ""
1777:             THIS.AbrirBuscaCdGrupo()
1778:         ENDIF
1779:         IF USED("cursor_4c_ValGrp")
1780:             USE IN cursor_4c_ValGrp
1781:         ENDIF
1782:     ENDPROC

*-- Linhas 1827 a 1846:
1827:         IF EMPTY(loc_cVal)
1828:             RETURN
1829:         ENDIF
1830:         loc_nR = SQLEXEC(gnConnHandle, ;
1831:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1832:             "cursor_4c_ValGrp")
1833:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1834:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1835:         ELSE
1836:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1837:             THIS.txt_4c_AteGrupo.Value = ""
1838:             THIS.AbrirBuscaAteGrupo()
1839:         ENDIF
1840:         IF USED("cursor_4c_ValGrp")
1841:             USE IN cursor_4c_ValGrp
1842:         ENDIF
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * Lookups - SigCdCol

*-- Linhas 1888 a 1907:
1888:         IF EMPTY(loc_cVal)
1889:             RETURN
1890:         ENDIF
1891:         loc_nR = SQLEXEC(gnConnHandle, ;
1892:             "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
1893:             "cursor_4c_ValCol")
1894:         IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
1895:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
1896:         ELSE
1897:             MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
1898:             THIS.txt_4c_Col.Value = ""
1899:             THIS.AbrirBuscaCol()
1900:         ENDIF
1901:         IF USED("cursor_4c_ValCol")
1902:             USE IN cursor_4c_ValCol
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *==========================================================================
1907:     * Lookups - SigCdMoe (Moeda - Tipo 2)

*-- Linhas 1926 a 1945:
1926:         IF EMPTY(loc_cVal)
1927:             RETURN
1928:         ENDIF
1929:         loc_nR = SQLEXEC(gnConnHandle, ;
1930:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1931:             "cursor_4c_ValMoe")
1932:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1933:             THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1934:         ELSE
1935:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1936:             THIS.txt_4c_Moeda.Value = ""
1937:             THIS.AbrirBuscaMoeda()
1938:         ENDIF
1939:         IF USED("cursor_4c_ValMoe")
1940:             USE IN cursor_4c_ValMoe
1941:         ENDIF
1942:     ENDPROC
1943: 
1944:     *==========================================================================
1945:     * Lookups - SigCdMoe (Moecs)

*-- Linhas 1964 a 1983:
1964:         IF EMPTY(loc_cVal)
1965:             RETURN
1966:         ENDIF
1967:         loc_nR = SQLEXEC(gnConnHandle, ;
1968:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1969:             "cursor_4c_ValMoe")
1970:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1971:             THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1972:         ELSE
1973:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1974:             THIS.txt_4c_Moecs.Value = ""
1975:             THIS.AbrirBuscaMoecs()
1976:         ENDIF
1977:         IF USED("cursor_4c_ValMoe")
1978:             USE IN cursor_4c_ValMoe
1979:         ENDIF
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * Lookups - SigCdMoe (MoeCusFs)

*-- Linhas 2002 a 2021:
2002:         IF EMPTY(loc_cVal)
2003:             RETURN
2004:         ENDIF
2005:         loc_nR = SQLEXEC(gnConnHandle, ;
2006:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2007:             "cursor_4c_ValMoe")
2008:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2009:             THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2010:         ELSE
2011:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2012:             THIS.txt_4c_MoeCusFs.Value = ""
2013:             THIS.AbrirBuscaMoeCusFs()
2014:         ENDIF
2015:         IF USED("cursor_4c_ValMoe")
2016:             USE IN cursor_4c_ValMoe
2017:         ENDIF
2018:     ENDPROC
2019: 
2020:     *==========================================================================
2021:     * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)

*-- Linhas 2040 a 2059:
2040:         IF EMPTY(loc_cVal)
2041:             RETURN
2042:         ENDIF
2043:         loc_nR = SQLEXEC(gnConnHandle, ;
2044:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2045:             "cursor_4c_ValMoe")
2046:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2047:             THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2048:         ELSE
2049:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2050:             THIS.txt_4c_Moedas.Value = ""
2051:             THIS.AbrirBuscaMoedas()
2052:         ENDIF
2053:         IF USED("cursor_4c_ValMoe")
2054:             USE IN cursor_4c_ValMoe
2055:         ENDIF
2056:     ENDPROC
2057: 
2058:     *==========================================================================
2059:     * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)

*-- Linhas 2078 a 2097:
2078:         IF EMPTY(loc_cVal)
2079:             RETURN
2080:         ENDIF
2081:         loc_nR = SQLEXEC(gnConnHandle, ;
2082:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2083:             "cursor_4c_ValMoe")
2084:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2085:             THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2086:         ELSE
2087:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2088:             THIS.txt_4c_MoeCusto.Value = ""
2089:             THIS.AbrirBuscaMoeCusto()
2090:         ENDIF
2091:         IF USED("cursor_4c_ValMoe")
2092:             USE IN cursor_4c_ValMoe
2093:         ENDIF
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)

*-- Linhas 2116 a 2135:
2116:         IF EMPTY(loc_cVal)
2117:             RETURN
2118:         ENDIF
2119:         loc_nR = SQLEXEC(gnConnHandle, ;
2120:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2121:             "cursor_4c_ValMoe")
2122:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2123:             THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2124:         ELSE
2125:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2126:             THIS.txt_4c_MoeVs.Value = ""
2127:             THIS.AbrirBuscaMoeVs()
2128:         ENDIF
2129:         IF USED("cursor_4c_ValMoe")
2130:             USE IN cursor_4c_ValMoe
2131:         ENDIF
2132:     ENDPROC
2133: 
2134:     *==========================================================================
2135:     * Lookups - SigPrFti (CFtios = Feitio)

*-- Linhas 2176 a 2195:
2176:         IF EMPTY(loc_cVal)
2177:             RETURN
2178:         ENDIF
2179:         loc_nR = SQLEXEC(gnConnHandle, ;
2180:             "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
2181:             "cursor_4c_ValFtio")
2182:         IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
2183:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
2184:         ELSE
2185:             MsgAviso("Feitio n" + CHR(227) + "o encontrado.", "")
2186:             THIS.txt_4c_CFtios.Value = ""
2187:             THIS.AbrirBuscaCFtios()
2188:         ENDIF
2189:         IF USED("cursor_4c_ValFtio")
2190:             USE IN cursor_4c_ValFtio
2191:         ENDIF
2192:     ENDPROC
2193: 
2194:     *==========================================================================
2195:     * Lookups - Fornecedor via fAcessoContas (Conta / DConta)

*-- Linhas 2303 a 2322:
2303:         IF EMPTY(loc_cVal)
2304:             RETURN
2305:         ENDIF
2306:         loc_nR = SQLEXEC(gnConnHandle, ;
2307:             "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
2308:             "cursor_4c_ValPmc")
2309:         IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
2310:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
2311:         ELSE
2312:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
2313:             THIS.txt_4c_Promo.Value = ""
2314:             THIS.AbrirBuscaPromo()
2315:         ENDIF
2316:         IF USED("cursor_4c_ValPmc")
2317:             USE IN cursor_4c_ValPmc
2318:         ENDIF
2319:     ENDPROC
2320: 
2321:     *==========================================================================
2322:     * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a

*-- Linhas 2386 a 2404:
2386:         LOCAL loc_oErro
2387:         TRY
2388:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2389:                 SELECT cursor_4c_Produtos
2390:                 GO TOP
2391:                 THIS.grd_4c_Produtos.Refresh
2392:                 THIS.Refresh
2393:             ELSE
2394:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
2395:                          "para visualizar. Execute o Processar primeiro.", "Aviso")
2396:             ENDIF
2397:         CATCH TO loc_oErro
2398:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2399:         ENDTRY
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
2404:     *   Permite reprocessar com os mesmos parametros mas lista limpa

*-- Linhas 2429 a 2447:
2429:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2430:             RETURN
2431:         ENDIF
2432:         SELECT cursor_4c_Produtos
2433:         loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
2434: 
2435:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2436:             "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
2437:             "Produtos")
2438:         IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2439:             RETURN
2440:         ENDIF
2441: 
2442:         IF !loc_oForm.this_lAchouRegistro
2443:             loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2444:             loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2445:             loc_oForm.Show()
2446:         ENDIF
2447: 

*-- Linhas 2454 a 2477:
2454:         ENDIF
2455: 
2456:         IF !EMPTY(loc_cSelecionado)
2457:             SELECT cursor_4c_Produtos
2458:             REPLACE CPros WITH loc_cSelecionado
2459:             THIS.grd_4c_Produtos.Refresh
2460:             THIS.CarregarProdutoAuditado(loc_cSelecionado)
2461:         ELSE
2462:             SELECT cursor_4c_Produtos
2463:             IF !EOF("cursor_4c_Produtos")
2464:                 REPLACE CPros WITH SPACE(14)
2465:             ENDIF
2466:             THIS.grd_4c_Produtos.Refresh
2467:         ENDIF
2468:         loc_oForm.Release()
2469:     ENDPROC
2470: 
2471:     *==========================================================================
2472:     * FormParaBO - Transfere todos os campos do form para propriedades do BO
2473:     * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
2474:     *==========================================================================
2475:     PROCEDURE FormParaBO()
2476:         LOCAL loc_oBO
2477:         loc_oBO = THIS.this_oBusinessObject

*-- Linhas 2650 a 2668:
2650:     *==========================================================================
2651:     PROCEDURE CarregarLista()
2652:         IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2653:             SELECT cursor_4c_Produtos
2654:             GO TOP
2655:             IF VARTYPE(THIS.grd_4c_Produtos) = "O"
2656:                 THIS.grd_4c_Produtos.Refresh
2657:             ENDIF
2658:         ENDIF
2659:     ENDPROC
2660: 
2661:     *==========================================================================
2662:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
2663:     * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
2664:     * apos reset; habilita Atualizar apos Processar com sucesso.
2665:     * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
2666:     *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
2667:     *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
2668:     *==========================================================================

