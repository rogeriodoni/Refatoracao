# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-ASPAS] Linha 294: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = '" + loc_cEmps + "'"
- [SQL-ASPAS] Linha 321: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "SELECT * FROM SigMvEst WHERE Emps = '" + loc_cEmps + "' AND Sqtds > 0"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLECOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, EMPS, SQTDS, GRUPOS, ESTOS, CPROS, LNCONTA, SITUAS, CPROEQS, REFFS, REFF2S

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
lcSql = [Select Razas From SigCdEmp Where Cemps = ']+_Empr+[']
thisform.podatamgr.sqlexecute(lcsql,'TmpEmp')
insert into cscabecalho (NomeEmpresa,RelTitulo, RelTitulo2) values (cNomeEmpresa,cRelTitulo,cRelTitulo2)
	lcSql = [Select * From SigMvEst Where Emps = ']+_Empr+[' And Sqtds > 0 ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEst')
	lcSql = [Select Cpros,cproEqs,Reffs,cgrus,dpros,CGrus,Cunis,Linhas,Colecoes,situas From SigCdPro ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
		Select a.*,b.Dpros From LocalEst a, LocalPro b Where a.Grupos = cGrupoA And a.Estos = cEstoqA And ;
		(Select Cpros+CodCors+CodTams From LocalEst Where Grupos = cGrupoB ;
		Select a.*,b.Dpros From LocalEst a, LocalPro b Where a.Grupos = cGrupoA And a.Estos = cEstoqA And ;
		(Select Cpros From LocalEst Where Grupos = cGrupoB ;
	Select Cpros,cproEqs,Reffs,cgrus,dpros,'    ' as CodCors, '  ' as CodTams, 0 as Sqtds From LocalPro Where &lcWhere. ;
	Append From Dbf('Tmppro2')
	Select Cpros,cproEqs,reffs,cgrus,dpros,' ' as CodCors, ' ' as CodTams, 0 as Sqtds From LocalPro Where ;
	cProEqs <> ' ' And CproEqs in (Select Cpros From TmpPro) Into Cursor TmpPro2
	Select TmpPro2
		If Seek(cproEqs,'TmpPro','Cpros')
		Select Reffs, Max(Reff2s) as reff2s From TmpPro Group by 1 Into Cursor TmpProx
		Select distinct Padr(reffs,10) as cpros, Space(40) as dpros, ' ' as codcors, ' 'as codtams, 0 as sqtds ;
		  From TmpProx Where Reffs Not In ;
		(Select b.Reffs From LocalEst a, LocalPro b Where a.Grupos = cGrupoB And a.Estos = cEstoqB And a.Emps = _Empr And a.Sqtds > 0 and a.cpros = b.cpros ) ;
		(Select b.reffs From LocalEst a, LocalPro b Where a.Grupos = cGrupoB And a.Estos = cEstoqB And a.Emps = _Empr And a.Sqtds > 0 and a.cpros = b.cpros ) ) ;
		Select * From TmpPro Where Cpros Not In ;
		(Select cpros From LocalEst Where Grupos = cGrupoB And Estos = cEstoqB And Emps = _Empr And Sqtds > 0 ) ;
		(Select cpros From LocalEst Where Grupos = cGrupoB And Estos = cEstoqB And Emps = _Empr And Sqtds > 0 ) ) ;
Select CsRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecpe.prg) - TRECHOS RELEVANTES PARA PASS SQL (1859 linhas total):

*-- Linhas 280 a 337:
280:                 .MousePointer    = 15
281:                 .ToolTipText     = "[Esc] Encerrar"
282:                 .Themes          = .F.
283:                 .Visible         = .T.
284:             ENDWITH
285:         ENDWITH
286:     ENDPROC
287: 
288:     *--------------------------------------------------------------------------
289:     * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
290:     *   O form legado SIGRECPE " + CHR(233) + " FLAT (sem PageFrame), mas no novo padr" + CHR(227) + "o
291:     *   os campos de filtro s" + CHR(227) + "o agrupados em um PageFrame de 1 p" + CHR(225) + "gina.
292:     *   Os controles de filtro (TextBoxes, OptionGroups, Labels) s" + CHR(227) + "o
293:     *   adicionados " + CHR(224) + " Page1 na Fase 5.
294:     *--------------------------------------------------------------------------
295:     PROTECTED PROCEDURE ConfigurarPageFrame()
296:         LOCAL loc_oPgf
297: 
298:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
299:         loc_oPgf = THIS.pgf_4c_Paginas
300: 
301:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
302:         loc_oPgf.PageCount = 1
303: 
304:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) ate o fim do form
305:         loc_oPgf.Top    = 85
306:         loc_oPgf.Left   = -1
307:         loc_oPgf.Width  = THIS.Width + 2
308:         loc_oPgf.Height = THIS.Height - 85
309:         loc_oPgf.Tabs   = .F.
310: 
311:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
312:         loc_oPgf.Page1.Caption   = "Filtros"
313:         loc_oPgf.Page1.FontName  = "Tahoma"
314:         loc_oPgf.Page1.FontSize  = 8
315:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
316:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
317:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
318: 
319:         loc_oPgf.Visible    = .T.
320:         loc_oPgf.ActivePage = 1
321:     ENDPROC
322: 
323:     *--------------------------------------------------------------------------
324:     * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
325:     *   Equivalente ao bloco 'processamento' do form legado SIGRECPE.
326:     *   Todos os controles referenciados s" + CHR(227) + "o criados na Fase 5.
327:     *--------------------------------------------------------------------------
328:     PROTECTED PROCEDURE FormParaRelatorio()
329:         LOCAL loc_oPg
330:         TRY
331:             loc_oPg = THIS.pgf_4c_Paginas.Page1
332:             WITH THIS.this_oRelatorio
333:                 *-- Estoque A
334:                 .this_cCdGrEstoqueA = ALLTRIM(loc_oPg.txt_4c_CdGrEstoqueA.Value)
335:                 .this_cDsGrEstoqueA = ALLTRIM(loc_oPg.txt_4c_DsGrEstoqueA.Value)
336:                 .this_cCdEstoqueA   = ALLTRIM(loc_oPg.txt_4c_CdEstoqueA.Value)
337:                 .this_cDsEstoqueA   = ALLTRIM(loc_oPg.txt_4c_DsEstoqueA.Value)

