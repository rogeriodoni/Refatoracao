# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-SQL] Campo 'Compos' usado em ControlSource de cursor_4c_Compos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Imps' usado em ControlSource de cursor_4c_Opers mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dopes' usado em ControlSource de cursor_4c_Opers mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Imps' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Emps' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Razas' usado em ControlSource de cursor_4c_Emps mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, OPEINATVS, 0, CODIGOS, EMPS, DOPES, FKCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, OPEINATVS, 0, CODIGOS, EMPS, DOPES, FKCHAVES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMda.prg) - TRECHOS RELEVANTES PARA PASS SQL (2590 linhas total):

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
370:             .Header1.Caption = "C" + CHR(243) + "digo"
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

*-- Linhas 1298 a 1316:
1298:             .FontSize    = 8
1299:             .GridLines   = 2
1300:             .RecordMark  = .F.
1301:             .DeleteMark  = .F.
1302:             .ScrollBars  = 2
1303:             .ReadOnly    = .F.
1304:             .Movable     = .F.
1305:             .Resizable   = .F.
1306:             .Visible     = .T.
1307:         ENDWITH
1308: 
1309:         WITH loc_oPagina.grd_4c_Compo.Column1
1310:             .Width     = 244
1311:             .Movable   = .F.
1312:             .Resizable = .F.
1313:             .ReadOnly  = .F.
1314:         ENDWITH
1315:         loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
1316: 

*-- Linhas 1380 a 1401:
1380:                         loc_oGrid.ColumnCount = 3
1381:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1382: 
1383:                         *-- ControlSource SEMPRE apos RecordSource (Problema 48)
1384:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1385:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1386:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1387: 
1388:                         loc_oGrid.Column1.Width     = 80
1389:                         loc_oGrid.Column2.Width     = 290
1390:                         loc_oGrid.Column3.Width     = 40
1391:                         loc_oGrid.Column1.Alignment = 0
1392:                         loc_oGrid.Column2.Alignment = 0
1393:                         loc_oGrid.Column3.Alignment = 2
1394: 
1395:                         *-- Headers OBRIGATORIO apos RecordSource (Problema 6/32)
1396:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1397:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1398:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
1399: 
1400:                         THIS.FormatarGridLista(loc_oGrid)
1401:                         loc_oGrid.Refresh()

*-- Linhas 1460 a 1485:
1460: 
1461:         TRY
1462:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1463:                 IF THIS.this_oBusinessObject.Salvar()
1464:                     *-- Salvar relacionados quando cursores existirem (habilitado em Fase 6+)
1465:                     IF USED("cursor_4c_Emps") OR USED("cursor_4c_Opers") OR USED("cursor_4c_Compos")
1466:                         THIS.this_oBusinessObject.SalvarRelacionados( ;
1467:                             THIS.this_oBusinessObject.this_cCodigos, ;
1468:                             "cursor_4c_Emps", ;
1469:                             "cursor_4c_Opers", ;
1470:                             "cursor_4c_Compos")
1471:                     ENDIF
1472:                     MsgInfo("Registro salvo com sucesso!")
1473:                     THIS.pgf_4c_Paginas.ActivePage = 1
1474:                     THIS.this_cModoAtual = "LISTA"
1475:                     THIS.CarregarLista()
1476:                     loc_lResultado = .T.
1477:                 ENDIF
1478:             ENDIF
1479:         CATCH TO loException
1480:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
1481:                 "FormMda.BtnSalvarClick")
1482:         ENDTRY
1483: 
1484:         RETURN loc_lResultado
1485:     ENDPROC

*-- Linhas 1541 a 1559:
1541:         loc_cCodigo = ""
1542: 
1543:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1544:             SELECT cursor_4c_Dados
1545:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1546:         ENDIF
1547: 
1548:         IF EMPTY(loc_cCodigo)
1549:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1550:             RETURN
1551:         ENDIF
1552: 
1553:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1554:             THIS.this_cModoAtual = "VISUALIZAR"
1555:             THIS.BOParaForm()
1556:             THIS.HabilitarCampos(.F.)
1557:             THIS.AlternarPagina(2)
1558:             THIS.CarregarRelacionados(loc_cCodigo)
1559:         ENDIF

