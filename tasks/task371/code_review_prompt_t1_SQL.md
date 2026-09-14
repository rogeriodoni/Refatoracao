# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IPIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CLFISCALS, PCESCOLHA, I, VALUE, ESTASO, ESTAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ALIQIPIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CLFISCALS, PCESCOLHA, I, VALUE, ESTASO, ESTAS

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
  ControlSource = "crSigCdClf.codigos"
  ControlSource = "crSigCdClf.descricaos"
  ControlSource = "crSigCdClf.aipis"
  ControlSource = "crSigCdClf.unidades"
  ControlSource = "crSigCdClf.IndIVAST"
  ControlSource = "crSigCdClf.aliqfcp"
  ControlSource = "crSigCdClf.BIcms"
  ControlSource = "crSigCdClf.TpSubSt"
  ControlSource = "crSigCdClf.TipoMercs"
  ControlSource = "crSigCdClf.BIcmss"
  ControlSource = "crSigCdClf.cest"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
SELECT * from crSigcdIva where codigos = lcCod into cursor crIva readwrite
SELECT crIva
SELECT * from crSigcdRed where codigos = lcCod into cursor crRed readwrite
SELECT crRed
	.column1.ControlSource = 'crIva.EstasO'
	.column2.ControlSource = 'crIva.EstasD'
	.Column3.controlsource = 'crIva.indivast'
	.Column4.controlsource = 'crIva.indivastpi'
	.column1.ControlSource = 'crRed.Estas'
	.column2.ControlSource = 'crRed.Areds'
	.Column3.controlsource = 'crRed.bReds'
Select crIva
lcSql = [Select * From SigCdIva Where codigos = '] + lcClf + [']
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpIva')
Select TmpIva
	Select crIva
Select crIva
Select crRed
lcSql = [Select * From SigCdRed Where codigos = '] + lcClf + [']
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpRed')
Select TmpRed
	Select crRed
Select crRed
Select CrSigCdClf
		lcSql = [Select Count(*) as QtProd From SigCdPro Where ClFiscals = ']+CrSigCdClf.codigos+[' And ]+;
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro') < 1
	select CrSigCdClf
	SET delete off
		Select CrSigCdIva
		Select crIVA
				Select CrSigCdIva
				IF DELETED('crIva')
					DELETE 
			SELECT crIva
	SET delete on
	SET delete off
		Select CrSigCdRed
		Select crRed
				Select CrSigCdRed
				IF DELETED('crRed')
					DELETE 
			SELECT crRed
	SET delete on
If Not ThisForm.poDataMgr.Update('crSigCdIva')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdIva)')
If Not ThisForm.poDataMgr.Update('crSigCdRed')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRed)')
	lcSQL = [Select top 1 cpros from SigCdPro where clfiscals = ']+ThisForm.Pagina.Dados.getCodigo.Value+[' ] + ;
			[Select top 1 cpros from SigCdPrc where clfiscals = ']+ThisForm.Pagina.Dados.getCodigo.Value+[']	
	ThisForm.poDataMgr.SQLExecute(lcSQL,[crChecaPro])	
select CrSigCdClf
select CrSigCdClf
Select crIva
Select crIva
SELECT crIva
Delete
Select estasO, estasD from crIva into cursor Duplica group by estasO, estasD  having count(1) > 1 
Select Duplica
	Select crIva
Select crIva
Select estasO, estasD from crIva into cursor Duplica group by estasO, estasD  having count(1) > 1 
Select Duplica
	Select crIva
Select crIva
Select crRed
Select crRed
SELECT crRed
Delete
Select estasO, estasD from crIva into cursor Duplica group by estasO, estasD  having count(1) > 1 
Select Duplica
	Select crIva
Select crIva

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormClf.prg) - TRECHOS RELEVANTES PARA PASS SQL (2502 linhas total):

*-- Linhas 296 a 314:
296:             .Width             = 940
297:             .Height            = 470
298:             .ReadOnly          = .T.
299:             .DeleteMark        = .F.
300:             .RecordMark        = .F.
301:             .ScrollBars        = 3
302:             .GridLines         = 3
303:             .AllowHeaderSizing = .T.
304:             .Visible           = .T.
305:         ENDWITH
306: 
307:         *-- ColumnCount FORA do WITH para criacao imediata das colunas (Problema 36)
308:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
309:         loc_oPagina.grd_4c_Lista.Column1.Width = 94
310:         loc_oPagina.grd_4c_Lista.Column2.Width = 290
311:         loc_oPagina.grd_4c_Lista.Column3.Width = 45
312:         loc_oPagina.grd_4c_Lista.Column4.Width = 31
313:         loc_oPagina.grd_4c_Lista.Column5.Width = 70
314: 

*-- Linhas 1083 a 1101:
1083:             .Left          = 693
1084:             .Width         = 235
1085:             .Height        = 234
1086:             .DeleteMark    = .F.
1087:             .RecordMark    = .F.
1088:             .ScrollBars    = 2
1089:             .GridLines     = 3
1090:             .GridLineWidth = 1
1091:             .GridLineColor = RGB(238, 238, 238)
1092:             .HeaderHeight  = 20
1093:             .FontName      = "Tahoma"
1094:             .FontSize      = 8
1095:             .Visible       = .T.
1096:         ENDWITH
1097: 
1098:         *-- ColumnCount FORA do WITH (Problema 36)
1099:         loc_oPagina.grd_4c_IVA.ColumnCount = 4
1100:         loc_oPagina.grd_4c_IVA.Column1.Width = 45
1101:         loc_oPagina.grd_4c_IVA.Column2.Width = 45