*-- Linhas 551 a 569:
551:                 ENDIF
552:                 loc_cArquivo = PUTFILE("Salvar como...", "SigReCpE", "XLS")
553:                 IF !EMPTY(loc_cArquivo)
554:                     SELECT (loc_cCursor)
555:                     COPY TO (loc_cArquivo) TYPE XLS
556:                     MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
557:                         loc_cArquivo, "Excel")
558:                 ENDIF
559:                 EXIT
560:             ENDDO
561:         CATCH TO loc_oErro
562:             MsgErro(loc_oErro.Message + CHR(13) + ;
563:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
564:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
565:         ENDTRY
566:     ENDPROC
567: 
568:     *--------------------------------------------------------------------------
569:     * BtnSairClick - Fecha o formul" + CHR(225) + "rio

*-- Linhas 1241 a 1263:
1241:                     loc_oPg.txt_4c_DsEstoqueA.Value   = ""
1242:                     EXIT
1243:                 ENDIF
1244:                 loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr" + ;
1245:                            " WHERE codigos = " + EscaparSQL(PADR(loc_cCodigo, 10))
1246:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstAVal")
1247:                 IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstAVal")
1248:                     SELECT cursor_4c_GrEstAVal
1249:                     loc_oPg.txt_4c_CdGrEstoqueA.Value = ALLTRIM(cursor_4c_GrEstAVal.codigos)
1250:                     loc_oPg.txt_4c_DsGrEstoqueA.Value = ALLTRIM(cursor_4c_GrEstAVal.descrs)
1251:                     loc_oPg.txt_4c_CdEstoqueA.Value   = ""
1252:                     loc_oPg.txt_4c_DsEstoqueA.Value   = ""
1253:                 ELSE
1254:                     MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
1255:                         "Grupo de Estoque")
1256:                     loc_oPg.txt_4c_CdGrEstoqueA.Value = ""
1257:                     loc_oPg.txt_4c_DsGrEstoqueA.Value = ""
1258:                     THIS.AbrirBuscaGrEstoque("A")
1259:                 ENDIF
1260:                 EXIT
1261:             ENDDO
1262:         CATCH TO loc_oErro
1263:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1287 a 1305:
1287:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1288:                 loc_oBusca.Show()
1289:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1290:                     SELECT (loc_cCursor)
1291:                     IF UPPER(ALLTRIM(par_cLado)) = "A"
1292:                         loc_oPg.txt_4c_CdGrEstoqueA.Value = ALLTRIM(codigos)
1293:                         loc_oPg.txt_4c_DsGrEstoqueA.Value = ALLTRIM(descrs)
1294:                         loc_oPg.txt_4c_CdEstoqueA.Value   = ""
1295:                         loc_oPg.txt_4c_DsEstoqueA.Value   = ""
1296:                     ELSE
1297:                         loc_oPg.txt_4c_CdGrupoB.Value = ALLTRIM(codigos)
1298:                         loc_oPg.txt_4c_DsGrupoB.Value = ALLTRIM(descrs)
1299:                         loc_oPg.txt_4c_CdContaB.Value  = ""
1300:                         loc_oPg.txt_4c_DsContaB.Value  = ""
1301:                     ENDIF
1302:                 ENDIF
1303:                 loc_oBusca.Release()
1304:             ENDIF
1305:         CATCH TO loc_oErro

