# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ROWSOURCETYPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VERM, NMCAMPO, NSELPOSI, I, CKOUTRPT, CKFILTRO, CCMD, NSELPOSF, CLETRA, RPT_ID, PKCHAVES, PROGRAMAS, TVFONTSTYLE, LCIIF, LNCOUNT, NMREPORT, CODIGOS, LLRPT_D, PCESCOLHA, DISABLEDPICTURE, OBJECT_ID, NSELPOSA, NSHIFT, CKTOTAL, NWIDTH, NHEIGHT, OBJTYPE, COMMENT

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
  ControlSource = "_vp_DtInicial"
  ControlSource = "_vp_DtFinal"
	Select crSIGCDRLC
	Select crSIGCDRLC
Select Crs_RPT_C
	Select crSIGCDRLC
	Select crSIGCDRLC
Select CrsProps_Grupo
Select CrsProps_Titulo
Select 0
Select CrsTmpFRX
			Select CrsProps_Titulo
			Select CrsProps_Titulo
			Select CrsProps_Campos
				Select CrsTmp_LstCmps
			Select CrsProps_Grupo
	Store This.Pagina.Dados.pageframe1.Page1.OleRTF_SqlCMD.GetLineFromChar( _oRTF.nSelPosA ) To _oRTF.nLineI, _oRTF.nLineFromChar
			_oRTF.nLineFromChar = This.Pagina.Dados.pageframe1.Page1.OleRTF_SqlCMD.GetLineFromChar( _oRTF.nSelPosI )
			If _oRTF.nLineFromChar # _oRTF.nLineI 
		Select Crs_RPT_C
		Insert Into TmpCdRlc ( RPT_ID, DtCad, NmReport, Ativo ) Values( Crs_RPT_C.RPT_ID, Crs_RPT_C.DtCad, Crs_RPT_C.NmReport, Crs_RPT_C.Ativo )	
			Insert SIGCDPRG ( BarraForms, BarraPict, Descricaos, Parametros, Programas, PkChaves ) 
		If Thisform.podatamgr.SqlExecute(lcSQL) < 1
		Select 0
			Select TmpCdRld
		Select CrsProps_Campos
			Select TmpCdRld
aLstCMDs[01] = "SELECT"
aLstCMDs[03] = "FROM"
aLstCMDs[20] = "JOIN"
aLstCMDs[22] = "INSERT"
aLstCMDs[23] = "UPDATE"
	Select CrsProps_Titulo
	ThisForm.Pagina.Dados.pageframe1.Page2.Cbo_TamPapel.ControlSource 	   = "CrsProps_Titulo.PaperSize"
	ThisForm.Pagina.Dados.pageframe1.Page2.OptGrp_Orientacao.ControlSource = "CrsProps_Titulo.Orientation"
	Select CrsProps_Grupo
		Select CrsTmp_LstCmps
	Select CrsProps_Campos
Store 0 To _oRTF.nLineI, _oRTF.nLineFromChar
	Select crSIGCDRLC
	Select crSIGCDRLC
Select Crs_RPT_C
	Select crSIGCDRLC
If Thisform.podatamgr.SqlExecute([Delete From SIGCDRLC Where RPT_ID = ?lcRPT_ID]) <= 0
If Thisform.podatamgr.SqlExecute([Delete From SIGCDRLD Where RPT_ID = ?lcRPT_ID]) <= 0
If Thisform.podatamgr.SqlExecute([Delete From SIGCDPRG Where PkChaves = '3RPTCUSTOM] + lcRPT_ID + ['] ) <= 0
If Thisform.podatamgr.SqlExecute([Delete From SIGCDACU Where Programas = ?lcRPT_ID]) <= 0
If Thisform.podatamgr.SqlExecute([Select * From SIGCDRLC], [CrsTmp_RPT]) <= 0
	Select crSIGCDRLC
	MessageBox( "Problemas no Select do cursor CrsTmp_RPT:"+Chr(13)+ laError[2], 48, "Atenção" )
	Select * From CrsTmp_RPT Into Cursor Crs_RPT_C ReadWrite
	Select crSIGCDRLC
	MessageBox( "Problemas no Select do cursor CrsTmp_RPT (2)", 48, "Atenção" )
