# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCAS, LNPTOTAL, DESCRATS, OPCAO, COLETORS, PERCRATS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCAS, LNPTOTAL, DESCRATS, OPCAO, COLETORS, PERCRATS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MARCAS, LNPTOTAL, DESCRATS, OPCAO, COLETORS, PERCRATS

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
  ControlSource = "crSigCdRcc.DescRats"
  ControlSource = "crSigCdRcc.Empos"
  DeleteMark = .F.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
Select csSigCdRci
	Select csSigCdRci
Select csSigCdRci
	Select csSigCdRci
	Select csSigCdRci
	lcSqlCdCri = [Select * From SigCdRci Where DescRats = ?lcDescRat]
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRcc Where DescRats = ?lcDescRat], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRci Where DescRats = ?lcDescRat], '') < 1)
If llOk And Not Thisform.poDataMgr.Update('crSigCdRcc')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRcc )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdRci')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRci )')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRcc Where DescRats = ?lcDescRat], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRci Where DescRats = ?lcDescRat], '') < 1)
If Not Thisform.poDataMgr.Update('crSigCdRcc')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRcc )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdRci')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRci )')
lcQuery = [Select 0 as Marcas, Space(3) as Emps, a.grupos, a.iclis as Contas, a.rclis as Descs, CAST(0.00 as numeric(5,2)) as percrats, 0 as Manual ] + ;
	[from sigcdcli a ] + ;
	[join sigcdgcr b on a.grupos = b.codigos ] + ;
Thisform.poDatamgr.SqlExecute(lcQuery,[csSigCdRci])
Select csSigCdRci
Select crSigCdRci
	If Seek(crSigCdRci.Grupos + crSigCdRci.Contas,[csSigCdRci],[GruConta])
Select crSigCdRci
Select csSigCdRci
Thisform.pagina.dados.grdRateio.column1.ControlSource = [csSigCdRci.Emps]
Thisform.pagina.dados.grdRateio.column2.ControlSource = [csSigCdRci.Grupos]
Thisform.pagina.dados.grdRateio.column3.ControlSource = [csSigCdRci.Contas]
Thisform.pagina.dados.grdRateio.column4.ControlSource = [csSigCdRci.Descs]
Thisform.pagina.dados.grdRateio.column5.ControlSource = [csSigCdRci.PercRats]
Thisform.pagina.dados.grdRateio.column6.ControlSource = [csSigCdRci.Marcas]
Select csSigCdRci
	Select crSigCdRci
	Select Sum(PercRats) as TotRats From csSigCdRci Where Marcas = 1 Into Cursor TmpItens
	Select csSigCdRci
		Select crSigCdRci
		Select csSigCdRci
	Select crSigCdRci
	Delete For (Empty(Emps) And Empty(Grupos) And Empty(Contas)) And PercRats = 0
Select csSigCdRci
Select csSigCdRci
Select csSigCdRci

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRcc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1457 linhas total):

*-- Linhas 331 a 349:
331:             .Width              = 890
332:             .Height             = 450
333:             .ReadOnly           = .T.
334:             .DeleteMark         = .F.
335:             .RecordMark         = .F.
336:             .GridLines          = 3
337:             .RowHeight          = 16
338:             .ScrollBars         = 2
339:             .HighlightStyle     = 2
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .GridLineColor      = RGB(238, 238, 238)
343:             .BackColor          = RGB(255, 255, 255)
344:             .ForeColor          = RGB(90, 90, 90)
345:             .Visible            = .T.
346:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
347:             .Column1.Width           = 350
348:             .Column2.Header1.Caption = "Emp."
349:             .Column2.Width           = 60

