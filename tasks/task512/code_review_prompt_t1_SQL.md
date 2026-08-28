# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VERM, NMCAMPO, NSELPOSI, I, CKOUTRPT, CKFILTRO, CCMD, NSELPOSF, CLETRA, RPT_ID, PKCHAVES, PROGRAMAS, TVFONTSTYLE, LCIIF, LNCOUNT, NMREPORT, CODIGOS, LLRPT_D, PCESCOLHA, DISABLEDPICTURE, OBJECT_ID, NSELPOSA, NSHIFT, CKTOTAL, NWIDTH, NHEIGHT, OBJTYPE, COMMENT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_TYPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VERM, NMCAMPO, NSELPOSI, I, CKOUTRPT, CKFILTRO, CCMD, NSELPOSF, CLETRA, RPT_ID, PKCHAVES, PROGRAMAS, TVFONTSTYLE, LCIIF, LNCOUNT, NMREPORT, CODIGOS, LLRPT_D, PCESCOLHA, DISABLEDPICTURE, OBJECT_ID, NSELPOSA, NSHIFT, CKTOTAL, NWIDTH, NHEIGHT, OBJTYPE, COMMENT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VERM, NMCAMPO, NSELPOSI, I, CKOUTRPT, CKFILTRO, CCMD, NSELPOSF, CLETRA, RPT_ID, PKCHAVES, PROGRAMAS, TVFONTSTYLE, LCIIF, LNCOUNT, NMREPORT, CODIGOS, LLRPT_D, PCESCOLHA, DISABLEDPICTURE, OBJECT_ID, NSELPOSA, NSHIFT, CKTOTAL, NWIDTH, NHEIGHT, OBJTYPE, COMMENT
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS SQL (2802 linhas total):

*-- Linhas 363 a 381:
363:                 .HighlightBackColor = RGB(255, 255, 255)
364:                 .HighlightForeColor = RGB(15, 41, 104)
365:                 .HighlightStyle     = 2
366:                 .DeleteMark         = .F.
367:                 .RecordMark         = .F.
368:                 .RowHeight          = 16
369:                 .ScrollBars         = 2
370:                 .GridLines          = 3
371:                 .ColumnCount        = 5
372:                 .Visible            = .T.
373:             ENDWITH
374: 
375:             THIS.TornarControlesVisiveis(loc_oPagina)
376:         CATCH TO loc_oErro
377:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
378:         ENDTRY
379:     ENDPROC
380: 
381:     *==========================================================================

*-- Linhas 908 a 926:
908:                 .HighlightBackColor = RGB(255, 255, 255)
909:                 .HighlightForeColor = RGB(15, 41, 104)
910:                 .HighlightStyle     = 2
911:                 .DeleteMark         = .F.
912:                 .RecordMark         = .F.
913:                 .RowHeight          = 16
914:                 .ScrollBars         = 3
915:                 .GridLines          = 3
916:                 .ColumnCount        = 0
917:                 .ReadOnly           = .T.
918:                 .Visible            = .T.
919:             ENDWITH
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * CarregarLista - Carrega lista de relatorios no grid

*-- Linhas 939 a 961:
939: 
940:                     loc_oGrid.ColumnCount = 5
941:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
942:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
943:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
944:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
945:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
946:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
947: 
948:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
949:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
950:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
951:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
952:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
953:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
954: 
955:                     loc_oGrid.Column1.Width = 350
956:                     loc_oGrid.Column2.Width = 350
957:                     loc_oGrid.Column3.Width = 90
958:                     loc_oGrid.Column4.Width = 90
959:                     loc_oGrid.Column5.Width = 50
960: 
961:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1028 a 1046:
1028:             ENDIF
1029: 
1030:             IF loc_lProsseguir
1031:                 SELECT cursor_4c_Dados
1032:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1033: 
1034:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1035:                     THIS.this_pcEscolha  = "CONSULTAR"
1036:                     THIS.this_cModoAtual = "VISUALIZAR"
1037:                     THIS.BOParaForm()
1038:                     THIS.ConfigurarModoEditor(.T.)
1039:                     THIS.AlternarPagina(2)
1040:                 ELSE
1041:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1042:                 ENDIF
1043:             ENDIF
1044:         CATCH TO loc_oErro
1045:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarClick")
1046:         ENDTRY

*-- Linhas 1060 a 1078:
1060:             ENDIF
1061: 
1062:             IF loc_lProsseguir
1063:                 SELECT cursor_4c_Dados
1064:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1065: 
1066:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1067:                     THIS.this_oBusinessObject.EditarRegistro()
1068:                     THIS.this_pcEscolha  = "ALTERAR"
1069:                     THIS.this_cModoAtual = "ALTERAR"
1070:                     THIS.BOParaForm()
1071:                     THIS.ConfigurarModoEditor(.F.)
1072:                     THIS.AlternarPagina(2)
1073:                 ELSE
1074:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1075:                 ENDIF
1076:             ENDIF
1077:         CATCH TO loc_oErro
1078:             MsgErro(loc_oErro.Message, "FormRPT.BtnAlterarClick")