Select crSIGCDRLC
	Select crSIGCDRLC
		Select CrsTmp_SqlResult
		Select 0
		If Thisform.podatamgr.SqlExecute( .oTabelaPadrao.cStrQuery, .oTabelaPadrao.cNomeCursor ) > 0
			Select (.oTabelaPadrao.cNomeCursor)
			MessageBox( "Problemas no Select do cursor " + .oTabelaPadrao.cNomeCursor +":"+ Chr(13) + laError[2], 48, "Atenção" )
lcCrs = Left( toCol.ControlSource, At( ".", toCol.ControlSource )-1 )
lcCmp = AllTrim( toCol.ControlSource )
Select &lcCrs.
Lparameters taMenu,tcOnSelection
Local lcOnSelection, lnMenuCount, lnCount, llDoubleArray
Local lcMenuItem, lcMenuSelection
	FROM Mrow(),Mcol() ;
On Selection Popup _popShortcutMenu Deactivate Popup _popShortcutMenu
	lcMenuSelection=taMenu[BAR(),2]
	If Not Empty( lcMenuSelection ) And Type( "lcMenuSelection" ) == "C"
		lcOnSelection = Alltrim( lcMenuSelection )
	If Empty( lcOnSelection )
		lcOnSelection = Alltrim( Iif( Empty( tcOnSelection ), "", tcOnSelection ) )
	lcOnSelection = Alltrim( Iif( Empty( tcOnSelection ), "", tcOnSelection ) )
If Empty( lcOnSelection )
&lcOnSelection
		Select Crs_RPT_C
			If Thisform.podatamgr.SqlExecute(lcSqlQuery, [CrsTmp_SqlResult] ) < 1
				MessageBox( "Problemas no Select :"+laError[2], 64, "Atenção" )
				Select CrsTmp_SqlResult
	Select crSIGCDRLC
Select crSigPrCpl
	If Not ThisForm.poDataMgr.Update('TmpCdRlc')
	If Not ThisForm.poDataMgr.Update('TmpCdRld')
