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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS SQL (2298 linhas total):

*-- Linhas 342 a 381:
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345: 
346:         *--------------------------------------------------------------------------
347:         *-- Grid lista de matrizes - cursor_4c_Dados (7 colunas)
348:         *--------------------------------------------------------------------------
349:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
350:         loc_oPagina.grd_4c_Lista.RecordSource = ""
351:         loc_oPagina.grd_4c_Lista.ColumnCount  = 7
352: 
353:         WITH loc_oPagina.grd_4c_Lista
354:             .Top                = 88
355:             .Left               = 5
356:             .Width              = 905
357:             .Height             = 480
358:             .FontName           = "Verdana"
359:             .FontSize           = 8
360:             .ForeColor          = RGB(90, 90, 90)
361:             .BackColor          = RGB(255, 255, 255)
362:             .GridLineColor      = RGB(238, 238, 238)
363:             .HighlightBackColor = RGB(255, 255, 255)
364:             .HighlightForeColor = RGB(15, 41, 104)
365:             .HighlightStyle     = 2
366:             .DeleteMark         = .F.
367:             .RecordMark         = .F.
368:             .RowHeight          = 16
369:             .ScrollBars         = 2
370:             .GridLines          = 3
371:             .ReadOnly           = .T.
372:             .Visible            = .T.
373:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
374:             .Column1.Width           = 50
375:             .Column2.Header1.Caption = "Ano"
376:             .Column2.Width           = 50
377:             .Column3.Header1.Caption = "Grupo"
378:             .Column3.Width           = 80
379:             .Column4.Header1.Caption = "Conta"
380:             .Column4.Width           = 80
381:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 736 a 754:
736:             .FontSize    = 8
737:             .Visible     = .T.
738:             .RecordMark   = .F.
739:             .DeleteMark   = .F.
740:         ENDWITH
741: 
742:         loc_oGrid = loc_oPagina.grd_4c_Dados
743: 
744:         *-- Coluna 1 - Grupos
745:         WITH loc_oGrid.Column1
746:             .Header1.Caption = "Grupo"
747:             .Width           = 65
748:         ENDWITH
749: 
750:         *-- Coluna 2 - Contas
751:         WITH loc_oGrid.Column2
752:             .Header1.Caption = "Conta"
753:             .Width           = 65
754:         ENDWITH

*-- Linhas 1105 a 1147:
1105: 
1106:         THIS.TornarControlesVisiveis(loc_oPagina)
1107:     ENDPROC
1108: 
1109:     *-- =========================================================================
1110:     *-- CARREGAR LISTA - Carrega cursor_4c_Dados no Grid da Page1
1111:     *-- =========================================================================
1112: 
1113:     PROCEDURE CarregarLista()
1114:         LOCAL loc_lResultado, loc_oGrid
1115:         loc_lResultado = .F.
1116: 
1117:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1118:             RETURN .T.
1119:         ENDIF
1120: 
1121:         TRY
1122:             IF THIS.this_oBusinessObject.Buscar("")
1123:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1124:                 loc_oGrid.ColumnCount = 7
1125:                 loc_oGrid.RecordSource            = "cursor_4c_Dados"
1126:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1127:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1128:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1129:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1130:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1131:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1132:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1133:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1134:                 loc_oGrid.Column2.Header1.Caption = "Ano"
1135:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1136:                 loc_oGrid.Column4.Header1.Caption = "Conta"
1137:                 loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1138:                 loc_oGrid.Column6.Header1.Caption = "Moeda"
1139:                 loc_oGrid.Column7.Header1.Caption = "Inativa"
1140:                 THIS.FormatarGridLista(loc_oGrid)
1141:                 loc_lResultado = .T.
1142:             ENDIF
1143: 
1144:         CATCH TO loc_oErro
1145:             MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
1146:             loc_lResultado = .F.
1147:         ENDTRY

