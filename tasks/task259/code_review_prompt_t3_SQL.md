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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2175 linhas total):

*-- Linhas 776 a 874:
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
786:             *-- Coluna 1: CheckBox de selecao
787:             WITH .Column1
788:                 .Width      = 25
789:                 .Movable    = .F.
790:                 .Resizable  = .F.
791:                 .Sparse     = .F.
792:                 .AddObject("Check1", "CheckBox")
793:                 .Check1.Caption = ""
794:                 .Check1.Value   = 0
795:                 .CurrentControl = "Check1"
796:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
797:                 WITH .Header1
798:                     .Caption = ""
799:                     .Tag     = "1"
800:                 ENDWITH
801:             ENDWITH
802: 
803:             *-- Coluna 2: Codigo do produto
804:             WITH .Column2
805:                 .Width         = 110
806:                 .Movable       = .F.
807:                 .Resizable     = .F.
808:                 .ReadOnly      = .T.
809:                 .ControlSource = "cursor_4c_Produtos.CPros"
810:                 WITH .Header1
811:                     .Caption = "Produto"
812:                 ENDWITH
813:                 WITH .Text1
814:                     .FontName = "Verdana"
815:                     .FontSize = 8
816:                 ENDWITH
817:             ENDWITH
818: 
819:             *-- Coluna 3: Descricao (ReadOnly)
820:             WITH .Column3
821:                 .Width         = 260
822:                 .Movable       = .F.
823:                 .Resizable     = .F.
824:                 .ReadOnly      = .T.
825:                 .ControlSource = "cursor_4c_Produtos.DPros"
826:                 WITH .Header1
827:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
828:                 ENDWITH
829:                 WITH .Text1
830:                     .FontName = "Verdana"
831:                     .FontSize = 8
832:                 ENDWITH
833:             ENDWITH
834: 
835:             *-- Coluna 4: Preco Anterior (ReadOnly)
836:             WITH .Column4
837:                 .Width         = 165
838:                 .Movable       = .F.
839:                 .Resizable     = .F.
840:                 .ReadOnly      = .T.
841:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
842:                 .Alignment     = 3
843:                 WITH .Header1
844:                     .Caption = "Pre" + CHR(231) + "o Anterior"
845:                 ENDWITH
846:                 WITH .Text1
847:                     .FontName  = "Verdana"
848:                     .FontSize  = 8
849:                     .InputMask = "999,999.99"
850:                 ENDWITH
851:             ENDWITH
852: 
853:             *-- Coluna 5: Preco Atual (editavel se LibValAtu)
854:             WITH .Column5
855:                 .Width         = 165
856:                 .Movable       = .F.
857:                 .Resizable     = .F.
858:                 .ReadOnly      = !THIS.this_lLibValAtu
859:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
860:                 .Alignment     = 3
861:                 WITH .Header1
862:                     .Caption = "Pre" + CHR(231) + "o Atual"
863:                     IF !THIS.this_lLibValAtu
864:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
865:                     ENDIF
866:                 ENDWITH
867:                 WITH .Text1
868:                     .FontName  = "Verdana"
869:                     .FontSize  = 8
870:                     .InputMask = "999,999.99"
871:                 ENDWITH
872:             ENDWITH
873:         ENDWITH
874:     ENDPROC

*-- Linhas 967 a 987:
967:             IF loc_lSucesso
968:                 THIS.grd_4c_Dados.ColumnCount = 3
969:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
970:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
971:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
972:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
973:                 THIS.grd_4c_Dados.Refresh()
974:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
975:                 THIS.cmg_4c_Botoes.Refresh()
976:                 THIS.grd_4c_Dados.Column1.SetFocus()
977:             ENDIF
978:         CATCH TO loc_oErro
979:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
980:                     " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
981:         ENDTRY
982:     ENDPROC
983: 
984:     *==========================================================================
985:     * BtnAtualizarClick - Grava alteracoes no banco de dados
986:     *==========================================================================
987:     PROCEDURE BtnAtualizarClick()