*-- Linhas 566 a 584:
566:             .Height             = 387
567:             .FontName           = "Tahoma"
568:             .FontSize           = 8
569:             .DeleteMark         = .F.
570:             .RecordMark         = .F.
571:             .ScrollBars         = 2
572:             .RowHeight          = 16
573:             .GridLineColor      = RGB(238, 238, 238)
574:             .BackColor          = RGB(255, 255, 255)
575:             .ForeColor          = RGB(0, 0, 0)
576:             .HighlightStyle     = 2
577:             .HighlightBackColor = RGB(255, 255, 255)
578:             .HighlightForeColor = RGB(15, 41, 104)
579:             .Visible            = .T.
580: 
581:             *-- Column1: Emp. (ColumnOrder=2, width=31) - editavel quando Marcas=1
582:             .Column1.Header1.Caption     = "Emp."
583:             .Column1.Header1.Alignment   = 2
584:             .Column1.Width               = 31

*-- Linhas 732 a 752:
732:                     loc_oGrid.ColumnCount = 3
733:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
734:                     loc_oGrid.ColumnCount  = 3
735:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.DescRats"
736:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.EmpOs"
737:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DEmpresa"
738: 
739:                     loc_oGrid.Column1.Width = 350
740:                     loc_oGrid.Column2.Width = 60
741:                     loc_oGrid.Column3.Width = 430
742: 
743:                     loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
744:                     loc_oGrid.Column2.Header1.Caption = "Emp."
745:                     loc_oGrid.Column3.Header1.Caption = ""
746: 
747:                     THIS.FormatarGridLista(loc_oGrid)
748:                     loc_lSucesso = .T.
749:                 ELSE
750:                     MsgErro("Erro ao carregar lista de rateios.", "Erro")
751:                 ENDIF
752:             ENDIF

*-- Linhas 851 a 869:
851:         ENDIF
852: 
853:         TRY
854:             SELECT cursor_4c_Dados
855:             loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)
856: 
857:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
858:                 THIS.this_oBusinessObject.CarregarItensPorRateio(loc_cDescRats)
859:                 THIS.this_cModoAtual = "VISUALIZAR"
860:                 THIS.BOParaForm()
861:                 THIS.HabilitarCampos(.F.)
862:                 THIS.AjustarBotoesPorModo()
863:                 THIS.CarregarGridRateio("cursor_4c_Itens")
864:                 THIS.AlternarPagina(2)
865:             ELSE
866:                 MsgErro("Erro ao carregar rateio para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
867:             ENDIF
868:         CATCH TO loException
869:             MsgErro("Erro em BtnVisualizarClick: " + loException.Message, "Erro")

*-- Linhas 883 a 901:
883:         ENDIF
884: 
885:         TRY
886:             SELECT cursor_4c_Dados
887:             loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)
888: 
889:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
890:                 THIS.this_oBusinessObject.CarregarClientesPorGrupoColetora(loc_cDescRats)
891:                 THIS.this_oBusinessObject.EditarRegistro()
892:                 THIS.this_cModoAtual = "ALTERAR"
893:                 THIS.BOParaForm()
894:                 THIS.HabilitarCampos(.T.)
895:                 THIS.AjustarBotoesPorModo()
896:                 THIS.CarregarGridRateio("cursor_4c_RateioEdit")
897:                 THIS.AlternarPagina(2)
898:             ELSE
899:                 MsgErro("Erro ao carregar rateio para altera" + CHR(231) + CHR(227) + "o.", "Erro")
900:             ENDIF
901:         CATCH TO loException

*-- Linhas 916 a 934:
916:         ENDIF
917: 
918:         TRY
919:             SELECT cursor_4c_Dados
920:             loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)
921: 
922:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do rateio:" + CHR(13) + ;
923:                     loc_cDescRats, "Confirmar Exclus" + CHR(227) + "o")
924: 
925:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
926:                     IF THIS.this_oBusinessObject.Excluir()
927:                         MsgInfo("Rateio exclu" + CHR(237) + "do com sucesso!", "Sucesso")
928:                         THIS.CarregarLista()
929:                     ELSE
930:                         MsgErro("Erro ao excluir rateio.", "Erro")
931:                     ENDIF
932:                 ELSE
933:                     MsgErro("Erro ao carregar rateio para exclus" + CHR(227) + "o.", "Erro")
934:                 ENDIF