*-- Linhas 1378 a 1405:
1378: 
1379:     PROCEDURE BtnVisualizarClick()
1380:         LOCAL loc_lResultado, loc_cCodigo
1381:         loc_lResultado = .F.
1382: 
1383:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1384:             MsgAviso("Nenhum registro selecionado.")
1385:             RETURN .F.
1386:         ENDIF
1387: 
1388:         TRY
1389:             SELECT cursor_4c_Dados
1390:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1391: 
1392:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1393:                 THIS.this_cModoAtual = "VISUALIZAR"
1394:                 THIS.BOParaForm()
1395:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1396:                 THIS.AlternarGradeDetalhe()
1397:                 THIS.HabilitarCampos(.F.)
1398:                 THIS.AjustarBotoesPorModo()
1399:                 THIS.AlternarPaginaDados()
1400:                 loc_lResultado = .T.
1401:             ENDIF
1402: 
1403:         CATCH TO loc_oErro
1404:             MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
1405:         ENDTRY

*-- Linhas 1413 a 1440:
1413: 
1414:     PROCEDURE BtnAlterarClick()
1415:         LOCAL loc_lResultado, loc_cCodigo
1416:         loc_lResultado = .F.
1417: 
1418:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1419:             MsgAviso("Nenhum registro selecionado.")
1420:             RETURN .F.
1421:         ENDIF
1422: 
1423:         TRY
1424:             SELECT cursor_4c_Dados
1425:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1426: 
1427:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1428:                 THIS.this_oBusinessObject.EditarRegistro()
1429:                 THIS.this_cModoAtual = "ALTERAR"
1430:                 THIS.BOParaForm()
1431:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1432:                 THIS.AlternarGradeDetalhe()
1433:                 THIS.HabilitarCampos(.T.)
1434:                 THIS.AjustarBotoesPorModo()
1435:                 THIS.AlternarPaginaDados()
1436:                 loc_lResultado = .T.
1437:             ENDIF
1438: 
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")

*-- Linhas 1449 a 1475:
1449: 
1450:     PROCEDURE BtnExcluirClick()
1451:         LOCAL loc_lResultado, loc_cCodigo
1452:         loc_lResultado = .F.
1453: 
1454:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1455:             MsgAviso("Nenhum registro selecionado.")
1456:             RETURN .F.
1457:         ENDIF
1458: 
1459:         SELECT cursor_4c_Dados
1460:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1461: 
1462:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
1463:             RETURN .F.
1464:         ENDIF
1465: 
1466:         TRY
1467:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1468:                 IF THIS.this_oBusinessObject.Excluir()
1469:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
1470:                     THIS.CarregarLista()
1471:                     loc_lResultado = .T.
1472:                 ENDIF
1473:             ENDIF
1474: 
1475:         CATCH TO loc_oErro

