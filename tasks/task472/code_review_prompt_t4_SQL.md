# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (38)
- [GRID-SQL] Campo 'Ano' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'sGrupos' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'sContas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'sDContas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Moeda' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Inativas' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Grupos' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Contas' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Jan' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Fev' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Mar' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Abr' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Mai' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Jun' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Jul' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Ago' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Set' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Out' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Nov' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Val_Dez' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Total' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Jan' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Fev' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Mar' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Abr' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Mai' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Jun' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Jul' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Ago' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Set' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Out' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Nov' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Acm_Dez' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'ChkValida' usado em ControlSource de cursor_4c_MtI mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CODIGO, ANO, SGRUPOS, SCONTAS, INATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CODIGO, ANO, SGRUPOS, SCONTAS, INATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CODIGO, ANO, SGRUPOS, SCONTAS, INATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CODIGO, ANO, SGRUPOS, SCONTAS, INATIVAS

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
  ControlSource = "crSigCdMtz.DtIncs"
  ControlSource = "crSigCdMtz.UsuIncs"
  ControlSource = "crSigCdMtz.DtAlts"
  ControlSource = "crSigCdMtz.sGrupos"
  ControlSource = "crSigCdMtz.UsuAlts"
  ControlSource = "crSigCdMtz.sContas"
  ControlSource = "crSigCdMtz.Inativas"
  ControlSource = "crSigCdMtz.Ano"
  ControlSource = "crSigCdMtz.Codigo"
  ControlSource = "crSigCdMtz.Moeda"
  ControlSource = ""
  ControlSource = "crSigCdMtz.sDContas"
  DeleteMark = .F.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
lnOldSel = Select()
Select csSigCdMtI
Select (val_abr+val_ago+val_dez+val_fev+val_jan+val_jul+val_jun+val_mai+val_nov+val_out+val_set+val_mar) As Total From csSigCdMtI Where cIdChaves = pcChave Into Cursor crTmpTot Readwrite
Select crTmpTot
Select csSigCdMtI
Select csSigCdMtI
Select Sum(Total) As Total From csSigCdMtI Into Cursor crTmpTot Readwrite
Select crTmpTot
Select(lnOldSel)
If Not Thisform.poDataMgr.Update('crSigCdMtz')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMtz )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdMtI')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMtI )')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdMtz Where Codigo = ?lcCodigo], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdMtI Where Codigo = ?lcCodigo], '') < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdMtz Where Codigo = ?lcCodigo], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdMtI Where Codigo = ?lcCodigo], '') < 1)
If llOk And Not Thisform.poDataMgr.Update('crSigCdMtz')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMtz )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdMtI')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdMtI )')
	lcQuery = [Select a.*, b.rclis as sDContas From SigCdMtz a join SigCdCli b on a.sContas = b.IClis ]
	lcSqlCdMtI = [Select *, (val_abr+val_ago+val_dez+val_fev+val_jan+val_jul+val_jun+val_mai+val_nov+val_out+val_set+val_mar) as Total From SigCdMtI Where Codigo = ?lcCodigo]
Select crSigCdMtI
lcQuery = [Select a.*, (val_abr+val_ago+val_dez+val_fev+val_jan+val_jul+val_jun+val_mai+val_nov+val_out+val_set+val_mar) as Total ] + ;
	[from SigCdMtI a ] + ;
	[join SigCdMtz b on a.codigo = b.codigo ] + ;
Thisform.podatamgr.SqlExecute(lcQuery,[csSigCdMtI])
Select csSigCdMtI
Thisform.pagina.dados.grdSaldos.column1.ControlSource  = [csSigCdMtI.Grupos]
Thisform.pagina.dados.grdSaldos.column2.ControlSource  = [csSigCdMtI.Contas]
Thisform.pagina.dados.grdSaldos.column3.ControlSource  = [csSigCdMtI.Val_Jan]
Thisform.pagina.dados.grdSaldos.column4.ControlSource  = [csSigCdMtI.Val_Fev]
Thisform.pagina.dados.grdSaldos.column5.ControlSource  = [csSigCdMtI.Val_Mar]
Thisform.pagina.dados.grdSaldos.column6.ControlSource  = [csSigCdMtI.Val_Abr]
Thisform.pagina.dados.grdSaldos.column7.ControlSource  = [csSigCdMtI.Val_Mai]
Thisform.pagina.dados.grdSaldos.column8.ControlSource  = [csSigCdMtI.Val_Jun]
Thisform.pagina.dados.grdSaldos.column9.ControlSource  = [csSigCdMtI.Val_Jul]
Thisform.pagina.dados.grdSaldos.column10.ControlSource = [csSigCdMtI.Val_Ago]
Thisform.pagina.dados.grdSaldos.column11.ControlSource = [csSigCdMtI.Val_Set]
Thisform.pagina.dados.grdSaldos.column12.ControlSource = [csSigCdMtI.Val_Out]
Thisform.pagina.dados.grdSaldos.column13.ControlSource = [csSigCdMtI.Val_Nov]
Thisform.pagina.dados.grdSaldos.column14.ControlSource = [csSigCdMtI.Val_Dez]
Thisform.pagina.dados.grdSaldos.column15.ControlSource = [csSigCdMtI.Total]
Thisform.pagina.dados.grdSaldos.column16.ControlSource = [csSigCdMtI.Acm_Jan]
Thisform.pagina.dados.grdSaldos.column17.ControlSource = [csSigCdMtI.Acm_Fev]
Thisform.pagina.dados.grdSaldos.column18.ControlSource = [csSigCdMtI.Acm_Mar]
Thisform.pagina.dados.grdSaldos.column19.ControlSource = [csSigCdMtI.Acm_Abr]
Thisform.pagina.dados.grdSaldos.column20.ControlSource = [csSigCdMtI.Acm_Mai]
Thisform.pagina.dados.grdSaldos.column21.ControlSource = [csSigCdMtI.Acm_Jun]
Thisform.pagina.dados.grdSaldos.column22.ControlSource = [csSigCdMtI.Acm_Jul]
Thisform.pagina.dados.grdSaldos.column23.ControlSource = [csSigCdMtI.Acm_Ago]
Thisform.pagina.dados.grdSaldos.column24.ControlSource = [csSigCdMtI.Acm_Set]
Thisform.pagina.dados.grdSaldos.column25.ControlSource = [csSigCdMtI.Acm_Out]
Thisform.pagina.dados.grdSaldos.column26.ControlSource = [csSigCdMtI.Acm_Nov]
Thisform.pagina.dados.grdSaldos.column27.ControlSource = [csSigCdMtI.Acm_Dez]
Thisform.pagina.dados.grdSaldos.column28.ControlSource = [csSigCdMtI.ChkValida]
Select csSigCdMtI
Select Sum(val_abr+val_ago+val_dez+val_fev+val_jan+val_jul+val_jun+val_mai+val_nov+val_out+val_set+val_mar) As Total From csSigCdMtI Into Cursor crTmpTot Readwrite
Select crTmpTot
Select crSigCdMtI
		lcQuery = [Select * From SigCdMtz Where Ano = ']+lcAno+[' And sGrupos = ']+lcGrupo+[' And sContas = ']+lcConta+[' ]
		If ThisForm.Podatamgr.SqlExecute(lcQuery,[crChkMtz])<1
	Select csSigCdMtI
	Select Count(*) as Qtds, Grupos, Contas ;
		From csSigCdMtI ;
	Select csRegDup
	Select crSigCdMtI
	Select csSigCdMtI
		Select crSigCdMtI
		Select csSigCdMtI
	Select crSigCdMtI
	Delete For (Empty(Grupos) And Empty(Contas))
	Select csSigCdMtI
		Insert Into csSigCdMtI (Codigo, cIdChaves) Values (lnCodigo, fUniqueIds())
	Select csSigCdMtI
		Delete
	Select csSigCdMtI
		Insert Into csSigCdMtI (Codigo, cIdChaves) Values (lnCodigo, fUniqueIds())

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS SQL (2290 linhas total):