Select Crs_RPT_C
	Select crSIGCDRLC
	If (ThisForm.poDataMgr.SQLExecute([Delete From SIGCDRLC Where RPT_ID = ?lcRPT_ID], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SIGCDRLD Where RPT_ID = ?lcRPT_ID], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SIGCDPRG Where PkChaves = '3RPTCUSTOM] + lcRPT_ID + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SIGCDACU Where Programas = ?lcRPT_ID], '') < 1)
If Thisform.podatamgr.SqlExecute([Select * From SIGCDRLC], [Crs_RPT_C]) < 1
	Select crSIGCDRLC
Select crSIGCDRLC
If Thisform.podatamgr.SqlExecute([Delete From SIGCDRLC Where RPT_ID = ?lcReport_ID]) < 1
	If Thisform.podatamgr.SqlExecute([Delete From SIGCDRLD Where RPT_ID = ?lcReport_ID]) < 1
	If Not ThisForm.poDataMgr.Update('TmpCdRlc')
	If Not ThisForm.poDataMgr.Update('TmpCdRld')
This.oTabelaPadrao.AddProperty( "cStrQuery", 	  " Select Substring( NmReport, 1, 50 ) As NmReport, Substring( Descr, 1, 100 ) As Descr, RPT_ID From SIGCDRLC " )
			Select crSIGCDRLC
		Select crSIGCDRLC
_oRTF.AddProperty( "nLineFromChar", 0 )
If Thisform.podatamgr.SqlExecute([Select Upper(Name) As NmTable, Object_ID, Modify_Date From Sys.Tables Order By Name], [CrsTmp_Tables] ) <= 0
Select CrsTmp_Tables
If Thisform.podatamgr.SqlExecute([Select * From SIGCDRLC], [Crs_RPT_C] ) < 1
If Thisform.podatamgr.SqlExecute([Select Top 1 * From SIGCDRLD], [Crs_RPT_D]) < 1
Select TmpCdRlc
Select TmpCdRld
		Select Crs_RPT_C
		Select CrsTmp_SqlResult
				Select CrsProps_Titulo
				Select CrsProps_Grupo
					Select CrsProps_Campos
						Select CrsTmp_LstCmps
				Select CrsProps_Campos
		Select Crs_RPT_C				
	Select CrsTmp_SqlResult
	Select 0
	Select crSIGCDRLC
Select Crs_RPT_C
	Select crSIGCDRLC
	Select crSIGCDRLC
	Select crSIGCDRLC
Select Crs_RPT_C
Select * From Crs_RPT_C Where Crs_RPT_C.RPT_ID = lcRPT_ID Into Table ( ".\Tmp\" + lcNmArqExp + ".Dbf" )
Select 0
Select crSIGCDRLC
Select 0
Select Crs_RPT_C
Select Crs_RPT_C
Select 0
lc_SQL = "Select c.Column_ID, c.Name As Column_Name, t.Name As Type, c.Max_Length, " +;
"From sys.all_Columns c " + Chr(13) +;
"Join sys.types t ON t.System_Type_ID = c.System_Type_ID " + Chr(13) +;
If Thisform.podatamgr.SqlExecute(lc_SQL, [CrsTmp_SqlResult]) < 1
	Select CrsTmp_SqlResult
	Select CrsTmp_SqlResult
		Select Crs_RPT_C
	Select CrsTmp_SqlResult
	Select 0
		Store This.GetLineFromChar( _oRTF.nSelPosA ) To _oRTF.nLineI, _oRTF.nLineFromChar
				_oRTF.nLineFromChar = This.GetLineFromChar( _oRTF.nSelPosF )
				If _oRTF.cLetra == " " OR _oRTF.cLetra == "(" OR _oRTF.cLetra == "[" OR _oRTF.cLetra == "{" OR _oRTF.nLineI # _oRTF.nLineFromChar 
Store This.GetLineFromChar( _oRTF.nSelPosA ) To _oRTF.nLineI, _oRTF.nLineFromChar
		_oRTF.nLineFromChar = This.GetLineFromChar( _oRTF.nSelPosF )
	_oRTF.nLineFromChar = This.GetLineFromChar( _oRTF.nSelPosI )
	If _oRTF.nLineFromChar # _oRTF.nLineI 
		Select CrsTmp_SqlResult
		Select Crs_RPT_C
Select CrsProps_Campos
Select CrsProps_Grupo
Select CrsTmp_SqlResult
Select CrsProps_Campos
Select * From TmpCabPadrao where objtype not in (1,9) into table TmpRelat readwrite
Select TmpRelat
Select JustStem( loReport.cReportFile )
Append From TmpRelat
Delete file TmpRelat.*
	Select CrsTmp_SqlResult

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS SQL (2830 linhas total):

*-- Linhas 366 a 384:
366:                 .HighlightBackColor = RGB(255, 255, 255)
367:                 .HighlightForeColor = RGB(15, 41, 104)
368:                 .HighlightStyle     = 2
369:                 .DeleteMark         = .F.
370:                 .RecordMark         = .F.
371:                 .RowHeight          = 16
372:                 .ScrollBars         = 2
373:                 .GridLines          = 3
374:                 .ColumnCount        = 5
375:                 .Visible            = .T.
376:             ENDWITH
377: 
378:             THIS.TornarControlesVisiveis(loc_oPagina)
379:         CATCH TO loc_oErro
380:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
381:         ENDTRY
382:     ENDPROC
383: 
384:     *==========================================================================

*-- Linhas 911 a 929:
911:                 .HighlightBackColor = RGB(255, 255, 255)
912:                 .HighlightForeColor = RGB(15, 41, 104)
913:                 .HighlightStyle     = 2
914:                 .DeleteMark         = .F.
915:                 .RecordMark         = .F.
916:                 .RowHeight          = 16
917:                 .ScrollBars         = 3
918:                 .GridLines          = 3
919:                 .ColumnCount        = 0
920:                 .ReadOnly           = .T.
921:                 .Visible            = .T.
922:             ENDWITH
923:         CATCH TO loc_oErro
924:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
925:         ENDTRY
926:     ENDPROC
927: 
928:     *==========================================================================
929:     * CarregarLista - Carrega lista de relatorios no grid

*-- Linhas 942 a 964:
942: 
943:                     loc_oGrid.ColumnCount = 5
944:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
945:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
946:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
947:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
948:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
949:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
950: 
951:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
952:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
953:                     loc_oGrid.Column2.Header1.Caption = "Descr"
954:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
955:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
956:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
957: 
958:                     loc_oGrid.Column1.Width = 350
959:                     loc_oGrid.Column2.Width = 350
960:                     loc_oGrid.Column3.Width = 90
961:                     loc_oGrid.Column4.Width = 90
962:                     loc_oGrid.Column5.Width = 50
963: 
964:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1031 a 1049:
1031:             ENDIF
1032: 
1033:             IF loc_lProsseguir
1034:                 SELECT cursor_4c_Dados
1035:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1036: 
1037:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1038:                     THIS.this_pcEscolha  = "CONSULTAR"
1039:                     THIS.this_cModoAtual = "VISUALIZAR"
1040:                     THIS.BOParaForm()
1041:                     THIS.ConfigurarModoEditor(.T.)
1042:                     THIS.AlternarPagina(2)
1043:                 ELSE
1044:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1045:                 ENDIF
1046:             ENDIF
1047:         CATCH TO loc_oErro
1048:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarClick")
1049:         ENDTRY

*-- Linhas 1063 a 1081:
1063:             ENDIF
1064: 
1065:             IF loc_lProsseguir
1066:                 SELECT cursor_4c_Dados
1067:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1068: 
1069:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1070:                     THIS.this_oBusinessObject.EditarRegistro()
1071:                     THIS.this_pcEscolha  = "ALTERAR"
1072:                     THIS.this_cModoAtual = "ALTERAR"
1073:                     THIS.BOParaForm()
1074:                     THIS.ConfigurarModoEditor(.F.)
1075:                     THIS.AlternarPagina(2)
1076:                 ELSE
1077:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1078:                 ENDIF
1079:             ENDIF
1080:         CATCH TO loc_oErro
1081:             MsgErro(loc_oErro.Message, "FormRPT.BtnAlterarClick")

*-- Linhas 1096 a 1114:
1096:             ENDIF
1097: 
1098:             IF loc_lProsseguir
1099:                 SELECT cursor_4c_Dados
1100:                 loc_cRptId    = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1101:                 loc_cNmReport = ALLTRIM(NVL(cursor_4c_Dados.NmReport, ""))
1102: 
1103:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do relat" + CHR(243) + "rio:" + ;
1104:                                CHR(13) + loc_cNmReport + "?", ;
1105:                                "Confirmar Exclus" + CHR(227) + "o")
1106: 
1107:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1108:                         IF THIS.this_oBusinessObject.Excluir()
1109:                             MsgInfo("Relat" + CHR(243) + "rio exclu" + CHR(237) + "do com sucesso!")
1110:                             THIS.CarregarLista()
1111:                         ELSE
1112:                             MsgErro("Erro ao excluir relat" + CHR(243) + "rio.", "Erro")
1113:                         ENDIF
1114:                     ELSE

*-- Linhas 1136 a 1158:
1136: 
1137:                     loc_oGrid.ColumnCount = 5
1138:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1139:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
1140:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
1141:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
1142:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1143:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1144: 
1145:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
1146:                     loc_oGrid.Column2.Header1.Caption = "Descr"
1147:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
1148:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
1149:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1150: 
1151:                     loc_oGrid.Column1.Width = 350
1152:                     loc_oGrid.Column2.Width = 350
1153:                     loc_oGrid.Column3.Width = 90
1154:                     loc_oGrid.Column4.Width = 90
1155:                     loc_oGrid.Column5.Width = 50
1156: 
1157:                     THIS.FormatarGridLista(loc_oGrid)
1158:                     loc_oGrid.Refresh()

*-- Linhas 1235 a 1267:
1235:                     USE IN cursor_4c_SqlResultTemp
1236:                 ENDIF
1237: 
1238:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")
1239: 
1240:                 IF loc_nResultado >= 0
1241:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResultTemp")
1242:                     SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
1243:                     IF USED("cursor_4c_SqlResultTemp")
1244:                         USE IN cursor_4c_SqlResultTemp
1245:                     ENDIF
1246: 
1247:                     loc_oGrid.ColumnCount = 3
1248:                     loc_oGrid.RecordSource = "cursor_4c_SqlResult"
1249:                     loc_oGrid.ColumnCount  = loc_nCols
1250: 
1251:                     FOR loc_nI = 1 TO loc_nCols
1252:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1253:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1254:                         loc_oGrid.Columns(loc_nI).Width = 100
1255:                     ENDFOR
1256: 
1257:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1258:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1259:                     loc_oGrid.Refresh()
1260: 
1261:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1262:                             " registro(s) retornado(s).")
1263:                 ELSE
1264:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1265:                 ENDIF
1266:             ENDIF
1267:         CATCH TO loc_oErro

