# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-TABELA] Tabela 'SigCdCfg' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FXAFIMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FKCHAVES, PKCHAVES, CODS, TIPOS, CODFAIXAS, LNINI, LNFIM, EMPS

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
  DeleteMark = .F.
  Column1.ControlSource = "crGrdItP.Mercs"
  Column2.ControlSource = "crGrdItP.CGrus"
  Column3.ControlSource = "crGrdItP.SGrus"
  Column4.ControlSource = "crGrdItP.PPctFixs"
  ControlSource = "crSigCmCab.Cods"
  ControlSource = "crSigCmCab.Emps"
  ControlSource = "crSigCmCab.DtInis"
  ControlSource = "crSigCmCab.DtFims"
  ControlSource = "crSigCmCab.MetaEmps"
  ControlSource = "crSigCmCab.PctVd1"
  ControlSource = "crSigCmCab.PctVd2"
  DeleteMark = .F.
  Column1.ControlSource = "crGrdItV.CodVens"
  Column2.ControlSource = "crGrdItV.VMetas"
  Column3.ControlSource = "crGrdItV.SalBases"
  Column4.ControlSource = "crGrdItV.CodResps"
  Column5.ControlSource = "crGrdItV.RPctFixs"
  Column6.ControlSource = "crGrdItV.VMetItns"
  DeleteMark = .F.
  Column1.ControlSource = "Padl(crGrdItM.CodFaixas, 2, [0])"
  Column2.ControlSource = "crGrdItM.FxaInis"
  Column3.ControlSource = "crGrdItM.FxaFims"
  Column4.ControlSource = "crGrdItM.PctFaixas"
  Column5.ControlSource = "crGrdItM.Bonus"
  ControlSource = "crSigCmCab.Moedas"
lcQryCmCab = [Select * From SigCmCab]
lcQryCmItn = [Select * From SigCmItn Where fkChaves = ?pKey]
		lcQuery = [Select GrPadVens, GrPadResps From SigCdPam]
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdPam]) < 1)
Select crSigCmCab
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCmCab Where pkChaves = ?pKey], []) < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCmItn Where fkChaves = ?pKey], []) < 1)
If Not ThisForm.poDataMgr.Update([crSigCmCab])
If Not ThisForm.poDataMgr.Update([crSigCmItn])
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCmCab Where pkChaves = ?pKey], []) < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCmItn Where fkChaves = ?pKey], []) < 1)
If Not ThisForm.poDataMgr.Update([crSigCmCab])
If Not ThisForm.poDataMgr.Update([crSigCmItn])
Select crSigCmCab
Select crSigCmCab
	Select * From crSigCmItn Where Tipos = [PRO] Order By Mercs, CGrus, SGrus Into Cursor LocalItn
	Select LocalItn
		Insert Into crGrdItP From Memvar
	Select * From crSigCmItn Where Tipos = [VEN] Order By CodVens Into Cursor LocalItn
	Select LocalItn
		Insert Into crGrdItV From Memvar
	Select * From crSigCmItn Where Tipos = [MET] Order By CodFaixas Into Cursor LocalItn
	Select LocalItn
		Insert Into crGrdItM From Memvar
	Select crSigCmCab
		lcQuery = [Select * ] + ;
				    [From SigCmCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp]) < 1)
	Select crGrdItP
			Delete In crGrdItP
			Select * From crGrdItP ;
			Insert Into crGrdItP (Tipos, pkChaves, fkChaves) Values ([PRO], fUniqueIds(), crSigCmCab.pkChaves)
	Select crGrdItV
			Delete In crGrdItV
			Select * From crGrdItV ;
			Insert Into crGrdItV (Tipos, pkChaves, fkChaves) Values ([VEN], fUniqueIds(), crSigCmCab.pkChaves)
	Select Sum(1) as Soma From crGrdItV Into Cursor crVenTots
	Select crGrdItM
			Delete In crGrdItM
	Select crGrdItM
		Select * From crGrdItM ;
			Insert Into crGrdItM (Tipos, pkChaves, fkChaves) Values ([VEN], fUniqueIds(), crSigCmCab.pkChaves)
	Select crGrdItP
		Insert Into crSigCmItn (Mercs, CGrus, SGrus, PPctFixs, fkChaves, pkChaves, Tipos) ;
	Select crGrdItV
		Insert Into crSigCmItn (CodVens, VMetas, SalBases, CodResps, RPctFixs, fkChaves, pkChaves, Tipos, VMetItns) ;
	Select crGrdItM
		Insert Into crSigCmItn (CodFaixas, FxaInis, FxaFims, PctFaixas, Bonus, fkChaves, pkChaves, Tipos) ;
	Select crSigCmCab
		Insert Into crGrdItP (Tipos, pkChaves, fkChaves) Values ([PRO], fUniqueIds(), crSigCmCab.pkChaves)
		Insert Into crGrdItV (Tipos, pkChaves, fkChaves) Values ([VEN], fUniqueIds(), crSigCmCab.pkChaves)
		Insert Into crGrdItV (Tipos, pkChaves, fkChaves) Values ([VEN], fUniqueIds(), crSigCmCab.pkChaves)
		Select crGrdItM
		Insert Into crGrdItM (CodFaixas, FxaInis, Tipos, pkChaves, fkChaves) ;
		Select crGrdItM
		Insert Into crGrdItM (CodFaixas, FxaInis, Tipos, pkChaves, fkChaves) ;
	Delete In crGrdItV
	Select crGrdItM
	Delete In crGrdItM
	Delete In crGrdItP

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOM.prg) - TRECHOS RELEVANTES PARA PASS SQL (2231 linhas total):