*-- Linhas 344 a 383:
344:             .AutoSize        = .F.
345:             .Visible         = .T.
346:         ENDWITH
347: 
348:         *--------------------------------------------------------------------------
349:         *-- Grid lista de matrizes - cursor_4c_Dados (7 colunas)
350:         *--------------------------------------------------------------------------
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         loc_oPagina.grd_4c_Lista.RecordSource = ""
353:         loc_oPagina.grd_4c_Lista.ColumnCount  = 7
354: 
355:         WITH loc_oPagina.grd_4c_Lista
356:             .Top                = 88
357:             .Left               = 5
358:             .Width              = 905
359:             .Height             = 480
360:             .FontName           = "Verdana"
361:             .FontSize           = 8
362:             .ForeColor          = RGB(90, 90, 90)
363:             .BackColor          = RGB(255, 255, 255)
364:             .GridLineColor      = RGB(238, 238, 238)
365:             .HighlightBackColor = RGB(255, 255, 255)
366:             .HighlightForeColor = RGB(15, 41, 104)
367:             .HighlightStyle     = 2
368:             .DeleteMark         = .F.
369:             .RecordMark         = .F.
370:             .RowHeight          = 16
371:             .ScrollBars         = 2
372:             .GridLines          = 3
373:             .ReadOnly           = .T.
374:             .Visible            = .T.
375:             .Column1.Header1.Caption = ""
376:             .Column1.Width           = 50
377:             .Column2.Header1.Caption = ""
378:             .Column2.Width           = 50
379:             .Column3.Header1.Caption = "Grupo"
380:             .Column3.Width           = 80
381:             .Column4.Header1.Caption = "Conta"
382:             .Column4.Width           = 80
383:             .Column5.Header1.Caption = ""

*-- Linhas 738 a 756:
738:             .FontSize    = 8
739:             .Visible     = .T.
740:             .RecordMark   = .F.
741:             .DeleteMark   = .F.
742:         ENDWITH
743: 
744:         loc_oGrid = loc_oPagina.grd_4c_Dados
745: 
746:         *-- Coluna 1 - Grupos
747:         WITH loc_oGrid.Column1
748:             .Header1.Caption = "Grupo"
749:             .Width           = 65
750:         ENDWITH
751: 
752:         *-- Coluna 2 - Contas
753:         WITH loc_oGrid.Column2
754:             .Header1.Caption = "Conta"
755:             .Width           = 65
756:         ENDWITH

*-- Linhas 1107 a 1149:
1107: 
1108:         THIS.TornarControlesVisiveis(loc_oPagina)
1109:     ENDPROC
1110: 
1111:     *-- =========================================================================
1112:     *-- CARREGAR LISTA - Carrega cursor_4c_Dados no Grid da Page1
1113:     *-- =========================================================================
1114: 
1115:     PROCEDURE CarregarLista()
1116:         LOCAL loc_lResultado, loc_oGrid
1117:         loc_lResultado = .F.
1118: 
1119:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1120:             RETURN .T.
1121:         ENDIF
1122: 
1123:         TRY
1124:             IF THIS.this_oBusinessObject.Buscar("")
1125:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1126:                 loc_oGrid.ColumnCount = 7
1127:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
1128:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1129:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1130:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1131:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1132:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1133:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1134:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1135:                 THIS.FormatarGridLista(loc_oGrid)
1136:                 loc_lResultado = .T.
1137:             ENDIF
1138: 
1139:         CATCH TO loc_oErro
1140:             MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
1141:             loc_lResultado = .F.
1142:         ENDTRY
1143: 
1144:         RETURN loc_lResultado
1145:     ENDPROC
1146: 
1147:     *-- =========================================================================
1148:     *-- ALTERNAR PAGINA - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
1149:     *-- =========================================================================

