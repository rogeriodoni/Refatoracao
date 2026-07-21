# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPASSO, 0, CGRUS, COLECOES, IFORS, MOEVS, MARGEMS, CPROS, LMARCA, PROMOS, NFAIXAFINS, VALUE

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
If ThisForm.poDataMgr.SqlExecute([Select MarkUpCVs,GrPadFors From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdPac ],'CrSigCdPac') < 1
Select CrSigCdPac
If ThisForm.poDataMgr.SqlExecute([Select CGrus,Arreds From SigCdGrp ],'CrSigCdGrp') < 1
Select CrSigCdGrp
Select CrProdutos
	.Column1.ControlSource = 'CrProdutos.lMarca'
	.Column2.ControlSource = 'CrProdutos.CPros'
	.Column3.ControlSource = 'CrProdutos.DPros'
	.Column4.ControlSource = 'CrProdutos.ValAnt'
	.Column5.ControlSource = 'CrProdutos.ValAtu'
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where 0 = 1 ],'TmpPro') < 1
Select TmpPro
lStrQuery = [Select * From SigCdPro ]+;
			Iif(ThisForm.chkIgnorar.Value = 1, [ ], [ And Cpros Not in (Select Distinct cpros From SigPrCpo) ]) + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
Select TmpPro
Select TmpPro
	loBarra.Update(.T.)
	Insert Into CrProdutos From MemVar
Select CrProdutos
	Select * From CrProdutos Where lMarca = 1 Order By CPros Into Cursor CsProdutos ReadWrite
	Select CsProdutos
	Select CsProdutos
		loBarra.Update(.T.,'Produto: ' + CsProdutos.CPros)
		If Seek(CsProdutos.CPros,'TmpPro','CPros')
			Select TmpPro
			Insert Into CrSigCdPrc From MemVar
			Insert Into CrSigCdPro From MemVar
			If ThisForm.poDataMgr.SqlExecute([Select * From SigPrCpo Where CPros = ']+m.CPros+[' ],'TmpCompo') < 1
			Select TmpCompo
				Insert Into CrSigPrCp2 From MemVar
				Select TmpCompo
			If ThisForm.poDataMgr.SqlExecute([Delete From SigPrPrt Where CPros = '] + m.CPros + [' ], []) < 1
				lStrQuery = [Delete From SigPrPmi Where CPros = '] + CsProdutos.CPros + [']
				If ThisForm.poDataMgr.SqlExecute(lStrQuery, '') < 1
				lStrQuery = [Select * From SigPrPmi Where CPros = ']+CsProdutos.CPros+[' And Promos = ']+lcPromo+[' ]
				If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPromI') < 1
				Select TmpPromI
					Insert Into CrSigPrPmi (CPros,Pecas,Promos,CBars,Datas,CIdChaves,PromoPro,DtAlts) ;
		Select CsProdutos
		Select crSigCdPro
			lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+crSigCdPro.cGrus+[' Order By nFaixaFins]
			If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
			Select csSigCdPsg
					Select crSigCdPro
					Select crSigCdPro
	loBarraFim.Update(.T.,'SigCdPro (1/4)...')
	Select CrSigCdPro
	Select CrSigCdPrc
	Select * From CrSigCdPro Into Cursor CsSelecao
	Select CsSelecao
			If Not ThisForm.poDataMgr.Update('CrSigCdPro')
		Insert Into CrSigCdPro From Memvar 
	llOk = llOk And ThisForm.poDataMgr.Update('CrSigCdPro')
		loBarraFim.Update(.T.,'SigCdPrc (2/4)...')
		Select * From CrSigCdPrc Into Cursor CsSelecao
		Select CsSelecao
				If Not ThisForm.poDataMgr.Update('CrSigCdPrc')
			Insert Into CrSigCdPrc From Memvar 
		llOk = llOk And ThisForm.poDataMgr.Update('CrSigCdPrc')
		loBarraFim.Update(.T.,'SigPrCp2 (3/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrCp2')
		loBarraFim.Update(.T.,'SigPrPmi (4/4)...')
		llOk = ThisForm.poDataMgr.Update('CrSigPrPmi')
Select CrProdutos
lcSql = [Select FigJpgs From SigCdPro Where Cpros = ']+CrProdutos.cpros+[']
If ThisForm.PodataMgr.Sqlexecute(lcSql,'CsTmpPro') < 1
Select CsTmpPro
Select CrProdutos
	Update CrProdutos Set lMarca = 1
	Update CrProdutos Set lMarca = 0
	Select CqSigCdPro
		Insert Into TmpPro From MemVar
		Select TmpPro
		Select CrProdutos
			Select CrProdutos
				Insert Into CrProdutos From MemVar
			Select CrProdutos
	Select CrProdutos
		Insert Into CrProdutos From MemVar
	Select CrProdutos
		Insert Into CrProdutos From MemVar
		Select CrProdutos
		Delete From CrProdutos
		Select CrProdutos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2161 linhas total):

