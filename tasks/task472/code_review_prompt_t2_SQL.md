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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmtz.prg) - TRECHOS RELEVANTES PARA PASS SQL (2304 linhas total):

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
375:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
376:             .Column1.Width           = 50
377:             .Column2.Header1.Caption = "Ano"
378:             .Column2.Width           = 50
379:             .Column3.Header1.Caption = "Grupo"
380:             .Column3.Width           = 80
381:             .Column4.Header1.Caption = "Conta"
382:             .Column4.Width           = 80
383:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

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
1135:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1136:                 loc_oGrid.Column2.Header1.Caption = "Ano"
1137:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1138:                 loc_oGrid.Column4.Header1.Caption = "Conta"
1139:                 loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1140:                 loc_oGrid.Column6.Header1.Caption = "Moeda"
1141:                 loc_oGrid.Column7.Header1.Caption = "Valida"
1142:                 THIS.FormatarGridLista(loc_oGrid)
1143:                 loc_lResultado = .T.
1144:             ENDIF
1145: 
1146:         CATCH TO loc_oErro
1147:             MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
1148:             loc_lResultado = .F.
1149:         ENDTRY

*-- Linhas 1380 a 1407:
1380: 
1381:     PROCEDURE BtnVisualizarClick()
1382:         LOCAL loc_lResultado, loc_cCodigo
1383:         loc_lResultado = .F.
1384: 
1385:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1386:             MsgAviso("Nenhum registro selecionado.")
1387:             RETURN .F.
1388:         ENDIF
1389: 
1390:         TRY
1391:             SELECT cursor_4c_Dados
1392:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1393: 
1394:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1395:                 THIS.this_cModoAtual = "VISUALIZAR"
1396:                 THIS.BOParaForm()
1397:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1398:                 THIS.AlternarGradeDetalhe()
1399:                 THIS.HabilitarCampos(.F.)
1400:                 THIS.AjustarBotoesPorModo()
1401:                 THIS.AlternarPaginaDados()
1402:                 loc_lResultado = .T.
1403:             ENDIF
1404: 
1405:         CATCH TO loc_oErro
1406:             MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
1407:         ENDTRY

*-- Linhas 1415 a 1442:
1415: 
1416:     PROCEDURE BtnAlterarClick()
1417:         LOCAL loc_lResultado, loc_cCodigo
1418:         loc_lResultado = .F.
1419: 
1420:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1421:             MsgAviso("Nenhum registro selecionado.")
1422:             RETURN .F.
1423:         ENDIF
1424: 
1425:         TRY
1426:             SELECT cursor_4c_Dados
1427:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1428: 
1429:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1430:                 THIS.this_oBusinessObject.EditarRegistro()
1431:                 THIS.this_cModoAtual = "ALTERAR"
1432:                 THIS.BOParaForm()
1433:                 THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
1434:                 THIS.AlternarGradeDetalhe()
1435:                 THIS.HabilitarCampos(.T.)
1436:                 THIS.AjustarBotoesPorModo()
1437:                 THIS.AlternarPaginaDados()
1438:                 loc_lResultado = .T.
1439:             ENDIF
1440: 
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")

*-- Linhas 1451 a 1477:
1451: 
1452:     PROCEDURE BtnExcluirClick()
1453:         LOCAL loc_lResultado, loc_cCodigo
1454:         loc_lResultado = .F.
1455: 
1456:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1457:             MsgAviso("Nenhum registro selecionado.")
1458:             RETURN .F.
1459:         ENDIF
1460: 
1461:         SELECT cursor_4c_Dados
1462:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
1463: 
1464:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
1465:             RETURN .F.
1466:         ENDIF
1467: 
1468:         TRY
1469:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1470:                 IF THIS.this_oBusinessObject.Excluir()
1471:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
1472:                     THIS.CarregarLista()
1473:                     loc_lResultado = .T.
1474:                 ENDIF
1475:             ENDIF
1476: 
1477:         CATCH TO loc_oErro