*-- Linhas 1373 a 1400:
1373: 
1374:     PROCEDURE BtnVisualizarClick()
1375:         LOCAL loc_lResultado, loc_cCodigo
1376:         loc_lResultado = .F.
1377: 
1378:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1379:             MsgAviso("Nenhum registro selecionado.")
1380:             RETURN .F.
1381:         ENDIF
1382: 
1383:         TRY
1384:             SELECT cursor_4c_Dados
1385:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1386: 
1387:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1388:                 THIS.this_cModoAtual = "VISUALIZAR"
1389:                 THIS.BOParaForm()
1390:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1391:                 THIS.AlternarGradeDetalhe()
1392:                 THIS.HabilitarCampos(.F.)
1393:                 THIS.AjustarBotoesPorModo()
1394:                 THIS.AlternarPaginaDados()
1395:                 loc_lResultado = .T.
1396:             ENDIF
1397: 
1398:         CATCH TO loc_oErro
1399:             MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
1400:         ENDTRY

*-- Linhas 1408 a 1435:
1408: 
1409:     PROCEDURE BtnAlterarClick()
1410:         LOCAL loc_lResultado, loc_cCodigo
1411:         loc_lResultado = .F.
1412: 
1413:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1414:             MsgAviso("Nenhum registro selecionado.")
1415:             RETURN .F.
1416:         ENDIF
1417: 
1418:         TRY
1419:             SELECT cursor_4c_Dados
1420:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1421: 
1422:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1423:                 THIS.this_oBusinessObject.EditarRegistro()
1424:                 THIS.this_cModoAtual = "ALTERAR"
1425:                 THIS.BOParaForm()
1426:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1427:                 THIS.AlternarGradeDetalhe()
1428:                 THIS.HabilitarCampos(.T.)
1429:                 THIS.AjustarBotoesPorModo()
1430:                 THIS.AlternarPaginaDados()
1431:                 loc_lResultado = .T.
1432:             ENDIF
1433: 
1434:         CATCH TO loc_oErro
1435:             MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")

*-- Linhas 1444 a 1470:
1444: 
1445:     PROCEDURE BtnExcluirClick()
1446:         LOCAL loc_lResultado, loc_cCodigo
1447:         loc_lResultado = .F.
1448: 
1449:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1450:             MsgAviso("Nenhum registro selecionado.")
1451:             RETURN .F.
1452:         ENDIF
1453: 
1454:         SELECT cursor_4c_Dados
1455:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1456: 
1457:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
1458:             RETURN .F.
1459:         ENDIF
1460: 
1461:         TRY
1462:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1463:                 IF THIS.this_oBusinessObject.Excluir()
1464:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
1465:                     THIS.CarregarLista()
1466:                     loc_lResultado = .T.
1467:                 ENDIF
1468:             ENDIF
1469: 
1470:         CATCH TO loc_oErro

*-- Linhas 1493 a 1526:
1493:                 loc_oBusca.Show()
1494: 
1495:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
1496:                     SELECT cursor_4c_BuscaMtz
1497:                     IF !EOF()
1498:                         LOCAL loc_oGrid
1499:                         THIS.this_oBusinessObject.Buscar( ;
1500:                             "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
1501:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1502:                         IF VARTYPE(loc_oGrid) = "O"
1503:                             loc_oGrid.ColumnCount = 7
1504:                             loc_oGrid.RecordSource            = "cursor_4c_Dados"
1505:                             loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1506:                             loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1507:                             loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1508:                             loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1509:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1510:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1511:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1512:                             THIS.FormatarGridLista(loc_oGrid)
1513:                         ENDIF
1514:                     ENDIF
1515:                 ENDIF
1516: 
1517:                 loc_oBusca.Release()
1518:                 loc_lResultado = .T.
1519:             ENDIF
1520: 
1521:         CATCH TO loc_oErro
1522:             MsgErro(loc_oErro.Message, "Formmtz.BtnBuscarClick")
1523:         ENDTRY
1524: 
1525:         IF USED("cursor_4c_BuscaMtz")
1526:             USE IN cursor_4c_BuscaMtz

*-- Linhas 1607 a 1669:
1607:     PROTECTED PROCEDURE AlternarPaginaDados()
1608:         THIS.pgf_4c_Paginas.ActivePage = 2
1609:     ENDPROC
1610: 
1611:     *-- =========================================================================
1612:     *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
1613:     *-- (sera completado na Fase 4 quando o grid for criado)
1614:     *-- =========================================================================
1615: 
1616:     PROTECTED PROCEDURE AlternarGradeDetalhe()
1617:         LOCAL loc_oGrid, loc_lResultado
1618:         loc_lResultado = .F.
1619: 
1620:         TRY
1621:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1622:             IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
1623:                 loc_oGrid.ColumnCount = 28
1624:                 loc_oGrid.RecordSource = "cursor_4c_MtI"
1625: 
1626:                 *-- Wires ControlSources apos RecordSource estar definido
1627:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
1628:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
1629:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
1630:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
1631:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
1632:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
1633:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
1634:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
1635:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
1636:                 loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
1637:                 loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
1638:                 loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
1639:                 loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
1640:                 loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
1641:                 loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
1642:                 loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
1643:                 loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
1644:                 loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
1645:                 loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
1646:                 loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
1647:                 loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
1648:                 loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
1649:                 loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
1650:                 loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
1651:                 loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
1652:                 loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
1653:                 loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
1654:                 loc_oGrid.Column28.chk_4c_Check1.ControlSource = "cursor_4c_MtI.ChkValida"
1655: 
1656:                 loc_oGrid.FontName = "Tahoma"
1657:                 loc_oGrid.FontSize = 8
1658:                 loc_oGrid.Refresh()
1659:                 loc_lResultado = .T.
1660:             ENDIF
1661:         CATCH TO loc_oErro
1662:             MsgErro(loc_oErro.Message, "Formmtz.AlternarGradeDetalhe")
1663:         ENDTRY
1664: 
1665:         RETURN loc_lResultado
1666:     ENDPROC
1667: 
1668:     *-- =========================================================================
1669:     *-- VALIDAR ANO MTZ - Valida ano de competencia (range 2000-2999)

*-- Linhas 1709 a 1732:
1709:         ENDIF
1710: 
1711:         TRY
1712:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
1713:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1714: 
1715:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
1716:                !EOF("cursor_4c_GcBusca")
1717:                 SELECT cursor_4c_GcBusca
1718:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1719:                     ALLTRIM(cursor_4c_GcBusca.Classes)
1720: 
1721:                 IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
1722:                     MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
1723:                             CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
1724:                             "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
1725:                             " informada!", "Aten" + CHR(231) + CHR(227) + "o")
1726:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1727:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1728:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
1729:                 ELSE
1730:                     loc_lResultado = .T.
1731:                 ENDIF
1732:             ELSE