*-- Linhas 1048 a 1092:
1048:         TRY
1049:             IF !USED("cursor_4c_Produtos")
1050:                 SET NULL ON
1051:                 CREATE CURSOR cursor_4c_Produtos ( ;
1052:                     lMarca  N(1) NULL, ;
1053:                     CPros   C(14) NULL, ;
1054:                     DPros   C(40) NULL, ;
1055:                     ValAnt  N(14,4) NULL, ;
1056:                     ValAtu  N(14,4) NULL, ;
1057:                     fCustos N(9,4) NULL, ;
1058:                     MoePcs  C(3) NULL, ;
1059:                     CustoFs N(14,4) NULL, ;
1060:                     Manual  N(1) NULL)
1061:                 INDEX ON CPros TAG CPros
1062:                 SET NULL OFF
1063:             ENDIF
1064: 
1065:             INSERT INTO cursor_4c_Produtos ;
1066:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1067:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1068: 
1069:             SELECT cursor_4c_Produtos
1070:             SET ORDER TO
1071:             GO BOTTOM
1072: 
1073:             THIS.grd_4c_Dados.ColumnCount = 3
1074:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1075:             THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
1076:             THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
1077:             THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
1078:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1079:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1080:             THIS.grd_4c_Dados.Refresh()
1081:             THIS.grd_4c_Dados.SetFocus()
1082:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1083:         CATCH TO loc_oErro
1084:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1085:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1086:         ENDTRY
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1091:     * Delega para BtnProcessarClick que executa o processamento principal
1092:     *==========================================================================

*-- Linhas 1113 a 1131:
1113:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1114:                         "Visualizar")
1115:             ELSE
1116:                 SELECT cursor_4c_Produtos
1117:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1118:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1119:                             "Visualizar")
1120:                 ELSE
1121:                     THIS.GrdAfterRowColChange(2)
1122:                     THIS.grd_4c_Dados.Refresh()
1123:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1124:                         THIS.img_4c_Foto.Refresh()
1125:                     ENDIF
1126:                 ENDIF
1127:             ENDIF
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1130:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1131:         ENDTRY

*-- Linhas 1143 a 1184:
1143:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1144:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1145:             ELSE
1146:                 SELECT cursor_4c_Produtos
1147:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1148: 
1149:                 IF loc_nRemovidos = 0
1150:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1151:                             "Excluir")
1152:                         IF !EOF("cursor_4c_Produtos")
1153:                             DELETE
1154:                             PACK MEMO
1155:                             loc_nRemovidos = 1
1156:                         ENDIF
1157:                     ENDIF
1158:                 ELSE
1159:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1160:                             " produto(s) marcado(s) do grid?", "Excluir")
1161:                         DELETE FOR NVL(lMarca, 0) = 1
1162:                         PACK MEMO
1163:                     ELSE
1164:                         loc_nRemovidos = 0
1165:                     ENDIF
1166:                 ENDIF
1167: 
1168:                 IF loc_nRemovidos > 0
1169:                     SELECT cursor_4c_Produtos
1170:                     GO TOP
1171:                     THIS.grd_4c_Dados.Refresh()
1172:                     THIS.Refresh()
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1177:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1183:     *==========================================================================
1184:     PROCEDURE OptTipoChange()