*-- Linhas 1500 a 1533:
1500:                 loc_oBusca.Show()
1501: 
1502:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
1503:                     SELECT cursor_4c_BuscaMtz
1504:                     IF !EOF()
1505:                         LOCAL loc_oGrid
1506:                         THIS.this_oBusinessObject.Buscar( ;
1507:                             "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
1508:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1509:                         IF VARTYPE(loc_oGrid) = "O"
1510:                             loc_oGrid.ColumnCount = 7
1511:                             loc_oGrid.RecordSource            = "cursor_4c_Dados"
1512:                             loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Codigo"
1513:                             loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Ano"
1514:                             loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.sGrupos"
1515:                             loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.sContas"
1516:                             loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.sDContas"
1517:                             loc_oGrid.Column6.ControlSource   = "cursor_4c_Dados.Moeda"
1518:                             loc_oGrid.Column7.ControlSource   = "cursor_4c_Dados.Inativas"
1519:                             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1520:                             loc_oGrid.Column2.Header1.Caption = "Ano"
1521:                             loc_oGrid.Column3.Header1.Caption = "Grupo"
1522:                             loc_oGrid.Column4.Header1.Caption = "Conta"
1523:                             loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1524:                             loc_oGrid.Column6.Header1.Caption = "Moeda"
1525:                             loc_oGrid.Column7.Header1.Caption = "Valida"
1526:                             THIS.FormatarGridLista(loc_oGrid)
1527:                         ENDIF
1528:                     ENDIF
1529:                 ENDIF
1530: 
1531:                 loc_oBusca.Release()
1532:                 loc_lResultado = .T.
1533:             ENDIF

*-- Linhas 1621 a 1683:
1621:     PROTECTED PROCEDURE AlternarPaginaDados()
1622:         THIS.pgf_4c_Paginas.ActivePage = 2
1623:     ENDPROC
1624: 
1625:     *-- =========================================================================
1626:     *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
1627:     *-- (sera completado na Fase 4 quando o grid for criado)
1628:     *-- =========================================================================
1629: 
1630:     PROTECTED PROCEDURE AlternarGradeDetalhe()
1631:         LOCAL loc_oGrid, loc_lResultado
1632:         loc_lResultado = .F.
1633: 
1634:         TRY
1635:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1636:             IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
1637:                 loc_oGrid.ColumnCount = 13
1638:                 loc_oGrid.RecordSource = "cursor_4c_MtI"
1639: 
1640:                 *-- Wires ControlSources apos RecordSource estar definido
1641:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
1642:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
1643:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
1644:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
1645:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
1646:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
1647:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
1648:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
1649:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
1650:                 loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
1651:                 loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
1652:                 loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
1653:                 loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
1654:                 loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
1655:                 loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
1656:                 loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
1657:                 loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
1658:                 loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
1659:                 loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
1660:                 loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
1661:                 loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
1662:                 loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
1663:                 loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
1664:                 loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
1665:                 loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
1666:                 loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
1667:                 loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
1668:                 loc_oGrid.Column28.chk_4c_Valida.ControlSource = "cursor_4c_MtI.ChkValida"
1669: 
1670:                 loc_oGrid.FontName = "Tahoma"
1671:                 loc_oGrid.FontSize = 8
1672:                 loc_oGrid.Refresh()
1673:                 loc_lResultado = .T.
1674:             ENDIF
1675:         CATCH TO loc_oErro
1676:             MsgErro(loc_oErro.Message, "Formmtz.AlternarGradeDetalhe")
1677:         ENDTRY
1678: 
1679:         RETURN loc_lResultado
1680:     ENDPROC
1681: 
1682:     *-- =========================================================================
1683:     *-- VALIDAR ANO MTZ - Valida ano de competencia (range 2000-2999)

*-- Linhas 1723 a 1746:
1723:         ENDIF
1724: 
1725:         TRY
1726:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
1727:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1728: 
1729:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
1730:                !EOF("cursor_4c_GcBusca")
1731:                 SELECT cursor_4c_GcBusca
1732:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1733:                     ALLTRIM(cursor_4c_GcBusca.Classes)
1734: 
1735:                 IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
1736:                     MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
1737:                             CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
1738:                             "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
1739:                             " informada!", "Aten" + CHR(231) + CHR(227) + "o")
1740:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1741:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1742:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
1743:                 ELSE
1744:                     loc_lResultado = .T.
1745:                 ENDIF
1746:             ELSE

*-- Linhas 1780 a 1798:
1780:                 ENDIF
1781: 
1782:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
1783:                     SELECT cursor_4c_GcBusca2
1784:                     IF !EOF()
1785:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
1786:                             ALLTRIM(cursor_4c_GcBusca2.Codigos)
1787:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
1788:                             ALLTRIM(cursor_4c_GcBusca2.Classes)
1789:                     ENDIF
1790:                 ELSE
1791:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ""
1792:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
1793:                 ENDIF
1794: 
1795:                 loc_oBusca.Release()
1796:             ENDIF
1797: 
1798:         CATCH TO loc_oErro