*-- Linhas 1093 a 1111:
1093:             ENDIF
1094: 
1095:             IF loc_lProsseguir
1096:                 SELECT cursor_4c_Dados
1097:                 loc_cRptId    = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1098:                 loc_cNmReport = ALLTRIM(NVL(cursor_4c_Dados.NmReport, ""))
1099: 
1100:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do relat" + CHR(243) + "rio:" + ;
1101:                                CHR(13) + loc_cNmReport + "?", ;
1102:                                "Confirmar Exclus" + CHR(227) + "o")
1103: 
1104:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1105:                         IF THIS.this_oBusinessObject.Excluir()
1106:                             MsgInfo("Relat" + CHR(243) + "rio exclu" + CHR(237) + "do com sucesso!")
1107:                             THIS.CarregarLista()
1108:                         ELSE
1109:                             MsgErro("Erro ao excluir relat" + CHR(243) + "rio.", "Erro")
1110:                         ENDIF
1111:                     ELSE

*-- Linhas 1133 a 1155:
1133: 
1134:                     loc_oGrid.ColumnCount = 5
1135:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1136:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
1137:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
1138:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
1139:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1140:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1141: 
1142:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
1143:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1144:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
1145:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
1146:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1147: 
1148:                     loc_oGrid.Column1.Width = 350
1149:                     loc_oGrid.Column2.Width = 350
1150:                     loc_oGrid.Column3.Width = 90
1151:                     loc_oGrid.Column4.Width = 90
1152:                     loc_oGrid.Column5.Width = 50
1153: 
1154:                     THIS.FormatarGridLista(loc_oGrid)
1155:                     loc_oGrid.Refresh()

*-- Linhas 1227 a 1256:
1227:                     USE IN cursor_4c_SqlResult
1228:                 ENDIF
1229: 
1230:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1231: 
1232:                 IF loc_nResultado >= 0
1233:                     loc_oGrid = loc_oPage.grd_4c_Resultado
1234:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResult")
1235: 
1236:                     loc_oGrid.ColumnCount = 3
1237:                     loc_oGrid.RecordSource = "cursor_4c_SqlResult"
1238:                     loc_oGrid.ColumnCount  = loc_nCols
1239: 
1240:                     FOR loc_nI = 1 TO loc_nCols
1241:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1242:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1243:                         loc_oGrid.Columns(loc_nI).Width = 100
1244:                     ENDFOR
1245: 
1246:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1247:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1248:                     loc_oGrid.Refresh()
1249: 
1250:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1251:                             " registro(s) retornado(s).")
1252:                 ELSE
1253:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1254:                 ENDIF
1255:             ENDIF
1256:         CATCH TO loc_oErro

*-- Linhas 1296 a 1314:
1296:                     USE IN cursor_4c_SqlResult
1297:                 ENDIF
1298: 
1299:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1300: 
1301:                 IF loc_nResultado >= 0
1302:                     REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
1303:                 ELSE
1304:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1305:                 ENDIF
1306:             ENDIF
1307:         CATCH TO loc_oErro
1308:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarRptClick")
1309:         ENDTRY
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * BtnLayoutClick - Executa SQL e abre o Designer de Layout
1314:     *==========================================================================