*-- Linhas 1307 a 1331:
1307:                     USE IN cursor_4c_SqlResultTemp
1308:                 ENDIF
1309: 
1310:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")
1311: 
1312:                 IF loc_nResultado >= 0
1313:                     IF USED("cursor_4c_SqlResult")
1314:                         USE IN cursor_4c_SqlResult
1315:                     ENDIF
1316:                     SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
1317:                     IF USED("cursor_4c_SqlResultTemp")
1318:                         USE IN cursor_4c_SqlResultTemp
1319:                     ENDIF
1320:                     REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
1321:                 ELSE
1322:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1323:                 ENDIF
1324:             ENDIF
1325:         CATCH TO loc_oErro
1326:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarRptClick")
1327:         ENDTRY
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * BtnLayoutClick - Executa SQL e abre o Designer de Layout

*-- Linhas 1351 a 1410:
1351:                     USE IN cursor_4c_SqlResultTemp
1352:                 ENDIF
1353: 
1354:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResultTemp")
1355: 
1356:                 IF loc_nResultado >= 0
1357:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResultTemp")
1358:                     IF USED("cursor_4c_SqlResult")
1359:                         USE IN cursor_4c_SqlResult
1360:                     ENDIF
1361:                     SELECT * FROM cursor_4c_SqlResultTemp INTO CURSOR cursor_4c_SqlResult READWRITE
1362:                     IF USED("cursor_4c_SqlResultTemp")
1363:                         USE IN cursor_4c_SqlResultTemp
1364:                     ENDIF
1365: 
1366:                     IF loc_nCols = 0
1367:                         MsgAviso("O SQL n" + CHR(227) + "o retornou campos.", "Aten" + CHR(231) + CHR(227) + "o")
1368:                         loc_lProsseguir = .F.
1369:                     ENDIF
1370:                 ELSE
1371:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1372:                     loc_lProsseguir = .F.
1373:                 ENDIF
1374:             ENDIF
1375: 
1376:             IF loc_lProsseguir
1377:                 *-- Cria/recria cursores do designer
1378:                 THIS.CriarCursoresDesigner()
1379: 
1380:                 *-- Popula CrsProps_Titulo com 1 linha de titulo
1381:                 IF USED("CrsProps_Titulo")
1382:                     SELECT CrsProps_Titulo
1383:                     IF RECCOUNT("CrsProps_Titulo") = 0
1384:                         APPEND BLANK
1385:                         REPLACE CrsProps_Titulo.NmCampo    WITH "TITULO"
1386:                         REPLACE CrsProps_Titulo.LblCaption WITH ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
1387:                         REPLACE CrsProps_Titulo.LblFonte   WITH "Arial,12,B"
1388:                         REPLACE CrsProps_Titulo.LblAlinhar WITH "C"
1389:                         REPLACE CrsProps_Titulo.LblTamCmp  WITH 200
1390:                     ENDIF
1391:                 ENDIF
1392: 
1393:                 *-- Popula CrsProps_Campos com um registro por campo do resultado SQL
1394:                 IF USED("CrsProps_Campos")
1395:                     SELECT CrsProps_Campos
1396:                     ZAP
1397:                     FOR loc_nI = 1 TO loc_nCols
1398:                         APPEND BLANK
1399:                         REPLACE CrsProps_Campos.NmCampo    WITH ALLTRIM(laFields[loc_nI, 1])
1400:                         REPLACE CrsProps_Campos.TpCampo    WITH ALLTRIM(laFields[loc_nI, 2])
1401:                         REPLACE CrsProps_Campos.CkOutRPT   WITH 1
1402:                         REPLACE CrsProps_Campos.CkFiltro   WITH 0
1403:                         REPLACE CrsProps_Campos.CkSubTot   WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1404:                         REPLACE CrsProps_Campos.CkTotal    WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1405:                         REPLACE CrsProps_Campos.LblCaption WITH ALLTRIM(laFields[loc_nI, 1])
1406:                         REPLACE CrsProps_Campos.LblFonte   WITH "Arial,9,N"
1407:                         REPLACE CrsProps_Campos.LblAlinhar WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), "R", "L")
1408:                         REPLACE CrsProps_Campos.LblTamCmp  WITH IIF(laFields[loc_nI, 3] > 0, laFields[loc_nI, 3], 10)
1409:                         REPLACE CrsProps_Campos.LblTipoCmp WITH laFields[loc_nI, 2]
1410:                     ENDFOR