*-- Linhas 1334 a 1356:
1334:                     loc_oPg.txt_4c_DsEstoqueA.Value = ""
1335:                     EXIT
1336:                 ENDIF
1337:                 loc_cSQL = "SELECT TOP 1 iclis, razaos FROM SigCdCli" + ;
1338:                            " WHERE iclis = " + EscaparSQL(PADR(loc_cCodigo, 10))
1339:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaAVal")
1340:                 IF loc_nResult > 0 AND !EOF("cursor_4c_ContaAVal")
1341:                     SELECT cursor_4c_ContaAVal
1342:                     loc_oPg.txt_4c_CdEstoqueA.Value = ALLTRIM(cursor_4c_ContaAVal.iclis)
1343:                     loc_oPg.txt_4c_DsEstoqueA.Value = ALLTRIM(cursor_4c_ContaAVal.razaos)
1344:                 ELSE
1345:                     MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
1346:                         "Conta de Estoque")
1347:                     loc_oPg.txt_4c_CdEstoqueA.Value = ""
1348:                     loc_oPg.txt_4c_DsEstoqueA.Value = ""
1349:                     THIS.AbrirBuscaConta("A")
1350:                 ENDIF
1351:                 EXIT
1352:             ENDDO
1353:         CATCH TO loc_oErro
1354:             MsgErro(loc_oErro.Message, "Erro")
1355:         ENDTRY
1356:         IF USED("cursor_4c_ContaAVal")

*-- Linhas 1373 a 1404:
1373:             ENDIF
1374: 
1375:             IF !EMPTY(loc_cGrupo)
1376:                 loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
1377:             ELSE
1378:                 loc_cFiltro = ""
1379:             ENDIF
1380: 
1381:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1382:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
1383:                 "Conta de Estoque", .F., .F., loc_cFiltro)
1384:             IF VARTYPE(loc_oBusca) = "O"
1385:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
1386:                 loc_oBusca.mAddColuna("razaos", "", "Raz" + CHR(227) + "o Social")
1387:                 loc_oBusca.Show()
1388:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1389:                     SELECT (loc_cCursor)
1390:                     IF UPPER(ALLTRIM(par_cLado)) = "A"
1391:                         loc_oPg.txt_4c_CdEstoqueA.Value = ALLTRIM(iclis)
1392:                         loc_oPg.txt_4c_DsEstoqueA.Value = ALLTRIM(razaos)
1393:                     ELSE
1394:                         loc_oPg.txt_4c_CdContaB.Value = ALLTRIM(iclis)
1395:                         loc_oPg.txt_4c_DsContaB.Value = ALLTRIM(razaos)
1396:                     ENDIF
1397:                 ENDIF
1398:                 loc_oBusca.Release()
1399:             ENDIF
1400:         CATCH TO loc_oErro
1401:             MsgErro(loc_oErro.Message, "Erro")
1402:         ENDTRY
1403:         IF USED(loc_cCursor)
1404:             USE IN (loc_cCursor)