*-- Linhas 1498 a 1531:
1498:                 loc_oBusca.Show()
1499: 
1500:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
1501:                     SELECT cursor_4c_BuscaMtz
1502:                     IF !EOF()
1503:                         LOCAL loc_oGrid
1504:                         THIS.this_oBusinessObject.Buscar( ;
1505:                             "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
1506:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1507:                         IF VARTYPE(loc_oGrid) = "O"
1508:                             loc_oGrid.ColumnCount = 7
1509:                             loc_oGrid.RecordSource            = "cursor_4c_Dados"
1510:                             loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1511:                             loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1512:                             loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1513:                             loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1514:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1515:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1516:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1517:                             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1518:                             loc_oGrid.Column2.Header1.Caption = "Ano"
1519:                             loc_oGrid.Column3.Header1.Caption = "Grupo"
1520:                             loc_oGrid.Column4.Header1.Caption = "Conta"
1521:                             loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1522:                             loc_oGrid.Column6.Header1.Caption = "Moeda"
1523:                             loc_oGrid.Column7.Header1.Caption = "Inativa"
1524:                             THIS.FormatarGridLista(loc_oGrid)
1525:                         ENDIF
1526:                     ENDIF
1527:                 ENDIF
1528: 
1529:                 loc_oBusca.Release()
1530:                 loc_lResultado = .T.
1531:             ENDIF

*-- Linhas 1619 a 1681:
1619:     PROTECTED PROCEDURE AlternarPaginaDados()
1620:         THIS.pgf_4c_Paginas.ActivePage = 2
1621:     ENDPROC
1622: 
1623:     *-- =========================================================================
1624:     *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
1625:     *-- (sera completado na Fase 4 quando o grid for criado)
1626:     *-- =========================================================================
1627: 
1628:     PROTECTED PROCEDURE AlternarGradeDetalhe()
1629:         LOCAL loc_oGrid, loc_lResultado
1630:         loc_lResultado = .F.
1631: 
1632:         TRY
1633:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1634:             IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
1635:                 loc_oGrid.ColumnCount = 13
1636:                 loc_oGrid.RecordSource = "cursor_4c_MtI"
1637: 
1638:                 *-- Wires ControlSources apos RecordSource estar definido
1639:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
1640:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
1641:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
1642:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
1643:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
1644:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
1645:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
1646:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
1647:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
1648:                 loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
1649:                 loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
1650:                 loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
1651:                 loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
1652:                 loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
1653:                 loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
1654:                 loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
1655:                 loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
1656:                 loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
1657:                 loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
1658:                 loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
1659:                 loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
1660:                 loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
1661:                 loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
1662:                 loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
1663:                 loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
1664:                 loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
1665:                 loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
1666:                 loc_oGrid.Column28.chk_4c_Valida.ControlSource = "cursor_4c_MtI.ChkValida"
1667: 
1668:                 loc_oGrid.FontName = "Tahoma"
1669:                 loc_oGrid.FontSize = 8
1670:                 loc_oGrid.Refresh()
1671:                 loc_lResultado = .T.
1672:             ENDIF
1673:         CATCH TO loc_oErro
1674:             MsgErro(loc_oErro.Message, "Formmtz.AlternarGradeDetalhe")
1675:         ENDTRY
1676: 
1677:         RETURN loc_lResultado
1678:     ENDPROC
1679: 
1680:     *-- =========================================================================
1681:     *-- VALIDAR ANO MTZ - Valida ano de competencia (range 2000-2999)

*-- Linhas 1719 a 1742:
1719:         ENDIF
1720: 
1721:         TRY
1722:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
1723:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1724: 
1725:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
1726:                !EOF("cursor_4c_GcBusca")
1727:                 SELECT cursor_4c_GcBusca
1728:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1729:                     ALLTRIM(cursor_4c_GcBusca.Classes)
1730: 
1731:                 IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
1732:                     MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
1733:                             CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
1734:                             "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
1735:                             " informada!", "Aten" + CHR(231) + CHR(227) + "o")
1736:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1737:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1738:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
1739:                 ELSE
1740:                     loc_lResultado = .T.
1741:                 ENDIF
1742:             ELSE

*-- Linhas 1776 a 1794:
1776:                 ENDIF
1777: 
1778:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
1779:                     SELECT cursor_4c_GcBusca2
1780:                     IF !EOF()
1781:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
1782:                             ALLTRIM(cursor_4c_GcBusca2.Codigos)
1783:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1784:                             ALLTRIM(cursor_4c_GcBusca2.Classes)
1785:                     ENDIF
1786:                 ELSE
1787:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1788:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1789:                 ENDIF
1790: 
1791:                 loc_oBusca.Release()
1792:             ENDIF
1793: 
1794:         CATCH TO loc_oErro

*-- Linhas 1828 a 1854:
1828:         ENDIF
1829: 
1830:         TRY
1831:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
1832:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
1833:             IF !EMPTY(loc_cGrupo)
1834:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1835:             ENDIF
1836: 
1837:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
1838:                !EOF("cursor_4c_CliBusca")
1839:                 SELECT cursor_4c_CliBusca
1840:                 IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
1841:                     MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
1842:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1843:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1844:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
1845:                 ELSE
1846:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1847:                         ALLTRIM(cursor_4c_CliBusca.Rclis)
1848:                     loc_lResultado = .T.
1849:                 ENDIF
1850:             ELSE
1851:                 IF USED("cursor_4c_CliBusca")
1852:                     USE IN cursor_4c_CliBusca
1853:                 ENDIF
1854:                 THIS.AbrirBuscaContaMtz()