*-- Linhas 1272 a 1310:
1272:         IF THIS.chk_4c_Auditado.Value = 1
1273:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1274:             IF USED("cursor_4c_Produtos")
1275:                 INSERT INTO cursor_4c_Produtos ;
1276:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1277:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1278:                 SELECT cursor_4c_Produtos
1279:                 SET ORDER TO
1280:                 GO TOP
1281:             ENDIF
1282:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1283:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1284:             THIS.txt_4c_Colecao.Enabled               = .F.
1285:             THIS.txt_4c_Moeda.Enabled                 = .F.
1286:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1287:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1288:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1289:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1290:             THIS.grd_4c_Dados.Refresh()
1291:         ELSE
1292:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1293:             IF USED("cursor_4c_Produtos")
1294:                 DELETE FROM cursor_4c_Produtos
1295:                 SELECT cursor_4c_Produtos
1296:                 SET ORDER TO CPros
1297:                 GO TOP
1298:             ENDIF
1299:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1300:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1301:             THIS.txt_4c_Colecao.Enabled               = .T.
1302:             THIS.txt_4c_Moeda.Enabled                 = .T.
1303:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1304:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1305:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1306:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1307:             THIS.grd_4c_Dados.Refresh()
1308:             THIS.txt_4c_GrupoIni.SetFocus()
1309:         ENDIF
1310:         THIS.cmg_4c_Botoes.Refresh()

*-- Linhas 1318 a 1376:
1318: 
1319:         TRY
1320:             IF USED("cursor_4c_Produtos")
1321:                 SELECT cursor_4c_Produtos
1322:                 IF EOF("cursor_4c_Produtos")
1323:                     THIS.img_4c_Foto.Visible = .F.
1324:                     THIS.img_4c_Foto.Picture = ""
1325:                 ELSE
1326:                     *-- Rastrear edicao manual do preco (Column5)
1327:                     IF par_nColIndex = 5
1328:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1329:                     ELSE
1330:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1331:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1332:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1333:                         ENDIF
1334:                         THIS.this_cAntValue = ""
1335:                         ENDIF
1336:                     ENDIF
1337: 
1338:                     *-- Exibir foto do produto
1339:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1340:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1341:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1342:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1343:                         IF USED("cursor_4c_FigTemp")
1344:                             USE IN cursor_4c_FigTemp
1345:                         ENDIF
1346:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1347:                             SELECT cursor_4c_FigTemp
1348:                             THIS.img_4c_Foto.Visible = .F.
1349:                             THIS.img_4c_Foto.Picture = ""
1350:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1351:                                 CLEAR RESOURCES
1352:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1353:                                     "data:image/png;base64,", ""), ;
1354:                                     "data:image/jpeg;base64,", ""), ;
1355:                                     "data:image/jpg;base64,", ""), 14)
1356:                                 STRTOFILE(loc_cFoto, loc_cArqFig)
1357:                                 THIS.img_4c_Foto.Picture = loc_cArqFig
1358:                                 THIS.img_4c_Foto.Visible = .T.
1359:                             ENDIF
1360:                             USE IN cursor_4c_FigTemp
1361:                             SELECT cursor_4c_Produtos
1362:                         ELSE
1363:                             THIS.img_4c_Foto.Visible = .F.
1364:                             THIS.img_4c_Foto.Picture = ""
1365:                         ENDIF
1366:                     ELSE
1367:                         THIS.img_4c_Foto.Visible = .F.
1368:                         THIS.img_4c_Foto.Picture = ""
1369:                     ENDIF
1370:                 ENDIF
1371:             ENDIF
1372:         CATCH TO loc_oErro
1373:             IF USED("cursor_4c_FigTemp")
1374:                 USE IN cursor_4c_FigTemp
1375:             ENDIF
1376:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1386 a 1407:
1386:             RETURN
1387:         ENDIF
1388:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1389:             UPDATE cursor_4c_Produtos SET lMarca = 1
1390:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1391:         ELSE
1392:             UPDATE cursor_4c_Produtos SET lMarca = 0
1393:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1394:         ENDIF
1395:         THIS.grd_4c_Dados.Refresh()
1396:         THIS.Refresh()
1397:     ENDPROC
1398: 
1399:     *==========================================================================
1400:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1401:     *==========================================================================
1402:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1403:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1404:             RETURN
1405:         ENDIF
1406:         IF THIS.chk_4c_Auditado.Value != 1
1407:             RETURN