*-- Linhas 776 a 876:
776:             .ColumnCount   = 5
777:             .FontName      = "Tahoma"
778:             .FontSize      = 8
779:             .DeleteMark    = .F.
780:             .RecordMark    = .F.
781:             .GridLines     = 3
782:             .GridLineWidth = 1
783:             .HeaderHeight  = 17
784:             .RowHeight     = 17
785:             .ScrollBars    = 3
786:             .RecordSource  = "cursor_4c_Produtos"
787: 
788:             *-- Coluna 1: CheckBox de selecao
789:             WITH .Column1
790:                 .Width      = 25
791:                 .Movable    = .F.
792:                 .Resizable  = .F.
793:                 .Sparse     = .F.
794:                 .AddObject("Check1", "CheckBox")
795:                 .Check1.Caption = ""
796:                 .Check1.Value   = 0
797:                 .CurrentControl = "Check1"
798:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
799:                 WITH .Header1
800:                     .Caption = ""
801:                     .Tag     = "1"
802:                 ENDWITH
803:             ENDWITH
804: 
805:             *-- Coluna 2: Codigo do produto
806:             WITH .Column2
807:                 .Width         = 110
808:                 .Movable       = .F.
809:                 .Resizable     = .F.
810:                 .ReadOnly      = .T.
811:                 .ControlSource = "cursor_4c_Produtos.CPros"
812:                 WITH .Header1
813:                     .Caption = "Produto"
814:                 ENDWITH
815:                 WITH .Text1
816:                     .FontName = "Verdana"
817:                     .FontSize = 8
818:                 ENDWITH
819:             ENDWITH
820: 
821:             *-- Coluna 3: Descricao (ReadOnly)
822:             WITH .Column3
823:                 .Width         = 260
824:                 .Movable       = .F.
825:                 .Resizable     = .F.
826:                 .ReadOnly      = .T.
827:                 .ControlSource = "cursor_4c_Produtos.DPros"
828:                 WITH .Header1
829:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
830:                 ENDWITH
831:                 WITH .Text1
832:                     .FontName = "Verdana"
833:                     .FontSize = 8
834:                 ENDWITH
835:             ENDWITH
836: 
837:             *-- Coluna 4: Preco Anterior (ReadOnly)
838:             WITH .Column4
839:                 .Width         = 165
840:                 .Movable       = .F.
841:                 .Resizable     = .F.
842:                 .ReadOnly      = .T.
843:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
844:                 .Alignment     = 3
845:                 WITH .Header1
846:                     .Caption = "Pre" + CHR(231) + "o Anterior"
847:                 ENDWITH
848:                 WITH .Text1
849:                     .FontName  = "Verdana"
850:                     .FontSize  = 8
851:                     .InputMask = "999,999.99"
852:                 ENDWITH
853:             ENDWITH
854: 
855:             *-- Coluna 5: Preco Atual (editavel se LibValAtu)
856:             WITH .Column5
857:                 .Width         = 165
858:                 .Movable       = .F.
859:                 .Resizable     = .F.
860:                 .ReadOnly      = !THIS.this_lLibValAtu
861:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
862:                 .Alignment     = 3
863:                 WITH .Header1
864:                     .Caption = "Pre" + CHR(231) + "o Atual"
865:                     IF !THIS.this_lLibValAtu
866:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
867:                     ENDIF
868:                 ENDWITH
869:                 WITH .Text1
870:                     .FontName  = "Verdana"
871:                     .FontSize  = 8
872:                     .InputMask = "999,999.99"
873:                 ENDWITH
874:             ENDWITH
875:         ENDWITH
876:     ENDPROC