*-- Linhas 1874 a 1908:
1874:             loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1875:             loc_cFiltro = ""
1876:             IF !EMPTY(loc_cGrupo)
1877:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1878:             ENDIF
1879: 
1880:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1881:                 "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
1882:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
1883:                 "Conta Corrente", .F., .T., loc_cFiltro)
1884: 
1885:             IF VARTYPE(loc_oBusca) = "O"
1886:                 IF !loc_oBusca.this_lAchouRegistro
1887:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1888:                     loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
1889:                     loc_oBusca.Show()
1890:                 ENDIF
1891: 
1892:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
1893:                     SELECT cursor_4c_CliBusca2
1894:                     IF !EOF()
1895:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
1896:                             ALLTRIM(cursor_4c_CliBusca2.IClis)
1897:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1898:                             ALLTRIM(cursor_4c_CliBusca2.Rclis)
1899:                     ENDIF
1900:                 ELSE
1901:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1902:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1903:                 ENDIF
1904: 
1905:                 loc_oBusca.Release()
1906:             ENDIF
1907: 
1908:         CATCH TO loc_oErro

*-- Linhas 1941 a 1964:
1941:         ENDIF
1942: 
1943:         TRY
1944:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
1945:                        " WHERE CMoes = " + EscaparSQL(loc_cMoeda)
1946: 
1947:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
1948:                !EOF("cursor_4c_MoeBusca")
1949:                 SELECT cursor_4c_MoeBusca
1950:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1951:                     ALLTRIM(cursor_4c_MoeBusca.CMoes)
1952:                 loc_lResultado = .T.
1953:             ELSE
1954:                 IF USED("cursor_4c_MoeBusca")
1955:                     USE IN cursor_4c_MoeBusca
1956:                 ENDIF
1957:                 THIS.AbrirBuscaMoedaMtz()
1958:             ENDIF
1959: 
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
1962:         ENDTRY
1963: 
1964:         IF USED("cursor_4c_MoeBusca")

*-- Linhas 1987 a 2005:
1987:                 ENDIF
1988: 
1989:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
1990:                     SELECT cursor_4c_MoeBusca2
1991:                     IF !EOF()
1992:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1993:                             ALLTRIM(cursor_4c_MoeBusca2.CMoes)
1994:                     ENDIF
1995:                 ELSE
1996:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
1997:                 ENDIF
1998: 
1999:                 loc_oBusca.Release()
2000:             ENDIF
2001: 
2002:         CATCH TO loc_oErro
2003:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
2004:         ENDTRY
2005: 