*-- Linhas 1833 a 1859:
1833:         ENDIF
1834: 
1835:         TRY
1836:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
1837:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
1838:             IF !EMPTY(loc_cGrupo)
1839:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1840:             ENDIF
1841: 
1842:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
1843:                !EOF("cursor_4c_CliBusca")
1844:                 SELECT cursor_4c_CliBusca
1845:                 IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
1846:                     MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
1847:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1848:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1849:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
1850:                 ELSE
1851:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1852:                         ALLTRIM(cursor_4c_CliBusca.Rclis)
1853:                     loc_lResultado = .T.
1854:                 ENDIF
1855:             ELSE
1856:                 IF USED("cursor_4c_CliBusca")
1857:                     USE IN cursor_4c_CliBusca
1858:                 ENDIF
1859:                 THIS.AbrirBuscaContaMtz()

*-- Linhas 1879 a 1913:
1879:             loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
1880:             loc_cFiltro = ""
1881:             IF !EMPTY(loc_cGrupo)
1882:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1883:             ENDIF
1884: 
1885:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1886:                 "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
1887:                 ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
1888:                 "Conta Corrente", .F., .T., loc_cFiltro)
1889: 
1890:             IF VARTYPE(loc_oBusca) = "O"
1891:                 IF !loc_oBusca.this_lAchouRegistro
1892:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1893:                     loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
1894:                     loc_oBusca.Show()
1895:                 ENDIF
1896: 
1897:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
1898:                     SELECT cursor_4c_CliBusca2
1899:                     IF !EOF()
1900:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
1901:                             ALLTRIM(cursor_4c_CliBusca2.IClis)
1902:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
1903:                             ALLTRIM(cursor_4c_CliBusca2.Rclis)
1904:                     ENDIF
1905:                 ELSE
1906:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
1907:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
1908:                 ENDIF
1909: 
1910:                 loc_oBusca.Release()
1911:             ENDIF
1912: 
1913:         CATCH TO loc_oErro

*-- Linhas 1947 a 1970:
1947:         ENDIF
1948: 
1949:         TRY
1950:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
1951:                        " WHERE CMoes = " + EscaparSQL(loc_cMoeda)
1952: 
1953:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
1954:                !EOF("cursor_4c_MoeBusca")
1955:                 SELECT cursor_4c_MoeBusca
1956:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1957:                     ALLTRIM(cursor_4c_MoeBusca.CMoes)
1958:                 loc_lResultado = .T.
1959:             ELSE
1960:                 IF USED("cursor_4c_MoeBusca")
1961:                     USE IN cursor_4c_MoeBusca
1962:                 ENDIF
1963:                 THIS.AbrirBuscaMoedaMtz()
1964:             ENDIF
1965: 
1966:         CATCH TO loc_oErro
1967:             MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
1968:         ENDTRY
1969: 
1970:         IF USED("cursor_4c_MoeBusca")

*-- Linhas 1993 a 2011:
1993:                 ENDIF
1994: 
1995:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
1996:                     SELECT cursor_4c_MoeBusca2
1997:                     IF !EOF()
1998:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
1999:                             ALLTRIM(cursor_4c_MoeBusca2.CMoes)
2000:                     ENDIF
2001:                 ELSE
2002:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
2003:                 ENDIF
2004: 
2005:                 loc_oBusca.Release()
2006:             ENDIF
2007: 
2008:         CATCH TO loc_oErro
2009:             MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
2010:         ENDTRY
2011: 