*-- Linhas 1046 a 1081:
1046: 
1047:         TRY
1048:             IF !USED("cursor_4c_Produtos")
1049:                 CREATE CURSOR cursor_4c_Produtos ( ;
1050:                     lMarca  N(1) NULL, ;
1051:                     CPros   C(14) NULL, ;
1052:                     DPros   C(40) NULL, ;
1053:                     ValAnt  N(14,4) NULL, ;
1054:                     ValAtu  N(14,4) NULL, ;
1055:                     fCustos N(9,4) NULL, ;
1056:                     MoePcs  C(3) NULL, ;
1057:                     CustoFs N(14,4) NULL, ;
1058:                     Manual  N(1) NULL)
1059:                 INDEX ON CPros TAG CPros
1060:             ENDIF
1061: 
1062:             INSERT INTO cursor_4c_Produtos ;
1063:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1064:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1065: 
1066:             SELECT cursor_4c_Produtos
1067:             SET ORDER TO
1068:             GO BOTTOM
1069: 
1070:             THIS.grd_4c_Dados.ColumnCount = 3
1071:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1072:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1073:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1074:             THIS.grd_4c_Dados.Refresh()
1075:             THIS.grd_4c_Dados.SetFocus()
1076:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1077:         CATCH TO loc_oErro
1078:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1079:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1080:         ENDTRY
1081:     ENDPROC

*-- Linhas 1107 a 1125:
1107:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1108:                         "Visualizar")
1109:             ELSE
1110:                 SELECT cursor_4c_Produtos
1111:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1112:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1113:                             "Visualizar")
1114:                 ELSE
1115:                     THIS.GrdAfterRowColChange(2)
1116:                     THIS.grd_4c_Dados.Refresh()
1117:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1118:                         THIS.img_4c_Foto.Refresh()
1119:                     ENDIF
1120:                 ENDIF
1121:             ENDIF
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1124:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1125:         ENDTRY

*-- Linhas 1137 a 1178:
1137:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1138:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1139:             ELSE
1140:                 SELECT cursor_4c_Produtos
1141:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1142: 
1143:                 IF loc_nRemovidos = 0
1144:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1145:                             "Excluir")
1146:                         IF !EOF("cursor_4c_Produtos")
1147:                             DELETE
1148:                             PACK MEMO
1149:                             loc_nRemovidos = 1
1150:                         ENDIF
1151:                     ENDIF
1152:                 ELSE
1153:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1154:                             " produto(s) marcado(s) do grid?", "Excluir")
1155:                         DELETE FOR NVL(lMarca, 0) = 1
1156:                         PACK MEMO
1157:                     ELSE
1158:                         loc_nRemovidos = 0
1159:                     ENDIF
1160:                 ENDIF
1161: 
1162:                 IF loc_nRemovidos > 0
1163:                     SELECT cursor_4c_Produtos
1164:                     GO TOP
1165:                     THIS.grd_4c_Dados.Refresh()
1166:                     THIS.Refresh()
1167:                 ENDIF
1168:             ENDIF
1169:         CATCH TO loc_oErro
1170:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1171:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1172:         ENDTRY
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1177:     *==========================================================================
1178:     PROCEDURE OptTipoChange()