*-- Linhas 395 a 413:
395:                 .HighlightBackColor = RGB(255, 255, 255)
396:                 .HighlightForeColor = RGB(15, 41, 104)
397:                 .HighlightStyle     = 2
398:                 .DeleteMark         = .F.
399:                 .RecordMark         = .F.
400:                 .RowHeight          = 16
401:                 .ScrollBars         = 2
402:                 .GridLines          = 3
403:                 .Visible            = .T.
404:             ENDWITH
405: 
406:             WITH loc_oGrid.Column1
407:                 .Width           = 290
408:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
409:             ENDWITH
410:             WITH loc_oGrid.Column2
411:                 .Width           = 40
412:                 .Header1.Caption = "Emp"
413:             ENDWITH

*-- Linhas 922 a 980:
922:                 .FontSize          = 8
923:                 .AllowHeaderSizing = .F.
924:                 .AllowRowSizing    = .F.
925:                 .DeleteMark        = .F.
926:                 .RecordMark        = .F.
927:                 .ScrollBars        = 2
928:                 .Visible           = .T.
929:             ENDWITH
930: 
931:             WITH loc_oGridV.Column1
932:                 .ControlSource   = "crGrdItV.CodVens"
933:                 .Width           = 80
934:                 .Header1.Caption = "Vendedor"
935:             ENDWITH
936:             WITH loc_oGridV.Column2
937:                 .ControlSource   = "crGrdItV.VMetas"
938:                 .Width           = 115
939:                 .Header1.Caption = "Meta no Per" + CHR(237) + "odo"
940:             ENDWITH
941:             WITH loc_oGridV.Column3
942:                 .ControlSource   = "crGrdItV.SalBases"
943:                 .Width           = 115
944:                 .Header1.Caption = "Sal" + CHR(225) + "rio Base"
945:             ENDWITH
946:             WITH loc_oGridV.Column4
947:                 .ControlSource   = "crGrdItV.CodResps"
948:                 .Width           = 80
949:                 .Header1.Caption = "Respons" + CHR(225) + "vel"
950:             ENDWITH
951:             WITH loc_oGridV.Column5
952:                 .ControlSource   = "crGrdItV.RPctFixs"
953:                 .Width           = 82
954:                 .Header1.Caption = "% Respons" + CHR(225) + "vel"
955:             ENDWITH
956:             WITH loc_oGridV.Column6
957:                 .ControlSource   = "crGrdItV.VMetItns"
958:                 .Width           = 115
959:                 .Header1.Caption = "Meta por itens"
960:             ENDWITH
961: 
962:             loc_oGridV.RecordSource = "crGrdItV"
963: 
964:             *-- Re-atribuir Column6 apos RecordSource (auto-bind usa campo 6=fkChaves, nao VMetItns)
965:             loc_oGridV.Column6.ControlSource   = "crGrdItV.VMetItns"
966:             loc_oGridV.Column6.Header1.Caption = "Meta por itens"
967:             BINDEVENT(loc_oGridV, "AfterRowColChange", THIS, "GrdVendedoresAfterRowColChange")
968: 
969:             loc_oPagina.AddObject("cmd_4c_BtnExcV", "CommandButton")
970:             WITH loc_oPagina.cmd_4c_BtnExcV
971:                 .Caption         = ""
972:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
973:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
974:                 .Top             = 355
975:                 .Left            = 633
976:                 .Width           = 26
977:                 .Height          = 26
978:                 .ToolTipText     = "Excluir Linha da Grade"
979:                 .Themes          = .T.
980:                 .Visible         = .T.

*-- Linhas 1019 a 1059:
1019:                 .FontSize          = 8
1020:                 .AllowHeaderSizing = .F.
1021:                 .AllowRowSizing    = .F.
1022:                 .DeleteMark        = .F.
1023:                 .RecordMark        = .F.
1024:                 .ScrollBars        = 2
1025:                 .Visible           = .T.
1026:             ENDWITH
1027: 
1028:             WITH loc_oGridP.Column1
1029:                 .ControlSource   = "crGrdItP.Mercs"
1030:                 .Width           = 45
1031:                 .Header1.Caption = "G.Grupo"
1032:             ENDWITH
1033:             WITH loc_oGridP.Column2
1034:                 .ControlSource   = "crGrdItP.CGrus"
1035:                 .Width           = 45
1036:                 .Header1.Caption = "Grupo"
1037:             ENDWITH
1038:             WITH loc_oGridP.Column3
1039:                 .ControlSource   = "crGrdItP.SGrus"
1040:                 .Width           = 55
1041:                 .Header1.Caption = "Subgrupo"
1042:             ENDWITH
1043:             WITH loc_oGridP.Column4
1044:                 .ControlSource   = "crGrdItP.PPctFixs"
1045:                 .Width           = 80
1046:                 .Header1.Caption = "% Fixo"
1047:             ENDWITH
1048: 
1049:             loc_oGridP.RecordSource = "crGrdItP"
1050: 
1051:             BINDEVENT(loc_oGridP, "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")
1052: 
1053:             loc_oPagina.AddObject("cmd_4c_BtnExcP", "CommandButton")
1054:             WITH loc_oPagina.cmd_4c_BtnExcP
1055:                 .Caption         = ""
1056:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1057:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1058:                 .Top             = 576
1059:                 .Left            = 940