*-- Linhas 1568 a 1586:
1568:         loc_cCodigo = ""
1569: 
1570:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1571:             SELECT cursor_4c_Dados
1572:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1573:         ENDIF
1574: 
1575:         IF EMPTY(loc_cCodigo)
1576:             MsgAviso("Selecione um registro na lista.", "Alterar")
1577:             RETURN
1578:         ENDIF
1579: 
1580:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1581:             THIS.this_oBusinessObject.EditarRegistro()
1582:             THIS.this_cModoAtual = "ALTERAR"
1583:             THIS.BOParaForm()
1584:             THIS.HabilitarCampos(.T.)
1585:             THIS.AlternarPagina(2)
1586:             THIS.CarregarRelacionados(loc_cCodigo)

*-- Linhas 1597 a 1615:
1597:         loc_cDescricao = ""
1598: 
1599:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1600:             SELECT cursor_4c_Dados
1601:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
1602:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)
1603:         ENDIF
1604: 
1605:         IF EMPTY(loc_cCodigo)
1606:             MsgAviso("Selecione um registro na lista.", "Excluir")
1607:             RETURN
1608:         ENDIF
1609: 
1610:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do motivo:" + CHR(13) + ;
1611:                 loc_cCodigo + " - " + loc_cDescricao + "?", ;
1612:                 "Confirmar Exclus" + CHR(227) + "o")
1613:             RETURN
1614:         ENDIF
1615: 

*-- Linhas 1641 a 1681:
1641:                 loc_oBusca.Show()
1642: 
1643:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMda")
1644:                     SELECT cursor_4c_BuscaMda
1645:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaMda.codigos)
1646:                 ENDIF
1647: 
1648:                 loc_oBusca.Release()
1649:             ENDIF
1650:         CATCH TO loException
1651:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1652:                 "FormMda.BtnBuscarClick")
1653:         ENDTRY
1654: 
1655:         IF USED("cursor_4c_BuscaMda")
1656:             USE IN cursor_4c_BuscaMda
1657:         ENDIF
1658: 
1659:         IF !EMPTY(loc_cCodigo)
1660:             IF THIS.this_oBusinessObject.Buscar("codigos = " + EscaparSQL(loc_cCodigo))
1661:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1662:                 loc_oGrid.ColumnCount = 3
1663:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1664:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1665:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1666:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1667:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1668:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1669:                 loc_oGrid.Column3.Header1.Caption = "Tipo"
1670:                 loc_oGrid.Refresh()
1671:             ENDIF
1672:         ELSE
1673:             THIS.CarregarLista()
1674:         ENDIF
1675:     ENDPROC
1676: 
1677:     *===========================================================================
1678:     * FormParaBO - Transfere valores dos campos de Page2 para o BO
1679:     * Controles verificados com PEMSTATUS para compatibilidade multi-fase
1680:     *===========================================================================
1681:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 1892 a 1925:
1892:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1893:             loc_oPagina.opt_4c_OptTpDescs.Value = 1
1894:         ENDIF
1895: 
1896:         *-- Limpar cursores dos grids relacionados (recarregados em CarregarRelacionados)
1897:         IF USED("cursor_4c_Emps")
1898:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
1899:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5)
1900:                 loc_oPagina.grd_4c_Emps.Refresh()
1901:             ENDIF
1902:         ENDIF
1903:         IF USED("cursor_4c_Opers")
1904:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
1905:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5)
1906:                 loc_oPagina.grd_4c_Opers.Refresh()
1907:             ENDIF
1908:         ENDIF
1909:         IF USED("cursor_4c_Compos")
1910:             ZAP IN cursor_4c_Compos
1911:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
1912:                 loc_oPagina.grd_4c_Compo.Refresh()
1913:             ENDIF
1914:         ENDIF
1915:     ENDPROC
1916: 
1917:     *===========================================================================
1918:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo atual
1919:     *===========================================================================
1920:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1921:         LOCAL loc_oPagina, loc_lEditar
1922:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1923:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1924: 
1925:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)