*-- Linhas 2105 a 2232:
2105:     *-- =========================================================================
2106: 
2107:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2108:         LOCAL loc_cChave
2109: 
2110:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2111:             RETURN
2112:         ENDIF
2113: 
2114:         SELECT cursor_4c_MtI
2115:         loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))
2116: 
2117:         DO CASE
2118:         CASE par_nColIndex >= 3 AND par_nColIndex <= 14
2119:             IF !EMPTY(loc_cChave)
2120:                 THIS.AtualizaTotal(loc_cChave)
2121:             ENDIF
2122: 
2123:         CASE par_nColIndex = 1
2124:             THIS.ValidarGrupoLinhaGrid()
2125: 
2126:         CASE par_nColIndex = 2
2127:             THIS.ValidarContaLinhaGrid()
2128: 
2129:         ENDCASE
2130:     ENDPROC
2131: 
2132:     *-- =========================================================================
2133:     *-- VALIDAR GRUPO LINHA GRID - Valida SigCdGcr.Codigos na coluna Grupos
2134:     *-- Original: Column1.Text1.Valid (fAcessoContab)
2135:     *-- =========================================================================
2136: 
2137:     PROCEDURE ValidarGrupoLinhaGrid()
2138:         LOCAL loc_cGrupo, loc_cSQL
2139: 
2140:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2141:             RETURN
2142:         ENDIF
2143: 
2144:         SELECT cursor_4c_MtI
2145:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2146: 
2147:         IF EMPTY(loc_cGrupo)
2148:             RETURN
2149:         ENDIF
2150: 
2151:         TRY
2152:             loc_cSQL = "SELECT TOP 1 Codigos, Classes FROM SigCdGcr" + ;
2153:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2154: 
2155:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcGrid") <= 0 OR ;
2156:                EOF("cursor_4c_GcGrid")
2157:                 MsgErro("Acesso Negado!!! Grupo n" + CHR(227) + "o encontrado.", "")
2158:                 SELECT cursor_4c_MtI
2159:                 REPLACE Grupos WITH "" IN cursor_4c_MtI
2160:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2161:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2162:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
2163:                 ENDIF
2164:             ENDIF
2165: 
2166:         CATCH TO loc_oErro
2167:             MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoLinhaGrid")
2168:         ENDTRY
2169: 
2170:         IF USED("cursor_4c_GcGrid")
2171:             USE IN cursor_4c_GcGrid
2172:         ENDIF
2173:     ENDPROC
2174: 
2175:     *-- =========================================================================
2176:     *-- VALIDAR CONTA LINHA GRID - Valida SigCdCli.IClis na coluna Contas
2177:     *-- Original: Column2.Text1.Valid (fAcessoContas)
2178:     *-- =========================================================================
2179: 
2180:     PROCEDURE ValidarContaLinhaGrid()
2181:         LOCAL loc_cConta, loc_cGrupo, loc_cSQL
2182: 
2183:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2184:             RETURN
2185:         ENDIF
2186: 
2187:         SELECT cursor_4c_MtI
2188:         loc_cConta = ALLTRIM(NVL(cursor_4c_MtI.Contas, ""))
2189:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2190: 
2191:         IF EMPTY(loc_cConta)
2192:             RETURN
2193:         ENDIF
2194: 
2195:         TRY
2196:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Inativa FROM SigCdCli" + ;
2197:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
2198:             IF !EMPTY(loc_cGrupo)
2199:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
2200:             ENDIF
2201: 
2202:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrid") > 0 AND ;
2203:                !EOF("cursor_4c_CliGrid")
2204:                 SELECT cursor_4c_CliGrid
2205:                 IF NVL(cursor_4c_CliGrid.Inativa, 0) = 1
2206:                     MsgErro("Acesso Negado!!! Conta Inativa.", "")
2207:                     SELECT cursor_4c_MtI
2208:                     REPLACE Contas WITH "" IN cursor_4c_MtI
2209:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2210:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2211:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2212:                     ENDIF
2213:                 ENDIF
2214:             ELSE
2215:                 MsgErro("Acesso Negado!!! Conta n" + CHR(227) + "o encontrada.", "")
2216:                 SELECT cursor_4c_MtI
2217:                 REPLACE Contas WITH "" IN cursor_4c_MtI
2218:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2219:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2221:                 ENDIF
2222:             ENDIF
2223: 
2224:         CATCH TO loc_oErro
2225:             MsgErro(loc_oErro.Message, "Formmtz.ValidarContaLinhaGrid")
2226:         ENDTRY
2227: 
2228:         IF USED("cursor_4c_CliGrid")
2229:             USE IN cursor_4c_CliGrid
2230:         ENDIF
2231:     ENDPROC
2232: 

*-- Linhas 2275 a 2298:
2275: 
2276:     PROCEDURE Destroy()
2277:         LOCAL loc_oErro
2278: 
2279:         TRY
2280:             IF USED("cursor_4c_Dados")
2281:                 USE IN cursor_4c_Dados
2282:             ENDIF
2283:             IF USED("cursor_4c_MtI")
2284:                 USE IN cursor_4c_MtI
2285:             ENDIF
2286: 
2287:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2288:                 THIS.this_oBusinessObject = .NULL.
2289:             ENDIF
2290: 
2291:         CATCH TO loc_oErro
2292:             MsgErro(loc_oErro.Message, "Formmtz.Destroy")
2293:         ENDTRY
2294: 
2295:         DODEFAULT()
2296:     ENDPROC
2297: 
2298: ENDDEFINE


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