*-- Linhas 1195 a 1213:
1195:             .Left          = 388
1196:             .Width         = 235
1197:             .Height        = 143
1198:             .DeleteMark    = .F.
1199:             .RecordMark    = .F.
1200:             .ScrollBars    = 2
1201:             .GridLines     = 3
1202:             .GridLineWidth = 1
1203:             .GridLineColor = RGB(238, 238, 238)
1204:             .HeaderHeight  = 20
1205:             .FontName      = "Tahoma"
1206:             .FontSize      = 8
1207:             .Visible       = .T.
1208:         ENDWITH
1209: 
1210:         *-- ColumnCount FORA do WITH
1211:         loc_oPagina.grd_4c_Reducao.ColumnCount = 3
1212:         loc_oPagina.grd_4c_Reducao.Column1.Width = 51
1213:         loc_oPagina.grd_4c_Reducao.Column2.Width = 72

*-- Linhas 1357 a 1384:
1357:             IF !THIS.this_oBusinessObject.Buscar("")
1358:                 loc_lResultado = .F.
1359:             ELSE
1360:                 *-- RecordSource PRIMEIRO (reseta ControlSource e Headers automaticamente)
1361:                 loc_oGrid.ColumnCount = 5
1362:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1363: 
1364:                 *-- ControlSource APOS RecordSource
1365:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1366:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
1367:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aipis"
1368:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.unidades"
1369:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cest"
1370: 
1371:                 *-- Larguras (legado: Codigos=94, Descricaos=290, Aipis=45, Unidades=31, Cest=70)
1372:                 loc_oGrid.Column1.Width = 94
1373:                 loc_oGrid.Column2.Width = 290
1374:                 loc_oGrid.Column3.Width = 45
1375:                 loc_oGrid.Column4.Width = 31
1376:                 loc_oGrid.Column5.Width = 70
1377: 
1378:                 *-- Headers OBRIGATORIO apos RecordSource (VFP reseta ao mudar RecordSource)
1379:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1380:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1381:                 loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. IPI"
1382:                 loc_oGrid.Column4.Header1.Caption = "UN"
1383:                 loc_oGrid.Column5.Header1.Caption = "CEST"
1384: 

*-- Linhas 1440 a 1458:
1440:         loc_lResultado = .F.
1441:         TRY
1442:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1443:                 SELECT cursor_4c_Dados
1444:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1445:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1446:                     THIS.BOParaForm()
1447:                     THIS.this_cModoAtual = "VISUALIZAR"
1448:                     THIS.HabilitarCampos(.F.)
1449:                     THIS.CarregarFilhos(loc_cCodigo)
1450:                     THIS.VincularGridsFilhos()
1451:                     THIS.VerificarTemProduto(loc_cCodigo)
1452:                     THIS.AtualizarSayIPI()
1453:                     THIS.pgf_4c_Paginas.ActivePage = 2
1454:                     loc_lResultado = .T.
1455:                 ENDIF
1456:             ELSE
1457:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
1458:             ENDIF

*-- Linhas 1467 a 1485:
1467:         loc_lResultado = .F.
1468:         TRY
1469:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1470:                 SELECT cursor_4c_Dados
1471:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1472:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1473:                     THIS.this_oBusinessObject.EditarRegistro()
1474:                     THIS.BOParaForm()
1475:                     THIS.this_cModoAtual = "ALTERAR"
1476:                     THIS.HabilitarCampos(.T.)
1477:                     THIS.CarregarFilhos(loc_cCodigo)
1478:                     THIS.VincularGridsFilhos()
1479:                     THIS.VerificarTemProduto(loc_cCodigo)
1480:                     THIS.AtualizarSayIPI()
1481:                     THIS.pgf_4c_Paginas.ActivePage = 2
1482:                     loc_lResultado = .T.
1483:                 ENDIF
1484:             ELSE
1485:                 MsgAviso("Nenhum registro selecionado.", "Aviso")

*-- Linhas 1495 a 1532:
1495:         loc_lResultado = .F.
1496:         TRY
1497:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1498:                 SELECT cursor_4c_Dados
1499:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1500:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
1501:                     *-- Verifica se existem produtos usando esta classificacao fiscal
1502:                     loc_cSQL = "SELECT TOP 1 cpros FROM SigCdPro WHERE clfiscals = " + EscaparSQL(loc_cCodigo) + ;
1503:                                " UNION ALL " + ;
1504:                                "SELECT TOP 1 cpros FROM SigCdPrc WHERE clfiscals = " + EscaparSQL(loc_cCodigo)
1505:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExcPro") > 0
1506:                         IF USED("cursor_4c_ChkExcPro") AND !EOF("cursor_4c_ChkExcPro")
1507:                             IF USED("cursor_4c_ChkExcPro")
1508:                                 USE IN cursor_4c_ChkExcPro
1509:                             ENDIF
1510:                             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Excluir, Classifica" + CHR(231) + CHR(227) + "o Fiscal J" + CHR(225) + " Informada em Produtos.", "Aviso")
1511:                         ELSE
1512:                             IF USED("cursor_4c_ChkExcPro")
1513:                                 USE IN cursor_4c_ChkExcPro
1514:                             ENDIF
1515:                             *-- Excluir filhos antes do registro principal
1516:                             SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(loc_cCodigo))
1517:                             SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(loc_cCodigo))
1518:                             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1519:                                 IF THIS.this_oBusinessObject.Excluir()
1520:                                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1521:                                     THIS.CarregarLista()
1522:                                     loc_lResultado = .T.
1523:                                 ENDIF
1524:                             ENDIF
1525:                         ENDIF
1526:                     ELSE
1527:                         MostrarErro("Erro ao verificar produtos vinculados.", "Erro")
1528:                     ENDIF
1529:                 ENDIF
1530:             ELSE
1531:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
1532:             ENDIF