*-- Linhas 1538 a 1557:
1538:                 USE IN cursor_4c_ReportNomes
1539:             ENDIF
1540: 
1541:             loc_nRes = SQLEXEC(gnConnHandle, ;
1542:                        "SELECT DISTINCT NmReport FROM SIGCDRLC ORDER BY NmReport", ;
1543:                        "cursor_4c_ReportNomes")
1544: 
1545:             IF loc_nRes >= 0
1546:                 WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
1547:                     .RowSourceType = 2
1548:                     .RowSource     = "cursor_4c_ReportNomes"
1549:                     .BoundColumn   = 1
1550:                     .ColumnCount   = 1
1551:                 ENDWITH
1552:             ENDIF
1553:         CATCH TO loc_oErro
1554:             MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
1555:         ENDTRY
1556:     ENDPROC
1557: 

*-- Linhas 1870 a 1888:
1870:                 .GridLines        = 1
1871:                 .HeaderHeight     = 25
1872:                 .RowHeight        = 30
1873:                 .DeleteMark       = .F.
1874:                 .RecordMark       = .F.
1875:                 .ScrollBars       = 2
1876:                 .Visible          = .T.
1877:             ENDWITH
1878: 
1879:             *- Col1: LblCaption - "Titulo" (EditBox)
1880:             loc_oCol = loc_oGrd.Column1
1881:             loc_oCol.Header1.Caption = "Titulo"
1882:             loc_oCol.Width  = 300
1883:             loc_oCol.Sparse = .F.
1884:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1885:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1886:             WITH loc_oCol.edt_4c_TitCaption
1887:                 .Width      = 298
1888:                 .Height     = 28

