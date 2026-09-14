# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [GRID-SQL] Campo 'Compos' usado em ControlSource de cursor_4c_Compos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Imps' usado em ControlSource de cursor_4c_Opers mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dopes' usado em ControlSource de cursor_4c_Opers mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Imps' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Emps' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Razas' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL

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
  ControlSource = "crSigCdFs.LimDescs"
  ControlSource = "crSigCdFs.sgrus"
  ControlSource = "crSigCdFs.ggrus"
  ControlSource = "crSigCdFs.perfins"
  ControlSource = "crSigCdFs.perinis"
  ControlSource = "crSigCdFs.tipos"
  ControlSource = "crSigCdFs.codigos"
  ControlSource = "crSigCdFs.descrs"
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = "crSigCdFs.Chkbins"
  ControlSource = "crSigCdFs.Blqbonus"
  ControlSource = "crSigCdFs.BlqTabds"
  ControlSource = "crSigCdFs.chkDtAnivs"
  ControlSource = "crSigCdFs.TpDescs"
  DeleteMark = .F.
		lcQuery = [Select ?pNot as Imps, Cemps as Emps, Razas ] + ;
					[From SigCdEmp ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [csSigCdEmp]) < 1)
		Select csSigCdEmp
			.DeleteMark        = .f.
			.Column1.ControlSource   = [csSigCdEmp.Imps]
			.Column2.ControlSource   = [csSigCdEmp.Emps]
			.Column3.ControlSource   = [csSigCdEmp.Razas]
		lcQuery = [Select ?pNot as Imps, a.Dopes From SigCdOpe a inner join SigOpCdc b on b.Dopes = a.Dopes ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [csSigCdOpe]) < 1)
		Select csSigCdOpe
			.DeleteMark        = .f.
			.Column1.ControlSource   = [csSigCdOpe.Imps]
			.Column2.ControlSource   = [csSigCdOpe.Dopes]
		Select * From CrSigCdFsC Where 0=1 Into Cursor csSigPrCp ReadWrite
		Select csSigPrCp
			.DeleteMark        = .f.
			.Column1.ControlSource   = [CsSigPrCp.Compos]
		lcQuery = [Select Distinct Compos from SigCdPro]
		If (.poDataMgr.SqlExecute(lcQuery, [csCompos]) < 1)
		Select csCompos
	Select crSigCdFs
Select crSigCdFs
Update csSigCdEmp Set Imps = .f.
lcQuery = [Select * ] + ;
		    [From SigCdFsI ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEmps]) < 1)
Select LocalEmps
	Update csSigCdEmp Set Imps = .t. Where Emps = LocalEmps.Emps
Update csSigCdOpe set Imps = .F.
lcQuery = [Select * ] + ;
		    [From SigCdFsO ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalOpe]) < 1)
Select LocalOpe
	Update csSigCdOpe Set Imps = .t. Where Dopes = LocalOpe.Dopes
lcQuery = [Select * ] + ;
		    [From SigCdFsC ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalComP]) < 1)
Select LocalComP
	Insert Into CsSigPrCp (Cidchaves,Codigos,Compos) Values ;
Select crSigCdFs
Select CsSigPrCp
Select csSigCdEmp
Select csSigCdOpe
	Select Compos, Sum(1) as Tt From CsSigPrCp Group by 1 having Sum(1) > 1 Into Cursor csSelecao
	Select csSelecao
	lcQuery = [Select b.Grupos, b.Codigos ] + ;
			    [From SigCdCmt a, SigCdClc b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
	lcQuery = [Delete From SigCdFsI Where Codigos = '] + crSigCdFs.Codigos + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete crSigCdFsI)])
	lcQuery = [Delete From SigCdFsO Where Codigos = '] + crSigCdFs.Codigos + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete crSigCdFsO)])
	lcQuery = [Delete From SigCdFsC Where Codigos = '] + crSigCdFs.Codigos + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete crSigCdFsC)])
		Select csSigCdEmp
				Insert Into crSigCdFsI (Codigos, Emps, cIdChaves) Values (crSigCdFs.Codigos, csSigCdEmp.Emps, fUniqueIds())
		If Not ThisForm.poDataMgr.Update([crSigCdFsI])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdFsI)])
		Select csSigCdOpe
				Insert Into crSigCdFsO (Codigos, Dopes, cIdChaves) Values (crSigCdFs.Codigos, csSigCdOpe.Dopes, fUniqueIds())
		If Not ThisForm.poDataMgr.Update([crSigCdFsO])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdFsO)])
		Select csSigPrCp
			Insert Into crSigCdFsC (Codigos, Compos, cIdChaves) Values (crSigCdFs.Codigos, csSigPrCp.Compos, fUniqueIds())
		If Not ThisForm.poDataMgr.Update([crSigCdFsC])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdFsC)])
	Select csSigCdOpe
Select csSigCdOpe
	Select csSigCdEmp
Select csSigCdEmp
	Update csSigCdEmp Set Imps = (This.Value = 1)
	Update csSigCdOpe Set Imps = (This.Value = 1)
	Select CsCompos
	If Not Seek(This.Value)
Select csSigPrCp
Delete
Insert Into CsSigPrCp (Cidchaves,Codigos,Compos) Values ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMda.prg) - TRECHOS RELEVANTES PARA PASS SQL (2604 linhas total):

*-- Linhas 355 a 373:
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .ReadOnly           = .T.
364:             .Visible            = .T.
365:         ENDWITH
366: 
367:         WITH loc_oPagina.grd_4c_Lista.Column1
368:             .Width     = 80
369:             .Alignment = 0
370:             .Header1.Caption = ""
371:         ENDWITH
372: 
373:         WITH loc_oPagina.grd_4c_Lista.Column2