*-- Linhas 1542 a 1575:
1542:         TRY
1543:             loc_cFiltro = ""
1544:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1545:                 SELECT cursor_4c_Dados
1546:                 loc_cFiltro = ALLTRIM(cursor_4c_Dados.codigos)
1547:             ENDIF
1548: 
1549:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1550:                 "SIGCDCLF", "cursor_4c_BuscaClf", "codigos", loc_cFiltro, ;
1551:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
1552: 
1553:             IF VARTYPE(loc_oBusca) = "O"
1554:                 IF !loc_oBusca.this_lAchouRegistro
1555:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
1556:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1557:                     loc_oBusca.Show()
1558:                 ENDIF
1559:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
1560:                     SELECT cursor_4c_BuscaClf
1561:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaClf.codigos)
1562:                     IF THIS.this_oBusinessObject.Buscar("codigos = '" + ALLTRIM(loc_cFiltro) + "'")
1563:                         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1564:                             GO TOP IN cursor_4c_Dados
1565:                         ENDIF
1566:                     ENDIF
1567:                 ENDIF
1568:                 loc_oBusca.Release()
1569:             ENDIF
1570: 
1571:             IF USED("cursor_4c_BuscaClf")
1572:                 USE IN cursor_4c_BuscaClf
1573:             ENDIF
1574:             loc_lResultado = .T.
1575:         CATCH TO loException

*-- Linhas 1723 a 1745:
1723:             loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex = 0
1724:             loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1
1725:             IF USED("crIva")
1726:                 SELECT crIva
1727:                 ZAP
1728:             ENDIF
1729:             IF USED("crRed")
1730:                 SELECT crRed
1731:                 ZAP
1732:             ENDIF
1733:         CATCH TO loException
1734:             MostrarErro("Erro em LimparCampos:" + CHR(13) + loException.Message, "Erro")
1735:         ENDTRY
1736:     ENDPROC
1737: 
1738:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1739:         LOCAL loc_oPg2, loc_lCodigoHab
1740:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1741:         loc_lCodigoHab = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1742:         TRY
1743:             loc_oPg2.txt_4c_Codigo.Enabled    = loc_lCodigoHab
1744:             loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1745:             loc_oPg2.txt_4c_Unidade.Enabled   = par_lHabilitar

*-- Linhas 1939 a 1964:
1939:             ENDIF
1940: 
1941:             SET NULL OFF
1942:             CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
1943:                                  indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
1944:             SELECT crIva
1945:             APPEND BLANK
1946: 
1947:             CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
1948:                                  bReds n(7,3), cidChaves c(10))
1949:             SELECT crRed
1950:             APPEND BLANK
1951:             SET NULL ON
1952:         CATCH TO loException
1953:             SET NULL ON
1954:             MostrarErro("Erro em CriarCursoresFilhos:" + CHR(13) + loException.Message, "Erro")
1955:         ENDTRY
1956:     ENDPROC
1957: 
1958:     *--------------------------------------------------------------------------
1959:     * CarregarFilhos - Carrega crIva e crRed do banco para o codigo informado
1960:     *--------------------------------------------------------------------------
1961:     PROTECTED PROCEDURE CarregarFilhos
1962:         LPARAMETERS par_cCodigo
1963:         LOCAL loc_lResultado, loc_cSQL
1964:         loc_lResultado = .F.