*-- Linhas 1967 a 1985:
1967:                 .GridLines        = 1
1968:                 .HeaderHeight     = 25
1969:                 .RowHeight        = 30
1970:                 .DeleteMark       = .F.
1971:                 .RecordMark       = .F.
1972:                 .ScrollBars       = 3
1973:                 .Visible          = .T.
1974:             ENDWITH
1975: 
1976:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1977:             loc_oCol = loc_oGrd.Column1
1978:             loc_oCol.Header1.Caption = "Campo"
1979:             loc_oCol.Width    = 140
1980:             loc_oCol.Sparse   = .F.
1981:             loc_oCol.ReadOnly = .T.
1982:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1983:             loc_oCol.CurrentControl = "txt_4c_NmCampo"
1984:             WITH loc_oCol.txt_4c_NmCampo
1985:                 .Width     = 138

*-- Linhas 2204 a 2222:
2204:                 .GridLines        = 1
2205:                 .HeaderHeight     = 25
2206:                 .RowHeight        = 30
2207:                 .DeleteMark       = .F.
2208:                 .RecordMark       = .F.
2209:                 .ScrollBars       = 2
2210:                 .Visible          = .T.
2211:             ENDWITH
2212: 
2213:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2214:             loc_oCol = loc_oGrd.Column1
2215:             loc_oCol.Header1.Caption = "Grupo"
2216:             loc_oCol.Width  = 200
2217:             loc_oCol.Sparse = .F.
2218:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2219:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2220:             WITH loc_oCol.cbo_4c_NmCampoGRP
2221:                 .Style         = 2
2222:                 .RowSourceType = 1