*-- Linhas 1333 a 1385:
1333:                     USE IN cursor_4c_SqlResult
1334:                 ENDIF
1335: 
1336:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1337: 
1338:                 IF loc_nResultado >= 0
1339:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResult")
1340: 
1341:                     IF loc_nCols = 0
1342:                         MsgAviso("O SQL n" + CHR(227) + "o retornou campos.", "Aten" + CHR(231) + CHR(227) + "o")
1343:                         loc_lProsseguir = .F.
1344:                     ENDIF
1345:                 ELSE
1346:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1347:                     loc_lProsseguir = .F.
1348:                 ENDIF
1349:             ENDIF
1350: 
1351:             IF loc_lProsseguir
1352:                 *-- Cria/recria cursores do designer
1353:                 THIS.CriarCursoresDesigner()
1354: 
1355:                 *-- Popula CrsProps_Titulo com 1 linha de titulo
1356:                 IF USED("CrsProps_Titulo")
1357:                     SELECT CrsProps_Titulo
1358:                     IF RECCOUNT("CrsProps_Titulo") = 0
1359:                         APPEND BLANK
1360:                         REPLACE CrsProps_Titulo.NmCampo    WITH "TITULO"
1361:                         REPLACE CrsProps_Titulo.LblCaption WITH ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
1362:                         REPLACE CrsProps_Titulo.LblFonte   WITH "Arial,12,B"
1363:                         REPLACE CrsProps_Titulo.LblAlinhar WITH "C"
1364:                         REPLACE CrsProps_Titulo.LblTamCmp  WITH 200
1365:                     ENDIF
1366:                 ENDIF
1367: 
1368:                 *-- Popula CrsProps_Campos com um registro por campo do resultado SQL
1369:                 IF USED("CrsProps_Campos")
1370:                     SELECT CrsProps_Campos
1371:                     ZAP
1372:                     FOR loc_nI = 1 TO loc_nCols
1373:                         APPEND BLANK
1374:                         REPLACE CrsProps_Campos.NmCampo    WITH ALLTRIM(laFields[loc_nI, 1])
1375:                         REPLACE CrsProps_Campos.TpCampo    WITH ALLTRIM(laFields[loc_nI, 2])
1376:                         REPLACE CrsProps_Campos.CkOutRPT   WITH 1
1377:                         REPLACE CrsProps_Campos.CkFiltro   WITH 0
1378:                         REPLACE CrsProps_Campos.CkSubTot   WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1379:                         REPLACE CrsProps_Campos.CkTotal    WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1380:                         REPLACE CrsProps_Campos.LblCaption WITH ALLTRIM(laFields[loc_nI, 1])
1381:                         REPLACE CrsProps_Campos.LblFonte   WITH "Arial,9,N"
1382:                         REPLACE CrsProps_Campos.LblAlinhar WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), "R", "L")
1383:                         REPLACE CrsProps_Campos.LblTamCmp  WITH IIF(laFields[loc_nI, 3] > 0, laFields[loc_nI, 3], 10)
1384:                         REPLACE CrsProps_Campos.LblTipoCmp WITH laFields[loc_nI, 2]
1385:                     ENDFOR

*-- Linhas 1513 a 1532:
1513:                 USE IN cursor_4c_ReportNomes
1514:             ENDIF
1515: 
1516:             loc_nRes = SQLEXEC(gnConnHandle, ;
1517:                        "SELECT DISTINCT NmReport FROM SIGCDRLC ORDER BY NmReport", ;
1518:                        "cursor_4c_ReportNomes")
1519: 
1520:             IF loc_nRes >= 0
1521:                 WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
1522:                     .RowSourceType = 2
1523:                     .RowSource     = "cursor_4c_ReportNomes"
1524:                     .BoundColumn   = 1
1525:                     .ColumnCount   = 1
1526:                 ENDWITH
1527:             ENDIF
1528:         CATCH TO loc_oErro
1529:             MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
1530:         ENDTRY
1531:     ENDPROC
1532: 

*-- Linhas 1845 a 1863:
1845:                 .GridLines        = 1
1846:                 .HeaderHeight     = 25
1847:                 .RowHeight        = 30
1848:                 .DeleteMark       = .F.
1849:                 .RecordMark       = .F.
1850:                 .ScrollBars       = 2
1851:                 .Visible          = .T.
1852:             ENDWITH
1853: 
1854:             *- Col1: LblCaption - "Titulo" (EditBox)
1855:             loc_oCol = loc_oGrd.Column1
1856:             loc_oCol.Header1.Caption = "T" + CHR(237) + "tulo"
1857:             loc_oCol.Width  = 300
1858:             loc_oCol.Sparse = .F.
1859:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1860:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1861:             WITH loc_oCol.edt_4c_TitCaption
1862:                 .Width      = 298
1863:                 .Height     = 28

*-- Linhas 1942 a 1960:
1942:                 .GridLines        = 1
1943:                 .HeaderHeight     = 25
1944:                 .RowHeight        = 30
1945:                 .DeleteMark       = .F.
1946:                 .RecordMark       = .F.
1947:                 .ScrollBars       = 3
1948:                 .Visible          = .T.
1949:             ENDWITH
1950: 
1951:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1952:             loc_oCol = loc_oGrd.Column1
1953:             loc_oCol.Header1.Caption = "Campo"
1954:             loc_oCol.Width    = 140
1955:             loc_oCol.Sparse   = .F.
1956:             loc_oCol.ReadOnly = .T.
1957:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1958:             loc_oCol.CurrentControl = "txt_4c_NmCampo"
1959:             WITH loc_oCol.txt_4c_NmCampo
1960:                 .Width     = 138