*-- Linhas 1971 a 2160:
1971:             ENDIF
1972: 
1973:             SET NULL OFF
1974:             CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
1975:                                  indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
1976:             CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
1977:                                  bReds n(7,3), cidChaves c(10))
1978:             SET NULL ON
1979: 
1980:             *-- Carregar IVAs do banco
1981:             loc_cSQL = "SELECT codigos, estasO, estasD, indivast, indivastPi, cidChaves " + ;
1982:                        "FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo)
1983:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpIva") > 0
1984:                 IF USED("cursor_4c_TmpIva") AND RECCOUNT("cursor_4c_TmpIva") > 0
1985:                     SELECT cursor_4c_TmpIva
1986:                     SCAN
1987:                         SELECT crIva
1988:                         APPEND BLANK
1989:                         REPLACE crIva.codigos    WITH cursor_4c_TmpIva.codigos, ;
1990:                                 crIva.estasO     WITH cursor_4c_TmpIva.estasO, ;
1991:                                 crIva.estasD     WITH cursor_4c_TmpIva.estasD, ;
1992:                                 crIva.indivast   WITH cursor_4c_TmpIva.indivast, ;
1993:                                 crIva.indivastPi WITH cursor_4c_TmpIva.indivastPi, ;
1994:                                 crIva.cidChaves  WITH cursor_4c_TmpIva.cidChaves
1995:                         SELECT cursor_4c_TmpIva
1996:                     ENDSCAN
1997:                 ENDIF
1998:                 IF USED("cursor_4c_TmpIva")
1999:                     USE IN cursor_4c_TmpIva
2000:                 ENDIF
2001:             ENDIF
2002:             SELECT crIva
2003:             IF RECCOUNT() = 0
2004:                 APPEND BLANK
2005:             ENDIF
2006: 
2007:             *-- Carregar Reducoes do banco
2008:             loc_cSQL = "SELECT codigos, estas, aReds, bReds, cidChaves " + ;
2009:                        "FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo)
2010:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRed") > 0
2011:                 IF USED("cursor_4c_TmpRed") AND RECCOUNT("cursor_4c_TmpRed") > 0
2012:                     SELECT cursor_4c_TmpRed
2013:                     SCAN
2014:                         SELECT crRed
2015:                         APPEND BLANK
2016:                         REPLACE crRed.codigos   WITH cursor_4c_TmpRed.codigos, ;
2017:                                 crRed.estas     WITH cursor_4c_TmpRed.estas, ;
2018:                                 crRed.aReds     WITH cursor_4c_TmpRed.aReds, ;
2019:                                 crRed.bReds     WITH cursor_4c_TmpRed.bReds, ;
2020:                                 crRed.cidChaves WITH cursor_4c_TmpRed.cidChaves
2021:                         SELECT cursor_4c_TmpRed
2022:                     ENDSCAN
2023:                 ENDIF
2024:                 IF USED("cursor_4c_TmpRed")
2025:                     USE IN cursor_4c_TmpRed
2026:                 ENDIF
2027:             ENDIF
2028:             SELECT crRed
2029:             IF RECCOUNT() = 0
2030:                 APPEND BLANK
2031:             ENDIF
2032: 
2033:             loc_lResultado = .T.
2034:         CATCH TO loException
2035:             MostrarErro("Erro em CarregarFilhos:" + CHR(13) + loException.Message, "Erro")
2036:         ENDTRY
2037:         RETURN loc_lResultado
2038:     ENDPROC
2039: 
2040:     *--------------------------------------------------------------------------
2041:     * VincularGridsFilhos - Vincula grids grd_4c_IVA e grd_4c_Reducao aos cursores
2042:     *--------------------------------------------------------------------------
2043:     PROTECTED PROCEDURE VincularGridsFilhos
2044:         LOCAL loc_oPg2, loc_oGrdIva, loc_oGrdRed
2045:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2046:         loc_oGrdIva = loc_oPg2.grd_4c_IVA
2047:         loc_oGrdRed = loc_oPg2.grd_4c_Reducao
2048:         TRY
2049:             loc_oGrdIva.RecordSource = "crIva"
2050:             loc_oGrdIva.Column1.ControlSource = "crIva.estasO"
2051:             loc_oGrdIva.Column2.ControlSource = "crIva.estasD"
2052:             loc_oGrdIva.Column3.ControlSource = "crIva.indivast"
2053:             loc_oGrdIva.Column4.ControlSource = "crIva.indivastPi"
2054:             loc_oGrdIva.Column1.Width = 45
2055:             loc_oGrdIva.Column2.Width = 45
2056:             loc_oGrdIva.Column3.Width = 60
2057:             loc_oGrdIva.Column4.Width = 60
2058:             loc_oGrdIva.Column1.Header1.Caption = "UF Ori"
2059:             loc_oGrdIva.Column2.Header1.Caption = "UF Des"
2060:             loc_oGrdIva.Column3.Header1.Caption = "IVA"
2061:             loc_oGrdIva.Column4.Header1.Caption = "IVA Im"
2062:             loc_oGrdIva.Refresh()
2063: 
2064:             loc_oGrdRed.RecordSource = "crRed"
2065:             loc_oGrdRed.Column1.ControlSource = "crRed.estas"
2066:             loc_oGrdRed.Column2.ControlSource = "crRed.aReds"
2067:             loc_oGrdRed.Column3.ControlSource = "crRed.bReds"
2068:             loc_oGrdRed.Column1.Width = 51
2069:             loc_oGrdRed.Column2.Width = 72
2070:             loc_oGrdRed.Column3.Width = 72
2071:             loc_oGrdRed.Column1.Header1.Caption = "UF Dest"
2072:             loc_oGrdRed.Column2.Header1.Caption = "Aliq Red"
2073:             loc_oGrdRed.Column3.Header1.Caption = "Aliq B Red"
2074:             loc_oGrdRed.Refresh()
2075:         CATCH TO loException
2076:             MostrarErro("Erro em VincularGridsFilhos:" + CHR(13) + loException.Message, "Erro")
2077:         ENDTRY
2078:     ENDPROC
2079: 
2080:     *--------------------------------------------------------------------------
2081:     * SalvarFilhos - Salva SigCdIva e SigCdRed via DELETE+INSERT
2082:     *--------------------------------------------------------------------------
2083:     PROTECTED PROCEDURE SalvarFilhos
2084:         LPARAMETERS par_cCodigo
2085:         LOCAL loc_lResultado, loc_cSQL, loc_cChave
2086:         loc_lResultado = .T.
2087:         TRY
2088:             SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo))
2089: 
2090:             IF USED("crIva")
2091:                 SELECT crIva
2092:                 GO TOP
2093:                 SCAN
2094:                     IF !EMPTY(ALLTRIM(crIva.estasO)) AND !EMPTY(ALLTRIM(crIva.estasD))
2095:                         loc_cChave = IIF(EMPTY(ALLTRIM(crIva.cidChaves)), ;
2096:                                          LEFT(SYS(2015) + SYS(2015), 10), ;
2097:                                          ALLTRIM(crIva.cidChaves))
2098:                         loc_cSQL = "INSERT INTO SigCdIva (codigos, estasO, estasD, indivast, indivastPi, cidchaves) " + ;
2099:                                    "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
2100:                                    EscaparSQL(PADR(ALLTRIM(crIva.estasO), 2)) + ", " + ;
2101:                                    EscaparSQL(PADR(ALLTRIM(crIva.estasD), 2)) + ", " + ;
2102:                                    FormatarNumeroSQL(crIva.indivast) + ", " + ;
2103:                                    FormatarNumeroSQL(crIva.indivastPi) + ", " + ;
2104:                                    EscaparSQL(loc_cChave) + ")"
2105:                         SQLEXEC(gnConnHandle, loc_cSQL)
2106:                     ENDIF
2107:                 ENDSCAN
2108:             ENDIF
2109: 
2110:             SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo))
2111: 
2112:             IF USED("crRed")
2113:                 SELECT crRed
2114:                 GO TOP
2115:                 SCAN
2116:                     IF !EMPTY(ALLTRIM(crRed.estas))
2117:                         loc_cChave = IIF(EMPTY(ALLTRIM(crRed.cidChaves)), ;
2118:                                          LEFT(SYS(2015) + SYS(2015), 10), ;
2119:                                          ALLTRIM(crRed.cidChaves))
2120:                         loc_cSQL = "INSERT INTO SigCdRed (codigos, estas, aReds, bReds, cidchaves) " + ;
2121:                                    "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
2122:                                    EscaparSQL(PADR(ALLTRIM(crRed.estas), 2)) + ", " + ;
2123:                                    FormatarNumeroSQL(crRed.aReds) + ", " + ;
2124:                                    FormatarNumeroSQL(crRed.bReds) + ", " + ;
2125:                                    EscaparSQL(loc_cChave) + ")"
2126:                         SQLEXEC(gnConnHandle, loc_cSQL)
2127:                     ENDIF
2128:                 ENDSCAN
2129:             ENDIF
2130:         CATCH TO loException
2131:             MostrarErro("Erro em SalvarFilhos:" + CHR(13) + loException.Message, "Erro")
2132:             loc_lResultado = .F.
2133:         ENDTRY
2134:         RETURN loc_lResultado
2135:     ENDPROC
2136: 
2137:     *--------------------------------------------------------------------------
2138:     * BtnIncluirIvaClick - Adiciona linha em branco ao grid IVA
2139:     *--------------------------------------------------------------------------
2140:     PROCEDURE BtnIncluirIvaClick
2141:         LOCAL loc_lResultado
2142:         loc_lResultado = .F.
2143:         TRY
2144:             IF USED("crIva")
2145:                 SELECT crIva
2146:                 LOCATE FOR EMPTY(ALLTRIM(estasO))
2147:                 IF EOF()
2148:                     APPEND BLANK
2149:                     REPLACE crIva.estasO    WITH SPACE(2), ;
2150:                             crIva.estasD    WITH SPACE(2), ;
2151:                             crIva.indivast  WITH 0, ;
2152:                             crIva.indivastPi WITH 0
2153:                 ENDIF
2154:                 THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
2155:                 loc_lResultado = .T.
2156:             ENDIF
2157:         CATCH TO loException
2158:             MostrarErro("Erro ao incluir IVA:" + CHR(13) + loException.Message, "Erro")
2159:         ENDTRY
2160:         RETURN loc_lResultado