*-- Linhas 1431 a 1453:
1431:                     loc_oPg.txt_4c_DsContaB.Value  = ""
1432:                     EXIT
1433:                 ENDIF
1434:                 loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr" + ;
1435:                            " WHERE codigos = " + EscaparSQL(PADR(loc_cCodigo, 10))
1436:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstBVal")
1437:                 IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstBVal")
1438:                     SELECT cursor_4c_GrEstBVal
1439:                     loc_oPg.txt_4c_CdGrupoB.Value = ALLTRIM(cursor_4c_GrEstBVal.codigos)
1440:                     loc_oPg.txt_4c_DsGrupoB.Value = ALLTRIM(cursor_4c_GrEstBVal.descrs)
1441:                     loc_oPg.txt_4c_CdContaB.Value  = ""
1442:                     loc_oPg.txt_4c_DsContaB.Value  = ""
1443:                 ELSE
1444:                     MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
1445:                         "Grupo de Estoque")
1446:                     loc_oPg.txt_4c_CdGrupoB.Value = ""
1447:                     loc_oPg.txt_4c_DsGrupoB.Value = ""
1448:                     THIS.AbrirBuscaGrEstoque("B")
1449:                 ENDIF
1450:                 EXIT
1451:             ENDDO
1452:         CATCH TO loc_oErro
1453:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1481 a 1503:
1481:                     loc_oPg.txt_4c_DsContaB.Value = ""
1482:                     EXIT
1483:                 ENDIF
1484:                 loc_cSQL = "SELECT TOP 1 iclis, razaos FROM SigCdCli" + ;
1485:                            " WHERE iclis = " + EscaparSQL(PADR(loc_cCodigo, 10))
1486:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaBVal")
1487:                 IF loc_nResult > 0 AND !EOF("cursor_4c_ContaBVal")
1488:                     SELECT cursor_4c_ContaBVal
1489:                     loc_oPg.txt_4c_CdContaB.Value = ALLTRIM(cursor_4c_ContaBVal.iclis)
1490:                     loc_oPg.txt_4c_DsContaB.Value = ALLTRIM(cursor_4c_ContaBVal.razaos)
1491:                 ELSE
1492:                     MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
1493:                         "Conta de Estoque")
1494:                     loc_oPg.txt_4c_CdContaB.Value = ""
1495:                     loc_oPg.txt_4c_DsContaB.Value = ""
1496:                     THIS.AbrirBuscaConta("B")
1497:                 ENDIF
1498:                 EXIT
1499:             ENDDO
1500:         CATCH TO loc_oErro
1501:             MsgErro(loc_oErro.Message, "Erro")
1502:         ENDTRY
1503:         IF USED("cursor_4c_ContaBVal")

*-- Linhas 1570 a 1588:
1570:                 loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1571:                 loc_oBusca.Show()
1572:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1573:                     SELECT (loc_cCursor)
1574:                     par_oTxt.Value = ALLTRIM(cgrus)
1575:                 ENDIF
1576:                 loc_oBusca.Release()
1577:             ENDIF
1578:         CATCH TO loc_oErro
1579:             MsgErro(loc_oErro.Message, "Erro")
1580:         ENDTRY
1581:         IF USED(loc_cCursor)
1582:             USE IN (loc_cCursor)
1583:         ENDIF
1584:     ENDPROC
1585: 
1586:     *-- Busca Unidade (SigCdUni: cUnis/dUnis)
1587:     PROCEDURE AbrirBuscaUnidadeFiltro(par_oTxt)
1588:         LOCAL loc_oBusca, loc_cCursor