*-- Linhas 1067 a 1093:
1067:             .FontSize    = 8
1068:             .GridLines   = 2
1069:             .RecordMark  = .F.
1070:             .DeleteMark  = .F.
1071:             .ScrollBars  = 2
1072:             .ReadOnly    = .F.
1073:             .Movable     = .F.
1074:             .Resizable   = .F.
1075:             .Visible     = .T.
1076:         ENDWITH
1077: 
1078:         *-- Column1: CheckBox para Imps (RecordSource/ControlSource set em CarregarRelacionados)
1079:         WITH loc_oPagina.grd_4c_Opers.Column1
1080:             .Width     = 20
1081:             .Movable   = .F.
1082:             .Resizable = .F.
1083:             .ReadOnly  = .F.
1084:             .Sparse    = .F.
1085:         ENDWITH
1086:         loc_oPagina.grd_4c_Opers.Column1.Header1.Caption   = ""
1087:         loc_oPagina.grd_4c_Opers.Column1.Header1.Alignment = 2
1088:         loc_oPagina.grd_4c_Opers.Column1.AddObject("Check1", "CheckBox")
1089:         WITH loc_oPagina.grd_4c_Opers.Column1.Check1
1090:             .Caption   = ""
1091:             .Alignment = 0
1092:             .ReadOnly  = .F.
1093:             .Visible   = .T.

*-- Linhas 1178 a 1196:
1178:             .FontSize    = 8
1179:             .GridLines   = 2
1180:             .RecordMark  = .F.
1181:             .DeleteMark  = .F.
1182:             .ScrollBars  = 2
1183:             .ReadOnly    = .F.
1184:             .Movable     = .F.
1185:             .Resizable   = .F.
1186:             .Visible     = .T.
1187:         ENDWITH
1188: 
1189:         *-- Column1: CheckBox para Imps
1190:         WITH loc_oPagina.grd_4c_Emps.Column1
1191:             .Width     = 20
1192:             .Movable   = .F.
1193:             .Resizable = .F.
1194:             .ReadOnly  = .F.
1195:             .Sparse    = .F.
1196:         ENDWITH

*-- Linhas 1300 a 1318:
1300:             .FontSize    = 8
1301:             .GridLines   = 2
1302:             .RecordMark  = .F.
1303:             .DeleteMark  = .F.
1304:             .ScrollBars  = 2
1305:             .ReadOnly    = .F.
1306:             .Movable     = .F.
1307:             .Resizable   = .F.
1308:             .Visible     = .T.
1309:         ENDWITH
1310: 
1311:         WITH loc_oPagina.grd_4c_Compo.Column1
1312:             .Width     = 244
1313:             .Movable   = .F.
1314:             .Resizable = .F.
1315:             .ReadOnly  = .F.
1316:         ENDWITH
1317:         loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
1318: 

*-- Linhas 1382 a 1403:
1382:                         loc_oGrid.ColumnCount = 3
1383:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1384: 
1385:                         *-- ControlSource SEMPRE apos RecordSource (Problema 48)
1386:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1387:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1388:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1389: 
1390:                         loc_oGrid.Column1.Width     = 80
1391:                         loc_oGrid.Column2.Width     = 290
1392:                         loc_oGrid.Column3.Width     = 40
1393:                         loc_oGrid.Column1.Alignment = 0
1394:                         loc_oGrid.Column2.Alignment = 0
1395:                         loc_oGrid.Column3.Alignment = 2
1396: 
1397:                         *-- Headers OBRIGATORIO apos RecordSource (Problema 6/32)
1398:                         loc_oGrid.Column1.Header1.Caption = ""
1399:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1400:                         loc_oGrid.Column3.Header1.Caption = ""
1401: 
1402:                         THIS.FormatarGridLista(loc_oGrid)
1403:                         loc_oGrid.Refresh()

*-- Linhas 1462 a 1487:
1462: 
1463:         TRY
1464:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1465:                 IF THIS.this_oBusinessObject.Salvar()
1466:                     *-- Salvar relacionados quando cursores existirem (habilitado em Fase 6+)
1467:                     IF USED("cursor_4c_Emps") OR USED("cursor_4c_Opers") OR USED("cursor_4c_Compos")
1468:                         THIS.this_oBusinessObject.SalvarRelacionados( ;
1469:                             THIS.this_oBusinessObject.this_cCodigos, ;
1470:                             "cursor_4c_Emps", ;
1471:                             "cursor_4c_Opers", ;
1472:                             "cursor_4c_Compos")
1473:                     ENDIF
1474:                     MsgInfo("Registro salvo com sucesso!")
1475:                     THIS.pgf_4c_Paginas.ActivePage = 1
1476:                     THIS.this_cModoAtual = "LISTA"
1477:                     THIS.CarregarLista()
1478:                     loc_lResultado = .T.
1479:                 ENDIF
1480:             ENDIF
1481:         CATCH TO loException
1482:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
1483:                 "FormMda.BtnSalvarClick")
1484:         ENDTRY
1485: 
1486:         RETURN loc_lResultado
1487:     ENDPROC

*-- Linhas 1543 a 1561:
1543:         loc_cCodigo = ""
1544: 
1545:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1546:             SELECT cursor_4c_Dados
1547:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1548:         ENDIF
1549: 
1550:         IF EMPTY(loc_cCodigo)
1551:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1552:             RETURN
1553:         ENDIF
1554: 
1555:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1556:             THIS.this_cModoAtual = "VISUALIZAR"
1557:             THIS.BOParaForm()
1558:             THIS.HabilitarCampos(.F.)
1559:             THIS.AlternarPagina(2)
1560:             THIS.CarregarRelacionados(loc_cCodigo)
1561:         ENDIF

