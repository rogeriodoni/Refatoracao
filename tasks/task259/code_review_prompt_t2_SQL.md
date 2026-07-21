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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2182 linhas total):

*-- Linhas 776 a 881:
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
787:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
788:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
789:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
790:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
791:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
792: 
793:             *-- Coluna 1: CheckBox de selecao
794:             WITH .Column1
795:                 .Width      = 25
796:                 .Movable    = .F.
797:                 .Resizable  = .F.
798:                 .Sparse     = .F.
799:                 .AddObject("Check1", "CheckBox")
800:                 .Check1.Caption = ""
801:                 .Check1.Value   = 0
802:                 .CurrentControl = "Check1"
803:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
804:                 WITH .Header1
805:                     .Caption = ""
806:                     .Tag     = "1"
807:                 ENDWITH
808:             ENDWITH
809: 
810:             *-- Coluna 2: Codigo do produto
811:             WITH .Column2
812:                 .Width         = 110
813:                 .Movable       = .F.
814:                 .Resizable     = .F.
815:                 .ReadOnly      = .T.
816:                 .ControlSource = "cursor_4c_Produtos.CPros"
817:                 WITH .Header1
818:                     .Caption = "Produto"
819:                 ENDWITH
820:                 WITH .Text1
821:                     .FontName = "Verdana"
822:                     .FontSize = 8
823:                 ENDWITH
824:             ENDWITH
825: 
826:             *-- Coluna 3: Descricao (ReadOnly)
827:             WITH .Column3
828:                 .Width         = 260
829:                 .Movable       = .F.
830:                 .Resizable     = .F.
831:                 .ReadOnly      = .T.
832:                 .ControlSource = "cursor_4c_Produtos.DPros"
833:                 WITH .Header1
834:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
835:                 ENDWITH
836:                 WITH .Text1
837:                     .FontName = "Verdana"
838:                     .FontSize = 8
839:                 ENDWITH
840:             ENDWITH
841: 
842:             *-- Coluna 4: Preco Anterior (ReadOnly)
843:             WITH .Column4
844:                 .Width         = 165
845:                 .Movable       = .F.
846:                 .Resizable     = .F.
847:                 .ReadOnly      = .T.
848:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
849:                 .Alignment     = 3
850:                 WITH .Header1
851:                     .Caption = "Pre" + CHR(231) + "o Anterior"
852:                 ENDWITH
853:                 WITH .Text1
854:                     .FontName  = "Verdana"
855:                     .FontSize  = 8
856:                     .InputMask = "999,999.99"
857:                 ENDWITH
858:             ENDWITH
859: 
860:             *-- Coluna 5: Preco Atual (editavel se LibValAtu)
861:             WITH .Column5
862:                 .Width         = 165
863:                 .Movable       = .F.
864:                 .Resizable     = .F.
865:                 .ReadOnly      = !THIS.this_lLibValAtu
866:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
867:                 .Alignment     = 3
868:                 WITH .Header1
869:                     .Caption = "Pre" + CHR(231) + "o Atual"
870:                     IF !THIS.this_lLibValAtu
871:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
872:                     ENDIF
873:                 ENDWITH
874:                 WITH .Text1
875:                     .FontName  = "Verdana"
876:                     .FontSize  = 8
877:                     .InputMask = "999,999.99"
878:                 ENDWITH
879:             ENDWITH
880:         ENDWITH
881:     ENDPROC

*-- Linhas 974 a 994:
974:             IF loc_lSucesso
975:                 THIS.grd_4c_Dados.ColumnCount = 3
976:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
977:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
978:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
979:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
980:                 THIS.grd_4c_Dados.Refresh()
981:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
982:                 THIS.cmg_4c_Botoes.Refresh()
983:                 THIS.grd_4c_Dados.Column1.SetFocus()
984:             ENDIF
985:         CATCH TO loc_oErro
986:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
987:                     " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
988:         ENDTRY
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * BtnAtualizarClick - Grava alteracoes no banco de dados
993:     *==========================================================================
994:     PROCEDURE BtnAtualizarClick()