*-- Linhas 1596 a 1614:
1596:                 loc_oBusca.mAddColuna("dUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
1597:                 loc_oBusca.Show()
1598:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1599:                     SELECT (loc_cCursor)
1600:                     par_oTxt.Value = ALLTRIM(cUnis)
1601:                 ENDIF
1602:                 loc_oBusca.Release()
1603:             ENDIF
1604:         CATCH TO loc_oErro
1605:             MsgErro(loc_oErro.Message, "Erro")
1606:         ENDTRY
1607:         IF USED(loc_cCursor)
1608:             USE IN (loc_cCursor)
1609:         ENDIF
1610:     ENDPROC
1611: 
1612:     *-- Busca Linha (SigCdLin: Linhas/Descs)
1613:     PROCEDURE AbrirBuscaLinhaFiltro(par_oTxt)
1614:         LOCAL loc_oBusca, loc_cCursor

*-- Linhas 1622 a 1640:
1622:                 loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1623:                 loc_oBusca.Show()
1624:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1625:                     SELECT (loc_cCursor)
1626:                     par_oTxt.Value = ALLTRIM(Linhas)
1627:                 ENDIF
1628:                 loc_oBusca.Release()
1629:             ENDIF
1630:         CATCH TO loc_oErro
1631:             MsgErro(loc_oErro.Message, "Erro")
1632:         ENDTRY
1633:         IF USED(loc_cCursor)
1634:             USE IN (loc_cCursor)
1635:         ENDIF
1636:     ENDPROC
1637: 
1638:     *-- Busca Grupo de Venda / Colecao (SigCdCol: Colecoes/Descs)
1639:     PROCEDURE AbrirBuscaColecaoFiltro(par_oTxt)
1640:         LOCAL loc_oBusca, loc_cCursor

*-- Linhas 1648 a 1666:
1648:                 loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
1649:                 loc_oBusca.Show()
1650:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1651:                     SELECT (loc_cCursor)
1652:                     par_oTxt.Value = ALLTRIM(Colecoes)
1653:                 ENDIF
1654:                 loc_oBusca.Release()
1655:             ENDIF
1656:         CATCH TO loc_oErro
1657:             MsgErro(loc_oErro.Message, "Erro")
1658:         ENDTRY
1659:         IF USED(loc_cCursor)
1660:             USE IN (loc_cCursor)
1661:         ENDIF
1662:     ENDPROC
1663: 
1664:     *==========================================================================
1665:     * MAPEAMENTO CRUD -> REPORT (continuacao Fase 4)
1666:     * Forms CRUD tem Page1=Lista (grid+botoes CRUD) e Page2=Dados.

*-- Linhas 1743 a 1761:
1743: 
1744:     *--------------------------------------------------------------------------
1745:     * CarregarLista - Override: forms REPORT nao tem grid de lista para carregar
1746:     *   Em forms CRUD: executa SELECT na tabela e carrega cursor_4c_Dados no grid.
1747:     *   Em forms REPORT: dados sao gerados sob demanda pelo BO (PrepararDados)
1748:     *   ao clicar Visualizar/Imprimir/Excel. Retorna .T. para compatibilidade
1749:     *   com codigo generico que verifica resultado de CarregarLista.
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE CarregarLista()
1752:         RETURN .T.
1753:     ENDPROC
1754: 
1755:     *--------------------------------------------------------------------------
1756:     * ConfigurarPaginaDados - Override CRUD->REPORT (FASE 5/8)
1757:     *   Em forms CRUD: cria Page2 com Labels, TextBoxes e botoes Salvar/Cancelar.
1758:     *   Em forms REPORT: Page2 NAO existe - o form e FLAT (uma pagina de filtros).
1759:     *   Todos os controles de entrada estao na Page1 (ConfigurarPaginaFiltros).
1760:     *   Este override garante que, se FormBase ou codigo generico chamar
1761:     *   ConfigurarPaginaDados(), a pagina de filtros seja configurada corretamente


### BO (C:\4c\projeto\app\classes\sigrecpeBO.prg):
*==============================================================================
* sigrecpeBO.prg
* Business Object para relatorio: Divergencias em Estoques
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS sigrecpeBO AS RelatorioBase

    *-- Cursor de resultado do relatorio
    this_cCursorDados    = "cursor_4c_Dados"

    *-- Estoque A - Grupo e Conta
    this_cCdGrEstoqueA   = ""
    this_cDsGrEstoqueA   = ""
    this_cCdEstoqueA     = ""
    this_cDsEstoqueA     = ""

    *-- Estoque B - Grupo e Conta
    this_cCdGrupoB       = ""
    this_cDsGrupoB       = ""
    this_cCdContaB       = ""
    this_cDsContaB       = ""

    *-- Opcoes de comparacao (valores default iguais ao legado)
    this_nTipo           = 1
    this_nCorTam         = 2
    this_nReff           = 2
    this_nSituacao       = 3

    *-- Filtros de produto (intervalo inicial/final)
    this_cCgrui          = ""
    this_cCgruf          = ""
    this_cCunii          = ""
    this_cCunif          = ""
    this_cLini           = ""
    this_cLinf           = ""
    this_cColi           = ""
    this_cColf           = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de preset
    * Para BO de relatorio: permite reaplicar parametros salvos previamente
    * par_cAliasCursor: nome do alias com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                EXIT
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                EXIT
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            *-- Estoque A
            IF TYPE("m.cCdGrEstoqueA") = "C"
                THIS.this_cCdGrEstoqueA = ALLTRIM(m.cCdGrEstoqueA)
            ENDIF
            IF TYPE("m.cDsGrEstoqueA") = "C"
                THIS.this_cDsGrEstoqueA = ALLTRIM(m.cDsGrEstoqueA)
            ENDIF
            IF TYPE("m.cCdEstoqueA") = "C"
                THIS.this_cCdEstoqueA = ALLTRIM(m.cCdEstoqueA)
            ENDIF
            IF TYPE("m.cDsEstoqueA") = "C"
                THIS.this_cDsEstoqueA = ALLTRIM(m.cDsEstoqueA)
            ENDIF

            *-- Estoque B
            IF TYPE("m.cCdGrupoB") = "C"
                THIS.this_cCdGrupoB = ALLTRIM(m.cCdGrupoB)
            ENDIF
            IF TYPE("m.cDsGrupoB") = "C"
                THIS.this_cDsGrupoB = ALLTRIM(m.cDsGrupoB)
            ENDIF
            IF TYPE("m.cCdContaB") = "C"
                THIS.this_cCdContaB = ALLTRIM(m.cCdContaB)
            ENDIF
            IF TYPE("m.cDsContaB") = "C"
                THIS.this_cDsContaB = ALLTRIM(m.cDsContaB)
            ENDIF

            *-- Opcoes de comparacao
            IF TYPE("m.nTipo") = "N"
                THIS.this_nTipo = m.nTipo
            ENDIF
            IF TYPE("m.nCorTam") = "N"
                THIS.this_nCorTam = m.nCorTam
            ENDIF
            IF TYPE("m.nReff") = "N"
                THIS.this_nReff = m.nReff
            ENDIF
            IF TYPE("m.nSituacao") = "N"
                THIS.this_nSituacao = m.nSituacao
            ENDIF

            *-- Filtros de produto
            IF TYPE("m.cCgrui") = "C"
                THIS.this_cCgrui = ALLTRIM(m.cCgrui)
            ENDIF
            IF TYPE("m.cCgruf") = "C"
                THIS.this_cCgruf = ALLTRIM(m.cCgruf)
            ENDIF
            IF TYPE("m.cCunii") = "C"
                THIS.this_cCunii = ALLTRIM(m.cCunii)
            ENDIF
            IF TYPE("m.cCunif") = "C"
                THIS.this_cCunif = ALLTRIM(m.cCunif)
            ENDIF
            IF TYPE("m.cLini") = "C"
                THIS.this_cLini = ALLTRIM(m.cLini)
            ENDIF
            IF TYPE("m.cLinf") = "C"
                THIS.this_cLinf = ALLTRIM(m.cLinf)
            ENDIF
            IF TYPE("m.cColi") = "C"
                THIS.this_cColi = ALLTRIM(m.cColi)
            ENDIF
            IF TYPE("m.cColf") = "C"
                THIS.this_cColf = ALLTRIM(m.cColf)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros (para auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TP="    + ALLTRIM(STR(THIS.this_nTipo,1)) + ;
                     ";GA="   + ALLTRIM(THIS.this_cCdGrEstoqueA) + ;
                     ";EA="   + ALLTRIM(THIS.this_cCdEstoqueA) + ;
                     ";GB="   + ALLTRIM(THIS.this_cCdGrupoB) + ;
                     ";EB="   + ALLTRIM(THIS.this_cCdContaB) + ;
                     ";CT="   + ALLTRIM(STR(THIS.this_nCorTam,1)) + ;
                     ";RF="   + ALLTRIM(STR(THIS.this_nReff,1)) + ;
                     ";SIT="  + ALLTRIM(STR(THIS.this_nSituacao,1)) + ;
                     ";GRU="  + ALLTRIM(THIS.this_cCgrui) + "-" + ALLTRIM(THIS.this_cCgruf) + ;
                     ";UNI="  + ALLTRIM(THIS.this_cCunii) + "-" + ALLTRIM(THIS.this_cCunif) + ;
                     ";LIN="  + ALLTRIM(THIS.this_cLini)  + "-" + ALLTRIM(THIS.this_cLinf) + ;
                     ";COL="  + ALLTRIM(THIS.this_cColi)  + "-" + ALLTRIM(THIS.this_cColf)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: IMPRESSAO, VISUALIZACAO, EXCEL
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpE") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGrupoA, loc_cEstoqA, loc_cGrupoB, loc_cEstoqB
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2
        LOCAL loc_cEmps

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cEmps   = go_4c_Sistema.cCodEmpresa
                loc_cGrupoA = PADR(THIS.this_cCdGrEstoqueA, 10)
                loc_cEstoqA = PADR(THIS.this_cCdEstoqueA,   10)
                loc_cGrupoB = PADR(THIS.this_cCdGrupoB,     10)
                loc_cEstoqB = PADR(THIS.this_cCdContaB,     10)

                *-- Obter nome da empresa
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = '" + loc_cEmps + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar empresa"
                    EXIT
                ENDIF
                SELECT cursor_4c_TmpEmp
                loc_cNomeEmpresa = IIF(!EOF(), ALLTRIM(Razas), "")
                USE IN cursor_4c_TmpEmp

                *-- Montar titulos do relatorio (CHR: 234=e-circunflex)
                loc_cRelTitulo  = "Diverg" + CHR(234) + "ncias entre Estoque"
                loc_cRelTitulo2 = "Estoque A :" + loc_cGrupoA + "/" + loc_cEstoqA + ;
                                  " - Estoque B :" + loc_cGrupoB + "/" + loc_cEstoqB

                *-- Criar cursor de cabecalho para o FRX
                IF USED("cscabecalho")
                    USE IN cscabecalho
                ENDIF
                CREATE CURSOR cscabecalho (NomeEmpresa C(80), RelTitulo C(80), RelTitulo2 C(80))
                INSERT INTO cscabecalho (NomeEmpresa, RelTitulo, RelTitulo2) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2)

                *-- Carregar movimentos de estoque do SQL Server
                IF USED("cursor_4c_LocalEst")
                    USE IN cursor_4c_LocalEst
                ENDIF
                loc_cSQL = "SELECT * FROM SigMvEst WHERE Emps = '" + loc_cEmps + "' AND Sqtds > 0"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEst")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar movimentos de estoque"
                    EXIT
                ENDIF

                *-- Carregar cadastro de produtos do SQL Server
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros, cproEqs, Reffs, cgrus, dpros, " + ;
                           "Cunis, Linhas, Colecoes, situas FROM SigCdPro"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar produtos"
                    EXIT
                ENDIF

                *-- Fechar cursor resultado anterior
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                *-- Executar comparacao conforme tipo selecionado
                IF THIS.this_nTipo = 1
                    THIS.ExecutarComparacaoEstoqueAvsB(loc_cGrupoA, loc_cEstoqA, ;
                        loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ELSE
                    THIS.ExecutarComparacaoProdutosVsB(loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoEstoqueAvsB - Tipo 1: itens do Estoque A ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoEstoqueAvsB(par_cGrupoA, par_cEstoqA, ;
                                                       par_cGrupoB, par_cEstoqB, ;
                                                       par_cEmps)
        IF THIS.this_nCorTam = 1
            *-- Analisa por Cor/Tamanho: chave composta Cpros+CodCors+CodTams
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros + a.CodCors + a.CodTams NOT IN ;
                      (SELECT Cpros + CodCors + CodTams FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ELSE
            *-- Analisa somente por produto (Cpros)
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoProdutosVsB - Tipo 2: produtos filtrados ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoProdutosVsB(par_cGrupoB, par_cEstoqB, par_cEmps)
        LOCAL loc_cWhere, loc_cInicio, loc_cFinal

        *-- Montar clausula WHERE para filtros de produto
        loc_cWhere = ".T."

        *-- Filtro de Grupo (cgrus)
        loc_cInicio = ALLTRIM(THIS.this_cCgrui)
        loc_cFinal  = ALLTRIM(THIS.this_cCgruf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND cgrus >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Unidade (Cunis)
        loc_cInicio = ALLTRIM(THIS.this_cCunii)
        loc_cFinal  = ALLTRIM(THIS.this_cCunif)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Cunis >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Linha (Linhas)
        loc_cInicio = ALLTRIM(THIS.this_cLini)
        loc_cFinal  = ALLTRIM(THIS.this_cLinf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Linhas >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Colecao (Colecoes)
        loc_cInicio = ALLTRIM(THIS.this_cColi)
        loc_cFinal  = ALLTRIM(THIS.this_cColf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Colecoes >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de situacao (Ativos=1, Inativos=2, Todos=3 = sem filtro)
        IF THIS.this_nSituacao = 1 OR THIS.this_nSituacao = 2
            loc_cWhere = loc_cWhere + " AND situas = " + TRANSFORM(THIS.this_nSituacao)
        ENDIF

        *-- Criar cursor com produtos filtrados (sem CodCors/CodTams reais ainda)
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               "    " AS CodCors, "  " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE &loc_cWhere. ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Criar cursor TmpPro indexado por Cpros para SEEK de equivalentes
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        CREATE CURSOR cursor_4c_TmpPro ;
            (Cpros C(10), cproeqs C(10), dpros C(40), ;
             CodCors C(4), CodTams C(2), Sqtds N(12,2), ;
             Reffs C(40), Reff2s C(40))
        INDEX ON Cpros TAG Cpros
        SELECT cursor_4c_TmpPro
        APPEND FROM DBF("cursor_4c_TmpPro2")

        *-- Buscar produtos equivalentes (cproEqs aponta para outro Cpros)
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE !EMPTY(cproEqs) ;
              AND cproEqs IN (SELECT Cpros FROM cursor_4c_TmpPro) ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Preencher Reff2s em TmpPro com referencia do produto equivalente
        SELECT cursor_4c_TmpPro2
        SCAN
            IF SEEK(cproEqs, "cursor_4c_TmpPro", "Cpros")
                REPLACE cursor_4c_TmpPro.cproEqs WITH cursor_4c_TmpPro2.Cpros, ;
                        cursor_4c_TmpPro.Reff2s  WITH cursor_4c_TmpPro2.Reffs ;
                        IN cursor_4c_TmpPro
            ENDIF
        ENDSCAN

        *-- Gerar resultado conforme opcao de referencia de fornecedor
        IF THIS.this_nReff = 1
            *-- Agrupar por Reffs e comparar via referencia de fornecedor
            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
            SELECT Reffs, MAX(Reff2s) AS Reff2s ;
                FROM cursor_4c_TmpPro ;
                GROUP BY Reffs ;
                INTO CURSOR cursor_4c_TmpProx READWRITE

            SELECT DISTINCT PADR(Reffs, 10) AS Cpros, SPACE(40) AS dpros, ;
                            " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
                FROM cursor_4c_TmpProx ;
                WHERE !EMPTY(Reffs) ;
                  AND Reffs NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros) ;
                  AND (EMPTY(Reff2s) OR Reff2s NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY 1

            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
        ELSE
            *-- Comparar diretamente por Cpros e produto equivalente
            SELECT * ;
                FROM cursor_4c_TmpPro ;
                WHERE Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND (EMPTY(cproEqs) OR cproEqs NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY Cpros
        ENDIF

        *-- Limpar cursores temporarios
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