*-- Linhas 1266 a 1304:
1266:         IF THIS.chk_4c_Auditado.Value = 1
1267:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1268:             IF USED("cursor_4c_Produtos")
1269:                 INSERT INTO cursor_4c_Produtos ;
1270:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1271:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1272:                 SELECT cursor_4c_Produtos
1273:                 SET ORDER TO
1274:                 GO TOP
1275:             ENDIF
1276:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1277:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1278:             THIS.txt_4c_Colecao.Enabled               = .F.
1279:             THIS.txt_4c_Moeda.Enabled                 = .F.
1280:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1281:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1282:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1283:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1284:             THIS.grd_4c_Dados.Refresh()
1285:         ELSE
1286:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1287:             IF USED("cursor_4c_Produtos")
1288:                 DELETE FROM cursor_4c_Produtos
1289:                 SELECT cursor_4c_Produtos
1290:                 SET ORDER TO CPros
1291:                 GO TOP
1292:             ENDIF
1293:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1294:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1295:             THIS.txt_4c_Colecao.Enabled               = .T.
1296:             THIS.txt_4c_Moeda.Enabled                 = .T.
1297:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1298:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1299:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1300:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1301:             THIS.grd_4c_Dados.Refresh()
1302:             THIS.txt_4c_GrupoIni.SetFocus()
1303:         ENDIF
1304:         THIS.cmg_4c_Botoes.Refresh()

*-- Linhas 1312 a 1370:
1312: 
1313:         TRY
1314:             IF USED("cursor_4c_Produtos")
1315:                 SELECT cursor_4c_Produtos
1316:                 IF EOF("cursor_4c_Produtos")
1317:                     THIS.img_4c_Foto.Visible = .F.
1318:                     THIS.img_4c_Foto.Picture = ""
1319:                 ELSE
1320:                     *-- Rastrear edicao manual do preco (Column5)
1321:                     IF par_nColIndex = 5
1322:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1323:                     ELSE
1324:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1325:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1326:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1327:                         ENDIF
1328:                         THIS.this_cAntValue = ""
1329:                         ENDIF
1330:                     ENDIF
1331: 
1332:                     *-- Exibir foto do produto
1333:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1334:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1335:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1336:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1337:                         IF USED("cursor_4c_FigTemp")
1338:                             USE IN cursor_4c_FigTemp
1339:                         ENDIF
1340:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1341:                             SELECT cursor_4c_FigTemp
1342:                             THIS.img_4c_Foto.Visible = .F.
1343:                             THIS.img_4c_Foto.Picture = ""
1344:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1345:                                 CLEAR RESOURCES
1346:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1347:                                     "data:image/png;base64,", ""), ;
1348:                                     "data:image/jpeg;base64,", ""), ;
1349:                                     "data:image/jpg;base64,", ""), 14)
1350:                                 STRTOFILE(loc_cFoto, loc_cArqFig)
1351:                                 THIS.img_4c_Foto.Picture = loc_cArqFig
1352:                                 THIS.img_4c_Foto.Visible = .T.
1353:                             ENDIF
1354:                             USE IN cursor_4c_FigTemp
1355:                             SELECT cursor_4c_Produtos
1356:                         ELSE
1357:                             THIS.img_4c_Foto.Visible = .F.
1358:                             THIS.img_4c_Foto.Picture = ""
1359:                         ENDIF
1360:                     ELSE
1361:                         THIS.img_4c_Foto.Visible = .F.
1362:                         THIS.img_4c_Foto.Picture = ""
1363:                     ENDIF
1364:                 ENDIF
1365:             ENDIF
1366:         CATCH TO loc_oErro
1367:             IF USED("cursor_4c_FigTemp")
1368:                 USE IN cursor_4c_FigTemp
1369:             ENDIF
1370:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1380 a 1401:
1380:             RETURN
1381:         ENDIF
1382:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1383:             UPDATE cursor_4c_Produtos SET lMarca = 1
1384:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1385:         ELSE
1386:             UPDATE cursor_4c_Produtos SET lMarca = 0
1387:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1388:         ENDIF
1389:         THIS.grd_4c_Dados.Refresh()
1390:         THIS.Refresh()
1391:     ENDPROC
1392: 
1393:     *==========================================================================
1394:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1395:     *==========================================================================
1396:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1397:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1398:             RETURN
1399:         ENDIF
1400:         IF THIS.chk_4c_Auditado.Value != 1
1401:             RETURN