*-- Linhas 1055 a 1099:
1055:         TRY
1056:             IF !USED("cursor_4c_Produtos")
1057:                 SET NULL ON
1058:                 CREATE CURSOR cursor_4c_Produtos ( ;
1059:                     lMarca  N(1) NULL, ;
1060:                     CPros   C(14) NULL, ;
1061:                     DPros   C(40) NULL, ;
1062:                     ValAnt  N(14,4) NULL, ;
1063:                     ValAtu  N(14,4) NULL, ;
1064:                     fCustos N(9,4) NULL, ;
1065:                     MoePcs  C(3) NULL, ;
1066:                     CustoFs N(14,4) NULL, ;
1067:                     Manual  N(1) NULL)
1068:                 INDEX ON CPros TAG CPros
1069:                 SET NULL OFF
1070:             ENDIF
1071: 
1072:             INSERT INTO cursor_4c_Produtos ;
1073:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1074:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1075: 
1076:             SELECT cursor_4c_Produtos
1077:             SET ORDER TO
1078:             GO BOTTOM
1079: 
1080:             THIS.grd_4c_Dados.ColumnCount = 3
1081:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1082:             THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
1083:             THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
1084:             THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
1085:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1086:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1087:             THIS.grd_4c_Dados.Refresh()
1088:             THIS.grd_4c_Dados.SetFocus()
1089:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1092:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1093:         ENDTRY
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1098:     * Delega para BtnProcessarClick que executa o processamento principal
1099:     *==========================================================================

*-- Linhas 1120 a 1138:
1120:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1121:                         "Visualizar")
1122:             ELSE
1123:                 SELECT cursor_4c_Produtos
1124:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1125:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1126:                             "Visualizar")
1127:                 ELSE
1128:                     THIS.GrdAfterRowColChange(2)
1129:                     THIS.grd_4c_Dados.Refresh()
1130:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1131:                         THIS.img_4c_Foto.Refresh()
1132:                     ENDIF
1133:                 ENDIF
1134:             ENDIF
1135:         CATCH TO loc_oErro
1136:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1137:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1138:         ENDTRY

*-- Linhas 1150 a 1191:
1150:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1151:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1152:             ELSE
1153:                 SELECT cursor_4c_Produtos
1154:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1155: 
1156:                 IF loc_nRemovidos = 0
1157:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1158:                             "Excluir")
1159:                         IF !EOF("cursor_4c_Produtos")
1160:                             DELETE
1161:                             PACK MEMO
1162:                             loc_nRemovidos = 1
1163:                         ENDIF
1164:                     ENDIF
1165:                 ELSE
1166:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1167:                             " produto(s) marcado(s) do grid?", "Excluir")
1168:                         DELETE FOR NVL(lMarca, 0) = 1
1169:                         PACK MEMO
1170:                     ELSE
1171:                         loc_nRemovidos = 0
1172:                     ENDIF
1173:                 ENDIF
1174: 
1175:                 IF loc_nRemovidos > 0
1176:                     SELECT cursor_4c_Produtos
1177:                     GO TOP
1178:                     THIS.grd_4c_Dados.Refresh()
1179:                     THIS.Refresh()
1180:                 ENDIF
1181:             ENDIF
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1184:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1185:         ENDTRY
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1190:     *==========================================================================
1191:     PROCEDURE OptTipoChange()