*-- Linhas 1103 a 1148:
1103:                 .FontSize          = 8
1104:                 .AllowHeaderSizing = .F.
1105:                 .AllowRowSizing    = .F.
1106:                 .DeleteMark        = .F.
1107:                 .RecordMark        = .F.
1108:                 .ScrollBars        = 2
1109:                 .Visible           = .T.
1110:             ENDWITH
1111: 
1112:             WITH loc_oGridM.Column1
1113:                 .ControlSource   = "crGrdItM.CodFaixas"
1114:                 .Width           = 32
1115:                 .Header1.Caption = ""
1116:             ENDWITH
1117:             WITH loc_oGridM.Column2
1118:                 .ControlSource   = "crGrdItM.FxaInis"
1119:                 .Width           = 130
1120:                 .Header1.Caption = "Faixa Inicial"
1121:             ENDWITH
1122:             WITH loc_oGridM.Column3
1123:                 .ControlSource   = "crGrdItM.FxaFims"
1124:                 .Width           = 130
1125:                 .Header1.Caption = "Faixa Final"
1126:             ENDWITH
1127:             WITH loc_oGridM.Column4
1128:                 .ControlSource   = "crGrdItM.PctFaixas"
1129:                 .Width           = 90
1130:                 .Header1.Caption = "% Comiss" + CHR(227) + "o"
1131:             ENDWITH
1132:             WITH loc_oGridM.Column5
1133:                 .ControlSource   = "crGrdItM.Bonus"
1134:                 .Width           = 90
1135:                 .Header1.Caption = "% B" + CHR(244) + "nus x Meta"
1136:             ENDWITH
1137: 
1138:             loc_oGridM.RecordSource = "crGrdItM"
1139: 
1140:             BINDEVENT(loc_oGridM, "AfterRowColChange", THIS, "GrdMetasAfterRowColChange")
1141: 
1142:             loc_oPagina.AddObject("cmd_4c_BtnExcM", "CommandButton")
1143:             WITH loc_oPagina.cmd_4c_BtnExcM
1144:                 .Caption         = ""
1145:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1146:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1147:                 .Top             = 576
1148:                 .Left            = 516

*-- Linhas 1235 a 1258:
1235:                 loc_oGrid.ColumnCount = 5
1236:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1237: 
1238:                 *-- Re-atribuir ControlSource apos RecordSource (auto-bind reseta)
1239:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
1240:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
1241:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtInis"
1242:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtFims"
1243:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.MetaEmps"
1244: 
1245:                 *-- Reconfigurar cabecalhos apos RecordSource (Problemas 6 e 32)
1246:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1247:                 loc_oGrid.Column2.Header1.Caption = "Emp"
1248:                 loc_oGrid.Column3.Header1.Caption = "In" + CHR(237) + "cio"
1249:                 loc_oGrid.Column4.Header1.Caption = "Fim"
1250:                 loc_oGrid.Column5.Header1.Caption = "Meta Empresa"
1251: 
1252:                 THIS.FormatarGridLista(loc_oGrid)
1253:                 loc_lResultado = .T.
1254:             ENDIF
1255:         CATCH TO loc_oErro
1256:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormCOM.CarregarLista")
1257:         ENDTRY
1258: 

*-- Linhas 1297 a 1315:
1297:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1298:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1299:             ELSE
1300:                 SELECT cursor_4c_Dados
1301:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkchaves)
1302: 
1303:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1304:                     THIS.this_oBusinessObject.EditarRegistro()
1305:                     THIS.this_cModoAtual = "VISUALIZAR"
1306:                     THIS.BOParaForm()
1307:                     THIS.HabilitarCampos(.F.)
1308:                     THIS.AjustarBotoesPorModo()
1309:                     THIS.pgf_4c_Paginas.ActivePage = 2
1310:                 ELSE
1311:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
1312:                 ENDIF
1313:             ENDIF
1314:         CATCH TO loc_oErro
1315:             MostrarErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnVisualizarClick")

*-- Linhas 1327 a 1345:
1327:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1328:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1329:             ELSE
1330:                 SELECT cursor_4c_Dados
1331:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkchaves)
1332: 
1333:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1334:                     THIS.this_oBusinessObject.EditarRegistro()
1335:                     THIS.this_cModoAtual = "ALTERAR"
1336:                     THIS.BOParaForm()
1337:                     THIS.HabilitarCampos(.T.)
1338:                     THIS.AjustarBotoesPorModo()
1339:                     THIS.pgf_4c_Paginas.ActivePage = 2
1340:                 ELSE
1341:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
1342:                 ENDIF
1343:             ENDIF
1344:         CATCH TO loc_oErro
1345:             MostrarErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnAlterarClick")