*-- Linhas 1570 a 1588:
1570:         loc_cCodigo = ""
1571: 
1572:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1573:             SELECT cursor_4c_Dados
1574:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1575:         ENDIF
1576: 
1577:         IF EMPTY(loc_cCodigo)
1578:             MsgAviso("Selecione um registro na lista.", "Alterar")
1579:             RETURN
1580:         ENDIF
1581: 
1582:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1583:             THIS.this_oBusinessObject.EditarRegistro()
1584:             THIS.this_cModoAtual = "ALTERAR"
1585:             THIS.BOParaForm()
1586:             THIS.HabilitarCampos(.T.)
1587:             THIS.AlternarPagina(2)
1588:             THIS.CarregarRelacionados(loc_cCodigo)

*-- Linhas 1599 a 1617:
1599:         loc_cDescricao = ""
1600: 
1601:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1602:             SELECT cursor_4c_Dados
1603:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
1604:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)
1605:         ENDIF
1606: 
1607:         IF EMPTY(loc_cCodigo)
1608:             MsgAviso("Selecione um registro na lista.", "Excluir")
1609:             RETURN
1610:         ENDIF
1611: 
1612:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do motivo:" + CHR(13) + ;
1613:                 loc_cCodigo + " - " + loc_cDescricao + "?", ;
1614:                 "Confirmar Exclus" + CHR(227) + "o")
1615:             RETURN
1616:         ENDIF
1617: 

*-- Linhas 1643 a 1683:
1643:                 loc_oBusca.Show()
1644: 
1645:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMda")
1646:                     SELECT cursor_4c_BuscaMda
1647:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaMda.codigos)
1648:                 ENDIF
1649: 
1650:                 loc_oBusca.Release()
1651:             ENDIF
1652:         CATCH TO loException
1653:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1654:                 "FormMda.BtnBuscarClick")
1655:         ENDTRY
1656: 
1657:         IF USED("cursor_4c_BuscaMda")
1658:             USE IN cursor_4c_BuscaMda
1659:         ENDIF
1660: 
1661:         IF !EMPTY(loc_cCodigo)
1662:             IF THIS.this_oBusinessObject.Buscar("codigos = " + EscaparSQL(loc_cCodigo))
1663:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1664:                 loc_oGrid.ColumnCount = 3
1665:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1666:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1667:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1668:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1669:                 loc_oGrid.Column1.Header1.Caption = ""
1670:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1671:                 loc_oGrid.Column3.Header1.Caption = ""
1672:                 loc_oGrid.Refresh()
1673:             ENDIF
1674:         ELSE
1675:             THIS.CarregarLista()
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *===========================================================================
1680:     * FormParaBO - Transfere valores dos campos de Page2 para o BO
1681:     * Controles verificados com PEMSTATUS para compatibilidade multi-fase
1682:     *===========================================================================
1683:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 1894 a 1927:
1894:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1895:             loc_oPagina.opt_4c_OptTpDescs.Value = 1
1896:         ENDIF
1897: 
1898:         *-- Limpar cursores dos grids relacionados (recarregados em CarregarRelacionados)
1899:         IF USED("cursor_4c_Emps")
1900:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
1901:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5)
1902:                 loc_oPagina.grd_4c_Emps.Refresh()
1903:             ENDIF
1904:         ENDIF
1905:         IF USED("cursor_4c_Opers")
1906:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
1907:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5)
1908:                 loc_oPagina.grd_4c_Opers.Refresh()
1909:             ENDIF
1910:         ENDIF
1911:         IF USED("cursor_4c_Compos")
1912:             ZAP IN cursor_4c_Compos
1913:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
1914:                 loc_oPagina.grd_4c_Compo.Refresh()
1915:             ENDIF
1916:         ENDIF
1917:     ENDPROC
1918: 
1919:     *===========================================================================
1920:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo atual
1921:     *===========================================================================
1922:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1923:         LOCAL loc_oPagina, loc_lEditar
1924:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1925:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1926: 
1927:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)

*-- Linhas 1985 a 2028:
1985:         ENDIF
1986: 
1987:         TRY
1988:             loc_nRows = SQLEXEC(gnConnHandle, ;
1989:                 "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod), ;
1990:                 "cursor_4c_BuscaGGrus")
1991: 
1992:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
1993:                 loc_oPagina.txt_4c_GGrus.Value = ALLTRIM(cursor_4c_BuscaGGrus.codigos)
1994:                 IF USED("cursor_4c_BuscaGGrus")
1995:                     USE IN cursor_4c_BuscaGGrus
1996:                 ENDIF
1997:             ELSE
1998:                 IF USED("cursor_4c_BuscaGGrus")
1999:                     USE IN cursor_4c_BuscaGGrus
2000:                 ENDIF
2001: 
2002:                 *-- Nao encontrado exato: busca parcial para picker
2003:                 loc_nRows = SQLEXEC(gnConnHandle, ;
2004:                     "SELECT codigos, descs FROM SigCdGpr WHERE codigos LIKE " + ;
2005:                     EscaparSQL(loc_cCod + "%") + " ORDER BY codigos", ;
2006:                     "cursor_4c_BuscaGGrus")
2007: 
2008:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaGGrus") OR EOF("cursor_4c_BuscaGGrus")
2009:                     IF USED("cursor_4c_BuscaGGrus")
2010:                         USE IN cursor_4c_BuscaGGrus
2011:                     ENDIF
2012:                     SQLEXEC(gnConnHandle, ;
2013:                         "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
2014:                         "cursor_4c_BuscaGGrus")
2015:                 ENDIF
2016: 
2017:                 IF USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
2018:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2019:                     IF VARTYPE(loc_oBusca) = "O"
2020:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGGrus"
2021:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaGGrus", "codigos", "descs", ;
2022:                             "Buscar Grande Grupo")
2023:                         loc_oBusca.Mostrar()
2024:                         IF loc_oBusca.this_lSelecionou
2025:                             loc_oPagina.txt_4c_GGrus.Value = loc_oBusca.cCodigoSelecionado
2026:                         ELSE
2027:                             loc_oPagina.txt_4c_GGrus.Value = ""
2028:                         ENDIF