*-- Linhas 2111 a 2238:
2111:     *-- =========================================================================
2112: 
2113:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2114:         LOCAL loc_cChave
2115: 
2116:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2117:             RETURN
2118:         ENDIF
2119: 
2120:         SELECT cursor_4c_MtI
2121:         loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))
2122: 
2123:         DO CASE
2124:         CASE par_nColIndex >= 3 AND par_nColIndex <= 14
2125:             IF !EMPTY(loc_cChave)
2126:                 THIS.AtualizaTotal(loc_cChave)
2127:             ENDIF
2128: 
2129:         CASE par_nColIndex = 1
2130:             THIS.ValidarGrupoLinhaGrid()
2131: 
2132:         CASE par_nColIndex = 2
2133:             THIS.ValidarContaLinhaGrid()
2134: 
2135:         ENDCASE
2136:     ENDPROC
2137: 
2138:     *-- =========================================================================
2139:     *-- VALIDAR GRUPO LINHA GRID - Valida SigCdGcr.Codigos na coluna Grupos
2140:     *-- Original: Column1.Text1.Valid (fAcessoContab)
2141:     *-- =========================================================================
2142: 
2143:     PROCEDURE ValidarGrupoLinhaGrid()
2144:         LOCAL loc_cGrupo, loc_cSQL
2145: 
2146:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2147:             RETURN
2148:         ENDIF
2149: 
2150:         SELECT cursor_4c_MtI
2151:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2152: 
2153:         IF EMPTY(loc_cGrupo)
2154:             RETURN
2155:         ENDIF
2156: 
2157:         TRY
2158:             loc_cSQL = "SELECT TOP 1 Codigos, Classes FROM SigCdGcr" + ;
2159:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2160: 
2161:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcGrid") <= 0 OR ;
2162:                EOF("cursor_4c_GcGrid")
2163:                 MsgErro("Acesso Negado!!! Grupo n" + CHR(227) + "o encontrado.", "")
2164:                 SELECT cursor_4c_MtI
2165:                 REPLACE Grupos WITH "" IN cursor_4c_MtI
2166:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2167:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2168:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
2169:                 ENDIF
2170:             ENDIF
2171: 
2172:         CATCH TO loc_oErro
2173:             MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoLinhaGrid")
2174:         ENDTRY
2175: 
2176:         IF USED("cursor_4c_GcGrid")
2177:             USE IN cursor_4c_GcGrid
2178:         ENDIF
2179:     ENDPROC
2180: 
2181:     *-- =========================================================================
2182:     *-- VALIDAR CONTA LINHA GRID - Valida SigCdCli.IClis na coluna Contas
2183:     *-- Original: Column2.Text1.Valid (fAcessoContas)
2184:     *-- =========================================================================
2185: 
2186:     PROCEDURE ValidarContaLinhaGrid()
2187:         LOCAL loc_cConta, loc_cGrupo, loc_cSQL
2188: 
2189:         IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
2190:             RETURN
2191:         ENDIF
2192: 
2193:         SELECT cursor_4c_MtI
2194:         loc_cConta = ALLTRIM(NVL(cursor_4c_MtI.Contas, ""))
2195:         loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
2196: 
2197:         IF EMPTY(loc_cConta)
2198:             RETURN
2199:         ENDIF
2200: 
2201:         TRY
2202:             loc_cSQL = "SELECT TOP 1 IClis, Rclis, Inativa FROM SigCdCli" + ;
2203:                        " WHERE IClis = " + EscaparSQL(loc_cConta)
2204:             IF !EMPTY(loc_cGrupo)
2205:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
2206:             ENDIF
2207: 
2208:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrid") > 0 AND ;
2209:                !EOF("cursor_4c_CliGrid")
2210:                 SELECT cursor_4c_CliGrid
2211:                 IF NVL(cursor_4c_CliGrid.Inativa, 0) = 1
2212:                     MsgErro("Acesso Negado!!! Conta Inativa.", "")
2213:                     SELECT cursor_4c_MtI
2214:                     REPLACE Contas WITH "" IN cursor_4c_MtI
2215:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2216:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2217:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2218:                     ENDIF
2219:                 ENDIF
2220:             ELSE
2221:                 MsgErro("Acesso Negado!!! Conta n" + CHR(227) + "o encontrada.", "")
2222:                 SELECT cursor_4c_MtI
2223:                 REPLACE Contas WITH "" IN cursor_4c_MtI
2224:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
2225:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
2226:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column2.SetFocus()
2227:                 ENDIF
2228:             ENDIF
2229: 
2230:         CATCH TO loc_oErro
2231:             MsgErro(loc_oErro.Message, "Formmtz.ValidarContaLinhaGrid")
2232:         ENDTRY
2233: 
2234:         IF USED("cursor_4c_CliGrid")
2235:             USE IN cursor_4c_CliGrid
2236:         ENDIF
2237:     ENDPROC
2238: 

*-- Linhas 2281 a 2304:
2281: 
2282:     PROCEDURE Destroy()
2283:         LOCAL loc_oErro
2284: 
2285:         TRY
2286:             IF USED("cursor_4c_Dados")
2287:                 USE IN cursor_4c_Dados
2288:             ENDIF
2289:             IF USED("cursor_4c_MtI")
2290:                 USE IN cursor_4c_MtI
2291:             ENDIF
2292: 
2293:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2294:                 THIS.this_oBusinessObject = .NULL.
2295:             ENDIF
2296: 
2297:         CATCH TO loc_oErro
2298:             MsgErro(loc_oErro.Message, "Formmtz.Destroy")
2299:         ENDTRY
2300: 
2301:         DODEFAULT()
2302:     ENDPROC
2303: 
2304: ENDDEFINE


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