*-- Linhas 1359 a 1377:
1359:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1360:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1361:             ELSE
1362:                 SELECT cursor_4c_Dados
1363:                 loc_cCodigo   = ALLTRIM(cursor_4c_Dados.Cods)
1364:                 loc_cPkChaves = ALLTRIM(cursor_4c_Dados.pkchaves)
1365: 
1366:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da comiss" + CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
1367:                 IF loc_lConfirma
1368:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChaves)
1369:                         IF THIS.this_oBusinessObject.Excluir()
1370:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1371:                             THIS.CarregarLista()
1372:                         ENDIF
1373:                     ENDIF
1374:                 ENDIF
1375:             ENDIF
1376:         CATCH TO loc_oErro
1377:             MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnExcluirClick")

*-- Linhas 1411 a 1436:
1411: 
1412:         TRY
1413:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1414:                 SELECT cursor_4c_Dados
1415:                 loc_cCod = ALLTRIM(cursor_4c_Dados.Cods)
1416: 
1417:                 IF !EMPTY(loc_cCod)
1418:                     THIS.LockScreen = .T.
1419:                     THIS.CarregarLista()
1420:                     IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCod)
1421:                         SELECT cursor_4c_Dados
1422:                         LOCATE FOR ALLTRIM(Cods) = loc_cCod
1423:                     ENDIF
1424:                     THIS.LockScreen = .F.
1425:                 ENDIF
1426:             ENDIF
1427:         CATCH TO loc_oErro
1428:             MostrarErro("Erro ao copiar registro:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnCopiarClick")
1429:         ENDTRY
1430:     ENDPROC
1431: 
1432:     *==========================================================================
1433:     * BtnSalvarClick - Valida e salva o registro (Confirmar)
1434:     * Em modo BUSCAR, filtra a lista e retorna para Page1
1435:     *==========================================================================
1436:     PROCEDURE BtnSalvarClick()

*-- Linhas 1446 a 1468:
1446:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1447:                     loc_oGrid.ColumnCount = 5
1448:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1449:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
1450:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
1451:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtInis"
1452:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtFims"
1453:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.MetaEmps"
1454:                     loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1455:                     loc_oGrid.Column2.Header1.Caption = "Emp"
1456:                     loc_oGrid.Column3.Header1.Caption = "In" + CHR(237) + "cio"
1457:                     loc_oGrid.Column4.Header1.Caption = "Fim"
1458:                     loc_oGrid.Column5.Header1.Caption = "Meta Empresa"
1459:                     THIS.FormatarGridLista(loc_oGrid)
1460:                     THIS.pgf_4c_Paginas.ActivePage = 1
1461:                     THIS.this_cModoAtual = "LISTA"
1462:                 ENDIF
1463:             CATCH TO loc_oErro
1464:                 MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnSalvarClick")
1465:             ENDTRY
1466:             RETURN
1467:         ENDIF
1468: 

*-- Linhas 1815 a 1866:
1815:     PROCEDURE GrdVendExcluirClick()
1816:         TRY
1817:             IF USED("crGrdItV") AND !EOF("crGrdItV") AND RECCOUNT("crGrdItV") > 0
1818:                 SELECT crGrdItV
1819:                 DELETE
1820:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1821:             ENDIF
1822:         CATCH TO loc_oErro
1823:             MostrarErro("Erro ao excluir vendedor:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdVendExcluirClick")
1824:         ENDTRY
1825:     ENDPROC
1826: 
1827:     *==========================================================================
1828:     * GrdProdExcluirClick - Exclui linha corrente do grid de Produtos
1829:     * Original: btnExcP.Click -> marca como deletado no crGrdItP
1830:     *==========================================================================
1831:     PROCEDURE GrdProdExcluirClick()
1832:         TRY
1833:             IF USED("crGrdItP") AND !EOF("crGrdItP") AND RECCOUNT("crGrdItP") > 0
1834:                 SELECT crGrdItP
1835:                 DELETE
1836:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
1837:             ENDIF
1838:         CATCH TO loc_oErro
1839:             MostrarErro("Erro ao excluir produto:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdProdExcluirClick")
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * GrdMetaExcluirClick - Exclui linha corrente do grid de Metas
1845:     * Original: btnExcM.Click -> marca como deletado no crGrdItM
1846:     *==========================================================================
1847:     PROCEDURE GrdMetaExcluirClick()
1848:         TRY
1849:             IF USED("crGrdItM") AND !EOF("crGrdItM") AND RECCOUNT("crGrdItM") > 0
1850:                 SELECT crGrdItM
1851:                 DELETE
1852:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
1853:             ENDIF
1854:         CATCH TO loc_oErro
1855:             MostrarErro("Erro ao excluir meta:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdMetaExcluirClick")
1856:         ENDTRY
1857:     ENDPROC
1858: 
1859:     *==========================================================================
1860:     * GrdProdutosAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Produtos
1861:     *==========================================================================
1862:     PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
1863:         LOCAL loc_nPrev
1864:         loc_nPrev = THIS.this_nColPrevProd
1865:         THIS.this_nColPrevProd = par_nColIndex
1866:         TRY