*-- Linhas 1429 a 1464:
1429:             IF USED("cursor_4c_BuscaProSingle")
1430:                 USE IN cursor_4c_BuscaProSingle
1431:             ENDIF
1432:             IF SQLEXEC(gnConnHandle, ;
1433:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1434:                 "cursor_4c_BuscaProSingle") >= 1 ;
1435:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1436: 
1437:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1438:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1439:                     SELECT cursor_4c_BuscaProSingle
1440:                     GO TOP
1441:                     SCATTER MEMVAR MEMO
1442:                     SELECT cursor_4c_TmpPro
1443:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1444:                     INDEX ON CPros TAG CPros
1445:                 ENDIF
1446: 
1447:                 *-- Posicionar TmpPro no produto e calcular preco
1448:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1449:                 SELECT cursor_4c_TmpPro
1450: 
1451:             *-- Calcular novo preco
1452:             DO CASE
1453:             CASE loc_nTipo = 1
1454:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1455:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1456:             CASE loc_nTipo = 2
1457:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)
1458:             CASE loc_nTipo = 3
1459:                 loc_nCotId  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), ;
1460:                     DATETIME(), gnConnHandle)
1461:                 loc_nCotVd  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs), ;
1462:                     DATETIME(), gnConnHandle)
1463:                 loc_nPven   = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
1464:                     IIF(loc_nCotVd = 0, 1, loc_nCotVd)

*-- Linhas 1475 a 1516:
1475:             loc_nCustoFs = cursor_4c_TmpPro.CustoFs
1476: 
1477:             *-- Atualizar linha corrente no grid
1478:             SELECT cursor_4c_Produtos
1479:             REPLACE lMarca   WITH 1,                              ;
1480:                     CPros    WITH par_cCPros,                     ;
1481:                     DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
1482:                     ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
1483:                     ValAtu   WITH loc_nValAtu,                     ;
1484:                     fCustos  WITH loc_nFCustos,                   ;
1485:                     MoePcs   WITH loc_cMoePcs,                    ;
1486:                     CustoFs  WITH loc_nCustoFs,                   ;
1487:                     Manual   WITH 0
1488: 
1489:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1490:             THIS.cmg_4c_Botoes.Refresh()
1491: 
1492:             *-- Adicionar linha vazia para o proximo produto
1493:             SELECT cursor_4c_Produtos
1494:             SET ORDER TO
1495:             GO BOTTOM
1496:             IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1497:                 INSERT INTO cursor_4c_Produtos ;
1498:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1499:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1500:             ENDIF
1501:             SELECT cursor_4c_Produtos
1502:             THIS.grd_4c_Dados.Refresh()
1503:             KEYBOARD "{DNARROW}"
1504: 
1505:                     IF USED("cursor_4c_BuscaProSingle")
1506:                         USE IN cursor_4c_BuscaProSingle
1507:                     ENDIF
1508:                 ELSE
1509:                     IF USED("cursor_4c_BuscaProSingle")
1510:                         USE IN cursor_4c_BuscaProSingle
1511:                     ENDIF
1512:                 ENDIF
1513:             ELSE
1514:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1515:                 IF USED("cursor_4c_BuscaProSingle")
1516:                     USE IN cursor_4c_BuscaProSingle