*-- Linhas 1279 a 1317:
1279:         IF THIS.chk_4c_Auditado.Value = 1
1280:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1281:             IF USED("cursor_4c_Produtos")
1282:                 INSERT INTO cursor_4c_Produtos ;
1283:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1284:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1285:                 SELECT cursor_4c_Produtos
1286:                 SET ORDER TO
1287:                 GO TOP
1288:             ENDIF
1289:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1290:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1291:             THIS.txt_4c_Colecao.Enabled               = .F.
1292:             THIS.txt_4c_Moeda.Enabled                 = .F.
1293:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1294:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1295:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1296:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1297:             THIS.grd_4c_Dados.Refresh()
1298:         ELSE
1299:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1300:             IF USED("cursor_4c_Produtos")
1301:                 DELETE FROM cursor_4c_Produtos
1302:                 SELECT cursor_4c_Produtos
1303:                 SET ORDER TO CPros
1304:                 GO TOP
1305:             ENDIF
1306:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1307:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1308:             THIS.txt_4c_Colecao.Enabled               = .T.
1309:             THIS.txt_4c_Moeda.Enabled                 = .T.
1310:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1311:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1312:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1313:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1314:             THIS.grd_4c_Dados.Refresh()
1315:             THIS.txt_4c_GrupoIni.SetFocus()
1316:         ENDIF
1317:         THIS.cmg_4c_Botoes.Refresh()

*-- Linhas 1325 a 1383:
1325: 
1326:         TRY
1327:             IF USED("cursor_4c_Produtos")
1328:                 SELECT cursor_4c_Produtos
1329:                 IF EOF("cursor_4c_Produtos")
1330:                     THIS.img_4c_Foto.Visible = .F.
1331:                     THIS.img_4c_Foto.Picture = ""
1332:                 ELSE
1333:                     *-- Rastrear edicao manual do preco (Column5)
1334:                     IF par_nColIndex = 5
1335:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1336:                     ELSE
1337:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1338:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1339:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1340:                         ENDIF
1341:                         THIS.this_cAntValue = ""
1342:                         ENDIF
1343:                     ENDIF
1344: 
1345:                     *-- Exibir foto do produto
1346:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1347:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1348:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1349:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1350:                         IF USED("cursor_4c_FigTemp")
1351:                             USE IN cursor_4c_FigTemp
1352:                         ENDIF
1353:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1354:                             SELECT cursor_4c_FigTemp
1355:                             THIS.img_4c_Foto.Visible = .F.
1356:                             THIS.img_4c_Foto.Picture = ""
1357:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1358:                                 CLEAR RESOURCES
1359:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1360:                                     "data:image/png;base64,", ""), ;
1361:                                     "data:image/jpeg;base64,", ""), ;
1362:                                     "data:image/jpg;base64,", ""), 14)
1363:                                 STRTOFILE(loc_cFoto, loc_cArqFig)
1364:                                 THIS.img_4c_Foto.Picture = loc_cArqFig
1365:                                 THIS.img_4c_Foto.Visible = .T.
1366:                             ENDIF
1367:                             USE IN cursor_4c_FigTemp
1368:                             SELECT cursor_4c_Produtos
1369:                         ELSE
1370:                             THIS.img_4c_Foto.Visible = .F.
1371:                             THIS.img_4c_Foto.Picture = ""
1372:                         ENDIF
1373:                     ELSE
1374:                         THIS.img_4c_Foto.Visible = .F.
1375:                         THIS.img_4c_Foto.Picture = ""
1376:                     ENDIF
1377:                 ENDIF
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             IF USED("cursor_4c_FigTemp")
1381:                 USE IN cursor_4c_FigTemp
1382:             ENDIF
1383:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1393 a 1414:
1393:             RETURN
1394:         ENDIF
1395:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1396:             UPDATE cursor_4c_Produtos SET lMarca = 1
1397:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1398:         ELSE
1399:             UPDATE cursor_4c_Produtos SET lMarca = 0
1400:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1401:         ENDIF
1402:         THIS.grd_4c_Dados.Refresh()
1403:         THIS.Refresh()
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1408:     *==========================================================================
1409:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1410:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1411:             RETURN
1412:         ENDIF
1413:         IF THIS.chk_4c_Auditado.Value != 1
1414:             RETURN