*-- Linhas 953 a 973:
953:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
954:                 loc_oGrid.ColumnCount = 3
955:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
956:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.DescRats"
957:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.EmpOs"
958:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.DEmpresa"
959:                 loc_oGrid.Column1.Width             = 350
960:                 loc_oGrid.Column2.Width             = 60
961:                 loc_oGrid.Column3.Width             = 430
962:                 loc_oGrid.Column1.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
963:                 loc_oGrid.Column2.Header1.Caption   = "Emp."
964:                 loc_oGrid.Column3.Header1.Caption   = ""
965:                 THIS.FormatarGridLista(loc_oGrid)
966:             ELSE
967:                 MsgErro("Erro na busca de rateios.", "Erro")
968:             ENDIF
969:         CATCH TO loException
970:             MsgErro("Erro em BtnBuscarClick: " + loException.Message, "Erro")
971:         ENDTRY
972:     ENDPROC
973: 

*-- Linhas 992 a 1010:
992:         ENDIF
993: 
994:         TRY
995:             SELECT cursor_4c_Dados
996:             loc_cDescRats = ALLTRIM(cursor_4c_Dados.DescRats)
997: 
998:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDescRats)
999:                 THIS.this_oBusinessObject.CarregarClientesPorGrupoColetora(loc_cDescRats)
1000:                 THIS.this_oBusinessObject.NovoRegistro()
1001:                 THIS.this_cModoAtual = "INCLUIR"
1002:                 THIS.BOParaForm()
1003:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.Value = ""
1004:                 THIS.HabilitarCampos(.T.)
1005:                 THIS.AjustarBotoesPorModo()
1006:                 THIS.AlternarPagina(2)
1007:             ELSE
1008:                 MsgErro("Erro ao carregar rateio para duplicar.", "Erro")
1009:             ENDIF
1010:         CATCH TO loException

*-- Linhas 1091 a 1112:
1091:         ENDIF
1092: 
1093:         TRY
1094:             loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cEmpresa)
1095:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValida") >= 0 AND ;
1096:                RECCOUNT("cursor_4c_EmpValida") > 0
1097:                 SELECT cursor_4c_EmpValida
1098:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
1099:                     loc_oPg2.txt_4c_DEmpresa.Value    = ALLTRIM(cursor_4c_EmpValida.Razas)
1100:                     loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
1101:                 ENDIF
1102:             ELSE
1103:                 MsgAviso("Empresa '" + loc_cEmpresa + "' n" + CHR(227) + "o encontrada.", "Aviso")
1104:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
1105:                     loc_oPg2.txt_4c_Empresa.Value = ""
1106:                 ENDIF
1107:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
1108:                     loc_oPg2.txt_4c_DEmpresa.Value    = ""
1109:                     loc_oPg2.txt_4c_DEmpresa.ReadOnly = .F.
1110:                 ENDIF
1111:             ENDIF
1112: 

*-- Linhas 1143 a 1165:
1143:         ENDIF
1144: 
1145:         TRY
1146:             loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1147:                        EscaparSQL(loc_cNome + "%") + " ORDER BY Razas"
1148:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpNome")
1149:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_EmpNome") = 1
1150:                 SELECT cursor_4c_EmpNome
1151:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Empresa", 5)
1152:                     loc_oPg2.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpNome.CEmps)
1153:                 ENDIF
1154:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
1155:                     loc_oPg2.txt_4c_DEmpresa.Value    = ALLTRIM(cursor_4c_EmpNome.Razas)
1156:                     loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
1157:                 ENDIF
1158:             ELSE
1159:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_EmpNome") > 1
1160:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DEmpresa", 5)
1161:                     loc_oPg2.txt_4c_DEmpresa.Value = ""
1162:                 ENDIF
1163:                 MsgAviso("Mais de uma empresa encontrada. Digite o c" + CHR(243) + "digo.", "Aviso")
1164:             ELSE
1165:                 MsgAviso("Empresa '" + loc_cNome + "' n" + CHR(227) + "o encontrada.", "Aviso")