*-- Linhas 1435 a 1470:
1435:             IF USED("cursor_4c_BuscaProSingle")
1436:                 USE IN cursor_4c_BuscaProSingle
1437:             ENDIF
1438:             IF SQLEXEC(gnConnHandle, ;
1439:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1440:                 "cursor_4c_BuscaProSingle") >= 1 ;
1441:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1442: 
1443:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1444:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1445:                     SELECT cursor_4c_BuscaProSingle
1446:                     GO TOP
1447:                     SCATTER MEMVAR MEMO
1448:                     SELECT cursor_4c_TmpPro
1449:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1450:                     INDEX ON CPros TAG CPros
1451:                 ENDIF
1452: 
1453:                 *-- Posicionar TmpPro no produto e calcular preco
1454:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1455:                 SELECT cursor_4c_TmpPro
1456: 
1457:             *-- Calcular novo preco
1458:             DO CASE
1459:             CASE loc_nTipo = 1
1460:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1461:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1462:             CASE loc_nTipo = 2
1463:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)
1464:             CASE loc_nTipo = 3
1465:                 loc_nCotId  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), ;
1466:                     DATETIME(), gnConnHandle)
1467:                 loc_nCotVd  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs), ;
1468:                     DATETIME(), gnConnHandle)
1469:                 loc_nPven   = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
1470:                     IIF(loc_nCotVd = 0, 1, loc_nCotVd)

*-- Linhas 1481 a 1522:
1481:             loc_nCustoFs = cursor_4c_TmpPro.CustoFs
1482: 
1483:             *-- Atualizar linha corrente no grid
1484:             SELECT cursor_4c_Produtos
1485:             REPLACE lMarca   WITH 1,                              ;
1486:                     CPros    WITH par_cCPros,                     ;
1487:                     DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
1488:                     ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
1489:                     ValAtu   WITH loc_nValAtu,                     ;
1490:                     fCustos  WITH loc_nFCustos,                   ;
1491:                     MoePcs   WITH loc_cMoePcs,                    ;
1492:                     CustoFs  WITH loc_nCustoFs,                   ;
1493:                     Manual   WITH 0
1494: 
1495:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1496:             THIS.cmg_4c_Botoes.Refresh()
1497: 
1498:             *-- Adicionar linha vazia para o proximo produto
1499:             SELECT cursor_4c_Produtos
1500:             SET ORDER TO
1501:             GO BOTTOM
1502:             IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1503:                 INSERT INTO cursor_4c_Produtos ;
1504:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1505:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1506:             ENDIF
1507:             SELECT cursor_4c_Produtos
1508:             THIS.grd_4c_Dados.Refresh()
1509:             KEYBOARD "{DNARROW}"
1510: 
1511:                     IF USED("cursor_4c_BuscaProSingle")
1512:                         USE IN cursor_4c_BuscaProSingle
1513:                     ENDIF
1514:                 ELSE
1515:                     IF USED("cursor_4c_BuscaProSingle")
1516:                         USE IN cursor_4c_BuscaProSingle
1517:                     ENDIF
1518:                 ENDIF
1519:             ELSE
1520:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1521:                 IF USED("cursor_4c_BuscaProSingle")
1522:                     USE IN cursor_4c_BuscaProSingle

*-- Linhas 1555 a 1598:
1555:             IF USED("cursor_4c_BuscaGrp")
1556:                 USE IN cursor_4c_BuscaGrp
1557:             ENDIF
1558:             IF SQLEXEC(gnConnHandle, ;
1559:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1560:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1561:                 SELECT cursor_4c_BuscaGrp
1562:                 GO TOP
1563:                 IF !EOF("cursor_4c_BuscaGrp")
1564:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1565:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1566:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1567:                     ENDIF
1568:                     USE IN cursor_4c_BuscaGrp
1569:                     RETURN
1570:                 ENDIF
1571:                 USE IN cursor_4c_BuscaGrp
1572:             ENDIF
1573:         ENDIF
1574:         TRY
1575:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1576:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1577:                 "Grupos de Produto", .T., .T., "")
1578:             IF VARTYPE(loc_oBA) = "O"
1579:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1580:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1581:                 loc_oBA.Show()
1582:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1583:                     SELECT cursor_4c_BuscaGrp
1584:                     GO TOP
1585:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1586:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1587:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1588:                     ENDIF
1589:                 ELSE
1590:                     par_oTxtAlvo.Value = ""
1591:                 ENDIF
1592:                 IF USED("cursor_4c_BuscaGrp")
1593:                     USE IN cursor_4c_BuscaGrp
1594:                 ENDIF
1595:             ENDIF
1596:         CATCH TO loc_oErro
1597:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1598:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")