*-- Linhas 1898 a 1916:
1898:             loc_oBusca.Show()
1899:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMercs")
1900:                 loc_cMercs = ALLTRIM(cursor_4c_BuscaMercs.Codigos)
1901:                 SELECT crGrdItP
1902:                 IF loc_cMercs <> loc_cMercsAnterior
1903:                     REPLACE crGrdItP.Mercs WITH loc_cMercs
1904:                     REPLACE crGrdItP.CGrus WITH ""
1905:                     REPLACE crGrdItP.SGrus WITH ""
1906:                 ELSE
1907:                     REPLACE crGrdItP.Mercs WITH loc_cMercs
1908:                 ENDIF
1909:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
1910:             ENDIF
1911:             loc_oBusca = .NULL.
1912:         ENDIF
1913:     ENDPROC
1914: 
1915:     *==========================================================================
1916:     * AbrirLookupCGrusProd - Lookup de Grupo de Produto no grid Produtos

*-- Linhas 1936 a 1954:
1936:             loc_oBusca.mAddColuna("Mercs",  "@!",  "Grande Grupo")
1937:             loc_oBusca.Show()
1938:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCGrus")
1939:                 SELECT crGrdItP
1940:                 REPLACE crGrdItP.CGrus WITH ALLTRIM(cursor_4c_BuscaCGrus.CGrus)
1941:                 REPLACE crGrdItP.SGrus WITH ""
1942:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
1943:             ENDIF
1944:             loc_oBusca = .NULL.
1945:         ENDIF
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     * AbrirLookupSGrusProd - Lookup de SubGrupo no grid Produtos
1950:     *==========================================================================
1951:     PROCEDURE AbrirLookupSGrusProd()
1952:         LOCAL loc_oBusca, loc_cFiltro, loc_cCGrus
1953:         IF !USED("crGrdItP") OR EOF("crGrdItP")
1954:             RETURN

*-- Linhas 1969 a 2045:
1969:             loc_oBusca.mAddColuna("CGrus",      "@!", "Grupo")
1970:             loc_oBusca.Show()
1971:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGrus")
1972:                 SELECT crGrdItP
1973:                 REPLACE crGrdItP.SGrus WITH ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
1974:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
1975:             ENDIF
1976:             loc_oBusca = .NULL.
1977:         ENDIF
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * AutoAddLinhaGrdProd - Insere nova linha vazia no grid Produtos se necessario
1982:     *==========================================================================
1983:     PROCEDURE AutoAddLinhaGrdProd()
1984:         LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
1985:         IF !USED("crGrdItP") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
1986:             RETURN
1987:         ENDIF
1988:         loc_lTemDados = .F.
1989:         loc_lTemVazia = .F.
1990:         loc_cPkCab    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1991:         SELECT crGrdItP
1992:         GO TOP
1993:         DO WHILE !EOF("crGrdItP")
1994:             IF !DELETED()
1995:                 IF EMPTY(ALLTRIM(crGrdItP.Mercs))
1996:                     loc_lTemVazia = .T.
1997:                 ELSE
1998:                     loc_lTemDados = .T.
1999:                 ENDIF
2000:             ENDIF
2001:             SKIP
2002:         ENDDO
2003:         IF loc_lTemDados AND !loc_lTemVazia
2004:             SELECT crGrdItP
2005:             INSERT INTO crGrdItP (Tipos, pkChaves, fkChaves, Mercs, CGrus, SGrus, PPctFixs) ;
2006:                 VALUES ("PRO", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, "", "", "", 0)
2007:             THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
2008:         ENDIF
2009:     ENDPROC
2010: 
2011:     *==========================================================================
2012:     * GrdVendedoresAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Vendedores
2013:     *==========================================================================
2014:     PROCEDURE GrdVendedoresAfterRowColChange(par_nColIndex)
2015:         LOCAL loc_nPrev
2016:         loc_nPrev = THIS.this_nColPrevVend
2017:         THIS.this_nColPrevVend = par_nColIndex
2018:         TRY
2019:             DO CASE
2020:                 CASE loc_nPrev = 1
2021:                     THIS.AbrirLookupCodVens()
2022:                 CASE loc_nPrev = 2
2023:                     IF USED("crGrdItV") AND !EOF("crGrdItV")
2024:                         SELECT crGrdItV
2025:                         REPLACE crGrdItV.VMetas WITH ABS(crGrdItV.VMetas)
2026:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
2027:                     ENDIF
2028:                 CASE loc_nPrev = 3
2029:                     IF USED("crGrdItV") AND !EOF("crGrdItV")
2030:                         SELECT crGrdItV
2031:                         REPLACE crGrdItV.SalBases WITH ABS(crGrdItV.SalBases)
2032:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
2033:                     ENDIF
2034:                 CASE loc_nPrev = 4
2035:                     THIS.AbrirLookupCodResps()
2036:                 CASE (loc_nPrev = 5 OR loc_nPrev = 6) AND par_nColIndex = 1
2037:                     THIS.AutoAddLinhaGrdVend()
2038:             ENDCASE
2039:         CATCH TO loc_oErro
2040:             MostrarErro("Erro no grid Vendedores:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdVendedoresAfterRowColChange")
2041:         ENDTRY
2042:     ENDPROC
2043: 
2044:     *==========================================================================
2045:     * AbrirLookupCodVens - Lookup de Vendedor no grid Vendedores