*-- Linhas 1264 a 1286:
1264: 
1265:             IF !EMPTY(THIS.this_oBusinessObject.this_cEmpOs)
1266:                 TRY
1267:                     loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE CEmps = " + ;
1268:                                EscaparSQL(THIS.this_oBusinessObject.this_cEmpOs)
1269:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpNomeBO") >= 0 AND ;
1270:                        RECCOUNT("cursor_4c_EmpNomeBO") > 0
1271:                         SELECT cursor_4c_EmpNomeBO
1272:                         loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_EmpNomeBO.Razas)
1273:                     ENDIF
1274:                     IF USED("cursor_4c_EmpNomeBO")
1275:                         USE IN cursor_4c_EmpNomeBO
1276:                     ENDIF
1277:                 CATCH TO loException
1278:                     MsgErro("Erro ao carregar nome empresa: " + loException.Message, "Erro")
1279:                     IF USED("cursor_4c_EmpNomeBO")
1280:                         USE IN cursor_4c_EmpNomeBO
1281:                     ENDIF
1282:                 ENDTRY
1283:             ELSE
1284:                 loc_oPg2.txt_4c_DEmpresa.ReadOnly = .F.
1285:             ENDIF
1286:         ENDIF

*-- Linhas 1321 a 1344:
1321:             loc_oGrd.ColumnCount  = 6
1322: 
1323:             WITH loc_oGrd
1324:                 .Column1.ControlSource = par_cCursor + ".Emps"
1325:                 .Column2.ControlSource = par_cCursor + ".Grupos"
1326:                 .Column3.ControlSource = par_cCursor + ".Contas"
1327:                 .Column4.ControlSource = par_cCursor + ".Descs"
1328:                 .Column5.ControlSource = par_cCursor + ".PercRats"
1329:                 .Column6.ControlSource = par_cCursor + ".Marcas"
1330: 
1331:                 *-- Reconfigurar Headers apos RecordSource (Problema 32)
1332:                 .Column1.Header1.Caption = "Emp."
1333:                 .Column2.Header1.Caption = "Grupo"
1334:                 .Column3.Header1.Caption = "Centro de Custo"
1335:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1336:                 .Column5.Header1.Caption = "% Rateio"
1337:                 .Column6.Header1.Caption = ""
1338: 
1339:                 .Refresh()
1340:             ENDWITH
1341: 
1342:             THIS.AtualizarPTotal()
1343:         CATCH TO loException
1344:             MsgErro("Erro em CarregarGridRateio: " + loException.Message, "Erro")

*-- Linhas 1354 a 1392:
1354:         loc_nTotal = 0
1355: 
1356:         IF USED("cursor_4c_RateioEdit")
1357:             SELECT cursor_4c_RateioEdit
1358:             SUM PercRats FOR Marcas = 1 TO loc_nTotal
1359:         ENDIF
1360: 
1361:         IF PEMSTATUS(loc_oPg2, "txt_4c_PTotal", 5)
1362:             loc_oPg2.txt_4c_PTotal.Value = loc_nTotal
1363:             loc_oPg2.txt_4c_PTotal.Refresh()
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     *===========================================================================
1368:     * GridCheckClick - Processa click no CheckBox da coluna Marcas do grid
1369:     * Quando Marcas vira 0, zera PercRats; depois recalcula rateio automatico
1370:     *===========================================================================
1371:     PROCEDURE GridCheckClick()
1372:         IF !USED("cursor_4c_RateioEdit")
1373:             RETURN
1374:         ENDIF
1375: 
1376:         TRY
1377:             SELECT cursor_4c_RateioEdit
1378:             IF Marcas = 0
1379:                 REPLACE PercRats WITH 0 IN cursor_4c_RateioEdit
1380:             ENDIF
1381: 
1382:             THIS.this_oBusinessObject.CalcularRateioAuto()
1383:             THIS.AtualizarPTotal()
1384:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1385:         CATCH TO loException
1386:             MsgErro("Erro em GridCheckClick: " + loException.Message, "Erro")
1387:         ENDTRY
1388:     ENDPROC
1389: 
1390:     *===========================================================================
1391:     * GridRateioAfterRowColChange - Atualiza PTotal quando usuario edita % Rateio
1392:     * LPARAMETERS obrigatorio para BINDEVENT AfterRowColChange (Problema 38)