*-- Linhas 2531 a 2589:
2531:             IF USED("CrsProps_Titulo")
2532:                 USE IN CrsProps_Titulo
2533:             ENDIF
2534:             CREATE CURSOR CrsProps_Titulo ( ;
2535:                 NmCampo    C(40),  ;
2536:                 TpCampo    C(10),  ;
2537:                 CkOutRPT   I,      ;
2538:                 CkFiltro   I,      ;
2539:                 CkSubTot   I,      ;
2540:                 CkTotal    I,      ;
2541:                 LblCaption C(200), ;
2542:                 LblFonte   C(50),  ;
2543:                 LblBtFonte C(1),   ;
2544:                 LblBtCor   I,      ;
2545:                 LblAlinhar C(6),   ;
2546:                 LblTamCmp  I,      ;
2547:                 LblTipoCmp C(1)    ;
2548:             )
2549: 
2550:             *-- Cursor de campos do relatorio
2551:             IF USED("CrsProps_Campos")
2552:                 USE IN CrsProps_Campos
2553:             ENDIF
2554:             CREATE CURSOR CrsProps_Campos ( ;
2555:                 NmCampo    C(40),  ;
2556:                 TpCampo    C(10),  ;
2557:                 CkOutRPT   I,      ;
2558:                 CkFiltro   I,      ;
2559:                 CkSubTot   I,      ;
2560:                 CkTotal    I,      ;
2561:                 LblCaption C(200), ;
2562:                 LblFonte   C(50),  ;
2563:                 LblBtFonte C(1),   ;
2564:                 LblBtCor   I,      ;
2565:                 LblAlinhar C(6),   ;
2566:                 LblTamCmp  I,      ;
2567:                 LblTipoCmp C(1)    ;
2568:             )
2569: 
2570:             *-- Cursor de agrupamento do relatorio
2571:             IF USED("CrsProps_GRP")
2572:                 USE IN CrsProps_GRP
2573:             ENDIF
2574:             CREATE CURSOR CrsProps_GRP ( ;
2575:                 NmCampo    C(40),  ;
2576:                 TpCampo    C(10),  ;
2577:                 LblCaption C(200), ;
2578:                 LblFonte   C(50),  ;
2579:                 LblBtFonte C(1),   ;
2580:                 LblBtCor   I,      ;
2581:                 LblAlinhar C(6),   ;
2582:                 LblTamCmp  I       ;
2583:             )
2584:         CATCH TO loc_oErro
2585:             MsgErro(loc_oErro.Message, "FormRPT.CriarCursoresDesigner")
2586:         ENDTRY
2587:     ENDPROC
2588: 
2589:     *==========================================================================