*-- Linhas 1442 a 1477:
1442:             IF USED("cursor_4c_BuscaProSingle")
1443:                 USE IN cursor_4c_BuscaProSingle
1444:             ENDIF
1445:             IF SQLEXEC(gnConnHandle, ;
1446:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1447:                 "cursor_4c_BuscaProSingle") >= 1 ;
1448:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1449: 
1450:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1451:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1452:                     SELECT cursor_4c_BuscaProSingle
1453:                     GO TOP
1454:                     SCATTER MEMVAR MEMO
1455:                     SELECT cursor_4c_TmpPro
1456:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1457:                     INDEX ON CPros TAG CPros
1458:                 ENDIF
1459: 
1460:                 *-- Posicionar TmpPro no produto e calcular preco
1461:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1462:                 SELECT cursor_4c_TmpPro
1463: 
1464:             *-- Calcular novo preco
1465:             DO CASE
1466:             CASE loc_nTipo = 1
1467:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1468:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1469:             CASE loc_nTipo = 2
1470:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)
1471:             CASE loc_nTipo = 3
1472:                 loc_nCotId  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), ;
1473:                     DATETIME(), gnConnHandle)
1474:                 loc_nCotVd  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs), ;
1475:                     DATETIME(), gnConnHandle)
1476:                 loc_nPven   = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
1477:                     IIF(loc_nCotVd = 0, 1, loc_nCotVd)

*-- Linhas 1488 a 1529:
1488:             loc_nCustoFs = cursor_4c_TmpPro.CustoFs
1489: 
1490:             *-- Atualizar linha corrente no grid
1491:             SELECT cursor_4c_Produtos
1492:             REPLACE lMarca   WITH 1,                              ;
1493:                     CPros    WITH par_cCPros,                     ;
1494:                     DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
1495:                     ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
1496:                     ValAtu   WITH loc_nValAtu,                     ;
1497:                     fCustos  WITH loc_nFCustos,                   ;
1498:                     MoePcs   WITH loc_cMoePcs,                    ;
1499:                     CustoFs  WITH loc_nCustoFs,                   ;
1500:                     Manual   WITH 0
1501: 
1502:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1503:             THIS.cmg_4c_Botoes.Refresh()
1504: 
1505:             *-- Adicionar linha vazia para o proximo produto
1506:             SELECT cursor_4c_Produtos
1507:             SET ORDER TO
1508:             GO BOTTOM
1509:             IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1510:                 INSERT INTO cursor_4c_Produtos ;
1511:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1512:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1513:             ENDIF
1514:             SELECT cursor_4c_Produtos
1515:             THIS.grd_4c_Dados.Refresh()
1516:             KEYBOARD "{DNARROW}"
1517: 
1518:                     IF USED("cursor_4c_BuscaProSingle")
1519:                         USE IN cursor_4c_BuscaProSingle
1520:                     ENDIF
1521:                 ELSE
1522:                     IF USED("cursor_4c_BuscaProSingle")
1523:                         USE IN cursor_4c_BuscaProSingle
1524:                     ENDIF
1525:                 ENDIF
1526:             ELSE
1527:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1528:                 IF USED("cursor_4c_BuscaProSingle")
1529:                     USE IN cursor_4c_BuscaProSingle

*-- Linhas 1562 a 1605:
1562:             IF USED("cursor_4c_BuscaGrp")
1563:                 USE IN cursor_4c_BuscaGrp
1564:             ENDIF
1565:             IF SQLEXEC(gnConnHandle, ;
1566:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1567:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1568:                 SELECT cursor_4c_BuscaGrp
1569:                 GO TOP
1570:                 IF !EOF("cursor_4c_BuscaGrp")
1571:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1572:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1573:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1574:                     ENDIF
1575:                     USE IN cursor_4c_BuscaGrp
1576:                     RETURN
1577:                 ENDIF
1578:                 USE IN cursor_4c_BuscaGrp
1579:             ENDIF
1580:         ENDIF
1581:         TRY
1582:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1583:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1584:                 "Grupos de Produto", .T., .T., "")
1585:             IF VARTYPE(loc_oBA) = "O"
1586:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1587:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1588:                 loc_oBA.Show()
1589:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1590:                     SELECT cursor_4c_BuscaGrp
1591:                     GO TOP
1592:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1593:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1594:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1595:                     ENDIF
1596:                 ELSE
1597:                     par_oTxtAlvo.Value = ""
1598:                 ENDIF
1599:                 IF USED("cursor_4c_BuscaGrp")
1600:                     USE IN cursor_4c_BuscaGrp
1601:                 ENDIF
1602:             ENDIF
1603:         CATCH TO loc_oErro
1604:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1605:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")