*-- Linhas 2069 a 2112:
2069:         ENDIF
2070: 
2071:         TRY
2072:             loc_nRows = SQLEXEC(gnConnHandle, ;
2073:                 "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + EscaparSQL(loc_cCod), ;
2074:                 "cursor_4c_BuscaSGrus")
2075: 
2076:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2077:                 loc_oPagina.txt_4c_SGrus.Value = ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
2078:                 IF USED("cursor_4c_BuscaSGrus")
2079:                     USE IN cursor_4c_BuscaSGrus
2080:                 ENDIF
2081:             ELSE
2082:                 IF USED("cursor_4c_BuscaSGrus")
2083:                     USE IN cursor_4c_BuscaSGrus
2084:                 ENDIF
2085: 
2086:                 *-- Nao encontrado exato: busca parcial para picker
2087:                 loc_nRows = SQLEXEC(gnConnHandle, ;
2088:                     "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos LIKE " + ;
2089:                     EscaparSQL(loc_cCod + "%") + " ORDER BY Codigos", ;
2090:                     "cursor_4c_BuscaSGrus")
2091: 
2092:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaSGrus") OR EOF("cursor_4c_BuscaSGrus")
2093:                     IF USED("cursor_4c_BuscaSGrus")
2094:                         USE IN cursor_4c_BuscaSGrus
2095:                     ENDIF
2096:                     SQLEXEC(gnConnHandle, ;
2097:                         "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
2098:                         "cursor_4c_BuscaSGrus")
2099:                 ENDIF
2100: 
2101:                 IF USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2102:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2103:                     IF VARTYPE(loc_oBusca) = "O"
2104:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSGrus"
2105:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaSGrus", "Codigos", "Descricaos", ;
2106:                             "Buscar SubGrupo")
2107:                         loc_oBusca.Mostrar()
2108:                         IF loc_oBusca.this_lSelecionou
2109:                             loc_oPagina.txt_4c_SGrus.Value = loc_oBusca.cCodigoSelecionado
2110:                         ELSE
2111:                             loc_oPagina.txt_4c_SGrus.Value = ""
2112:                         ENDIF