*-- Linhas 1549 a 1592:
1549:             IF USED("cursor_4c_BuscaGrp")
1550:                 USE IN cursor_4c_BuscaGrp
1551:             ENDIF
1552:             IF SQLEXEC(gnConnHandle, ;
1553:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1554:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1555:                 SELECT cursor_4c_BuscaGrp
1556:                 GO TOP
1557:                 IF !EOF("cursor_4c_BuscaGrp")
1558:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1559:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1560:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1561:                     ENDIF
1562:                     USE IN cursor_4c_BuscaGrp
1563:                     RETURN
1564:                 ENDIF
1565:                 USE IN cursor_4c_BuscaGrp
1566:             ENDIF
1567:         ENDIF
1568:         TRY
1569:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1570:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1571:                 "Grupos de Produto", .T., .T., "")
1572:             IF VARTYPE(loc_oBA) = "O"
1573:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1574:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1575:                 loc_oBA.Show()
1576:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1577:                     SELECT cursor_4c_BuscaGrp
1578:                     GO TOP
1579:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1580:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1581:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1582:                     ENDIF
1583:                 ELSE
1584:                     par_oTxtAlvo.Value = ""
1585:                 ENDIF
1586:                 IF USED("cursor_4c_BuscaGrp")
1587:                     USE IN cursor_4c_BuscaGrp
1588:                 ENDIF
1589:             ENDIF
1590:         CATCH TO loc_oErro
1591:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1592:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")