*-- Linhas 1612 a 1652:
1612:             IF USED("cursor_4c_BuscaCol")
1613:                 USE IN cursor_4c_BuscaCol
1614:             ENDIF
1615:             IF SQLEXEC(gnConnHandle, ;
1616:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1617:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1618:                 SELECT cursor_4c_BuscaCol
1619:                 GO TOP
1620:                 IF !EOF("cursor_4c_BuscaCol")
1621:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1622:                     USE IN cursor_4c_BuscaCol
1623:                     RETURN
1624:                 ENDIF
1625:                 USE IN cursor_4c_BuscaCol
1626:             ENDIF
1627:         ENDIF
1628:         TRY
1629:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1630:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1631:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1632:             IF VARTYPE(loc_oBA) = "O"
1633:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1634:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1635:                 loc_oBA.Show()
1636:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1637:                     SELECT cursor_4c_BuscaCol
1638:                     GO TOP
1639:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1640:                 ELSE
1641:                     THIS.txt_4c_Colecao.Value = ""
1642:                 ENDIF
1643:                 IF USED("cursor_4c_BuscaCol")
1644:                     USE IN cursor_4c_BuscaCol
1645:                 ENDIF
1646:             ENDIF
1647:         CATCH TO loc_oErro
1648:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1649:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1650:         ENDTRY
1651:     ENDPROC
1652: 

*-- Linhas 1660 a 1709:
1660:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1661:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1662:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1663:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1664: 
1665:         IF !EMPTY(loc_cVal)
1666:             IF USED("cursor_4c_BuscaConta")
1667:                 USE IN cursor_4c_BuscaConta
1668:             ENDIF
1669:             IF SQLEXEC(gnConnHandle, ;
1670:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1671:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1672:                 SELECT cursor_4c_BuscaConta
1673:                 GO TOP
1674:                 IF !EOF("cursor_4c_BuscaConta")
1675:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1676:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1677:                     USE IN cursor_4c_BuscaConta
1678:                     RETURN
1679:                 ENDIF
1680:                 USE IN cursor_4c_BuscaConta
1681:             ENDIF
1682:         ENDIF
1683:         TRY
1684:             LOCAL loc_cFiltroBA
1685:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1686:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1687:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1688:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1689:             IF VARTYPE(loc_oBA) = "O"
1690:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1691:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1692:                 loc_oBA.Show()
1693:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1694:                     SELECT cursor_4c_BuscaConta
1695:                     GO TOP
1696:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1697:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1698:                 ELSE
1699:                     THIS.txt_4c_Conta.Value  = ""
1700:                     THIS.txt_4c_DConta.Value = ""
1701:                 ENDIF
1702:                 IF USED("cursor_4c_BuscaConta")
1703:                     USE IN cursor_4c_BuscaConta
1704:                 ENDIF
1705:             ENDIF
1706:         CATCH TO loc_oErro
1707:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1708:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1709:         ENDTRY

*-- Linhas 1722 a 1771:
1722:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1723:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1724:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1725:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1726: 
1727:         IF !EMPTY(loc_cVal)
1728:             IF USED("cursor_4c_BuscaConta")
1729:                 USE IN cursor_4c_BuscaConta
1730:             ENDIF
1731:             IF SQLEXEC(gnConnHandle, ;
1732:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1733:                 EscaparSQL(loc_cVal + "%") + ;
1734:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1735:                 "cursor_4c_BuscaConta") > 0
1736:                 SELECT cursor_4c_BuscaConta
1737:                 GO TOP
1738:                 IF !EOF("cursor_4c_BuscaConta")
1739:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1740:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1741:                     USE IN cursor_4c_BuscaConta
1742:                     RETURN
1743:                 ENDIF
1744:                 USE IN cursor_4c_BuscaConta
1745:             ENDIF
1746:         ENDIF
1747:         TRY
1748:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1749:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1750:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1751:             IF VARTYPE(loc_oBA) = "O"
1752:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1753:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1754:                 loc_oBA.Show()
1755:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1756:                     SELECT cursor_4c_BuscaConta
1757:                     GO TOP
1758:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1759:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1760:                 ELSE
1761:                     THIS.txt_4c_DConta.Value = ""
1762:                 ENDIF
1763:                 IF USED("cursor_4c_BuscaConta")
1764:                     USE IN cursor_4c_BuscaConta
1765:                 ENDIF
1766:             ENDIF
1767:         CATCH TO loc_oErro
1768:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1769:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1770:         ENDTRY
1771:     ENDPROC

*-- Linhas 1783 a 1822:
1783:             IF USED("cursor_4c_BuscaPromo")
1784:                 USE IN cursor_4c_BuscaPromo
1785:             ENDIF
1786:             IF SQLEXEC(gnConnHandle, ;
1787:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1788:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1789:                 SELECT cursor_4c_BuscaPromo
1790:                 GO TOP
1791:                 IF !EOF("cursor_4c_BuscaPromo")
1792:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1793:                     USE IN cursor_4c_BuscaPromo
1794:                     RETURN
1795:                 ENDIF
1796:                 USE IN cursor_4c_BuscaPromo
1797:             ENDIF
1798:         ENDIF
1799:         TRY
1800:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1801:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1802:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1803:             IF VARTYPE(loc_oBA) = "O"
1804:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1805:                 loc_oBA.Show()
1806:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1807:                     SELECT cursor_4c_BuscaPromo
1808:                     GO TOP
1809:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1810:                 ELSE
1811:                     THIS.txt_4c_Promo.Value = ""
1812:                 ENDIF
1813:                 IF USED("cursor_4c_BuscaPromo")
1814:                     USE IN cursor_4c_BuscaPromo
1815:                 ENDIF
1816:             ENDIF
1817:         CATCH TO loc_oErro
1818:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1819:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1820:         ENDTRY
1821:     ENDPROC
1822: 

*-- Linhas 1830 a 1869:
1830:             IF USED("cursor_4c_BuscaMoe")
1831:                 USE IN cursor_4c_BuscaMoe
1832:             ENDIF
1833:             IF SQLEXEC(gnConnHandle, ;
1834:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1835:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1836:                 SELECT cursor_4c_BuscaMoe
1837:                 GO TOP
1838:                 IF !EOF("cursor_4c_BuscaMoe")
1839:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1840:                     USE IN cursor_4c_BuscaMoe
1841:                     RETURN
1842:                 ENDIF
1843:                 USE IN cursor_4c_BuscaMoe
1844:             ENDIF
1845:         ENDIF
1846:         TRY
1847:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1848:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1849:             IF VARTYPE(loc_oBA) = "O"
1850:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1851:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1852:                 loc_oBA.Show()
1853:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1854:                     SELECT cursor_4c_BuscaMoe
1855:                     GO TOP
1856:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1857:                 ELSE
1858:                     par_oTxt.Value = ""
1859:                 ENDIF
1860:                 IF USED("cursor_4c_BuscaMoe")
1861:                     USE IN cursor_4c_BuscaMoe
1862:                 ENDIF
1863:             ENDIF
1864:         CATCH TO loc_oErro
1865:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1866:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1867:         ENDTRY
1868:     ENDPROC
1869: 

*-- Linhas 1922 a 1961:
1922:             IF USED("cursor_4c_BuscaFtio")
1923:                 USE IN cursor_4c_BuscaFtio
1924:             ENDIF
1925:             IF SQLEXEC(gnConnHandle, ;
1926:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1927:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1928:                 SELECT cursor_4c_BuscaFtio
1929:                 GO TOP
1930:                 IF !EOF("cursor_4c_BuscaFtio")
1931:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1932:                     USE IN cursor_4c_BuscaFtio
1933:                     RETURN
1934:                 ENDIF
1935:                 USE IN cursor_4c_BuscaFtio
1936:             ENDIF
1937:         ENDIF
1938:         TRY
1939:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1940:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1941:             IF VARTYPE(loc_oBA) = "O"
1942:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1943:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1944:                 loc_oBA.Show()
1945:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1946:                     SELECT cursor_4c_BuscaFtio
1947:                     GO TOP
1948:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1949:                 ELSE
1950:                     THIS.txt_4c_CFtios.Value = ""
1951:                 ENDIF
1952:                 IF USED("cursor_4c_BuscaFtio")
1953:                     USE IN cursor_4c_BuscaFtio
1954:                 ENDIF
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1958:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1959:         ENDTRY
1960:     ENDPROC
1961: 

*-- Linhas 2003 a 2044:
2003:         ENDIF
2004: 
2005:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2006:             SELECT cursor_4c_Produtos
2007:             GO TOP
2008:             THIS.grd_4c_Dados.Refresh()
2009:         ENDIF
2010:     ENDPROC
2011: 
2012:     *==========================================================================
2013:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2014:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2015:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2016:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2017:     *==========================================================================
2018:     PROCEDURE AlternarPagina(par_nPagina)
2019:         LOCAL loc_nPagina
2020: 
2021:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2022: 
2023:         DO CASE
2024:         CASE loc_nPagina = 1
2025:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2026:                 THIS.txt_4c_GrupoIni.SetFocus()
2027:             ENDIF
2028:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2029:                 SELECT cursor_4c_Produtos
2030:                 GO TOP
2031:                 THIS.grd_4c_Dados.Refresh()
2032:             ENDIF
2033:         CASE loc_nPagina = 2
2034:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2035:                 THIS.grd_4c_Dados.SetFocus()
2036:             ENDIF
2037:         ENDCASE
2038: 
2039:         RETURN .T.
2040:     ENDPROC
2041: 
2042:     *==========================================================================
2043:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2044:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.

*-- Linhas 2055 a 2093:
2055:                 USE IN cursor_4c_Produtos
2056:             ENDIF
2057: 
2058:             CREATE CURSOR cursor_4c_Produtos ( ;
2059:                 lMarca  N(1) NULL, ;
2060:                 CPros   C(14) NULL, ;
2061:                 DPros   C(40) NULL, ;
2062:                 ValAnt  N(14,4) NULL, ;
2063:                 ValAtu  N(14,4) NULL, ;
2064:                 fCustos N(9,4) NULL, ;
2065:                 MoePcs  C(3) NULL, ;
2066:                 CustoFs N(14,4) NULL, ;
2067:                 Manual  N(1) NULL)
2068:             INDEX ON CPros TAG CPros
2069:             SET NULL OFF
2070: 
2071:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2072:                 THIS.grd_4c_Dados.ColumnCount = 5
2073:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2074:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
2075:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
2076:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
2077:                 THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
2078:                 THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
2079:                 THIS.grd_4c_Dados.Refresh()
2080:             ENDIF
2081: 
2082:             THIS.AjustarBotoesPorModo()
2083: 
2084:             loc_lSucesso = .T.
2085:         CATCH TO loc_oErro
2086:             SET NULL OFF
2087:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2088:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2089:         ENDTRY
2090: 
2091:         RETURN loc_lSucesso
2092:     ENDPROC
2093: 