*-- Linhas 1766 a 1784:
1766:                 ENDIF
1767: 
1768:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
1769:                     SELECT cursor_4c_GcBusca2
1770:                     IF !EOF()
1771:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
1772:                             ALLTRIM(cursor_4c_GcBusca2.Codigos)
1773:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1774:                             ALLTRIM(cursor_4c_GcBusca2.Classes)
1775:                     ENDIF
1776:                 ELSE
1777:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1778:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1779:                 ENDIF
1780: 
1781:                 loc_oBusca.Release()
1782:             ENDIF
1783: 
1784:         CATCH TO loc_oErro

*-- Linhas 1819 a 1845:
1819:         ENDIF
1820: 
1821:         TRY
1822:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
1823:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
1824:             IF !EMPTY(loc_cGrupo)
1825:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1826:             ENDIF
1827: 
1828:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
1829:                !EOF("cursor_4c_CliBusca")
1830:                 SELECT cursor_4c_CliBusca
1831:                 IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
1832:                     MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
1833:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1834:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1835:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
1836:                 ELSE
1837:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1838:                         ALLTRIM(cursor_4c_CliBusca.Rclis)
1839:                     loc_lResultado = .T.
1840:                 ENDIF
1841:             ELSE
1842:                 IF USED("cursor_4c_CliBusca")
1843:                     USE IN cursor_4c_CliBusca
1844:                 ENDIF
1845:                 THIS.AbrirBuscaContaMtz()

*-- Linhas 1865 a 1899:
1865:             loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1866:             loc_cFiltro = ""
1867:             IF !EMPTY(loc_cGrupo)
1868:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1869:             ENDIF
1870: 
1871:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1872:                 "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
1873:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
1874:                 "Conta Corrente", .F., .T., loc_cFiltro)
1875: 
1876:             IF VARTYPE(loc_oBusca) = "O"
1877:                 IF !loc_oBusca.this_lAchouRegistro
1878:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1879:                     loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
1880:                     loc_oBusca.Show()
1881:                 ENDIF
1882: 
1883:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
1884:                     SELECT cursor_4c_CliBusca2
1885:                     IF !EOF()
1886:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
1887:                             ALLTRIM(cursor_4c_CliBusca2.IClis)
1888:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1889:                             ALLTRIM(cursor_4c_CliBusca2.Rclis)
1890:                     ENDIF
1891:                 ELSE
1892:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1893:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1894:                 ENDIF
1895: 
1896:                 loc_oBusca.Release()
1897:             ENDIF
1898: 
1899:         CATCH TO loc_oErro

*-- Linhas 1933 a 1956:
1933:         ENDIF
1934: 
1935:         TRY
1936:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
1937:                        " WHERE CMoes = " + EscaparSQL(loc_cMoeda)
1938: 
1939:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
1940:                !EOF("cursor_4c_MoeBusca")
1941:                 SELECT cursor_4c_MoeBusca
1942:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1943:                     ALLTRIM(cursor_4c_MoeBusca.CMoes)
1944:                 loc_lResultado = .T.
1945:             ELSE
1946:                 IF USED("cursor_4c_MoeBusca")
1947:                     USE IN cursor_4c_MoeBusca
1948:                 ENDIF
1949:                 THIS.AbrirBuscaMoedaMtz()
1950:             ENDIF
1951: 
1952:         CATCH TO loc_oErro
1953:             MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
1954:         ENDTRY
1955: 
1956:         IF USED("cursor_4c_MoeBusca")

*-- Linhas 1979 a 1997:
1979:                 ENDIF
1980: 
1981:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
1982:                     SELECT cursor_4c_MoeBusca2
1983:                     IF !EOF()
1984:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1985:                             ALLTRIM(cursor_4c_MoeBusca2.CMoes)
1986:                     ENDIF
1987:                 ELSE
1988:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
1989:                 ENDIF
1990: 
1991:                 loc_oBusca.Release()
1992:             ENDIF
1993: 
1994:         CATCH TO loc_oErro
1995:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
1996:         ENDTRY
1997: 