*-- Linhas 2147 a 2534:
2147:             THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
2148:             THIS.this_oBusinessObject.CarregarComposicoes(par_cCodigos)
2149:             THIS.this_oBusinessObject.BuscarComposicoesProdutos()
2150: 
2151:             *-- Grid Operacoes
2152:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5) AND USED("cursor_4c_Opers")
2153:                 loc_oGrd = loc_oPagina.grd_4c_Opers
2154:                 *-- RecordSource e ControlSource FORA de WITH (Problema 36/48)
2155:                 loc_oGrd.ColumnCount = 2
2156:                 loc_oGrd.RecordSource          = "cursor_4c_Opers"
2157:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Opers.Imps"
2158:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Opers.Dopes"
2159:                 *-- Headers OBRIGATORIO apos RecordSource (Problema 32)
2160:                 loc_oGrd.Column1.Header1.Caption = ""
2161:                 loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
2162:                 loc_oGrd.Refresh()
2163:             ENDIF
2164: 
2165:             *-- Grid Empresas
2166:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5) AND USED("cursor_4c_Emps")
2167:                 loc_oGrd = loc_oPagina.grd_4c_Emps
2168:                 loc_oGrd.ColumnCount = 3
2169:                 loc_oGrd.RecordSource          = "cursor_4c_Emps"
2170:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Emps.Imps"
2171:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Emps.Emps"
2172:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Emps.Razas"
2173:                 loc_oGrd.Column1.Header1.Caption = ""
2174:                 loc_oGrd.Column2.Header1.Caption = "Emp."
2175:                 loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2176:                 loc_oGrd.Refresh()
2177:             ENDIF
2178: 
2179:             *-- Grid Composicoes
2180:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5) AND USED("cursor_4c_Compos")
2181:                 loc_oGrd = loc_oPagina.grd_4c_Compo
2182:                 loc_oGrd.ColumnCount = 1
2183:                 loc_oGrd.RecordSource          = "cursor_4c_Compos"
2184:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Compos.Compos"
2185:                 loc_oGrd.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2186:                 loc_oGrd.Refresh()
2187:             ENDIF
2188: 
2189:             loc_lResultado = .T.
2190: 
2191:         CATCH TO loException
2192:             MostrarErro("Erro ao carregar relacionados:" + CHR(13) + loException.Message, ;
2193:                 "FormMda.CarregarRelacionados")
2194:         ENDTRY
2195: 
2196:         RETURN loc_lResultado
2197:     ENDPROC
2198: 
2199:     *===========================================================================
2200:     * OperCheckboxMouseDown - Toggle Imps em cursor_4c_Opers via mouse
2201:     * PUBLIC: BINDEVENT requer metodo publico
2202:     *===========================================================================
2203:     PROCEDURE OperCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2204:         IF THIS.this_cModoAtual = "VISUALIZAR"
2205:             NODEFAULT
2206:             RETURN
2207:         ENDIF
2208:         IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2209:             SELECT cursor_4c_Opers
2210:             REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2211:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2212:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2213:             ENDIF
2214:         ENDIF
2215:         NODEFAULT
2216:     ENDPROC
2217: 
2218:     *===========================================================================
2219:     * OperCheckboxMouseUp - Suprime comportamento padrao
2220:     * PUBLIC: BINDEVENT requer metodo publico
2221:     *===========================================================================
2222:     PROCEDURE OperCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2223:         NODEFAULT
2224:     ENDPROC
2225: 
2226:     *===========================================================================
2227:     * OperCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2228:     * PUBLIC: BINDEVENT requer metodo publico
2229:     *===========================================================================
2230:     PROCEDURE OperCheckboxClick()
2231:         NODEFAULT
2232:     ENDPROC
2233: 
2234:     *===========================================================================
2235:     * OperCheckboxKeyPress - Toggle Imps em cursor_4c_Opers via teclado
2236:     * PUBLIC: BINDEVENT requer metodo publico
2237:     *===========================================================================
2238:     PROCEDURE OperCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2239:         IF THIS.this_cModoAtual = "VISUALIZAR"
2240:             NODEFAULT
2241:             RETURN
2242:         ENDIF
2243:         IF INLIST(par_nKeyCode, 13, 32)
2244:             IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2245:                 SELECT cursor_4c_Opers
2246:                 REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2247:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2248:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2249:                 ENDIF
2250:             ENDIF
2251:             NODEFAULT
2252:         ENDIF
2253:     ENDPROC
2254: 
2255:     *===========================================================================
2256:     * EmpCheckboxMouseDown - Toggle Imps em cursor_4c_Emps via mouse
2257:     * PUBLIC: BINDEVENT requer metodo publico
2258:     *===========================================================================
2259:     PROCEDURE EmpCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2260:         IF THIS.this_cModoAtual = "VISUALIZAR"
2261:             NODEFAULT
2262:             RETURN
2263:         ENDIF
2264:         IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2265:             SELECT cursor_4c_Emps
2266:             REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2267:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2268:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2269:             ENDIF
2270:         ENDIF
2271:         NODEFAULT
2272:     ENDPROC
2273: 
2274:     *===========================================================================
2275:     * EmpCheckboxMouseUp - Suprime comportamento padrao
2276:     * PUBLIC: BINDEVENT requer metodo publico
2277:     *===========================================================================
2278:     PROCEDURE EmpCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2279:         NODEFAULT
2280:     ENDPROC
2281: 
2282:     *===========================================================================
2283:     * EmpCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2284:     * PUBLIC: BINDEVENT requer metodo publico
2285:     *===========================================================================
2286:     PROCEDURE EmpCheckboxClick()
2287:         NODEFAULT
2288:     ENDPROC
2289: 
2290:     *===========================================================================
2291:     * EmpCheckboxKeyPress - Toggle Imps em cursor_4c_Emps via teclado
2292:     * PUBLIC: BINDEVENT requer metodo publico
2293:     *===========================================================================
2294:     PROCEDURE EmpCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2295:         IF THIS.this_cModoAtual = "VISUALIZAR"
2296:             NODEFAULT
2297:             RETURN
2298:         ENDIF
2299:         IF INLIST(par_nKeyCode, 13, 32)
2300:             IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2301:                 SELECT cursor_4c_Emps
2302:                 REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2303:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2304:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2305:                 ENDIF
2306:             ENDIF
2307:             NODEFAULT
2308:         ENDIF
2309:     ENDPROC
2310: 
2311:     *===========================================================================
2312:     * MarcaTodosOpersClick - Marca todas operacoes (Imps = .T.)
2313:     * PUBLIC: BINDEVENT requer metodo publico
2314:     *===========================================================================
2315:     PROCEDURE MarcaTodosOpersClick()
2316:         IF USED("cursor_4c_Opers")
2317:             REPLACE ALL Imps WITH .T. IN cursor_4c_Opers
2318:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2319:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2320:             ENDIF
2321:         ENDIF
2322:     ENDPROC
2323: 
2324:     *===========================================================================
2325:     * DesmarcaTodosOpersClick - Desmarca todas operacoes (Imps = .F.)
2326:     * PUBLIC: BINDEVENT requer metodo publico
2327:     *===========================================================================
2328:     PROCEDURE DesmarcaTodosOpersClick()
2329:         IF USED("cursor_4c_Opers")
2330:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
2331:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2332:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2333:             ENDIF
2334:         ENDIF
2335:     ENDPROC
2336: 
2337:     *===========================================================================
2338:     * MarcaTodosEmpsClick - Marca todas empresas (Imps = .T.)
2339:     * PUBLIC: BINDEVENT requer metodo publico
2340:     *===========================================================================
2341:     PROCEDURE MarcaTodosEmpsClick()
2342:         IF USED("cursor_4c_Emps")
2343:             REPLACE ALL Imps WITH .T. IN cursor_4c_Emps
2344:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2345:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2346:             ENDIF
2347:         ENDIF
2348:     ENDPROC
2349: 
2350:     *===========================================================================
2351:     * DesmarcaTodosEmpsClick - Desmarca todas empresas (Imps = .F.)
2352:     * PUBLIC: BINDEVENT requer metodo publico
2353:     *===========================================================================
2354:     PROCEDURE DesmarcaTodosEmpsClick()
2355:         IF USED("cursor_4c_Emps")
2356:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
2357:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2358:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2359:             ENDIF
2360:         ENDIF
2361:     ENDPROC
2362: 
2363:     *===========================================================================
2364:     * CompoInserirClick - Insere linha vazia em cursor_4c_Compos
2365:     * PUBLIC: BINDEVENT requer metodo publico
2366:     *===========================================================================
2367:     PROCEDURE CompoInserirClick()
2368:         LOCAL loc_oPagina
2369:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2370: 
2371:         IF !USED("cursor_4c_Compos")
2372:             RETURN
2373:         ENDIF
2374: 
2375:         SELECT cursor_4c_Compos
2376:         APPEND BLANK
2377:         REPLACE Compos WITH "" IN cursor_4c_Compos
2378:         GO BOTTOM IN cursor_4c_Compos
2379: 
2380:         IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2381:             loc_oPagina.grd_4c_Compo.Refresh()
2382:         ENDIF
2383:     ENDPROC
2384: 
2385:     *===========================================================================
2386:     * CompoExcluirClick - Exclui linha atual de cursor_4c_Compos
2387:     * PUBLIC: BINDEVENT requer metodo publico
2388:     *===========================================================================
2389:     PROCEDURE CompoExcluirClick()
2390:         LOCAL loc_oPagina, loc_nRec
2391:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2392: 
2393:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos") OR ;
2394:            RECCOUNT("cursor_4c_Compos") = 0
2395:             RETURN
2396:         ENDIF
2397: 
2398:         TRY
2399:             SELECT cursor_4c_Compos
2400:             loc_nRec = RECNO("cursor_4c_Compos")
2401: 
2402:             *-- Rebuild writable cursor excluindo o registro atual
2403:             IF USED("cursor_4c_CompoTemp")
2404:                 USE IN cursor_4c_CompoTemp
2405:             ENDIF
2406:             SELECT Compos FROM cursor_4c_Compos ;
2407:                 WHERE RECNO() != loc_nRec ;
2408:                 INTO CURSOR cursor_4c_CompoTemp READWRITE
2409:             USE IN cursor_4c_Compos
2410: 
2411:             IF USED("cursor_4c_CompoTemp") AND RECCOUNT("cursor_4c_CompoTemp") > 0
2412:                 SELECT Compos FROM cursor_4c_CompoTemp ;
2413:                     INTO CURSOR cursor_4c_Compos READWRITE
2414:                 USE IN cursor_4c_CompoTemp
2415:                 GO BOTTOM IN cursor_4c_Compos
2416:             ELSE
2417:                 IF USED("cursor_4c_CompoTemp")
2418:                     USE IN cursor_4c_CompoTemp
2419:                 ENDIF
2420:                 SET NULL ON
2421:                 CREATE CURSOR cursor_4c_Compos (Compos C(30))
2422:                 SET NULL OFF
2423:             ENDIF
2424: 
2425:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2426:                 loc_oPagina.grd_4c_Compo.ColumnCount = 1
2427:                 loc_oPagina.grd_4c_Compo.RecordSource          = "cursor_4c_Compos"
2428:                 loc_oPagina.grd_4c_Compo.Column1.ControlSource = "cursor_4c_Compos.Compos"
2429:                 loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2430:                 loc_oPagina.grd_4c_Compo.Refresh()
2431:             ENDIF
2432: 
2433:         CATCH TO loException
2434:             MostrarErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2435:                 loException.Message, "FormMda.CompoExcluirClick")
2436:         ENDTRY
2437:     ENDPROC
2438: 
2439:     *===========================================================================
2440:     * CompoTextValid - Valida/busca composicao digitada em grd_4c_Compo
2441:     * PUBLIC: BINDEVENT requer metodo publico
2442:     *===========================================================================
2443:     PROCEDURE CompoTextValid()
2444:         LOCAL loc_cCompo, loc_oBusca, loc_lOk
2445:         loc_lOk = .T.
2446: 
2447:         IF THIS.this_cModoAtual = "VISUALIZAR"
2448:             RETURN loc_lOk
2449:         ENDIF
2450: 
2451:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos")
2452:             RETURN loc_lOk
2453:         ENDIF
2454: 
2455:         loc_cCompo = ALLTRIM(cursor_4c_Compos.Compos)
2456: 
2457:         IF EMPTY(loc_cCompo)
2458:             RETURN loc_lOk
2459:         ENDIF
2460: 
2461:         IF !USED("cursor_4c_CsCompos") OR RECCOUNT("cursor_4c_CsCompos") = 0
2462:             RETURN loc_lOk
2463:         ENDIF
2464: 
2465:         TRY
2466:             *-- Busca exata
2467:             SELECT cursor_4c_CsCompos
2468:             LOCATE FOR UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) = UPPER(loc_cCompo)
2469: 
2470:             IF !EOF("cursor_4c_CsCompos")
2471:                 *-- Encontrado: normaliza para forma canonica
2472:                 SELECT cursor_4c_Compos
2473:                 REPLACE Compos WITH ALLTRIM(cursor_4c_CsCompos.Compos) IN cursor_4c_Compos
2474:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2475:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2476:                 ENDIF
2477:             ELSE
2478:                 *-- Nao encontrado: abre picker com filtro parcial
2479:                 SELECT cursor_4c_Compos
2480: 
2481:                 IF USED("cursor_4c_BuscaCompo")
2482:                     USE IN cursor_4c_BuscaCompo
2483:                 ENDIF
2484: 
2485:                 SELECT Compos FROM cursor_4c_CsCompos ;
2486:                     WHERE UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) LIKE "%" + UPPER(loc_cCompo) + "%" ;
2487:                     ORDER BY cursor_4c_CsCompos.Compos ;
2488:                     INTO CURSOR cursor_4c_BuscaCompo
2489: 
2490:                 IF !USED("cursor_4c_BuscaCompo") OR EOF("cursor_4c_BuscaCompo")
2491:                     IF USED("cursor_4c_BuscaCompo")
2492:                         USE IN cursor_4c_BuscaCompo
2493:                     ENDIF
2494:                     SELECT Compos FROM cursor_4c_CsCompos ;
2495:                         ORDER BY cursor_4c_CsCompos.Compos ;
2496:                         INTO CURSOR cursor_4c_BuscaCompo
2497:                 ENDIF
2498: 
2499:                 IF USED("cursor_4c_BuscaCompo") AND !EOF("cursor_4c_BuscaCompo")
2500:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2501:                     IF VARTYPE(loc_oBusca) = "O"
2502:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCompo"
2503:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCompo", "Compos", "Compos", ;
2504:                             "Buscar Composi" + CHR(231) + CHR(227) + "o")
2505:                         loc_oBusca.Mostrar()
2506:                         SELECT cursor_4c_Compos
2507:                         IF loc_oBusca.this_lSelecionou
2508:                             REPLACE Compos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado) IN cursor_4c_Compos
2509:                         ELSE
2510:                             REPLACE Compos WITH "" IN cursor_4c_Compos
2511:                         ENDIF
2512:                         loc_oBusca.Release()
2513:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2514:                             THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2515:                         ENDIF
2516:                     ENDIF
2517:                 ELSE
2518:                     SELECT cursor_4c_Compos
2519:                     REPLACE Compos WITH "" IN cursor_4c_Compos
2520:                 ENDIF
2521: 
2522:                 IF USED("cursor_4c_BuscaCompo")
2523:                     USE IN cursor_4c_BuscaCompo
2524:                 ENDIF
2525:             ENDIF
2526: 
2527:         CATCH TO loException
2528:             MostrarErro("Erro ao validar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2529:                 loException.Message, "FormMda.CompoTextValid")
2530:         ENDTRY
2531: 
2532:         RETURN loc_lOk
2533:     ENDPROC
2534: 

*-- Linhas 2580 a 2604:
2580: 
2581:         IF USED("cursor_4c_BuscaMda")
2582:             USE IN cursor_4c_BuscaMda
2583:         ENDIF
2584: 
2585:         IF USED("cursor_4c_Emps")
2586:             USE IN cursor_4c_Emps
2587:         ENDIF
2588:         IF USED("cursor_4c_Opers")
2589:             USE IN cursor_4c_Opers
2590:         ENDIF
2591:         IF USED("cursor_4c_Compos")
2592:             USE IN cursor_4c_Compos
2593:         ENDIF
2594:         IF USED("cursor_4c_CsCompos")
2595:             USE IN cursor_4c_CsCompos
2596:         ENDIF
2597:         IF USED("cursor_4c_BuscaCompo")
2598:             USE IN cursor_4c_BuscaCompo
2599:         ENDIF
2600: 
2601:         DODEFAULT()
2602:     ENDPROC
2603: 
2604: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MdaBO.prg):
*==============================================================================
* MdaBO.prg - Business Object para Motivos de Desconto / Acrescimo
* Tabela principal: SigCdFs
* Tabelas relacionadas: SigCdFsi (empresas), SigCdFso (operacoes), SigCdFsc (composicoes)
*==============================================================================