*-- Linhas 2168 a 2207:
2168:         loc_lResultado = .F.
2169:         TRY
2170:             IF USED("crIva")
2171:                 SELECT crIva
2172:                 IF !EOF() AND !BOF()
2173:                     DELETE
2174:                     THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
2175:                     loc_lResultado = .T.
2176:                 ENDIF
2177:             ENDIF
2178:         CATCH TO loException
2179:             MostrarErro("Erro ao excluir IVA:" + CHR(13) + loException.Message, "Erro")
2180:         ENDTRY
2181:         RETURN loc_lResultado
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------
2185:     * BtnInsRedClick - Adiciona linha em branco ao grid Reducao
2186:     *--------------------------------------------------------------------------
2187:     PROCEDURE BtnInsRedClick
2188:         LOCAL loc_lResultado
2189:         loc_lResultado = .F.
2190:         TRY
2191:             IF USED("crRed")
2192:                 SELECT crRed
2193:                 LOCATE FOR EMPTY(ALLTRIM(estas))
2194:                 IF EOF()
2195:                     APPEND BLANK
2196:                     REPLACE crRed.estas WITH SPACE(2), ;
2197:                             crRed.aReds WITH 0, ;
2198:                             crRed.bReds WITH 0
2199:                 ENDIF
2200:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
2201:                 loc_lResultado = .T.
2202:             ENDIF
2203:         CATCH TO loException
2204:             MostrarErro("Erro ao incluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
2205:         ENDTRY
2206:         RETURN loc_lResultado
2207:     ENDPROC

*-- Linhas 2214 a 2234:
2214:         loc_lResultado = .F.
2215:         TRY
2216:             IF USED("crRed")
2217:                 SELECT crRed
2218:                 IF !EOF() AND !BOF()
2219:                     DELETE
2220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
2221:                     loc_lResultado = .T.
2222:                 ENDIF
2223:             ENDIF
2224:         CATCH TO loException
2225:             MostrarErro("Erro ao excluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
2226:         ENDTRY
2227:         RETURN loc_lResultado
2228:     ENDPROC
2229: 
2230:     *--------------------------------------------------------------------------
2231:     * IvaCol1KeyPress - Handler KeyPress para grd_4c_IVA.Column1 (estasO)
2232:     *--------------------------------------------------------------------------
2233:     PROCEDURE IvaCol1KeyPress
2234:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

*-- Linhas 2279 a 2353:
2279:                         loc_oBusca.Show()
2280:                     ENDIF
2281:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
2282:                         SELECT cursor_4c_BuscaUf
2283:                         par_oCampo.Value = ALLTRIM(cursor_4c_BuscaUf.Estados)
2284:                         par_oCampo.Refresh()
2285:                     ENDIF
2286:                     loc_oBusca.Release()
2287:                 ENDIF
2288:                 IF USED("cursor_4c_BuscaUf")
2289:                     USE IN cursor_4c_BuscaUf
2290:                 ENDIF
2291:                 loc_lResultado = .T.
2292:             ENDIF
2293:         CATCH TO loException
2294:             MostrarErro("Erro ao abrir lookup UF:" + CHR(13) + loException.Message, "Erro")
2295:         ENDTRY
2296:         RETURN loc_lResultado
2297:     ENDPROC
2298: 
2299:     *--------------------------------------------------------------------------
2300:     * IvaLostFocusValidar - Verifica duplicatas em crIva (estasO+estasD)
2301:     *--------------------------------------------------------------------------
2302:     PROCEDURE IvaLostFocusValidar
2303:         TRY
2304:             IF USED("crIva")
2305:                 SELECT estasO, estasD FROM crIva ;
2306:                     INTO CURSOR cursor_4c_DupIva ;
2307:                     GROUP BY estasO, estasD HAVING COUNT(1) > 1
2308:                 SELECT cursor_4c_DupIva
2309:                 IF RECCOUNT() > 0
2310:                     MsgAviso("IVA j" + CHR(225) + " lan" + CHR(231) + "ado!!!", "Aviso")
2311:                 ENDIF
2312:                 IF USED("cursor_4c_DupIva")
2313:                     USE IN cursor_4c_DupIva
2314:                 ENDIF
2315:                 SELECT crIva
2316:             ENDIF
2317:         CATCH TO loException
2318:             MostrarErro("Erro em IvaLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
2319:         ENDTRY
2320:     ENDPROC
2321: 
2322:     *--------------------------------------------------------------------------
2323:     * RedLostFocusValidar - Verifica duplicatas em crRed (estas)
2324:     *--------------------------------------------------------------------------
2325:     PROCEDURE RedLostFocusValidar
2326:         TRY
2327:             IF USED("crRed")
2328:                 SELECT estas FROM crRed ;
2329:                     INTO CURSOR cursor_4c_DupRed ;
2330:                     GROUP BY estas HAVING COUNT(1) > 1
2331:                 SELECT cursor_4c_DupRed
2332:                 IF RECCOUNT() > 0
2333:                     MsgAviso("Redu" + CHR(231) + CHR(227) + "o j" + CHR(225) + " lan" + CHR(231) + "ada!!!", "Aviso")
2334:                 ENDIF
2335:                 IF USED("cursor_4c_DupRed")
2336:                     USE IN cursor_4c_DupRed
2337:                 ENDIF
2338:                 SELECT crRed
2339:             ENDIF
2340:         CATCH TO loException
2341:             MostrarErro("Erro em RedLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
2342:         ENDTRY
2343:     ENDPROC
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * ValidarAliqFcp - Valida range 0-2 para AliqFcp (LostFocus)
2347:     *--------------------------------------------------------------------------
2348:     PROTECTED PROCEDURE ValidarAliqFcp
2349:         LOCAL loc_oPg2
2350:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2351:         TRY
2352:             IF loc_oPg2.txt_4c_AliqFcp.Value < 0 OR loc_oPg2.txt_4c_AliqFcp.Value > 2
2353:                 MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")

*-- Linhas 2398 a 2421:
2398:         LOCAL loc_lResultado, loc_cSQL
2399:         loc_lResultado = .F.
2400:         TRY
2401:             loc_cSQL = "SELECT COUNT(*) AS QtProd FROM SigCdPro " + ;
2402:                        "WHERE clfiscals = " + EscaparSQL(par_cCodigo) + ;
2403:                        " AND AliqIpis <> 0"
2404:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProd") > 0
2405:                 IF USED("cursor_4c_ChkProd")
2406:                     SELECT cursor_4c_ChkProd
2407:                     THIS.this_lTemProduto = (cursor_4c_ChkProd.QtProd > 0)
2408:                     USE IN cursor_4c_ChkProd
2409:                 ELSE
2410:                     THIS.this_lTemProduto = .F.
2411:                 ENDIF
2412:             ELSE
2413:                 THIS.this_lTemProduto = .F.
2414:             ENDIF
2415:             loc_lResultado = .T.
2416:         CATCH TO loException
2417:             MostrarErro("Erro em VerificarTemProduto:" + CHR(13) + loException.Message, "Erro")
2418:         ENDTRY
2419:         RETURN loc_lResultado
2420:     ENDPROC
2421: 


### BO (C:\4c\projeto\app\classes\ClfBO.prg):
*==============================================================================
* ClfBO.prg - Business Object para Classificacao Fiscal
* Tabela: SIGCDCLF
* Tabelas filhas: sigcdiva (IVAs por estado), sigcdred (Reducoes por estado)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS ClfBO AS BusinessBase

    *-- Propriedades da entidade (SIGCDCLF)
    this_cCodigo    = ""   && codigos char(10) PK
    this_cDescricao = ""   && descricaos char(40)
    this_nAipi      = 0    && aipis numeric(9,2) - Aliq. IPI padrao
    this_cUnidade   = ""   && unidades char(3)
    this_cAliqReds  = ""   && aliqreds char(1) S/N - Aliquota Reduzida ICMS
    this_cBaseReds  = ""   && basereds char(1) S/N - Base Reduzida ICMS
    this_cIpis      = ""   && ipis char(1) S/N - flag IPI
    this_cSitRibs   = ""   && sitribs char(3) - Situacao Tributaria
    this_nBIcms     = 0    && bicms numeric(9,6) - percentual Base Reduzida ICMS
    this_nIndIVAST  = 0    && indivast numeric(7,3) - IVA-ST SP
    this_cIpiProds  = ""   && ipiprods char(1) S/N - IPI por produto
    this_nTipoMercs = 0    && tipoMercs numeric(2,0) - Codigo Tipo Mercadoria
    this_nTpSubSt   = 0    && TpSubSt numeric(1,0) - 1=IVA 2=Valor Determinado
    this_nBIcmss    = 0    && bicmss numeric(9,6) - Base Reduzida Substituicao
    this_nAliqFcp   = 0    && aliqfcp numeric(6,3) - Aliquota ICMS FCP
    this_cCest      = ""   && cest char(7) - CEST
    this_cUniTrib   = ""   && unitrib char(6) - Unidade Tributaria

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLF"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(descricaos, "C")
            THIS.this_nAipi      = TratarNulo(aipis,      "N")
            THIS.this_cUnidade   = TratarNulo(unidades,   "C")
            THIS.this_cAliqReds  = TratarNulo(aliqreds,   "C")
            THIS.this_cBaseReds  = TratarNulo(basereds,   "C")
            THIS.this_cIpis      = TratarNulo(ipis,       "C")
            THIS.this_cSitRibs   = TratarNulo(sitribs,    "C")
            THIS.this_nBIcms     = TratarNulo(bicms,      "N")
            THIS.this_nIndIVAST  = TratarNulo(indivast,   "N")
            THIS.this_cIpiProds  = TratarNulo(ipiprods,   "C")
            THIS.this_nTipoMercs = TratarNulo(tipoMercs,  "N")
            THIS.this_nTpSubSt   = TratarNulo(TpSubSt,    "N")
            THIS.this_nBIcmss    = TratarNulo(bicmss,     "N")
            THIS.this_nAliqFcp   = TratarNulo(aliqfcp,    "N")
            THIS.this_cCest      = TratarNulo(cest,        "C")
            THIS.this_cUniTrib   = TratarNulo(unitrib,    "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SIGCDCLF
    * par_cFiltro: condicao WHERE adicional (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades, cest" + ;
                " FROM SIGCDCLF"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades," + ;
                " aliqreds, basereds, ipis, sitribs, bicms, indivast," + ;
                " ipiprods, tipoMercs, TpSubSt, bicmss, aliqfcp, cest, unitrib" + ;
                " FROM SIGCDCLF WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarIVAsPorCodigo - Carrega registros de sigcdiva para cursor local
    * Retorna cursor crIva readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarIVAsPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdiva WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpIva_4c")
            IF loc_nResultado >= 0
                IF USED("crIva")
                    SELECT crIva
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crIva ;
                        (cidchaves C(20), codigos C(10), estasO C(2), estasD C(2), ;
                         indivast N(7,3), indivastpi N(7,3), diasprz N(3,0))
                    SET NULL OFF
                ENDIF
                SELECT TmpIva_4c
                SCAN
                    SELECT crIva
                    APPEND BLANK
                    REPLACE codigos    WITH ALLTRIM(TmpIva_4c.codigos), ;
                            estasO     WITH ALLTRIM(TmpIva_4c.estaso), ;
                            estasD     WITH ALLTRIM(TmpIva_4c.estasd), ;
                            cidchaves  WITH ALLTRIM(TmpIva_4c.cidchaves), ;
                            indivast   WITH TmpIva_4c.indivast, ;
                            indivastpi WITH TmpIva_4c.indivastpi, ;
                            diasprz    WITH TmpIva_4c.diasprz
                ENDSCAN
                USE IN TmpIva_4c
                IF RECCOUNT("crIva") = 0
                    SELECT crIva
                    APPEND BLANK
                ENDIF
                SELECT crIva
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar IVAs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarIVAsPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpIva_4c")
                USE IN TmpIva_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarReducoesPorCodigo - Carrega registros de sigcdred para cursor local
    * Retorna cursor crRed readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarReducoesPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdred WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpRed_4c")
            IF loc_nResultado >= 0
                IF USED("crRed")
                    SELECT crRed
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crRed ;
                        (cidchaves C(20), codigos C(10), estas C(2), ;
                         areds N(6,3), breds N(6,3))
                    SET NULL OFF
                ENDIF
                SELECT TmpRed_4c
                SCAN
                    SELECT crRed
                    APPEND BLANK
                    REPLACE codigos   WITH ALLTRIM(TmpRed_4c.codigos), ;
                            estas     WITH ALLTRIM(TmpRed_4c.estas), ;
                            cidchaves WITH ALLTRIM(TmpRed_4c.cidchaves), ;
                            areds     WITH TmpRed_4c.areds, ;
                            breds     WITH TmpRed_4c.breds
                ENDSCAN
                USE IN TmpRed_4c
                SELECT crRed
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar Redu" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarReducoesPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpRed_4c")
                USE IN TmpRed_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND (THIS.this_nAliqFcp < 0 OR THIS.this_nAliqFcp > 2)
            MsgAviso("Valor da Al" + CHR(237) + "quota FCP Inv" + CHR(225) + "lida. Deve ser entre 0 e 2.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcms < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida ICMS inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcmss < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida Substitui" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicata - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDCLF WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtde > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicata:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChave
        loc_lResultado = .F.
        TRY
            IF THIS.VerificarDuplicata()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCLF" + ;
                    " (codigos, descricaos, aipis, unidades, aliqreds, basereds," + ;
                    " ipis, sitribs, bicms, indivast, ipiprods, tipoMercs," + ;
                    " TpSubSt, bicmss, aliqfcp, cest, unitrib)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                    EscaparSQL(THIS.this_cDescricao) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAipi)      + ", " + ;
                    EscaparSQL(THIS.this_cUnidade)   + ", " + ;
                    EscaparSQL(THIS.this_cAliqReds)  + ", " + ;
                    EscaparSQL(THIS.this_cBaseReds)  + ", " + ;
                    EscaparSQL(THIS.this_cIpis)      + ", " + ;
                    EscaparSQL(THIS.this_cSitRibs)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcms)     + ", " + ;
                    FormatarNumeroSQL(THIS.this_nIndIVAST)  + ", " + ;
                    EscaparSQL(THIS.this_cIpiProds)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTipoMercs) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpSubSt)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcmss)    + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAliqFcp)   + ", " + ;
                    EscaparSQL(THIS.this_cCest)      + ", " + ;
                    EscaparSQL(THIS.this_cUniTrib)   + ")"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.SalvarIVAs(THIS.this_cCodigo)
                    THIS.SalvarReducoes(THIS.this_cCodigo)
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLF SET" + ;
                " descricaos = "  + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " aipis = "       + FormatarNumeroSQL(THIS.this_nAipi)     + "," + ;
                " unidades = "    + EscaparSQL(THIS.this_cUnidade)   + "," + ;
                " aliqreds = "    + EscaparSQL(THIS.this_cAliqReds)  + "," + ;
                " basereds = "    + EscaparSQL(THIS.this_cBaseReds)  + "," + ;
                " ipis = "        + EscaparSQL(THIS.this_cIpis)      + "," + ;
                " sitribs = "     + EscaparSQL(THIS.this_cSitRibs)   + "," + ;
                " bicms = "       + FormatarNumeroSQL(THIS.this_nBIcms)    + "," + ;
                " indivast = "    + FormatarNumeroSQL(THIS.this_nIndIVAST) + "," + ;
                " ipiprods = "    + EscaparSQL(THIS.this_cIpiProds)  + "," + ;
                " tipoMercs = "   + FormatarNumeroSQL(THIS.this_nTipoMercs)+ "," + ;
                " TpSubSt = "     + FormatarNumeroSQL(THIS.this_nTpSubSt)  + "," + ;
                " bicmss = "      + FormatarNumeroSQL(THIS.this_nBIcmss)   + "," + ;
                " aliqfcp = "     + FormatarNumeroSQL(THIS.this_nAliqFcp)  + "," + ;
                " cest = "        + EscaparSQL(THIS.this_cCest)      + "," + ;
                " unitrib = "     + EscaparSQL(THIS.this_cUniTrib)   + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.SalvarIVAs(THIS.this_cCodigo)
                THIS.SalvarReducoes(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM SIGCDCLF WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarIVAs - Salva registros do cursor crIva em sigcdiva
    * Estrategia: DELETE todos os IVAs do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarIVAs(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crIva")
                SELECT crIva
                SCAN
                    IF !EMPTY(ALLTRIM(crIva.estasO)) OR !EMPTY(ALLTRIM(crIva.estasD))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdiva" + ;
                            " (cidchaves, codigos, estaso, estasd, indivast, indivastpi, diasprz)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)            + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))     + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasO))    + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasD))    + ", " + ;
                            FormatarNumeroSQL(crIva.indivast)    + ", " + ;
                            FormatarNumeroSQL(crIva.indivastpi)  + ", " + ;
                            FormatarNumeroSQL(crIva.diasprz)     + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar IVA:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarIVAs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarReducoes - Salva registros do cursor crRed em sigcdred
    * Estrategia: DELETE todas as reducoes do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarReducoes(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crRed")
                SELECT crRed
                SCAN
                    IF !EMPTY(ALLTRIM(crRed.estas))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdred" + ;
                            " (cidchaves, codigos, estas, areds, breds)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)         + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))  + ", " + ;
                            EscaparSQL(ALLTRIM(crRed.estas))  + ", " + ;
                            FormatarNumeroSQL(crRed.areds)    + ", " + ;
                            FormatarNumeroSQL(crRed.breds)    + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar Redu" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarReducoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTemProduto - Verifica se existem produtos com aliquota IPI
    * Retorna .T. se ha produtos com IPI associados a este codigo
    *--------------------------------------------------------------------------
    FUNCTION VerificarTemProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lTem
        loc_lTem = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SigCdPro" + ;
                " WHERE clfiscals = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND ipis = 'S'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmPro")
                TABLEREVERT(.T., "cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_TmPro") > 0
                SELECT cursor_4c_TmPro
                loc_lTem = (cursor_4c_TmPro.qtde > 0)
            ENDIF
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.VerificarTemProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        ENDTRY
        RETURN loc_lTem
    ENDFUNC

ENDDEFINE