*-- Linhas 2097 a 2224:
2097:     *-- =========================================================================
2098: 
2099:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2100:         LOCAL loc_cChave
2101: 
2102:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2103:             RETURN
2104:         ENDIF
2105: 
2106:         SELECT cursor_4c_MtI
2107:         loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))
2108: 
2109:         DO CASE
2110:         CASE par_nColIndex >= 3 AND par_nColIndex <= 14
2111:             IF !EMPTY(loc_cChave)
2112:                 THIS.AtualizaTotal(loc_cChave)
2113:             ENDIF
2114: 
2115:         CASE par_nColIndex = 1
2116:             THIS.ValidarGrupoLinhaGrid()
2117: 
2118:         CASE par_nColIndex = 2
2119:             THIS.ValidarContaLinhaGrid()
2120: 
2121:         ENDCASE
2122:     ENDPROC
2123: 
2124:     *-- =========================================================================
2125:     *-- VALIDAR GRUPO LINHA GRID - Valida SigCdGcr.Codigos na coluna Grupos
2126:     *-- Original: Column1.Text1.Valid (fAcessoContab)
2127:     *-- =========================================================================
2128: 
2129:     PROCEDURE ValidarGrupoLinhaGrid()
2130:         LOCAL loc_cGrupo, loc_cSQL
2131: 
2132:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2133:             RETURN
2134:         ENDIF
2135: 
2136:         SELECT cursor_4c_MtI
2137:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2138: 
2139:         IF EMPTY(loc_cGrupo)
2140:             RETURN
2141:         ENDIF
2142: 
2143:         TRY
2144:             loc_cSQL = "SELECT TOP 1 Codigos, Classes FROM SigCdGcr" + ;
2145:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2146: 
2147:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcGrid") <= 0 OR ;
2148:                EOF("cursor_4c_GcGrid")
2149:                 MsgErro("Acesso Negado!!! Grupo n" + CHR(227) + "o encontrado.", "")
2150:                 SELECT cursor_4c_MtI
2151:                 REPLACE Grupos WITH "" IN cursor_4c_MtI
2152:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2153:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2154:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
2155:                 ENDIF
2156:             ENDIF
2157: 
2158:         CATCH TO loc_oErro
2159:             MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoLinhaGrid")
2160:         ENDTRY
2161: 
2162:         IF USED("cursor_4c_GcGrid")
2163:             USE IN cursor_4c_GcGrid
2164:         ENDIF
2165:     ENDPROC
2166: 
2167:     *-- =========================================================================
2168:     *-- VALIDAR CONTA LINHA GRID - Valida SigCdCli.IClis na coluna Contas
2169:     *-- Original: Column2.Text1.Valid (fAcessoContas)
2170:     *-- =========================================================================
2171: 
2172:     PROCEDURE ValidarContaLinhaGrid()
2173:         LOCAL loc_cConta, loc_cGrupo, loc_cSQL
2174: 
2175:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2176:             RETURN
2177:         ENDIF
2178: 
2179:         SELECT cursor_4c_MtI
2180:         loc_cConta = ALLTRIM(NVL(cursor_4c_MtI.Contas, ""))
2181:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2182: 
2183:         IF EMPTY(loc_cConta)
2184:             RETURN
2185:         ENDIF
2186: 
2187:         TRY
2188:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Inativa FROM SigCdCli" + ;
2189:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
2190:             IF !EMPTY(loc_cGrupo)
2191:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
2192:             ENDIF
2193: 
2194:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrid") > 0 AND ;
2195:                !EOF("cursor_4c_CliGrid")
2196:                 SELECT cursor_4c_CliGrid
2197:                 IF NVL(cursor_4c_CliGrid.Inativa, 0) = 1
2198:                     MsgErro("Acesso Negado!!! Conta Inativa.", "")
2199:                     SELECT cursor_4c_MtI
2200:                     REPLACE Contas WITH "" IN cursor_4c_MtI
2201:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2202:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2203:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2204:                     ENDIF
2205:                 ENDIF
2206:             ELSE
2207:                 MsgErro("Acesso Negado!!! Conta n" + CHR(227) + "o encontrada.", "")
2208:                 SELECT cursor_4c_MtI
2209:                 REPLACE Contas WITH "" IN cursor_4c_MtI
2210:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2211:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2212:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2213:                 ENDIF
2214:             ENDIF
2215: 
2216:         CATCH TO loc_oErro
2217:             MsgErro(loc_oErro.Message, "Formmtz.ValidarContaLinhaGrid")
2218:         ENDTRY
2219: 
2220:         IF USED("cursor_4c_CliGrid")
2221:             USE IN cursor_4c_CliGrid
2222:         ENDIF
2223:     ENDPROC
2224: 

*-- Linhas 2267 a 2290:
2267: 
2268:     PROCEDURE Destroy()
2269:         LOCAL loc_oErro
2270: 
2271:         TRY
2272:             IF USED("cursor_4c_Dados")
2273:                 USE IN cursor_4c_Dados
2274:             ENDIF
2275:             IF USED("cursor_4c_MtI")
2276:                 USE IN cursor_4c_MtI
2277:             ENDIF
2278: 
2279:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2280:                 THIS.this_oBusinessObject = .NULL.
2281:             ENDIF
2282: 
2283:         CATCH TO loc_oErro
2284:             MsgErro(loc_oErro.Message, "Formmtz.Destroy")
2285:         ENDTRY
2286: 
2287:         DODEFAULT()
2288:     ENDPROC
2289: 
2290: ENDDEFINE


### BO (C:\4c\projeto\app\classes\mtzBO.prg):
*******************************************************************************
* mtzBO.prg - Business Object: Matriz de Saldos por Centro de Custo
* Tabela principal : SigCdMtz  (cabecalho da matriz)
* Tabela detalhe   : SigCdMtI  (linhas de centro de custo / meses)
* Herda de         : BusinessBase
*******************************************************************************