*-- Linhas 2179 a 2197:
2179:                 .GridLines        = 1
2180:                 .HeaderHeight     = 25
2181:                 .RowHeight        = 30
2182:                 .DeleteMark       = .F.
2183:                 .RecordMark       = .F.
2184:                 .ScrollBars       = 2
2185:                 .Visible          = .T.
2186:             ENDWITH
2187: 
2188:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2189:             loc_oCol = loc_oGrd.Column1
2190:             loc_oCol.Header1.Caption = "Grupo"
2191:             loc_oCol.Width  = 200
2192:             loc_oCol.Sparse = .F.
2193:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2194:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2195:             WITH loc_oCol.cbo_4c_NmCampoGRP
2196:                 .Style         = 2
2197:                 .RowSourceType = 1

*-- Linhas 2503 a 2561:
2503:             IF USED("CrsProps_Titulo")
2504:                 USE IN CrsProps_Titulo
2505:             ENDIF
2506:             CREATE CURSOR CrsProps_Titulo ( ;
2507:                 NmCampo    C(40),  ;
2508:                 TpCampo    C(10),  ;
2509:                 CkOutRPT   I,      ;
2510:                 CkFiltro   I,      ;
2511:                 CkSubTot   I,      ;
2512:                 CkTotal    I,      ;
2513:                 LblCaption C(200), ;
2514:                 LblFonte   C(50),  ;
2515:                 LblBtFonte C(1),   ;
2516:                 LblBtCor   I,      ;
2517:                 LblAlinhar C(6),   ;
2518:                 LblTamCmp  I,      ;
2519:                 LblTipoCmp C(1)    ;
2520:             )
2521: 
2522:             *-- Cursor de campos do relatorio
2523:             IF USED("CrsProps_Campos")
2524:                 USE IN CrsProps_Campos
2525:             ENDIF
2526:             CREATE CURSOR CrsProps_Campos ( ;
2527:                 NmCampo    C(40),  ;
2528:                 TpCampo    C(10),  ;
2529:                 CkOutRPT   I,      ;
2530:                 CkFiltro   I,      ;
2531:                 CkSubTot   I,      ;
2532:                 CkTotal    I,      ;
2533:                 LblCaption C(200), ;
2534:                 LblFonte   C(50),  ;
2535:                 LblBtFonte C(1),   ;
2536:                 LblBtCor   I,      ;
2537:                 LblAlinhar C(6),   ;
2538:                 LblTamCmp  I,      ;
2539:                 LblTipoCmp C(1)    ;
2540:             )
2541: 
2542:             *-- Cursor de agrupamento do relatorio
2543:             IF USED("CrsProps_GRP")
2544:                 USE IN CrsProps_GRP
2545:             ENDIF
2546:             CREATE CURSOR CrsProps_GRP ( ;
2547:                 NmCampo    C(40),  ;
2548:                 TpCampo    C(10),  ;
2549:                 LblCaption C(200), ;
2550:                 LblFonte   C(50),  ;
2551:                 LblBtFonte C(1),   ;
2552:                 LblBtCor   I,      ;
2553:                 LblAlinhar C(6),   ;
2554:                 LblTamCmp  I       ;
2555:             )
2556:         CATCH TO loc_oErro
2557:             MsgErro(loc_oErro.Message, "FormRPT.CriarCursoresDesigner")
2558:         ENDTRY
2559:     ENDPROC
2560: 
2561:     *==========================================================================

*-- Linhas 2647 a 2669:
2647:             IF USED("cursor_4c_Tables")
2648:                 USE IN cursor_4c_Tables
2649:             ENDIF
2650:             loc_nRes = SQLEXEC(gnConnHandle, ;
2651:                 "SELECT UPPER(name) AS NmTable FROM sys.tables ORDER BY name", ;
2652:                 "cursor_4c_Tables")
2653:             IF loc_nRes >= 0
2654:                 SELECT cursor_4c_Tables
2655:                 SCAN
2656:                     THIS.this_oWLstTABs.Lst_TABs.AddItem(ALLTRIM(cursor_4c_Tables.NmTable))
2657:                 ENDSCAN
2658:                 USE IN cursor_4c_Tables
2659:             ENDIF
2660: 
2661:             *-- Janela flutuante de Variaveis (F9)
2662:             THIS.this_oWLstVARs = CREATEOBJECT("Form")
2663:             WITH THIS.this_oWLstVARs
2664:                 .BorderStyle       = 1
2665:                 .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
2666:                 .HalfHeightCaption = .T.
2667:                 .Left              = 0
2668:                 .Top               = 0
2669:                 .Height            = 100


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
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%") + ;
                           " OR Descr LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
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

            loc_cSQL = "SELECT TABLE_NAME" + ;
                       " FROM INFORMATION_SCHEMA.TABLES" + ;
                       " WHERE TABLE_TYPE = 'BASE TABLE'" + ;
                       " ORDER BY TABLE_NAME"

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

            loc_cSQL = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH" + ;
                       " FROM INFORMATION_SCHEMA.COLUMNS" + ;
                       " WHERE TABLE_NAME = " + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ;
                       " ORDER BY ORDINAL_POSITION"

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