*-- Linhas 1619 a 1659:
1619:             IF USED("cursor_4c_BuscaCol")
1620:                 USE IN cursor_4c_BuscaCol
1621:             ENDIF
1622:             IF SQLEXEC(gnConnHandle, ;
1623:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1624:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1625:                 SELECT cursor_4c_BuscaCol
1626:                 GO TOP
1627:                 IF !EOF("cursor_4c_BuscaCol")
1628:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1629:                     USE IN cursor_4c_BuscaCol
1630:                     RETURN
1631:                 ENDIF
1632:                 USE IN cursor_4c_BuscaCol
1633:             ENDIF
1634:         ENDIF
1635:         TRY
1636:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1637:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1638:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1639:             IF VARTYPE(loc_oBA) = "O"
1640:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1641:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1642:                 loc_oBA.Show()
1643:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1644:                     SELECT cursor_4c_BuscaCol
1645:                     GO TOP
1646:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1647:                 ELSE
1648:                     THIS.txt_4c_Colecao.Value = ""
1649:                 ENDIF
1650:                 IF USED("cursor_4c_BuscaCol")
1651:                     USE IN cursor_4c_BuscaCol
1652:                 ENDIF
1653:             ENDIF
1654:         CATCH TO loc_oErro
1655:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1656:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1657:         ENDTRY
1658:     ENDPROC
1659: 

*-- Linhas 1667 a 1716:
1667:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1668:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1669:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1670:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1671: 
1672:         IF !EMPTY(loc_cVal)
1673:             IF USED("cursor_4c_BuscaConta")
1674:                 USE IN cursor_4c_BuscaConta
1675:             ENDIF
1676:             IF SQLEXEC(gnConnHandle, ;
1677:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1678:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1679:                 SELECT cursor_4c_BuscaConta
1680:                 GO TOP
1681:                 IF !EOF("cursor_4c_BuscaConta")
1682:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1683:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1684:                     USE IN cursor_4c_BuscaConta
1685:                     RETURN
1686:                 ENDIF
1687:                 USE IN cursor_4c_BuscaConta
1688:             ENDIF
1689:         ENDIF
1690:         TRY
1691:             LOCAL loc_cFiltroBA
1692:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1693:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1694:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1695:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1696:             IF VARTYPE(loc_oBA) = "O"
1697:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1698:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1699:                 loc_oBA.Show()
1700:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1701:                     SELECT cursor_4c_BuscaConta
1702:                     GO TOP
1703:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1704:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1705:                 ELSE
1706:                     THIS.txt_4c_Conta.Value  = ""
1707:                     THIS.txt_4c_DConta.Value = ""
1708:                 ENDIF
1709:                 IF USED("cursor_4c_BuscaConta")
1710:                     USE IN cursor_4c_BuscaConta
1711:                 ENDIF
1712:             ENDIF
1713:         CATCH TO loc_oErro
1714:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1715:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1716:         ENDTRY

*-- Linhas 1729 a 1778:
1729:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1730:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1731:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1732:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1733: 
1734:         IF !EMPTY(loc_cVal)
1735:             IF USED("cursor_4c_BuscaConta")
1736:                 USE IN cursor_4c_BuscaConta
1737:             ENDIF
1738:             IF SQLEXEC(gnConnHandle, ;
1739:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1740:                 EscaparSQL(loc_cVal + "%") + ;
1741:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1742:                 "cursor_4c_BuscaConta") > 0
1743:                 SELECT cursor_4c_BuscaConta
1744:                 GO TOP
1745:                 IF !EOF("cursor_4c_BuscaConta")
1746:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1747:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1748:                     USE IN cursor_4c_BuscaConta
1749:                     RETURN
1750:                 ENDIF
1751:                 USE IN cursor_4c_BuscaConta
1752:             ENDIF
1753:         ENDIF
1754:         TRY
1755:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1756:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1757:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1758:             IF VARTYPE(loc_oBA) = "O"
1759:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1760:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1761:                 loc_oBA.Show()
1762:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1763:                     SELECT cursor_4c_BuscaConta
1764:                     GO TOP
1765:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1766:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1767:                 ELSE
1768:                     THIS.txt_4c_DConta.Value = ""
1769:                 ENDIF
1770:                 IF USED("cursor_4c_BuscaConta")
1771:                     USE IN cursor_4c_BuscaConta
1772:                 ENDIF
1773:             ENDIF
1774:         CATCH TO loc_oErro
1775:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1776:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1777:         ENDTRY
1778:     ENDPROC

*-- Linhas 1790 a 1829:
1790:             IF USED("cursor_4c_BuscaPromo")
1791:                 USE IN cursor_4c_BuscaPromo
1792:             ENDIF
1793:             IF SQLEXEC(gnConnHandle, ;
1794:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1795:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1796:                 SELECT cursor_4c_BuscaPromo
1797:                 GO TOP
1798:                 IF !EOF("cursor_4c_BuscaPromo")
1799:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1800:                     USE IN cursor_4c_BuscaPromo
1801:                     RETURN
1802:                 ENDIF
1803:                 USE IN cursor_4c_BuscaPromo
1804:             ENDIF
1805:         ENDIF
1806:         TRY
1807:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1808:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1809:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1810:             IF VARTYPE(loc_oBA) = "O"
1811:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1812:                 loc_oBA.Show()
1813:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1814:                     SELECT cursor_4c_BuscaPromo
1815:                     GO TOP
1816:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1817:                 ELSE
1818:                     THIS.txt_4c_Promo.Value = ""
1819:                 ENDIF
1820:                 IF USED("cursor_4c_BuscaPromo")
1821:                     USE IN cursor_4c_BuscaPromo
1822:                 ENDIF
1823:             ENDIF
1824:         CATCH TO loc_oErro
1825:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1826:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1827:         ENDTRY
1828:     ENDPROC
1829: 

*-- Linhas 1837 a 1876:
1837:             IF USED("cursor_4c_BuscaMoe")
1838:                 USE IN cursor_4c_BuscaMoe
1839:             ENDIF
1840:             IF SQLEXEC(gnConnHandle, ;
1841:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1842:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1843:                 SELECT cursor_4c_BuscaMoe
1844:                 GO TOP
1845:                 IF !EOF("cursor_4c_BuscaMoe")
1846:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1847:                     USE IN cursor_4c_BuscaMoe
1848:                     RETURN
1849:                 ENDIF
1850:                 USE IN cursor_4c_BuscaMoe
1851:             ENDIF
1852:         ENDIF
1853:         TRY
1854:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1855:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1856:             IF VARTYPE(loc_oBA) = "O"
1857:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1858:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1859:                 loc_oBA.Show()
1860:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1861:                     SELECT cursor_4c_BuscaMoe
1862:                     GO TOP
1863:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1864:                 ELSE
1865:                     par_oTxt.Value = ""
1866:                 ENDIF
1867:                 IF USED("cursor_4c_BuscaMoe")
1868:                     USE IN cursor_4c_BuscaMoe
1869:                 ENDIF
1870:             ENDIF
1871:         CATCH TO loc_oErro
1872:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1873:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1874:         ENDTRY
1875:     ENDPROC
1876: 

*-- Linhas 1929 a 1968:
1929:             IF USED("cursor_4c_BuscaFtio")
1930:                 USE IN cursor_4c_BuscaFtio
1931:             ENDIF
1932:             IF SQLEXEC(gnConnHandle, ;
1933:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1934:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1935:                 SELECT cursor_4c_BuscaFtio
1936:                 GO TOP
1937:                 IF !EOF("cursor_4c_BuscaFtio")
1938:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1939:                     USE IN cursor_4c_BuscaFtio
1940:                     RETURN
1941:                 ENDIF
1942:                 USE IN cursor_4c_BuscaFtio
1943:             ENDIF
1944:         ENDIF
1945:         TRY
1946:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1947:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1948:             IF VARTYPE(loc_oBA) = "O"
1949:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1950:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1951:                 loc_oBA.Show()
1952:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1953:                     SELECT cursor_4c_BuscaFtio
1954:                     GO TOP
1955:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1956:                 ELSE
1957:                     THIS.txt_4c_CFtios.Value = ""
1958:                 ENDIF
1959:                 IF USED("cursor_4c_BuscaFtio")
1960:                     USE IN cursor_4c_BuscaFtio
1961:                 ENDIF
1962:             ENDIF
1963:         CATCH TO loc_oErro
1964:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1965:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1966:         ENDTRY
1967:     ENDPROC
1968: 

*-- Linhas 2010 a 2051:
2010:         ENDIF
2011: 
2012:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2013:             SELECT cursor_4c_Produtos
2014:             GO TOP
2015:             THIS.grd_4c_Dados.Refresh()
2016:         ENDIF
2017:     ENDPROC
2018: 
2019:     *==========================================================================
2020:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2021:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2022:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2023:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2024:     *==========================================================================
2025:     PROCEDURE AlternarPagina(par_nPagina)
2026:         LOCAL loc_nPagina
2027: 
2028:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2029: 
2030:         DO CASE
2031:         CASE loc_nPagina = 1
2032:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2033:                 THIS.txt_4c_GrupoIni.SetFocus()
2034:             ENDIF
2035:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2036:                 SELECT cursor_4c_Produtos
2037:                 GO TOP
2038:                 THIS.grd_4c_Dados.Refresh()
2039:             ENDIF
2040:         CASE loc_nPagina = 2
2041:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2042:                 THIS.grd_4c_Dados.SetFocus()
2043:             ENDIF
2044:         ENDCASE
2045: 
2046:         RETURN .T.
2047:     ENDPROC
2048: 
2049:     *==========================================================================
2050:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2051:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.

*-- Linhas 2062 a 2100:
2062:                 USE IN cursor_4c_Produtos
2063:             ENDIF
2064: 
2065:             CREATE CURSOR cursor_4c_Produtos ( ;
2066:                 lMarca  N(1) NULL, ;
2067:                 CPros   C(14) NULL, ;
2068:                 DPros   C(40) NULL, ;
2069:                 ValAnt  N(14,4) NULL, ;
2070:                 ValAtu  N(14,4) NULL, ;
2071:                 fCustos N(9,4) NULL, ;
2072:                 MoePcs  C(3) NULL, ;
2073:                 CustoFs N(14,4) NULL, ;
2074:                 Manual  N(1) NULL)
2075:             INDEX ON CPros TAG CPros
2076:             SET NULL OFF
2077: 
2078:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2079:                 THIS.grd_4c_Dados.ColumnCount = 5
2080:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2081:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
2082:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
2083:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
2084:                 THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
2085:                 THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
2086:                 THIS.grd_4c_Dados.Refresh()
2087:             ENDIF
2088: 
2089:             THIS.AjustarBotoesPorModo()
2090: 
2091:             loc_lSucesso = .T.
2092:         CATCH TO loc_oErro
2093:             SET NULL OFF
2094:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2095:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2096:         ENDTRY
2097: 
2098:         RETURN loc_lSucesso
2099:     ENDPROC
2100: 