DEFINE CLASS mtzBO AS BusinessBase

    *-- =========================================================================
    *-- PROPRIEDADES: SigCdMtz (cabecalho)
    *-- =========================================================================

    *-- Chave usuario (char 3 - gerada por GerarProximoCodigo na insercao)
    this_cCodigo    = ""

    *-- Ano de competencia da matriz (char 4, ex: "2026")
    this_cAno       = ""

    *-- Grupo de conta corrente (SigCdGcr.Codigos)
    this_cSGrupos   = ""

    *-- Conta de centro de custo (SigCdCli.IClis)
    this_cSContas   = ""

    *-- Flag inativa (0=ativa / 1=inativa -> convertido para .T./.F.)
    this_lInativas  = .F.

    *-- Moeda da matriz (SigCdMoe.CMoes, char 4)
    this_cMoeda     = ""

    *-- Auditoria de inclusao
    this_tDtIncs    = {}
    this_cUsuIncs   = ""

    *-- Auditoria de alteracao
    this_tDtAlts    = {}
    this_cUsuAlts   = ""

    *-- =========================================================================
    *-- PROPRIEDADES DERIVADAS / AUXILIARES (nao armazenadas diretamente)
    *-- =========================================================================

    *-- Descricao da conta - derivada do JOIN: SigCdCli.rclis AS sDContas
    *-- Nao existe como coluna em SigCdMtz; carregada via SELECT com JOIN
    this_cSDesconta = ""

    *-- Valor total acumulado dos meses de SigCdMtI (calculado, exibicao)
    this_nValorTotal = 0

    *-- =========================================================================
    *-- INIT
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMtz"
            THIS.this_cCampoChave = "Codigo"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- OBTER CHAVE PRIMARIA (requerido pelo sistema de auditoria)
    *-- =========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *-- =========================================================================
    *-- NOVO REGISTRO - Gera codigo unico para insercao
    *-- =========================================================================

    FUNCTION NovoRegistro()
        LOCAL loc_lResultado, loc_nProximo
        loc_lResultado = DODEFAULT()

        IF loc_lResultado
            TRY
                loc_nProximo = THIS.GerarProximoCodigo()
                IF loc_nProximo > 0
                    THIS.this_cCodigo = ALLTRIM(STR(loc_nProximo, 3))
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel gerar c" + CHR(243) + "digo para nova matriz.", "mtzBO.NovoRegistro")
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "mtzBO.NovoRegistro")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- GERAR PROXIMO CODIGO (PROTECTED) - MAX(Codigo)+1 em SigCdMtz
    *-- =========================================================================

    PROTECTED FUNCTION GerarProximoCodigo()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(Codigo) AS INT)), 0) + 1 AS ProximoCodigo" + ;
                       " FROM SigCdMtz" + ;
                       " WHERE ISNUMERIC(LTRIM(Codigo)) = 1"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ProxCod")
                TABLEREVERT(.T., "cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = NVL(ProximoCodigo, 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.GerarProximoCodigo")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *-- =========================================================================
    *-- BUSCAR - SELECT para grid Page1 (lista de matrizes)
    *-- =========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " ORDER BY a.Ano, a.sGrupos, a.sContas"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                           " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                           " a.DtIncs, a.UsuIncs" + ;
                           " FROM SigCdMtz a" + ;
                           " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY a.Ano, a.sGrupos, a.sContas"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro SigCdMtz no BO
    *-- =========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Codigo, a.Ano, a.sGrupos, a.sContas," + ;
                       " b.rclis AS sDContas, a.Moeda, a.Inativas," + ;
                       " a.DtIncs, a.UsuIncs, a.DtAlts, a.UsuAlts, a.CidChaves" + ;
                       " FROM SigCdMtz a" + ;
                       " LEFT JOIN SigCdCli b ON a.sContas = b.IClis" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DO CURSOR - Mapeia cursor para propriedades do BO
    *-- =========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Codigo, "C")
            THIS.this_cAno       = TratarNulo(Ano, "C")
            THIS.this_cSGrupos   = TratarNulo(sGrupos, "C")
            THIS.this_cSContas   = TratarNulo(sContas, "C")
            THIS.this_cSDesconta = TratarNulo(sDContas, "C")
            THIS.this_cMoeda     = TratarNulo(Moeda, "C")
            IF VARTYPE(Inativas) = "L"
                THIS.this_lInativas = Inativas
            ELSE
                THIS.this_lInativas = (NVL(Inativas, 0) = 1)
            ENDIF
            THIS.this_tDtIncs    = TratarNulo(DtIncs, "T")
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs, "C")
            THIS.this_tDtAlts    = TratarNulo(DtAlts, "T")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CARREGAR DETALHE - Carrega SigCdMtI para cursor_4c_MtI (grid Page2)
    *-- =========================================================================

    FUNCTION CarregarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_cSQL = "SELECT a.Codigo, a.CidChaves, a.Grupos, a.Contas," + ;
                       " a.Val_Jan, a.Val_Fev, a.Val_Mar, a.Val_Abr," + ;
                       " a.Val_Mai, a.Val_Jun, a.Val_Jul, a.Val_Ago," + ;
                       " a.Val_Set, a.Val_Out, a.Val_Nov, a.Val_Dez," + ;
                       " a.Acm_Jan, a.Acm_Fev, a.Acm_Mar, a.Acm_Abr," + ;
                       " a.Acm_Mai, a.Acm_Jun, a.Acm_Jul, a.Acm_Ago," + ;
                       " a.Acm_Set, a.Acm_Out, a.Acm_Nov, a.Acm_Dez," + ;
                       " (a.Val_Jan+a.Val_Fev+a.Val_Mar+a.Val_Abr+a.Val_Mai+a.Val_Jun+" + ;
                       "  a.Val_Jul+a.Val_Ago+a.Val_Set+a.Val_Out+a.Val_Nov+a.Val_Dez)" + ;
                       " AS Total, a.ChkValida" + ;
                       " FROM SigCdMtI a" + ;
                       " WHERE a.Codigo = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_MtI")
                TABLEREVERT(.T., "cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtI")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.CarregarDetalhe")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CarregarDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- CRIAR CURSOR DETALHE VAZIO - Cria cursor_4c_MtI vazio para insercao
    *-- =========================================================================

    FUNCTION CriarCursorDetalheVazio(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_MtI ( ;
                Codigo    C(3), ;
                CidChaves C(36), ;
                Grupos    C(10), ;
                Contas    C(10), ;
                Val_Jan   N(14,2), ;
                Val_Fev   N(14,2), ;
                Val_Mar   N(14,2), ;
                Val_Abr   N(14,2), ;
                Val_Mai   N(14,2), ;
                Val_Jun   N(14,2), ;
                Val_Jul   N(14,2), ;
                Val_Ago   N(14,2), ;
                Val_Set   N(14,2), ;
                Val_Out   N(14,2), ;
                Val_Nov   N(14,2), ;
                Val_Dez   N(14,2), ;
                Acm_Jan   N(14,2), ;
                Acm_Fev   N(14,2), ;
                Acm_Mar   N(14,2), ;
                Acm_Abr   N(14,2), ;
                Acm_Mai   N(14,2), ;
                Acm_Jun   N(14,2), ;
                Acm_Jul   N(14,2), ;
                Acm_Ago   N(14,2), ;
                Acm_Set   N(14,2), ;
                Acm_Out   N(14,2), ;
                Acm_Nov   N(14,2), ;
                Acm_Dez   N(14,2), ;
                Total     N(18,2), ;
                ChkValida L ;
            )
            SET NULL OFF

            *-- Adiciona linha em branco inicial para o usuario comecar a inserir
            INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                Total, ChkValida) ;
                VALUES (par_cCodigo, "", "", "", ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                0, .F.)

            GO TOP IN cursor_4c_MtI
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.CriarCursorDetalheVazio")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR LINHA DETALHE - Adiciona linha em branco no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION InserirLinhaDetalhe(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                *-- Verifica se ja existe uma linha vazia (sem Grupos e Contas)
                SELECT cursor_4c_MtI
                GO TOP
                LOCATE FOR EMPTY(ALLTRIM(Grupos)) AND EMPTY(ALLTRIM(Contas))
                IF !FOUND()
                    INSERT INTO cursor_4c_MtI (Codigo, CidChaves, Grupos, Contas, ;
                        Val_Jan, Val_Fev, Val_Mar, Val_Abr, Val_Mai, Val_Jun, ;
                        Val_Jul, Val_Ago, Val_Set, Val_Out, Val_Nov, Val_Dez, ;
                        Acm_Jan, Acm_Fev, Acm_Mar, Acm_Abr, Acm_Mai, Acm_Jun, ;
                        Acm_Jul, Acm_Ago, Acm_Set, Acm_Out, Acm_Nov, Acm_Dez, ;
                        Total, ChkValida) ;
                        VALUES (par_cCodigo, "", "", "", ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                        0, .F.)
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.InserirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- EXCLUIR LINHA DETALHE - Remove linha atual do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ExcluirLinhaDetalhe()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM IN cursor_4c_MtI
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExcluirLinhaDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- ATUALIZAR TOTAL - Calcula Total na linha do cursor_4c_MtI
    *-- =========================================================================

    FUNCTION AtualizarTotal(par_cChave)
        LOCAL loc_nTotal, loc_nTotalGeral, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                IF !EMPTY(ALLTRIM(par_cChave))
                    SELECT cursor_4c_MtI
                    LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    IF FOUND()
                        loc_nTotal = NVL(Val_Jan, 0) + NVL(Val_Fev, 0) + NVL(Val_Mar, 0) + ;
                                     NVL(Val_Abr, 0) + NVL(Val_Mai, 0) + NVL(Val_Jun, 0) + ;
                                     NVL(Val_Jul, 0) + NVL(Val_Ago, 0) + NVL(Val_Set, 0) + ;
                                     NVL(Val_Out, 0) + NVL(Val_Nov, 0) + NVL(Val_Dez, 0)
                        REPLACE Total WITH loc_nTotal IN cursor_4c_MtI ;
                            FOR ALLTRIM(CidChaves) == ALLTRIM(par_cChave)
                    ENDIF
                ENDIF

                *-- Calcula total geral de todas as linhas
                SELECT SUM(NVL(Total, 0)) AS TotalGeral FROM cursor_4c_MtI INTO CURSOR cursor_4c_TmpTot READWRITE
                SELECT cursor_4c_TmpTot
                THIS.this_nValorTotal = NVL(TotalGeral, 0)
                USE IN cursor_4c_TmpTot

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.AtualizarTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VALIDAR DUPLICATAS - Verifica Grupos+Contas duplicados no cursor_4c_MtI
    *-- =========================================================================

    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_lResultado
        loc_lValido = .T.
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_MtI")
                SELECT COUNT(*) AS Qtds, Grupos, Contas ;
                    FROM cursor_4c_MtI ;
                    WHERE !EMPTY(ALLTRIM(Contas)) AND !EMPTY(ALLTRIM(Grupos)) ;
                    GROUP BY Grupos, Contas ;
                    HAVING COUNT(*) >= 2 ;
                    INTO CURSOR cursor_4c_Dup READWRITE

                SELECT cursor_4c_Dup
                IF RECCOUNT("cursor_4c_Dup") > 0
                    MsgErro("H" + CHR(225) + " registros duplicados na grade de Contas, Verifique.", "Aviso")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_lResultado = loc_lValido
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ValidarDuplicatas")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- INSERIR (PROTECTED) - INSERT SigCdMtz + SigCdMtI via cursor_4c_MtI
    *-- =========================================================================

    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMtz" + ;
                       " (Codigo, Ano, sGrupos, sContas, Moeda, Inativas," + ;
                       "  DtIncs, UsuIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cAno) + "," + ;
                       EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       EscaparSQL(THIS.this_cSContas) + "," + ;
                       EscaparSQL(THIS.this_cMoeda) + "," + ;
                       IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .T.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZAR (PROTECTED) - UPDATE SigCdMtz + re-inserir SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtz SET" + ;
                       " Ano = " + EscaparSQL(THIS.this_cAno) + "," + ;
                       " sGrupos = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                       " sContas = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                       " Moeda = " + EscaparSQL(THIS.this_cMoeda) + "," + ;
                       " Inativas = " + IIF(THIS.this_lInativas, "1", "0") + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lResultado = THIS.SalvarDetalhe(THIS.this_cCodigo, .F.)
                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- EXECUTAR EXCLUSAO (PROTECTED) - DELETE SigCdMtz + SigCdMtI
    *-- =========================================================================

    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- DELETE SigCdMtI (detalhe) primeiro por FK
            loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdMtz WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtz)")
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(), "mtzBO.ExecutarExclusao (SigCdMtI)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- SALVAR DETALHE (PROTECTED) - INSERT SigCdMtI a partir de cursor_4c_MtI
    *-- =========================================================================

    PROTECTED FUNCTION SalvarDetalhe(par_cCodigo, par_lSomenteInserir)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupos, loc_cContas, loc_cChave
        LOCAL loc_nJan, loc_nFev, loc_nMar, loc_nAbr, loc_nMai, loc_nJun
        LOCAL loc_nJul, loc_nAgo, loc_nSet, loc_nOut, loc_nNov, loc_nDez
        loc_lResultado = .F.

        TRY
            IF !par_lSomenteInserir
                loc_cSQL = "DELETE FROM SigCdMtI WHERE Codigo = " + EscaparSQL(par_cCodigo)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            loc_lResultado = .T.

            IF USED("cursor_4c_MtI")
                SELECT cursor_4c_MtI
                GO TOP
                SCAN FOR !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas))
                    loc_cGrupos = ALLTRIM(Grupos)
                    loc_cContas = ALLTRIM(Contas)
                    loc_cChave  = ALLTRIM(CidChaves)
                    loc_nJan    = NVL(Val_Jan, 0)
                    loc_nFev    = NVL(Val_Fev, 0)
                    loc_nMar    = NVL(Val_Mar, 0)
                    loc_nAbr    = NVL(Val_Abr, 0)
                    loc_nMai    = NVL(Val_Mai, 0)
                    loc_nJun    = NVL(Val_Jun, 0)
                    loc_nJul    = NVL(Val_Jul, 0)
                    loc_nAgo    = NVL(Val_Ago, 0)
                    loc_nSet    = NVL(Val_Set, 0)
                    loc_nOut    = NVL(Val_Out, 0)
                    loc_nNov    = NVL(Val_Nov, 0)
                    loc_nDez    = NVL(Val_Dez, 0)

                    IF EMPTY(loc_cChave)
                        loc_cChave = ALLTRIM(SYS(2015)) + ALLTRIM(STR(SECONDS(), 10, 0))
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdMtI" + ;
                               " (Codigo, CidChaves, Grupos, Contas," + ;
                               "  Val_Jan, Val_Fev, Val_Mar, Val_Abr," + ;
                               "  Val_Mai, Val_Jun, Val_Jul, Val_Ago," + ;
                               "  Val_Set, Val_Out, Val_Nov, Val_Dez)" + ;
                               " VALUES (" + ;
                               EscaparSQL(par_cCodigo) + "," + ;
                               EscaparSQL(loc_cChave) + "," + ;
                               EscaparSQL(loc_cGrupos) + "," + ;
                               EscaparSQL(loc_cContas) + "," + ;
                               FormatarNumeroSQL(loc_nJan) + "," + ;
                               FormatarNumeroSQL(loc_nFev) + "," + ;
                               FormatarNumeroSQL(loc_nMar) + "," + ;
                               FormatarNumeroSQL(loc_nAbr) + "," + ;
                               FormatarNumeroSQL(loc_nMai) + "," + ;
                               FormatarNumeroSQL(loc_nJun) + "," + ;
                               FormatarNumeroSQL(loc_nJul) + "," + ;
                               FormatarNumeroSQL(loc_nAgo) + "," + ;
                               FormatarNumeroSQL(loc_nSet) + "," + ;
                               FormatarNumeroSQL(loc_nOut) + "," + ;
                               FormatarNumeroSQL(loc_nNov) + "," + ;
                               FormatarNumeroSQL(loc_nDez) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro(CapturarErroSQL(), "mtzBO.SalvarDetalhe (linha " + loc_cGrupos + "/" + loc_cContas + ")")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.SalvarDetalhe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *-- =========================================================================
    *-- VERIFICAR DUPLICADO - Verifica se Ano+Grupo+Conta ja existe em SigCdMtz
    *-- =========================================================================

    FUNCTION VerificarDuplicado(par_cAno, par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdMtz" + ;
                       " WHERE Ano = " + EscaparSQL(par_cAno) + ;
                       " AND sGrupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND sContas = " + EscaparSQL(par_cConta)

            IF !EMPTY(ALLTRIM(THIS.this_cCodigo)) AND !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                           " AND Codigo <> " + EscaparSQL(THIS.this_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMtz")
                TABLEREVERT(.T., "cursor_4c_ChkMtz")
                USE IN cursor_4c_ChkMtz
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMtz")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkMtz") > 0
                SELECT cursor_4c_ChkMtz
                loc_lExiste = (NVL(Qtd, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "mtzBO.VerificarDuplicado")
        ENDTRY

        IF USED("cursor_4c_ChkMtz")
            USE IN cursor_4c_ChkMtz
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *-- =========================================================================
    *-- DESTRUIR - Fecha cursores abertos pelo BO
    *-- =========================================================================

    PROCEDURE Destroy()
        IF USED("cursor_4c_MtI")
            USE IN cursor_4c_MtI
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