*-- Linhas 1978 a 2022:
1978:         ENDIF
1979: 
1980:         TRY
1981:             loc_nRows = SQLEXEC(gnConnHandle, ;
1982:                 "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod), ;
1983:                 "cursor_4c_BuscaGGrus")
1984: 
1985:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
1986:                 loc_oPagina.txt_4c_GGrus.Value = ALLTRIM(cursor_4c_BuscaGGrus.codigos)
1987:                 IF USED("cursor_4c_BuscaGGrus")
1988:                     USE IN cursor_4c_BuscaGGrus
1989:                 ENDIF
1990:             ELSE
1991:                 IF USED("cursor_4c_BuscaGGrus")
1992:                     USE IN cursor_4c_BuscaGGrus
1993:                 ENDIF
1994: 
1995:                 *-- Nao encontrado exato: busca parcial para picker
1996:                 loc_nRows = SQLEXEC(gnConnHandle, ;
1997:                     "SELECT codigos, descs FROM SigCdGpr WHERE codigos LIKE " + ;
1998:                     EscaparSQL(loc_cCod + "%") + " OR descs LIKE " + ;
1999:                     EscaparSQL(loc_cCod + "%") + " ORDER BY codigos", ;
2000:                     "cursor_4c_BuscaGGrus")
2001: 
2002:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaGGrus") OR EOF("cursor_4c_BuscaGGrus")
2003:                     IF USED("cursor_4c_BuscaGGrus")
2004:                         USE IN cursor_4c_BuscaGGrus
2005:                     ENDIF
2006:                     SQLEXEC(gnConnHandle, ;
2007:                         "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
2008:                         "cursor_4c_BuscaGGrus")
2009:                 ENDIF
2010: 
2011:                 IF USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
2012:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2013:                     IF VARTYPE(loc_oBusca) = "O"
2014:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaGGrus", "codigos", "descs", ;
2015:                             "Buscar Grande Grupo")
2016:                         loc_oBusca.Mostrar()
2017:                         IF loc_oBusca.this_lSelecionou
2018:                             loc_oPagina.txt_4c_GGrus.Value = loc_oBusca.cCodigoSelecionado
2019:                         ELSE
2020:                             loc_oPagina.txt_4c_GGrus.Value = ""
2021:                         ENDIF
2022:                         loc_oBusca.Release()

*-- Linhas 2058 a 2102:
2058:         ENDIF
2059: 
2060:         TRY
2061:             loc_nRows = SQLEXEC(gnConnHandle, ;
2062:                 "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + EscaparSQL(loc_cCod), ;
2063:                 "cursor_4c_BuscaSGrus")
2064: 
2065:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2066:                 loc_oPagina.txt_4c_SGrus.Value = ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
2067:                 IF USED("cursor_4c_BuscaSGrus")
2068:                     USE IN cursor_4c_BuscaSGrus
2069:                 ENDIF
2070:             ELSE
2071:                 IF USED("cursor_4c_BuscaSGrus")
2072:                     USE IN cursor_4c_BuscaSGrus
2073:                 ENDIF
2074: 
2075:                 *-- Nao encontrado exato: busca parcial para picker
2076:                 loc_nRows = SQLEXEC(gnConnHandle, ;
2077:                     "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos LIKE " + ;
2078:                     EscaparSQL(loc_cCod + "%") + " OR Descricaos LIKE " + ;
2079:                     EscaparSQL(loc_cCod + "%") + " ORDER BY Codigos", ;
2080:                     "cursor_4c_BuscaSGrus")
2081: 
2082:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaSGrus") OR EOF("cursor_4c_BuscaSGrus")
2083:                     IF USED("cursor_4c_BuscaSGrus")
2084:                         USE IN cursor_4c_BuscaSGrus
2085:                     ENDIF
2086:                     SQLEXEC(gnConnHandle, ;
2087:                         "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
2088:                         "cursor_4c_BuscaSGrus")
2089:                 ENDIF
2090: 
2091:                 IF USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2092:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2093:                     IF VARTYPE(loc_oBusca) = "O"
2094:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaSGrus", "Codigos", "Descricaos", ;
2095:                             "Buscar SubGrupo")
2096:                         loc_oBusca.Mostrar()
2097:                         IF loc_oBusca.this_lSelecionou
2098:                             loc_oPagina.txt_4c_SGrus.Value = loc_oBusca.cCodigoSelecionado
2099:                         ELSE
2100:                             loc_oPagina.txt_4c_SGrus.Value = ""
2101:                         ENDIF
2102:                         loc_oBusca.Release()