*-- Linhas 1606 a 1646:
1606:             IF USED("cursor_4c_BuscaCol")
1607:                 USE IN cursor_4c_BuscaCol
1608:             ENDIF
1609:             IF SQLEXEC(gnConnHandle, ;
1610:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1611:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1612:                 SELECT cursor_4c_BuscaCol
1613:                 GO TOP
1614:                 IF !EOF("cursor_4c_BuscaCol")
1615:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1616:                     USE IN cursor_4c_BuscaCol
1617:                     RETURN
1618:                 ENDIF
1619:                 USE IN cursor_4c_BuscaCol
1620:             ENDIF
1621:         ENDIF
1622:         TRY
1623:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1624:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1625:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1626:             IF VARTYPE(loc_oBA) = "O"
1627:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1628:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1629:                 loc_oBA.Show()
1630:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1631:                     SELECT cursor_4c_BuscaCol
1632:                     GO TOP
1633:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1634:                 ELSE
1635:                     THIS.txt_4c_Colecao.Value = ""
1636:                 ENDIF
1637:                 IF USED("cursor_4c_BuscaCol")
1638:                     USE IN cursor_4c_BuscaCol
1639:                 ENDIF
1640:             ENDIF
1641:         CATCH TO loc_oErro
1642:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1643:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1644:         ENDTRY
1645:     ENDPROC
1646: 

*-- Linhas 1654 a 1703:
1654:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1655:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1656:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1657:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1658: 
1659:         IF !EMPTY(loc_cVal)
1660:             IF USED("cursor_4c_BuscaConta")
1661:                 USE IN cursor_4c_BuscaConta
1662:             ENDIF
1663:             IF SQLEXEC(gnConnHandle, ;
1664:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1665:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1666:                 SELECT cursor_4c_BuscaConta
1667:                 GO TOP
1668:                 IF !EOF("cursor_4c_BuscaConta")
1669:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1670:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1671:                     USE IN cursor_4c_BuscaConta
1672:                     RETURN
1673:                 ENDIF
1674:                 USE IN cursor_4c_BuscaConta
1675:             ENDIF
1676:         ENDIF
1677:         TRY
1678:             LOCAL loc_cFiltroBA
1679:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1680:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1681:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1682:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1683:             IF VARTYPE(loc_oBA) = "O"
1684:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1685:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1686:                 loc_oBA.Show()
1687:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1688:                     SELECT cursor_4c_BuscaConta
1689:                     GO TOP
1690:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1691:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1692:                 ELSE
1693:                     THIS.txt_4c_Conta.Value  = ""
1694:                     THIS.txt_4c_DConta.Value = ""
1695:                 ENDIF
1696:                 IF USED("cursor_4c_BuscaConta")
1697:                     USE IN cursor_4c_BuscaConta
1698:                 ENDIF
1699:             ENDIF
1700:         CATCH TO loc_oErro
1701:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1702:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1703:         ENDTRY

*-- Linhas 1716 a 1765:
1716:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1717:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1718:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1719:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1720: 
1721:         IF !EMPTY(loc_cVal)
1722:             IF USED("cursor_4c_BuscaConta")
1723:                 USE IN cursor_4c_BuscaConta
1724:             ENDIF
1725:             IF SQLEXEC(gnConnHandle, ;
1726:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1727:                 EscaparSQL(loc_cVal + "%") + ;
1728:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1729:                 "cursor_4c_BuscaConta") > 0
1730:                 SELECT cursor_4c_BuscaConta
1731:                 GO TOP
1732:                 IF !EOF("cursor_4c_BuscaConta")
1733:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1734:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1735:                     USE IN cursor_4c_BuscaConta
1736:                     RETURN
1737:                 ENDIF
1738:                 USE IN cursor_4c_BuscaConta
1739:             ENDIF
1740:         ENDIF
1741:         TRY
1742:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1743:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1744:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1745:             IF VARTYPE(loc_oBA) = "O"
1746:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1747:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1748:                 loc_oBA.Show()
1749:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1750:                     SELECT cursor_4c_BuscaConta
1751:                     GO TOP
1752:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1753:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1754:                 ELSE
1755:                     THIS.txt_4c_DConta.Value = ""
1756:                 ENDIF
1757:                 IF USED("cursor_4c_BuscaConta")
1758:                     USE IN cursor_4c_BuscaConta
1759:                 ENDIF
1760:             ENDIF
1761:         CATCH TO loc_oErro
1762:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1763:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1764:         ENDTRY
1765:     ENDPROC

*-- Linhas 1777 a 1816:
1777:             IF USED("cursor_4c_BuscaPromo")
1778:                 USE IN cursor_4c_BuscaPromo
1779:             ENDIF
1780:             IF SQLEXEC(gnConnHandle, ;
1781:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1782:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1783:                 SELECT cursor_4c_BuscaPromo
1784:                 GO TOP
1785:                 IF !EOF("cursor_4c_BuscaPromo")
1786:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1787:                     USE IN cursor_4c_BuscaPromo
1788:                     RETURN
1789:                 ENDIF
1790:                 USE IN cursor_4c_BuscaPromo
1791:             ENDIF
1792:         ENDIF
1793:         TRY
1794:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1795:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1796:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1797:             IF VARTYPE(loc_oBA) = "O"
1798:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1799:                 loc_oBA.Show()
1800:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1801:                     SELECT cursor_4c_BuscaPromo
1802:                     GO TOP
1803:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1804:                 ELSE
1805:                     THIS.txt_4c_Promo.Value = ""
1806:                 ENDIF
1807:                 IF USED("cursor_4c_BuscaPromo")
1808:                     USE IN cursor_4c_BuscaPromo
1809:                 ENDIF
1810:             ENDIF
1811:         CATCH TO loc_oErro
1812:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1813:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1814:         ENDTRY
1815:     ENDPROC
1816: 

*-- Linhas 1824 a 1863:
1824:             IF USED("cursor_4c_BuscaMoe")
1825:                 USE IN cursor_4c_BuscaMoe
1826:             ENDIF
1827:             IF SQLEXEC(gnConnHandle, ;
1828:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1829:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1830:                 SELECT cursor_4c_BuscaMoe
1831:                 GO TOP
1832:                 IF !EOF("cursor_4c_BuscaMoe")
1833:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1834:                     USE IN cursor_4c_BuscaMoe
1835:                     RETURN
1836:                 ENDIF
1837:                 USE IN cursor_4c_BuscaMoe
1838:             ENDIF
1839:         ENDIF
1840:         TRY
1841:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1842:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1843:             IF VARTYPE(loc_oBA) = "O"
1844:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1845:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1846:                 loc_oBA.Show()
1847:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1848:                     SELECT cursor_4c_BuscaMoe
1849:                     GO TOP
1850:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1851:                 ELSE
1852:                     par_oTxt.Value = ""
1853:                 ENDIF
1854:                 IF USED("cursor_4c_BuscaMoe")
1855:                     USE IN cursor_4c_BuscaMoe
1856:                 ENDIF
1857:             ENDIF
1858:         CATCH TO loc_oErro
1859:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1860:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1861:         ENDTRY
1862:     ENDPROC
1863: 

*-- Linhas 1916 a 1955:
1916:             IF USED("cursor_4c_BuscaFtio")
1917:                 USE IN cursor_4c_BuscaFtio
1918:             ENDIF
1919:             IF SQLEXEC(gnConnHandle, ;
1920:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1921:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1922:                 SELECT cursor_4c_BuscaFtio
1923:                 GO TOP
1924:                 IF !EOF("cursor_4c_BuscaFtio")
1925:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1926:                     USE IN cursor_4c_BuscaFtio
1927:                     RETURN
1928:                 ENDIF
1929:                 USE IN cursor_4c_BuscaFtio
1930:             ENDIF
1931:         ENDIF
1932:         TRY
1933:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1934:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1935:             IF VARTYPE(loc_oBA) = "O"
1936:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1937:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1938:                 loc_oBA.Show()
1939:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1940:                     SELECT cursor_4c_BuscaFtio
1941:                     GO TOP
1942:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1943:                 ELSE
1944:                     THIS.txt_4c_CFtios.Value = ""
1945:                 ENDIF
1946:                 IF USED("cursor_4c_BuscaFtio")
1947:                     USE IN cursor_4c_BuscaFtio
1948:                 ENDIF
1949:             ENDIF
1950:         CATCH TO loc_oErro
1951:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1952:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1953:         ENDTRY
1954:     ENDPROC
1955: 

*-- Linhas 1994 a 2035:
1994:         ENDIF
1995: 
1996:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
1997:             SELECT cursor_4c_Produtos
1998:             GO TOP
1999:             THIS.grd_4c_Dados.Refresh()
2000:         ENDIF
2001:     ENDPROC
2002: 
2003:     *==========================================================================
2004:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2005:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2006:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2007:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2008:     *==========================================================================
2009:     PROCEDURE AlternarPagina(par_nPagina)
2010:         LOCAL loc_nPagina
2011: 
2012:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2013: 
2014:         DO CASE
2015:         CASE loc_nPagina = 1
2016:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2017:                 THIS.txt_4c_GrupoIni.SetFocus()
2018:             ENDIF
2019:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2020:                 SELECT cursor_4c_Produtos
2021:                 GO TOP
2022:                 THIS.grd_4c_Dados.Refresh()
2023:             ENDIF
2024:         CASE loc_nPagina = 2
2025:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2026:                 THIS.grd_4c_Dados.SetFocus()
2027:             ENDIF
2028:         ENDCASE
2029: 
2030:         RETURN .T.
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2035:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.

*-- Linhas 2046 a 2064:
2046:                 USE IN cursor_4c_Produtos
2047:             ENDIF
2048: 
2049:             CREATE CURSOR cursor_4c_Produtos ( ;
2050:                 lMarca  N(1) NULL, ;
2051:                 CPros   C(14) NULL, ;
2052:                 DPros   C(40) NULL, ;
2053:                 ValAnt  N(14,4) NULL, ;
2054:                 ValAtu  N(14,4) NULL, ;
2055:                 fCustos N(9,4) NULL, ;
2056:                 MoePcs  C(3) NULL, ;
2057:                 CustoFs N(14,4) NULL, ;
2058:                 Manual  N(1) NULL)
2059:             INDEX ON CPros TAG CPros
2060:             SET NULL OFF
2061: 
2062:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2063:                 THIS.grd_4c_Dados.ColumnCount = 5
2064:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"