*-- Linhas 1405 a 1445:
1405:         ENDIF
1406: 
1407:         TRY
1408:             SELECT cursor_4c_RateioEdit
1409:             REPLACE ALL Marcas WITH 1
1410:             GO TOP
1411: 
1412:             THIS.this_oBusinessObject.CalcularRateioAuto()
1413:             THIS.AtualizarPTotal()
1414:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1415:         CATCH TO loException
1416:             MsgErro("Erro em BtnSelTudoClick: " + loException.Message, "Erro")
1417:         ENDTRY
1418:     ENDPROC
1419: 
1420:     *===========================================================================
1421:     * BtnApagaClick - Desmarca todos os itens do grid de rateio
1422:     * Equivale ao botao apaga do legado: zera Marcas=0 e PercRats=0
1423:     *===========================================================================
1424:     PROCEDURE BtnApagaClick()
1425:         IF !USED("cursor_4c_RateioEdit")
1426:             RETURN
1427:         ENDIF
1428: 
1429:         TRY
1430:             SELECT cursor_4c_RateioEdit
1431:             REPLACE ALL Marcas WITH 0, PercRats WITH 0
1432:             GO TOP
1433: 
1434:             THIS.AtualizarPTotal()
1435:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1436:         CATCH TO loException
1437:             MsgErro("Erro em BtnApagaClick: " + loException.Message, "Erro")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *===========================================================================
1442:     * Destroy - Libera recursos
1443:     *===========================================================================
1444:     PROCEDURE Destroy()
1445:         IF USED("cursor_4c_Dados")


### BO (C:\4c\projeto\app\classes\RccBO.prg):
*==============================================================================
* RccBO.prg - Business Object para Rateio de Centros de Custo
* Tabelas: SigCdRcc (cabecalho) + SigCdRci (itens)
* Migrado de: SIGCDRCC.SCX
*==============================================================================