DEFINE CLASS MdaBO AS BusinessBase

    *-- Propriedades da tabela SigCdFs
    this_cCodigos    = ""    && codigos char(10) PK
    this_cDescrs     = ""    && descrs char(40)
    this_cTipos      = ""    && tipos char(1) - "D"=Desconto, "A"=Acrescimo
    this_nBlqbonus   = 0     && blqbonus numeric(1,0) - nao gerar bonus (1=Sim, 0=Nao)
    this_nBlqtabds   = 0     && blqtabds numeric(1,0) - bloquear tab.desconto
    this_nChkbins    = 0     && chkbins numeric(1,0) - bloquear desconto BIN
    this_nChkdtanivs = 0     && chkdtanivs numeric(1,0) - checar data aniversario
    this_cGgrus      = ""    && ggrus char(3) - grande grupo
    this_nLimdescs   = 0     && limdescs numeric(5,2) - limite de desconto
    this_dPerfins    = {}    && perfins datetime NULL - periodo fim
    this_dPerinis    = {}    && perinis datetime NULL - periodo inicio
    this_cSgrus      = ""    && sgrus char(6) - sub-grupo
    this_nTpdescs    = 0     && tpdescs numeric(1,0) - tipo desconto (0=Geral, 1=por Produto)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFs"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    SELECT 0 FROM cursor_4c_Dados WHERE .F. INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar motivos de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       " chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       " perinis, sgrus, tpdescs" + ;
                       " FROM SigCdFs" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos,    "C"))
            THIS.this_cDescrs     = ALLTRIM(TratarNulo(descrs,     "C"))
            THIS.this_cTipos      = ALLTRIM(TratarNulo(tipos,      "C"))
            THIS.this_nBlqbonus   = TratarNulo(blqbonus,   "N")
            THIS.this_nBlqtabds   = TratarNulo(blqtabds,   "N")
            THIS.this_nChkbins    = TratarNulo(chkbins,    "N")
            THIS.this_nChkdtanivs = TratarNulo(chkdtanivs, "N")
            THIS.this_cGgrus      = ALLTRIM(TratarNulo(ggrus,  "C"))
            THIS.this_nLimdescs   = TratarNulo(limdescs,   "N")
            THIS.this_dPerfins    = TratarNulo(perfins,    "D")
            THIS.this_dPerinis    = TratarNulo(perinis,    "D")
            THIS.this_cSgrus      = ALLTRIM(TratarNulo(sgrus,  "C"))
            THIS.this_nTpdescs    = TratarNulo(tpdescs,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdFs" + ;
                       " (codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       "  chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       "  perinis, sgrus, tpdescs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqbonus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkdtanivs) + ", " + ;
                       EscaparSQL(THIS.this_cGgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimdescs) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + ", " + ;
                       EscaparSQL(THIS.this_cSgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdFs SET" + ;
                       "  descrs      = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       "  tipos       = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       "  blqbonus    = " + FormatarNumeroSQL(THIS.this_nBlqbonus) + "," + ;
                       "  blqtabds    = " + FormatarNumeroSQL(THIS.this_nBlqtabds) + "," + ;
                       "  chkbins     = " + FormatarNumeroSQL(THIS.this_nChkbins) + "," + ;
                       "  chkdtanivs  = " + FormatarNumeroSQL(THIS.this_nChkdtanivs) + "," + ;
                       "  ggrus       = " + EscaparSQL(THIS.this_cGgrus) + "," + ;
                       "  limdescs    = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
                       "  perfins     = " + IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + "," + ;
                       "  perinis     = " + IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + "," + ;
                       "  sgrus       = " + EscaparSQL(THIS.this_cSgrus) + "," + ;
                       "  tpdescs     = " + FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se motivo esta em uso em SigCdCmt/SigCdClc
            loc_cSQL = "SELECT b.Grupos, b.Codigos" + ;
                       " FROM SigCdCmt a, SigCdClc b" + ;
                       " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                       " AND a.fkChaves = b.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifUso")
            IF loc_nResult < 0
                MsgErro("Erro ao verificar uso do motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN cursor_4c_VerifUso
                IF !EOF("cursor_4c_VerifUso")
                    MsgErro("O Motivo Est" + CHR(225) + " Em Uso No Cadastro de Classifica" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + ;
                            "Grupo : " + ALLTRIM(cursor_4c_VerifUso.Grupos) + ;
                            " - C" + CHR(243) + "digo : " + ALLTRIM(cursor_4c_VerifUso.Codigos), ;
                            "Exclus" + CHR(227) + "o N" + CHR(227) + "o Permitida!!!")
                ELSE
                    *-- Excluir registros relacionados primeiro
                    loc_lSucesso = THIS.ExcluirRelacionados()
                    IF loc_lSucesso
                        loc_cSQL = "DELETE FROM SigCdFs WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
                        IF loc_nResult >= 0
                            THIS.RegistrarAuditoria("DELETE")
                        ELSE
                            MsgErro("Erro ao excluir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Delete")
                            USE IN cursor_4c_Delete
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_VerifUso")
            USE IN cursor_4c_VerifUso
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRelacionados - Salva empresas, operacoes e composicoes do motivo
    * Par: par_cCodigos - codigo do motivo
    * Par: par_cCursorEmps - cursor com empresas selecionadas (csSigCdEmp)
    * Par: par_cCursorOpes - cursor com operacoes selecionadas (csSigCdOpe)
    * Par: par_cCursorCompo - cursor com composicoes (csSigPrCp)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarRelacionados(par_cCodigos, par_cCursorEmps, par_cCursorOpes, par_cCursorCompo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            *-- Deletar relacionamentos anteriores
            loc_lSucesso = THIS.ExcluirRelacionados()

            IF loc_lSucesso
                *-- Inserir empresas selecionadas em SigCdFsi
                IF USED(par_cCursorEmps)
                    SELECT (par_cCursorEmps)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsi (cIdChaves, Codigos, Emps)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Emps)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsEmp")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsEmp")
                                USE IN cursor_4c_InsEmp
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir operacoes selecionadas em SigCdFso
                IF loc_lSucesso AND USED(par_cCursorOpes)
                    SELECT (par_cCursorOpes)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFso (cIdChaves, Codigos, Dopes)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Dopes)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOpe")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsOpe")
                                USE IN cursor_4c_InsOpe
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir composicoes em SigCdFsc
                IF loc_lSucesso AND USED(par_cCursorCompo)
                    SELECT (par_cCursorCompo)
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(Compos))
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsc (cIdChaves, Codigos, Compos)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Compos)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsCompo")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsCompo")
                                USE IN cursor_4c_InsCompo
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.SalvarRelacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirRelacionados - Deleta SigCdFsi/SigCdFso/SigCdFsc pelo codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExcluirRelacionados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFsi WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsi")
            IF USED("cursor_4c_DelFsi")
                USE IN cursor_4c_DelFsi
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFso WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFso")
                IF USED("cursor_4c_DelFso")
                    USE IN cursor_4c_DelFso
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFsc WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsc")
                IF USED("cursor_4c_DelFsc")
                    USE IN cursor_4c_DelFsc
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relacionamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExcluirRelacionados: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Emps com: Imps L, Emps C(3), Razas C(...)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, Cemps AS Emps, Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE NOT Ativas = 2" + ;
                       " ORDER BY Cemps"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")
            IF loc_nResult >= 0
                *-- Marcar empresas vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Emps FROM SigCdFsi WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVinc") >= 0
                        SELECT cursor_4c_EmpsVinc
                        SCAN
                            UPDATE cursor_4c_Emps SET Imps = .T. WHERE Emps = ALLTRIM(cursor_4c_EmpsVinc.Emps)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_EmpsVinc")
                        USE IN cursor_4c_EmpsVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Emps
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarEmpresas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Opers com: Imps L, Dopes C(20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, a.Dopes" + ;
                       " FROM SigCdOpe a INNER JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                       " WHERE b.OpeInatvs <> 1" + ;
                       " ORDER BY a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opers")
            IF loc_nResult >= 0
                *-- Marcar operacoes vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Dopes FROM SigCdFso WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpesVinc") >= 0
                        SELECT cursor_4c_OpesVinc
                        SCAN
                            UPDATE cursor_4c_Opers SET Imps = .T. WHERE Dopes = ALLTRIM(cursor_4c_OpesVinc.Dopes)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_OpesVinc")
                        USE IN cursor_4c_OpesVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Opers
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarOperacoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicoes - Carrega composicoes vinculadas ao motivo para edicao
    * Popula cursor_4c_Compos (readwrite) com: Compos C(30)
    * Par: par_cCodigos - codigo do motivo (vazio = cursor vazio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Compos")
                USE IN cursor_4c_Compos
            ENDIF

            IF EMPTY(par_cCodigos)
                *-- Cursor vazio para inclusao
                SET NULL ON
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Compos FROM SigCdFsc WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " ORDER BY Compos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Compos")
                IF loc_nResult >= 0
                    GO TOP IN cursor_4c_Compos
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarComposicoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicoesProdutos - Cursor de composicoes de SigCdPro para lookup
    * Popula cursor_4c_CsCompos com: Compos C(30)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicoesProdutos()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT Compos FROM SigCdPro ORDER BY Compos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsCompos")
            IF loc_nResult >= 0
                GO TOP IN cursor_4c_CsCompos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es de produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.BuscarComposicoesProdutos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        IF USED("cursor_4c_Opers")
            USE IN cursor_4c_Opers
        ENDIF
        IF USED("cursor_4c_Compos")
            USE IN cursor_4c_Compos
        ENDIF
        IF USED("cursor_4c_CsCompos")
            USE IN cursor_4c_CsCompos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