*-- Linhas 2065 a 2083:
2065:             loc_oBusca.mAddColuna("RCLis",  "!",  "Nome")
2066:             loc_oBusca.Show()
2067:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVens")
2068:                 SELECT crGrdItV
2069:                 REPLACE crGrdItV.CodVens WITH ALLTRIM(cursor_4c_BuscaVens.IClis)
2070:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
2071:             ENDIF
2072:             loc_oBusca = .NULL.
2073:         ENDIF
2074:     ENDPROC
2075: 
2076:     *==========================================================================
2077:     * AbrirLookupCodResps - Lookup de Responsavel no grid Vendedores
2078:     *==========================================================================
2079:     PROCEDURE AbrirLookupCodResps()
2080:         LOCAL loc_oBusca, loc_cFiltro, loc_cGrpV, loc_cGrpR
2081:         IF !USED("crGrdItV") OR EOF("crGrdItV")
2082:             RETURN
2083:         ENDIF

*-- Linhas 2097 a 2229:
2097:             loc_oBusca.mAddColuna("RCLis",  "!",  "Nome")
2098:             loc_oBusca.Show()
2099:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaResps")
2100:                 SELECT crGrdItV
2101:                 REPLACE crGrdItV.CodResps WITH ALLTRIM(cursor_4c_BuscaResps.IClis)
2102:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
2103:             ENDIF
2104:             loc_oBusca = .NULL.
2105:         ENDIF
2106:     ENDPROC
2107: 
2108:     *==========================================================================
2109:     * AutoAddLinhaGrdVend - Insere nova linha vazia no grid Vendedores se necessario
2110:     *==========================================================================
2111:     PROCEDURE AutoAddLinhaGrdVend()
2112:         LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
2113:         IF !USED("crGrdItV") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
2114:             RETURN
2115:         ENDIF
2116:         loc_lTemDados = .F.
2117:         loc_lTemVazia = .F.
2118:         loc_cPkCab    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
2119:         SELECT crGrdItV
2120:         GO TOP
2121:         DO WHILE !EOF("crGrdItV")
2122:             IF !DELETED()
2123:                 IF EMPTY(ALLTRIM(crGrdItV.CodVens))
2124:                     loc_lTemVazia = .T.
2125:                 ELSE
2126:                     loc_lTemDados = .T.
2127:                 ENDIF
2128:             ENDIF
2129:             SKIP
2130:         ENDDO
2131:         IF loc_lTemDados AND !loc_lTemVazia
2132:             SELECT crGrdItV
2133:             INSERT INTO crGrdItV (Tipos, pkChaves, fkChaves, CodVens, VMetas, SalBases, CodResps, RPctFixs, VMetItns) ;
2134:                 VALUES ("VEN", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, "", 0, 0, "", 0, 0)
2135:             THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
2136:         ENDIF
2137:     ENDPROC
2138: 
2139:     *==========================================================================
2140:     * GrdMetasAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Metas
2141:     *==========================================================================
2142:     PROCEDURE GrdMetasAfterRowColChange(par_nColIndex)
2143:         LOCAL loc_nPrev
2144:         loc_nPrev = THIS.this_nColPrevMeta
2145:         THIS.this_nColPrevMeta = par_nColIndex
2146:         TRY
2147:             DO CASE
2148:                 CASE loc_nPrev = 2
2149:                     IF USED("crGrdItM") AND !EOF("crGrdItM")
2150:                         SELECT crGrdItM
2151:                         REPLACE crGrdItM.FxaInis WITH ABS(crGrdItM.FxaInis)
2152:                         THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
2153:                     ENDIF
2154:                 CASE loc_nPrev = 3
2155:                     THIS.ValidarFxaFims()
2156:                 CASE (loc_nPrev = 4 OR loc_nPrev = 5) AND par_nColIndex = 1
2157:                     THIS.AutoAddLinhaGrdMeta()
2158:             ENDCASE
2159:         CATCH TO loc_oErro
2160:             MostrarErro("Erro no grid Metas:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdMetasAfterRowColChange")
2161:         ENDTRY
2162:     ENDPROC
2163: 
2164:     *==========================================================================
2165:     * ValidarFxaFims - Valida que FxaFims > FxaInis no grid Metas
2166:     *==========================================================================
2167:     PROCEDURE ValidarFxaFims()
2168:         IF !USED("crGrdItM") OR EOF("crGrdItM")
2169:             RETURN
2170:         ENDIF
2171:         SELECT crGrdItM
2172:         IF crGrdItM.FxaFims <= crGrdItM.FxaInis AND crGrdItM.FxaFims <> 0
2173:             MsgAviso("Faixa Final deve ser maior que Faixa Inicial.", "Comiss" + CHR(245) + "es")
2174:             REPLACE crGrdItM.FxaFims WITH 0
2175:             THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
2176:         ENDIF
2177:     ENDPROC
2178: 
2179:     *==========================================================================
2180:     * AutoAddLinhaGrdMeta - Insere nova linha no grid Metas com renumeracao
2181:     *==========================================================================
2182:     PROCEDURE AutoAddLinhaGrdMeta()
2183:         LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
2184:         LOCAL loc_nProxFaixa, loc_nUltFxaFims, loc_nCodFaixa
2185:         IF !USED("crGrdItM") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
2186:             RETURN
2187:         ENDIF
2188:         loc_lTemDados  = .F.
2189:         loc_lTemVazia  = .F.
2190:         loc_cPkCab     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
2191:         loc_nProxFaixa = 0
2192:         loc_nUltFxaFims= 0
2193:         loc_nCodFaixa  = 0
2194:         SELECT crGrdItM
2195:         GO TOP
2196:         DO WHILE !EOF("crGrdItM")
2197:             IF !DELETED()
2198:                 IF crGrdItM.FxaInis = 0 AND crGrdItM.FxaFims = 0
2199:                     loc_lTemVazia = .T.
2200:                 ELSE
2201:                     loc_lTemDados   = .T.
2202:                     IF crGrdItM.FxaFims > loc_nUltFxaFims
2203:                         loc_nUltFxaFims = crGrdItM.FxaFims
2204:                     ENDIF
2205:                     IF crGrdItM.CodFaixas > loc_nCodFaixa
2206:                         loc_nCodFaixa = crGrdItM.CodFaixas
2207:                     ENDIF
2208:                 ENDIF
2209:             ENDIF
2210:             SKIP
2211:         ENDDO
2212:         IF loc_lTemDados AND !loc_lTemVazia
2213:             loc_nProxFaixa = loc_nUltFxaFims
2214:             INSERT INTO crGrdItM (Tipos, pkChaves, fkChaves, CodFaixas, FxaInis, FxaFims, Bonus) ;
2215:                 VALUES ("MET", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, loc_nCodFaixa + 1, loc_nProxFaixa, 0, 0)
2216:             THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
2217:         ENDIF
2218:     ENDPROC
2219: 
2220:     *==========================================================================
2221:     * Destroy - Libera recursos ao fechar o formulario
2222:     *==========================================================================
2223:     PROCEDURE Destroy()
2224:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2225:             THIS.this_oBusinessObject.FecharCursores()
2226:             THIS.this_oBusinessObject = .NULL.
2227:         ENDIF
2228:         DODEFAULT()
2229:     ENDPROC