*-- Linhas 2675 a 2697:
2675:             IF USED("cursor_4c_Tables")
2676:                 USE IN cursor_4c_Tables
2677:             ENDIF
2678:             loc_nRes = SQLEXEC(gnConnHandle, ;
2679:                 "SELECT UPPER(name) AS NmTable FROM sys.tables ORDER BY name", ;
2680:                 "cursor_4c_Tables")
2681:             IF loc_nRes >= 0
2682:                 SELECT cursor_4c_Tables
2683:                 SCAN
2684:                     THIS.this_oWLstTABs.Lst_TABs.AddItem(ALLTRIM(cursor_4c_Tables.NmTable))
2685:                 ENDSCAN
2686:                 USE IN cursor_4c_Tables
2687:             ENDIF
2688: 
2689:             *-- Janela flutuante de Variaveis (F9)
2690:             THIS.this_oWLstVARs = CREATEOBJECT("Form")
2691:             WITH THIS.this_oWLstVARs
2692:                 .BorderStyle       = 1
2693:                 .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
2694:                 .HalfHeightCaption = .T.
2695:                 .Left              = 0
2696:                 .Top               = 0
2697:                 .Height            = 100


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*------------------------------------------------------------------------------
* RPTBO.prg - Business Object para Cadastro Customizado de Relatorios 4Report
* Herda de BusinessBase
* Tabelas principais: SIGCDRLC (cabecalho), SIGCDRLD (detalhes/layout FRX)
* Migrado de: SIGCDRPT (tasks/task512)
*------------------------------------------------------------------------------
DEFINE CLASS RPTBO AS BusinessBase

    *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
    this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    this_cNmReport     = ""    && NmReport - Nome do arquivo do report
    this_cDescr        = ""    && Descr - Descricao do report
    this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
    this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
    this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
    this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDRLC"
        THIS.this_cCampoChave = "RPT_ID"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cRptId
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRptId - Gera novo RPT_ID no formato original: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarRptId()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT para listar relatorios no grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso  = .F.
        loc_cFiltro   = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                       " FROM SIGCDRLC"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY NmReport"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar relat" + CHR(243) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do relatorio por RPT_ID
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            MsgErro("RPT_ID inv" + CHR(225) + "lido para carregamento.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorNome - Carrega cabecalho do relatorio por NmReport
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorNome(par_cNmReport)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNmReport) != "C" OR EMPTY(ALLTRIM(par_cNmReport))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSqlQuery - Carrega apenas o SqlQuery de um relatorio (campo memo)
    *--------------------------------------------------------------------------
    FUNCTION CarregarSqlQuery(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        loc_cQuery   = ""

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF

            loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlQuery")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_SqlQuery") > 0
                SELECT cursor_4c_SqlQuery
                loc_cQuery = NVL(SqlQuery, "")
            ENDIF

            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cQuery
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")

            IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
               AFIELDS(laFields, par_cAliasCursor) > 0
                IF ASCAN(laFields, "SQLQUERY") > 0
                    THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursorCompleto - Mapeia TODOS os campos incluindo SqlQuery
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursorCompleto(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
            THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Campo NOME do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Campo SQL do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cRptId
        loc_lSucesso = .F.

        TRY
            *-- Gerar RPT_ID unico no formato original
            loc_cRptId = THIS.GerarRptId()
            THIS.this_cRptId      = loc_cRptId
            THIS.this_dDtCriacao  = DATE()
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                       " (RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cRptId) + ", " + ;
                       EscaparSQL(THIS.this_cNmReport) + ", " + ;
                       EscaparSQL(THIS.this_cDescr) + ", " + ;
                       IIF(THIS.this_lAtivo, "1", "0") + ", " + ;
                       FormatarDataSQL(THIS.this_dDtCriacao) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlteracao) + ", " + ;
                       EscaparSQL(THIS.this_cSqlQuery) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
                       " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
                       " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
                       " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
                       " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SIGCDRLD + SIGCDRLC (PROTECTED)
    * Ordem obrigatoria: SIGCDRLD primeiro (filhos), depois SIGCDRLC (pai)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para exclus" + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- 1. Excluir detalhes/layout FRX (SIGCDRLD) - filhos primeiro
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhes do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir cabecalho (SIGCDRLC) - pai depois
            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarSqlQuery - Atualiza apenas o campo SqlQuery de um relatorio existente
    * Chamado pelo editor SQL quando o usuario edita a query sem alterar outros campos
    *--------------------------------------------------------------------------
    FUNCTION SalvarSqlQuery(par_cRptId, par_cSqlQuery)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar SQL do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.SalvarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSqlQuery - Executa o SqlQuery e retorna cursor com resultado
    * Usado pelo editor SQL para pre-visualizar resultados
    *--------------------------------------------------------------------------
    FUNCTION ExecutarSqlQuery(par_cSqlQuery, par_cCursorDestino)
        LOCAL loc_nResultado, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                           par_cCursorDestino, "cursor_4c_SqlResult")

        IF VARTYPE(par_cSqlQuery) != "C" OR EMPTY(ALLTRIM(par_cSqlQuery))
            MsgAviso("SQL n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ALLTRIM(par_cSqlQuery), loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTabelasSqlServer - Lista tabelas do banco para o editor SQL (F8)
    *--------------------------------------------------------------------------
    FUNCTION BuscarTabelasSqlServer()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Tabelas")
                USE IN cursor_4c_Tabelas
            ENDIF

            loc_cSQL = "SELECT UPPER(Name) AS NmTable, Object_ID, Modify_Date" + ;
                       " FROM sys.tables" + ;
                       " ORDER BY Name"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tabelas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarTabelasSqlServer:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarColunasDaTabela - Lista colunas de uma tabela especifica (F9)
    *--------------------------------------------------------------------------
    FUNCTION BuscarColunasDaTabela(par_cNomeTabela)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNomeTabela) != "C" OR EMPTY(ALLTRIM(par_cNomeTabela))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Colunas")
                USE IN cursor_4c_Colunas
            ENDIF

            loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, c.Max_Length" + ;
                       " FROM sys.all_Columns c" + ;
                       " JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID" + ;
                       " WHERE c.Object_ID = OBJECT_ID(" + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ")" + ;
                       " ORDER BY c.Column_ID"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Colunas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar colunas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarColunasDaTabela:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