DEFINE CLASS RccBO AS BusinessBase

    *-- Propriedades do cabecalho (SigCdRcc)
    this_cDescRats  = ""    && Descricao do rateio (PK)
    this_cEmpOs     = ""    && Codigo da empresa
    this_cCidChaves = ""    && Chave unica do registro
    this_dDatas     = {}    && Data de criacao
    this_dDtAlts    = {}    && Data de alteracao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRcc"
        THIS.this_cCampoChave = "DescRats"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDescRats
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdRcc
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.EmpOs, b.Razas AS DEmpresa" + ;
                       " FROM SigCdRcc a" + ;
                       " LEFT JOIN SigCdEmp b ON b.CEmps = a.EmpOs" + ;
                       " ORDER BY a.DescRats"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = STRTRAN(loc_cSQL, " ORDER BY", ;
                    " WHERE a.DescRats LIKE " + EscaparSQL(par_cFiltro + "%") + " ORDER BY")
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar rateios: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo DescRats (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DescRats, EmpOs, CidChaves, Datas, DtAlts" + ;
                       " FROM SigCdRcc" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarPorCodigo: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Preenche propriedades a partir do cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDescRats  = TratarNulo(DescRats, "C")
            THIS.this_cEmpOs     = TratarNulo(EmpOs, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDatas     = TratarNulo(Datas, "D")
            THIS.this_dDtAlts    = TratarNulo(DtAlts, "D")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorRateio - Carrega itens de SigCdRci para o grid (modo VISUALIZAR)
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorRateio(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.Emps, a.Grupos, a.Contas," + ;
                       " a.PercRats, a.Marcas, a.CidChaves, c.rclis AS Descs" + ;
                       " FROM SigCdRci a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.Contas" + ;
                       " WHERE a.DescRats = " + EscaparSQL(par_cDescRats) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Itens")
                TABLEREVERT(.T., "cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarItensPorRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarClientesPorGrupoColetora - Popula cursor_4c_RateioEdit para edicao
    * Carrega todos os clientes do grupo coletora 9, marcando os ja salvos
    *--------------------------------------------------------------------------
    FUNCTION CarregarClientesPorGrupoColetora(par_cDescRatsExistente)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_RateioEdit")
                USE IN cursor_4c_RateioEdit
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_RateioEdit ( ;
                Marcas    I, ;
                Emps      C(3), ;
                Grupos    C(20), ;
                Contas    C(20), ;
                Descs     C(60), ;
                PercRats  N(5,2), ;
                Manual    I ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT 0 AS Marcas, SPACE(3) AS Emps, a.grupos," + ;
                       " a.iclis AS Contas, a.rclis AS Descs," + ;
                       " CAST(0.00 AS NUMERIC(5,2)) AS PercRats, 0 AS Manual" + ;
                       " FROM SigCdCli a" + ;
                       " JOIN SigCdGcr b ON a.grupos = b.codigos" + ;
                       " WHERE b.coletors = 9" + ;
                       " ORDER BY a.grupos, a.rclis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RateioEditTemp")
                TABLEREVERT(.T., "cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RateioEditTemp")
            IF loc_nResultado >= 0
                SELECT cursor_4c_RateioEdit
                APPEND FROM DBF("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp

                IF !EMPTY(par_cDescRatsExistente)
                    THIS.MarcarItensExistentes(par_cDescRatsExistente)
                ENDIF

                GO TOP IN cursor_4c_RateioEdit
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar clientes: " + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_RateioEditTemp")
                    USE IN cursor_4c_RateioEditTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarClientesPorGrupoColetora: " + loException.Message, "Erro")
            IF USED("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarItensExistentes - Marca no cursor_4c_RateioEdit os itens ja salvos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarItensExistentes(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cGrupos, loc_cContas, loc_nPerc

        TRY
            loc_cSQL = "SELECT Grupos, Contas, PercRats FROM SigCdRci" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RciExist")
                TABLEREVERT(.T., "cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RciExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_RciExist") > 0
                SELECT cursor_4c_RateioEdit
                INDEX ON Grupos + Contas TAG GruConta ADDITIVE

                SELECT cursor_4c_RciExist
                GO TOP
                DO WHILE !EOF("cursor_4c_RciExist")
                    loc_cGrupos = ALLTRIM(cursor_4c_RciExist.Grupos)
                    loc_cContas = ALLTRIM(cursor_4c_RciExist.Contas)
                    loc_nPerc   = cursor_4c_RciExist.PercRats

                    IF SEEK(loc_cGrupos + loc_cContas, "cursor_4c_RateioEdit", "GruConta")
                        REPLACE Marcas WITH 1, PercRats WITH loc_nPerc IN cursor_4c_RateioEdit
                    ENDIF

                    SKIP IN cursor_4c_RciExist
                ENDDO
            ENDIF

            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            SELECT cursor_4c_RateioEdit
            SET ORDER TO
            GO TOP
        CATCH TO loException
            MsgErro("Erro em MarcarItensExistentes: " + loException.Message, "Erro")
            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularRateioAuto - Distribui % automaticamente entre itens marcados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularRateioAuto()
        LOCAL loc_nQtde, loc_nRat, loc_nPTotal

        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nQtde = 0
            GO TOP
            COUNT FOR Marcas = 1 TO loc_nQtde

            IF loc_nQtde > 0
                loc_nRat = ROUND(100 / loc_nQtde, 2)
                SCAN FOR Marcas = 1
                    REPLACE PercRats WITH loc_nRat IN cursor_4c_RateioEdit
                ENDSCAN
            ENDIF

            SELECT cursor_4c_RateioEdit
            loc_nPTotal = 0
            SUM PercRats TO loc_nPTotal

            IF loc_nPTotal > 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats - (loc_nPTotal - 100) IN cursor_4c_RateioEdit
                ENDIF
                loc_nPTotal = 0
                SUM PercRats TO loc_nPTotal
            ENDIF

            IF !EMPTY(loc_nPTotal) AND loc_nPTotal < 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats + ((loc_nPTotal - 100) * -1) IN cursor_4c_RateioEdit
                ENDIF
            ENDIF

            GO TOP
        CATCH TO loException
            MsgErro("Erro em RccBO.CalcularRateioAuto: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTotalRateio - Verifica se soma dos itens marcados = 100%
    *--------------------------------------------------------------------------
    FUNCTION ValidarTotalRateio()
        LOCAL loc_nTotal, loc_lValido
        loc_lValido = .F.

        IF !USED("cursor_4c_RateioEdit")
            MsgAviso("Nenhum item de rateio carregado.", "Aviso")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nTotal = 0
            SUM PercRats FOR Marcas = 1 TO loc_nTotal

            IF loc_nTotal <> 100
                MsgAviso("Total de rateio diferente de 100%. " + ;
                    "Total atual: " + TRANSFORM(loc_nTotal) + "%", ;
                    "Lan" + CHR(231) + "amento incorreto")
            ELSE
                loc_lValido = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarTotalRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDescricaoExistente - Checa duplicidade em INSERIR
    *--------------------------------------------------------------------------
    FUNCTION VerificarDescricaoExistente(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdRcc WHERE DescRats = " + ;
                       EscaparSQL(par_cDescRats)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkExist")
                TABLEREVERT(.T., "cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkExist") > 0
                SELECT cursor_4c_ChkExist
                loc_lExiste = (cursor_4c_ChkExist.Total > 0)
            ENDIF
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        CATCH TO loException
            MsgErro("Erro em VerificarDescricaoExistente: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRcc + SigCdRci (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(SYS(2015)) + ", " + ;
                       EscaparSQL(THIS.this_cDescRats) + ", " + ;
                       EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Recria SigCdRcc + SigCdRci atomicamente (delete+insert)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover itens antigos: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover cabe" + CHR(231) + "alho antigo: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas, DtAlts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "GETDATE())"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao reinserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarItensRateio - INSERT em SigCdRci para cada item marcado no cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarItensRateio()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .T.

        IF !USED("cursor_4c_RateioEdit")
            RETURN .T.
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            GO TOP
            SCAN FOR Marcas = 1
                IF EMPTY(Grupos) AND EMPTY(Contas)
                    LOOP
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRci" + ;
                           " (CidChaves, DescRats, Emps, Grupos, Contas, PercRats, Marcas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(SYS(2015)) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(Emps) + ", " + ;
                           EscaparSQL(Grupos) + ", " + ;
                           EscaparSQL(Contas) + ", " + ;
                           FormatarNumeroSQL(PercRats) + ", " + ;
                           TRANSFORM(Marcas) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir item de rateio: " + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loException
            MsgErro("Erro em SalvarItensRateio: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdRci e SigCdRcc (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                loc_lTransAberta = .F.
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_RateioEdit")
            USE IN cursor_4c_RateioEdit
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