*-- Linhas 2136 a 2520:
2136:             THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
2137:             THIS.this_oBusinessObject.CarregarComposicoes(par_cCodigos)
2138:             THIS.this_oBusinessObject.BuscarComposicoesProdutos()
2139: 
2140:             *-- Grid Operacoes
2141:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5) AND USED("cursor_4c_Opers")
2142:                 loc_oGrd = loc_oPagina.grd_4c_Opers
2143:                 *-- RecordSource e ControlSource FORA de WITH (Problema 36/48)
2144:                 loc_oGrd.ColumnCount = 3
2145:                 loc_oGrd.RecordSource          = "cursor_4c_Opers"
2146:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Opers.Imps"
2147:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Opers.Dopes"
2148:                 *-- Headers OBRIGATORIO apos RecordSource (Problema 32)
2149:                 loc_oGrd.Column1.Header1.Caption = ""
2150:                 loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
2151:                 loc_oGrd.Refresh()
2152:             ENDIF
2153: 
2154:             *-- Grid Empresas
2155:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5) AND USED("cursor_4c_Emps")
2156:                 loc_oGrd = loc_oPagina.grd_4c_Emps
2157:                 loc_oGrd.ColumnCount = 3
2158:                 loc_oGrd.RecordSource          = "cursor_4c_Emps"
2159:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Emps.Imps"
2160:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Emps.Emps"
2161:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Emps.Razas"
2162:                 loc_oGrd.Column1.Header1.Caption = ""
2163:                 loc_oGrd.Column2.Header1.Caption = "Emp."
2164:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
2165:                 loc_oGrd.Refresh()
2166:             ENDIF
2167: 
2168:             *-- Grid Composicoes
2169:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5) AND USED("cursor_4c_Compos")
2170:                 loc_oGrd = loc_oPagina.grd_4c_Compo
2171:                 loc_oGrd.ColumnCount = 1
2172:                 loc_oGrd.RecordSource          = "cursor_4c_Compos"
2173:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Compos.Compos"
2174:                 loc_oGrd.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2175:                 loc_oGrd.Refresh()
2176:             ENDIF
2177: 
2178:             loc_lResultado = .T.
2179: 
2180:         CATCH TO loException
2181:             MostrarErro("Erro ao carregar relacionados:" + CHR(13) + loException.Message, ;
2182:                 "FormMda.CarregarRelacionados")
2183:         ENDTRY
2184: 
2185:         RETURN loc_lResultado
2186:     ENDPROC
2187: 
2188:     *===========================================================================
2189:     * OperCheckboxMouseDown - Toggle Imps em cursor_4c_Opers via mouse
2190:     * PUBLIC: BINDEVENT requer metodo publico
2191:     *===========================================================================
2192:     PROCEDURE OperCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2193:         IF THIS.this_cModoAtual = "VISUALIZAR"
2194:             NODEFAULT
2195:             RETURN
2196:         ENDIF
2197:         IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2198:             SELECT cursor_4c_Opers
2199:             REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2200:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2201:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2202:             ENDIF
2203:         ENDIF
2204:         NODEFAULT
2205:     ENDPROC
2206: 
2207:     *===========================================================================
2208:     * OperCheckboxMouseUp - Suprime comportamento padrao
2209:     * PUBLIC: BINDEVENT requer metodo publico
2210:     *===========================================================================
2211:     PROCEDURE OperCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2212:         NODEFAULT
2213:     ENDPROC
2214: 
2215:     *===========================================================================
2216:     * OperCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2217:     * PUBLIC: BINDEVENT requer metodo publico
2218:     *===========================================================================
2219:     PROCEDURE OperCheckboxClick()
2220:         NODEFAULT
2221:     ENDPROC
2222: 
2223:     *===========================================================================
2224:     * OperCheckboxKeyPress - Toggle Imps em cursor_4c_Opers via teclado
2225:     * PUBLIC: BINDEVENT requer metodo publico
2226:     *===========================================================================
2227:     PROCEDURE OperCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2228:         IF THIS.this_cModoAtual = "VISUALIZAR"
2229:             NODEFAULT
2230:             RETURN
2231:         ENDIF
2232:         IF INLIST(par_nKeyCode, 13, 32)
2233:             IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2234:                 SELECT cursor_4c_Opers
2235:                 REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2236:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2237:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2238:                 ENDIF
2239:             ENDIF
2240:             NODEFAULT
2241:         ENDIF
2242:     ENDPROC
2243: 
2244:     *===========================================================================
2245:     * EmpCheckboxMouseDown - Toggle Imps em cursor_4c_Emps via mouse
2246:     * PUBLIC: BINDEVENT requer metodo publico
2247:     *===========================================================================
2248:     PROCEDURE EmpCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2249:         IF THIS.this_cModoAtual = "VISUALIZAR"
2250:             NODEFAULT
2251:             RETURN
2252:         ENDIF
2253:         IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2254:             SELECT cursor_4c_Emps
2255:             REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2256:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2257:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2258:             ENDIF
2259:         ENDIF
2260:         NODEFAULT
2261:     ENDPROC
2262: 
2263:     *===========================================================================
2264:     * EmpCheckboxMouseUp - Suprime comportamento padrao
2265:     * PUBLIC: BINDEVENT requer metodo publico
2266:     *===========================================================================
2267:     PROCEDURE EmpCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2268:         NODEFAULT
2269:     ENDPROC
2270: 
2271:     *===========================================================================
2272:     * EmpCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2273:     * PUBLIC: BINDEVENT requer metodo publico
2274:     *===========================================================================
2275:     PROCEDURE EmpCheckboxClick()
2276:         NODEFAULT
2277:     ENDPROC
2278: 
2279:     *===========================================================================
2280:     * EmpCheckboxKeyPress - Toggle Imps em cursor_4c_Emps via teclado
2281:     * PUBLIC: BINDEVENT requer metodo publico
2282:     *===========================================================================
2283:     PROCEDURE EmpCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2284:         IF THIS.this_cModoAtual = "VISUALIZAR"
2285:             NODEFAULT
2286:             RETURN
2287:         ENDIF
2288:         IF INLIST(par_nKeyCode, 13, 32)
2289:             IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2290:                 SELECT cursor_4c_Emps
2291:                 REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2292:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2293:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2294:                 ENDIF
2295:             ENDIF
2296:             NODEFAULT
2297:         ENDIF
2298:     ENDPROC
2299: 
2300:     *===========================================================================
2301:     * MarcaTodosOpersClick - Marca todas operacoes (Imps = .T.)
2302:     * PUBLIC: BINDEVENT requer metodo publico
2303:     *===========================================================================
2304:     PROCEDURE MarcaTodosOpersClick()
2305:         IF USED("cursor_4c_Opers")
2306:             REPLACE ALL Imps WITH .T. IN cursor_4c_Opers
2307:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2308:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2309:             ENDIF
2310:         ENDIF
2311:     ENDPROC
2312: 
2313:     *===========================================================================
2314:     * DesmarcaTodosOpersClick - Desmarca todas operacoes (Imps = .F.)
2315:     * PUBLIC: BINDEVENT requer metodo publico
2316:     *===========================================================================
2317:     PROCEDURE DesmarcaTodosOpersClick()
2318:         IF USED("cursor_4c_Opers")
2319:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
2320:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2321:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2322:             ENDIF
2323:         ENDIF
2324:     ENDPROC
2325: 
2326:     *===========================================================================
2327:     * MarcaTodosEmpsClick - Marca todas empresas (Imps = .T.)
2328:     * PUBLIC: BINDEVENT requer metodo publico
2329:     *===========================================================================
2330:     PROCEDURE MarcaTodosEmpsClick()
2331:         IF USED("cursor_4c_Emps")
2332:             REPLACE ALL Imps WITH .T. IN cursor_4c_Emps
2333:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2334:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2335:             ENDIF
2336:         ENDIF
2337:     ENDPROC
2338: 
2339:     *===========================================================================
2340:     * DesmarcaTodosEmpsClick - Desmarca todas empresas (Imps = .F.)
2341:     * PUBLIC: BINDEVENT requer metodo publico
2342:     *===========================================================================
2343:     PROCEDURE DesmarcaTodosEmpsClick()
2344:         IF USED("cursor_4c_Emps")
2345:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
2346:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2347:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2348:             ENDIF
2349:         ENDIF
2350:     ENDPROC
2351: 
2352:     *===========================================================================
2353:     * CompoInserirClick - Insere linha vazia em cursor_4c_Compos
2354:     * PUBLIC: BINDEVENT requer metodo publico
2355:     *===========================================================================
2356:     PROCEDURE CompoInserirClick()
2357:         LOCAL loc_oPagina
2358:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2359: 
2360:         IF !USED("cursor_4c_Compos")
2361:             RETURN
2362:         ENDIF
2363: 
2364:         SELECT cursor_4c_Compos
2365:         APPEND BLANK
2366:         REPLACE Compos WITH "" IN cursor_4c_Compos
2367:         GO BOTTOM IN cursor_4c_Compos
2368: 
2369:         IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2370:             loc_oPagina.grd_4c_Compo.Refresh()
2371:         ENDIF
2372:     ENDPROC
2373: 
2374:     *===========================================================================
2375:     * CompoExcluirClick - Exclui linha atual de cursor_4c_Compos
2376:     * PUBLIC: BINDEVENT requer metodo publico
2377:     *===========================================================================
2378:     PROCEDURE CompoExcluirClick()
2379:         LOCAL loc_oPagina, loc_nRec
2380:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2381: 
2382:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos") OR ;
2383:            RECCOUNT("cursor_4c_Compos") = 0
2384:             RETURN
2385:         ENDIF
2386: 
2387:         TRY
2388:             SELECT cursor_4c_Compos
2389:             loc_nRec = RECNO("cursor_4c_Compos")
2390: 
2391:             *-- Rebuild writable cursor excluindo o registro atual
2392:             IF USED("cursor_4c_CompoTemp")
2393:                 USE IN cursor_4c_CompoTemp
2394:             ENDIF
2395:             SELECT Compos FROM cursor_4c_Compos ;
2396:                 WHERE RECNO() != loc_nRec ;
2397:                 INTO CURSOR cursor_4c_CompoTemp READWRITE
2398:             USE IN cursor_4c_Compos
2399: 
2400:             IF USED("cursor_4c_CompoTemp") AND RECCOUNT("cursor_4c_CompoTemp") > 0
2401:                 SELECT Compos FROM cursor_4c_CompoTemp ;
2402:                     INTO CURSOR cursor_4c_Compos READWRITE
2403:                 USE IN cursor_4c_CompoTemp
2404:                 GO BOTTOM IN cursor_4c_Compos
2405:             ELSE
2406:                 IF USED("cursor_4c_CompoTemp")
2407:                     USE IN cursor_4c_CompoTemp
2408:                 ENDIF
2409:                 CREATE CURSOR cursor_4c_Compos (Compos C(30))
2410:             ENDIF
2411: 
2412:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2413:                 loc_oPagina.grd_4c_Compo.ColumnCount = 1
2414:                 loc_oPagina.grd_4c_Compo.RecordSource          = "cursor_4c_Compos"
2415:                 loc_oPagina.grd_4c_Compo.Column1.ControlSource = "cursor_4c_Compos.Compos"
2416:                 loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2417:                 loc_oPagina.grd_4c_Compo.Refresh()
2418:             ENDIF
2419: 
2420:         CATCH TO loException
2421:             MostrarErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2422:                 loException.Message, "FormMda.CompoExcluirClick")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *===========================================================================
2427:     * CompoTextValid - Valida/busca composicao digitada em grd_4c_Compo
2428:     * PUBLIC: BINDEVENT requer metodo publico
2429:     *===========================================================================
2430:     PROCEDURE CompoTextValid()
2431:         LOCAL loc_cCompo, loc_oBusca, loc_lOk
2432:         loc_lOk = .T.
2433: 
2434:         IF THIS.this_cModoAtual = "VISUALIZAR"
2435:             RETURN loc_lOk
2436:         ENDIF
2437: 
2438:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos")
2439:             RETURN loc_lOk
2440:         ENDIF
2441: 
2442:         loc_cCompo = ALLTRIM(cursor_4c_Compos.Compos)
2443: 
2444:         IF EMPTY(loc_cCompo)
2445:             RETURN loc_lOk
2446:         ENDIF
2447: 
2448:         IF !USED("cursor_4c_CsCompos") OR RECCOUNT("cursor_4c_CsCompos") = 0
2449:             RETURN loc_lOk
2450:         ENDIF
2451: 
2452:         TRY
2453:             *-- Busca exata
2454:             SELECT cursor_4c_CsCompos
2455:             LOCATE FOR UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) = UPPER(loc_cCompo)
2456: 
2457:             IF !EOF("cursor_4c_CsCompos")
2458:                 *-- Encontrado: normaliza para forma canonica
2459:                 SELECT cursor_4c_Compos
2460:                 REPLACE Compos WITH ALLTRIM(cursor_4c_CsCompos.Compos) IN cursor_4c_Compos
2461:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2462:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2463:                 ENDIF
2464:             ELSE
2465:                 *-- Nao encontrado: abre picker com filtro parcial
2466:                 SELECT cursor_4c_Compos
2467: 
2468:                 IF USED("cursor_4c_BuscaCompo")
2469:                     USE IN cursor_4c_BuscaCompo
2470:                 ENDIF
2471: 
2472:                 SELECT Compos FROM cursor_4c_CsCompos ;
2473:                     WHERE UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) LIKE "%" + UPPER(loc_cCompo) + "%" ;
2474:                     ORDER BY cursor_4c_CsCompos.Compos ;
2475:                     INTO CURSOR cursor_4c_BuscaCompo
2476: 
2477:                 IF !USED("cursor_4c_BuscaCompo") OR EOF("cursor_4c_BuscaCompo")
2478:                     IF USED("cursor_4c_BuscaCompo")
2479:                         USE IN cursor_4c_BuscaCompo
2480:                     ENDIF
2481:                     SELECT Compos FROM cursor_4c_CsCompos ;
2482:                         ORDER BY cursor_4c_CsCompos.Compos ;
2483:                         INTO CURSOR cursor_4c_BuscaCompo
2484:                 ENDIF
2485: 
2486:                 IF USED("cursor_4c_BuscaCompo") AND !EOF("cursor_4c_BuscaCompo")
2487:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2488:                     IF VARTYPE(loc_oBusca) = "O"
2489:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCompo", "Compos", "Compos", ;
2490:                             "Buscar Composi" + CHR(231) + CHR(227) + "o")
2491:                         loc_oBusca.Mostrar()
2492:                         SELECT cursor_4c_Compos
2493:                         IF loc_oBusca.this_lSelecionou
2494:                             REPLACE Compos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado) IN cursor_4c_Compos
2495:                         ELSE
2496:                             REPLACE Compos WITH "" IN cursor_4c_Compos
2497:                         ENDIF
2498:                         loc_oBusca.Release()
2499:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2500:                             THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2501:                         ENDIF
2502:                     ENDIF
2503:                 ELSE
2504:                     SELECT cursor_4c_Compos
2505:                     REPLACE Compos WITH "" IN cursor_4c_Compos
2506:                 ENDIF
2507: 
2508:                 IF USED("cursor_4c_BuscaCompo")
2509:                     USE IN cursor_4c_BuscaCompo
2510:                 ENDIF
2511:             ENDIF
2512: 
2513:         CATCH TO loException
2514:             MostrarErro("Erro ao validar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2515:                 loException.Message, "FormMda.CompoTextValid")
2516:         ENDTRY
2517: 
2518:         RETURN loc_lOk
2519:     ENDPROC
2520: 

*-- Linhas 2566 a 2590:
2566: 
2567:         IF USED("cursor_4c_BuscaMda")
2568:             USE IN cursor_4c_BuscaMda
2569:         ENDIF
2570: 
2571:         IF USED("cursor_4c_Emps")
2572:             USE IN cursor_4c_Emps
2573:         ENDIF
2574:         IF USED("cursor_4c_Opers")
2575:             USE IN cursor_4c_Opers
2576:         ENDIF
2577:         IF USED("cursor_4c_Compos")
2578:             USE IN cursor_4c_Compos
2579:         ENDIF
2580:         IF USED("cursor_4c_CsCompos")
2581:             USE IN cursor_4c_CsCompos
2582:         ENDIF
2583:         IF USED("cursor_4c_BuscaCompo")
2584:             USE IN cursor_4c_BuscaCompo
2585:         ENDIF
2586: 
2587:         DODEFAULT()
2588:     ENDPROC
2589: 
2590: ENDDEFINE


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
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
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