### BO (C:\4c\projeto\app\classes\COMBO.prg):
*==============================================================================
* COMBO.prg - Business Object para Cadastro de Comissoes
* Tabela principal: SigCmCab (cabecalho)
* Tabela detalhe:   SigCmItn (itens: PRO=Produtos, VEN=Vendedores, MET=Metas)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS COMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCmCab (cabecalho)
    *--------------------------------------------------------------------------
    this_cCodigo    = ""    && pkchaves char(20) - PK (GUID)
    this_cDescricao = ""    && cods     char(40) - Descricao da comissao
    this_cEmps      = ""    && emps     char(3)  - Codigo empresa
    this_dDtInicio  = {}    && dtinis   datetime - Data inicio vigencia
    this_dDtFim     = {}    && dtfims   datetime - Data fim vigencia
    this_nMetaEmps  = 0     && metaemps numeric(15,2) - Meta da empresa
    this_nPctVd1    = 0     && pctvd1   numeric(5,2)  - % vendedor 1
    this_nPctVd2    = 0     && pctvd2   numeric(5,2)  - % vendedor 2
    this_cMoedas    = ""    && moedas   char(3)  - Codigo moeda
    this_cCodGerente = ""   && CodGerente char(10) - Codigo gerente

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de descricao (lookup display)
    *--------------------------------------------------------------------------
    this_cDEmps      = ""   && Descricao da empresa (SigCdEmp.Razas)
    this_cDMoedas    = ""   && Descricao da moeda   (SigCdMoe.DMoes)
    this_cGrPadVens  = ""   && Grupo padrao vendedores (config geral)
    this_cGrPadRess  = ""   && Grupo padrao responsaveis (config geral)
    this_cGrPadGers  = ""   && Grupo padrao gerentes (config geral)

    *--------------------------------------------------------------------------
    * Propriedade herdada obrigatoria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCmCab"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro COMBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigCmCab com filtro opcional por descricao
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       loc_cWhere + ;
                       " ORDER BY a.cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo pkchaves e itens dos cursores
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCodigo) <> "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas, ISNULL(c.DMoes, '') AS DMoes" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       " LEFT JOIN SigCdMoe c ON c.CMoes = a.moedas" + ;
                       " WHERE a.pkchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarItens(par_cCodigo)
                ENDIF
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(pkchaves,   "C")
            THIS.this_cDescricao = TratarNulo(cods,       "C")
            THIS.this_cEmps      = TratarNulo(emps,       "C")
            THIS.this_dDtInicio  = TratarNulo(dtinis,     "D")
            THIS.this_dDtFim     = TratarNulo(dtfims,     "D")
            THIS.this_nMetaEmps  = TratarNulo(metaemps,   "N")
            THIS.this_nPctVd1    = TratarNulo(pctvd1,     "N")
            THIS.this_nPctVd2    = TratarNulo(pctvd2,     "N")
            THIS.this_cMoedas    = TratarNulo(moedas,     "C")
            THIS.this_cCodGerente = TratarNulo(CodGerente, "C")
            IF TYPE(par_cAliasCursor + ".Razas") = "C"
                THIS.this_cDEmps   = TratarNulo(Razas,  "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDMoedas = TratarNulo(DMoes,  "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega cursores crGrdItP, crGrdItV, crGrdItM do banco
    *==========================================================================
    PROCEDURE CarregarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult

        TRY
            *-- Cursor de Produtos (PRO)
            IF USED("crGrdItP")
                ZAP IN crGrdItP
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT mercs, cgrus, sgrus, ppctfixs, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'PRO'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItP")
                TABLEREVERT(.T., "cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItP")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItP") > 0
                SELECT crGrdItP
                APPEND FROM DBF("cursor_4c_ItP")
                GO TOP IN crGrdItP
            ENDIF
            IF USED("cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            *-- Cursor de Vendedores (VEN)
            IF USED("crGrdItV")
                ZAP IN crGrdItV
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codvens, vmetas, salbases, codresps, rpctfixs, fkchaves, pkchaves, tipos, vmetitns" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'VEN'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItV")
                TABLEREVERT(.T., "cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItV")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItV") > 0
                SELECT crGrdItV
                APPEND FROM DBF("cursor_4c_ItV")
                GO TOP IN crGrdItV
            ENDIF
            IF USED("cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            *-- Cursor de Metas (MET)
            IF USED("crGrdItM")
                ZAP IN crGrdItM
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codfaixas, fxainis, fxafims, pctfaixas, bonus, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'MET' ORDER BY codfaixas"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItM")
                TABLEREVERT(.T., "cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItM")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItM") > 0
                SELECT crGrdItM
                APPEND FROM DBF("cursor_4c_ItM")
                GO TOP IN crGrdItM
            ENDIF
            IF USED("cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarItens - Grava cursores crGrdItP/crGrdItV/crGrdItM em SigCmItn
    *==========================================================================
    PROTECTED PROCEDURE SalvarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult, loc_cPk

        *-- Apaga itens anteriores
        loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResult < 0
            MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            RETURN
        ENDIF

        *-- Salva Produtos (PRO)
        IF USED("crGrdItP")
            SELECT crGrdItP
            GO TOP IN crGrdItP
            SCAN FOR !DELETED()
                IF !EMPTY(ALLTRIM(crGrdItP.Mercs)) OR !EMPTY(ALLTRIM(crGrdItP.CGrus))
                    loc_cPk = crGrdItP.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'PRO', " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.Mercs)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.CGrus)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.SGrus)) + ", " + ;
                               FormatarNumeroSQL(crGrdItP.PPctFixs) + ", " + ;
                               "'', 0, 0, '', 0, 0, NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Vendedores (VEN)
        IF USED("crGrdItV")
            SELECT crGrdItV
            GO TOP IN crGrdItV
            SCAN FOR !DELETED()
                IF !EMPTY(ALLTRIM(crGrdItV.CodVens))
                    loc_cPk = crGrdItV.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'VEN', " + ;
                               "'', '', '', 0, " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodVens)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetas) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.SalBases) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodResps)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.RPctFixs) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetItns) + ", " + ;
                               "NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Metas (MET)
        IF USED("crGrdItM")
            SELECT crGrdItM
            GO TOP IN crGrdItM
            SCAN FOR !DELETED()
                IF crGrdItM.FxaInis + crGrdItM.FxaFims > 0
                    loc_cPk = crGrdItM.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'MET', " + ;
                               "'', '', '', 0, '', 0, 0, '', 0, 0, " + ;
                               FormatarNumeroSQL(crGrdItM.CodFaixas) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.FxaInis) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.FxaFims) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.PctFaixas) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.Bonus) + ", " + ;
                               "'', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigCmCab e itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cPk
        loc_lResultado = .F.

        TRY
            loc_cPk = fUniqueIds()
            THIS.this_cCodigo = loc_cPk

            loc_cSQL = "INSERT INTO sigcmcab" + ;
                       " (pkchaves, cods, emps, dtinis, dtfims, metaemps," + ;
                       "  pctvd1, pctvd2, moedas, CodGerente, usuars, usualts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPk) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(loc_cPk)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCmCab + re-insere itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigcmcab SET" + ;
                       " cods = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       " emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       " dtfims = " + FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       " metaemps = " + FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       " pctvd1 = " + FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       " pctvd2 = " + FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       " moedas = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       " CodGerente = " + EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       " usualts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigCmCab e SigCmItn
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM sigcmcab WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InicializarCursores - Cria cursores vazios para as grades de itens
    *==========================================================================
    PROCEDURE InicializarCursores()
        TRY
            IF !USED("crGrdItP")
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItP
            ENDIF

            IF !USED("crGrdItV")
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItV
            ENDIF

            IF !USED("crGrdItM")
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.InicializarCursores: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores de itens ao destruir o BO
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("crGrdItP")
            USE IN crGrdItP
        ENDIF
        IF USED("crGrdItV")
            USE IN crGrdItV
        ENDIF
        IF USED("crGrdItM")
            USE IN crGrdItM
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarConfigGeral - Carrega grupos padrao de vendedores/responsaveis
    *==========================================================================
    PROCEDURE CarregarConfigGeral()
        LOCAL loc_cSQL, loc_nResult

        TRY
            loc_cSQL = "SELECT TOP 1 GrPadVens, GrPadRess, GrPadGers" + ;
                       " FROM SigCdCfg WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cfg")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Cfg") > 0
                GO TOP IN cursor_4c_Cfg
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_Cfg.GrPadVens)
                THIS.this_cGrPadRess = ALLTRIM(cursor_4c_Cfg.GrPadRess)
                THIS.this_cGrPadGers = ALLTRIM(cursor_4c_Cfg.GrPadGers)
            ENDIF
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarConfigGeral: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

