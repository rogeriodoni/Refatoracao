# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, ESTOS, CPROS, EMPGRUESTS, DATAS, EMPDOPNUMS, EMPDNPS, CGRUS, LCWHEREHIS, CODCORS, CODTAMS, CODBARRAS, DOPPS, NUMPS, DOPES, NUMES, CEMPS, TIPO, VALUE, CBARS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, ESTOS, CPROS, EMPGRUESTS, DATAS, EMPDOPNUMS, EMPDNPS, CGRUS, LCWHEREHIS, CODCORS, CODTAMS, CODBARRAS, DOPPS, NUMPS, DOPES, NUMES, CEMPS, TIPO, VALUE, CBARS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, ESTOS, CPROS, EMPGRUESTS, DATAS, EMPDOPNUMS, EMPDNPS, CGRUS, LCWHEREHIS, CODCORS, CODTAMS, CODBARRAS, DOPPS, NUMPS, DOPES, NUMES, CEMPS, TIPO, VALUE, CBARS

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
lcSql = [Select cunis, cestos from SigCdUni ]
ThisForm.Podatamgr.sqlexecute(lcsql,'CrTmpUni')
Select CrTmpUni
	Insert Into CsCabecalho (NomeEmpresa, Titulo1, Titulo2, Periodo, Opcao, Obs, ImpMedio, ImpPeso );
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.grupos,a.estos,a.cpros,a.codcors,a.codtams,a.spesos,b.cunis,b.cunips ]+;
			   [From SigMvEst a, SigCdPro b ]+;
	Select TmpEst
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select emps,grupos,estos,dopes,numes,empgruests,empdopnums,cpros,datas,]+;
		   [From SigMvHst ]+;
	Select TmpHis
	Select a.cpros,b.datas,a.codcors,a.codtams,a.estos,a.grupos,b.emps,b.dopes,b.numes,b.empdopnums,;
	From TmpEst a, TmpHis b ;
	Select TmpRelatorio
	Select CsRelatorio
		oProg.Update(.T.)
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select grupoos,contaos,grupods,contads ]+;
					   [From SigMvCab ]+;
		Select TprMvCab
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select grupoos,contaos,grupods,contads ]+;
						   [From SigCdNec ]+;
			Select TprMvCab
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cpros,dpros,cunis ]+;
					   [From SigCdPro ]+;
		Select TmpPro
		Select CsRelatorio
		=Seek(CsRelatorio.cunis,'CrTmpUni')
	Select CsRelatorio
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cunis,cgrus,cpros,dpros,cunips From SigCdPro Where cpros = "]+lcCdCodigo+[" ],"CrSigCdPro")
	Select CrSigCdPro
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select tipoestos From SigCdGrp Where cgrus = "]+lcGrupo+[" ],"CrSigCdGrp")
	Select CrSigCdGrp
	=Seek(CrSigCdPro.cunis,'CrTmpUni')
	Insert Into CsCabecalho (NomeEmpresa, Titulo1, Titulo2, Periodo, Produto, Unidade, Opcao, Obs, ImpPeso, ImpMedio, Traco );
	lcQuery = [Select emps,grupos,estos,cpros,codcors,codtams,CidChaves,codbarras,dopes,numes,]+;
			  [As contads, pesos, spesos, ']+Space(40)+['as dpros, '   'as cunis, '   'as cunips From SigMvHst ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcQuery,"CrSigMvHst")
	Select CrSigMvHst
		loBarra.Update(.T.)
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select grupoos,contaos,grupods,contads,Notas From SigMvCab ]+;
		Select TprMvCab
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select grupoos,contaos,grupods,contads ]+;
						   [From SigCdNec ]+;
			Select TprMvCab
					lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select Nops From SigPdMvf ]+;
					Select TmpMfas
						Select TmpOps
						If !Seek(lcNop)
					Select TmpOps
					lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigMvPec ]+;
					Select TmpEstPe
						Select CrOpe
						lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select Notas From SigMvCab ]+;
						Select CrEest
	Insert Into TempCab From MemVar
	Select CrSigMvHst
lcQueryEmp = [Select cemps,razas From SigCdEmp Where cemps = ']+_Empr+[' ]
Select CrSigCdEmp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select tipoestos From SigCdPam ],'CrSigCdPam')
			Select CrSigCdEmp
			Select CrSigCdEmp
		lnQueryOk = .poDataMgr.SqlExecute([Select cpros From SigOpEtq Where cbars = ]+lcCdBarra+[ ],'TmpEti')
		Select TmpEti
			lnQueryOk = .poDataMgr.SqlExecute([Select cpros From SigCdPro Where cbars = ]+lcCdBarra+[ ],'TmpPro')
			Select TmpPro
				lnQueryOk = .poDataMgr.SqlExecute([Select cpros,dpros From SigCdPro Where cbars = ]+lcCdBarra+[ ],'TmpPro')
				Select TmpPro
			lnQueryOk = .poDataMgr.SqlExecute([Select cpros,dpros From SigCdPro Where cpros = ']+lcCprosEti+[' ],'TmpPro')
			Select TmpPro

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1629 linhas total):

*-- Linhas 818 a 841:
818:             loc_cCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
819:         ENDIF
820:         IF !EMPTY(loc_cCod) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
821:             loc_nResult = SQLEXEC(gnConnHandle, ;
822:                 "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
823:                 EscaparSQL(loc_cCod), ;
824:                 "cursor_4c_SigrehprEmpLg")
825:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpLg")
826:                 SELECT cursor_4c_SigrehprEmpLg
827:                 loc_cDs = ALLTRIM(cursor_4c_SigrehprEmpLg.razas)
828:             ENDIF
829:             IF USED("cursor_4c_SigrehprEmpLg")
830:                 USE IN cursor_4c_SigrehprEmpLg
831:             ENDIF
832:         ENDIF
833:         THIS.txt_4c_CdEmpresa.Value = loc_cCod
834:         THIS.txt_4c_DsEmpresa.Value = loc_cDs
835:     ENDPROC
836: 
837:     *--------------------------------------------------------------------------
838:     * AtualizarHabilitacaoCampos - Habilita/desabilita campos por tipo
839:     * Equivale aos When events do original
840:     *--------------------------------------------------------------------------
841:     PROTECTED PROCEDURE AtualizarHabilitacaoCampos()

*-- Linhas 973 a 996:
973:                 THIS.txt_4c_DsEstoque.Value   = ""
974:                 RETURN
975:             ENDIF
976:             loc_nResult = SQLEXEC(gnConnHandle, ;
977:                 "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
978:                 EscaparSQL(loc_cCodigo), ;
979:                 "cursor_4c_SigrehprGcrVl")
980:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprGcrVl")
981:                 SELECT cursor_4c_SigrehprGcrVl
982:                 THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.codigos)
983:                 THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.descs)
984:             ELSE
985:                 MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
986:                          "Grupo de Estoque")
987:                 THIS.txt_4c_CdGrEstoque.Value = ""
988:                 THIS.txt_4c_DsGrEstoque.Value = ""
989:                 THIS.AbrirBuscaGrEstoque()
990:             ENDIF
991:             IF USED("cursor_4c_SigrehprGcrVl")
992:                 USE IN cursor_4c_SigrehprGcrVl
993:             ENDIF
994:         CATCH TO loc_oErro
995:             MsgErro(loc_oErro.Message, "Erro")
996:         ENDTRY

*-- Linhas 1021 a 1039:
1021:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1022:                 loc_oBusca.Show()
1023:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1024:                     SELECT (loc_cCursor)
1025:                     THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
1026:                     THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)
1027:                     THIS.txt_4c_CdEstoque.Value   = ""
1028:                     THIS.txt_4c_DsEstoque.Value   = ""
1029:                 ENDIF
1030:                 loc_oBusca.Release()
1031:             ENDIF
1032:         CATCH TO loc_oErro
1033:             MsgErro(loc_oErro.Message, "Erro")
1034:         ENDTRY
1035:         IF USED(loc_cCursor)
1036:             USE IN (loc_cCursor)
1037:         ENDIF
1038:     ENDPROC
1039: 

*-- Linhas 1067 a 1092:
1067:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
1068:             loc_cFiltro = ""
1069:             IF !EMPTY(loc_cGrupo)
1070:                 loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1071:             ENDIF
1072:             loc_nResult = SQLEXEC(gnConnHandle, ;
1073:                 "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
1074:                 EscaparSQL(loc_cCodigo) + loc_cFiltro, ;
1075:                 "cursor_4c_SigrehprCliVl")
1076:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprCliVl")
1077:                 SELECT cursor_4c_SigrehprCliVl
1078:                 THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.iclis)
1079:                 THIS.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.rclis)
1080:             ELSE
1081:                 MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
1082:                          "Conta de Estoque")
1083:                 THIS.txt_4c_CdEstoque.Value = ""
1084:                 THIS.txt_4c_DsEstoque.Value = ""
1085:                 THIS.AbrirBuscaEstoque()
1086:             ENDIF
1087:             IF USED("cursor_4c_SigrehprCliVl")
1088:                 USE IN cursor_4c_SigrehprCliVl
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message, "Erro")
1092:         ENDTRY

*-- Linhas 1110 a 1138:
1110:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
1111:             loc_cFiltro = ""
1112:             IF !EMPTY(loc_cGrupo)
1113:                 loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1114:             ENDIF
1115:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1116:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
1117:                 "Selecionar Conta de Estoque", loc_cFiltro)
1118:             IF VARTYPE(loc_oBusca) = "O"
1119:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1120:                 loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
1121:                 loc_oBusca.Show()
1122:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1123:                     SELECT (loc_cCursor)
1124:                     THIS.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
1125:                     THIS.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
1126:                 ENDIF
1127:                 loc_oBusca.Release()
1128:             ENDIF
1129:         CATCH TO loc_oErro
1130:             MsgErro(loc_oErro.Message, "Erro")
1131:         ENDTRY
1132:         IF USED(loc_cCursor)
1133:             USE IN (loc_cCursor)
1134:         ENDIF
1135:     ENDPROC
1136: 
1137:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
1138:         IF par_nKeyCode = 115

*-- Linhas 1161 a 1184:
1161:                 THIS.txt_4c_DsCodigo.Value = ""
1162:                 RETURN
1163:             ENDIF
1164:             loc_nResult = SQLEXEC(gnConnHandle, ;
1165:                 "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
1166:                 EscaparSQL(loc_cCodigo), ;
1167:                 "cursor_4c_SigrehprProVl")
1168:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl")
1169:                 SELECT cursor_4c_SigrehprProVl
1170:                 THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.cpros)
1171:                 THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.dpros)
1172:             ELSE
1173:                 MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Produto")
1174:                 THIS.txt_4c_CdCodigo.Value = ""
1175:                 THIS.txt_4c_DsCodigo.Value = ""
1176:                 THIS.AbrirBuscaCodigo()
1177:             ENDIF
1178:             IF USED("cursor_4c_SigrehprProVl")
1179:                 USE IN cursor_4c_SigrehprProVl
1180:             ENDIF
1181:         CATCH TO loc_oErro
1182:             MsgErro(loc_oErro.Message, "Erro")
1183:         ENDTRY
1184:     ENDPROC

*-- Linhas 1206 a 1224:
1206:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1207:                 loc_oBusca.Show()
1208:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1209:                     SELECT (loc_cCursor)
1210:                     THIS.txt_4c_CdCodigo.Value = ALLTRIM(cpros)
1211:                     THIS.txt_4c_DsCodigo.Value = ALLTRIM(dpros)
1212:                 ENDIF
1213:                 loc_oBusca.Release()
1214:             ENDIF
1215:         CATCH TO loc_oErro
1216:             MsgErro(loc_oErro.Message, "Erro")
1217:         ENDTRY
1218:         IF USED(loc_cCursor)
1219:             USE IN (loc_cCursor)
1220:         ENDIF
1221:     ENDPROC
1222: 
1223:     PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
1224:         IF par_nKeyCode = 115

*-- Linhas 1252 a 1329:
1252:             ENDIF
1253: 
1254:             *-- 1. Buscar em SigOpEtq por cbars
1255:             loc_nResult = SQLEXEC(gnConnHandle, ;
1256:                 "SELECT TOP 1 cpros FROM SigOpEtq WHERE cbars = " + ;
1257:                 ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
1258:                 "cursor_4c_SigrehprEtqVl")
1259:             IF loc_nResult < 1
1260:                 MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
1261:                         "digo de barras.", "ValidarCdBarra")
1262:                 RETURN
1263:             ENDIF
1264: 
1265:             SELECT cursor_4c_SigrehprEtqVl
1266:             GO TOP
1267:             IF !EOF("cursor_4c_SigrehprEtqVl")
1268:                 *-- Encontrado em SigOpEtq: buscar produto pelo cpros
1269:                 loc_cCpros = ALLTRIM(cursor_4c_SigrehprEtqVl.cpros)
1270:                 IF USED("cursor_4c_SigrehprEtqVl")
1271:                     USE IN cursor_4c_SigrehprEtqVl
1272:                 ENDIF
1273:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1274:                     "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
1275:                     EscaparSQL(loc_cCpros), ;
1276:                     "cursor_4c_SigrehprProVl2")
1277:                 IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl2")
1278:                     SELECT cursor_4c_SigrehprProVl2
1279:                     THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.cpros)
1280:                     THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.dpros)
1281:                 ENDIF
1282:                 IF USED("cursor_4c_SigrehprProVl2")
1283:                     USE IN cursor_4c_SigrehprProVl2
1284:                 ENDIF
1285:             ELSE
1286:                 *-- Nao encontrado em SigOpEtq: buscar em SigCdPro por cbars
1287:                 IF USED("cursor_4c_SigrehprEtqVl")
1288:                     USE IN cursor_4c_SigrehprEtqVl
1289:                 ENDIF
1290:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1291:                     "SELECT TOP 1 cpros FROM SigCdPro WHERE cbars = " + ;
1292:                     ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
1293:                     "cursor_4c_SigrehprPrvVl")
1294:                 IF loc_nResult < 1
1295:                     MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
1296:                             "digo de barras.", "ValidarCdBarra")
1297:                 ELSE
1298:                     SELECT cursor_4c_SigrehprPrvVl
1299:                     GO TOP
1300:                     IF EOF("cursor_4c_SigrehprPrvVl")
1301:                         MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + ;
1302:                                  "o cadastrado!", "C" + CHR(243) + "digo de Barras")
1303:                         THIS.txt_4c_CdCodigo.Value = ""
1304:                         THIS.txt_4c_DsCodigo.Value = ""
1305:                     ELSE
1306:                         IF USED("cursor_4c_SigrehprPrvVl")
1307:                             USE IN cursor_4c_SigrehprPrvVl
1308:                         ENDIF
1309:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1310:                             "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cbars = " + ;
1311:                             ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
1312:                             "cursor_4c_SigrehprProVl3")
1313:                         IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl3")
1314:                             SELECT cursor_4c_SigrehprProVl3
1315:                             THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.cpros)
1316:                             THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.dpros)
1317:                         ENDIF
1318:                         IF USED("cursor_4c_SigrehprProVl3")
1319:                             USE IN cursor_4c_SigrehprProVl3
1320:                         ENDIF
1321:                     ENDIF
1322:                     IF USED("cursor_4c_SigrehprPrvVl")
1323:                         USE IN cursor_4c_SigrehprPrvVl
1324:                     ENDIF
1325:                 ENDIF
1326:             ENDIF
1327: 
1328:             IF USED("cursor_4c_SigrehprEtqVl")
1329:                 USE IN cursor_4c_SigrehprEtqVl

*-- Linhas 1352 a 1375:
1352:                 THIS.txt_4c_DsEmpresa.Value = ""
1353:                 RETURN
1354:             ENDIF
1355:             loc_nResult = SQLEXEC(gnConnHandle, ;
1356:                 "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
1357:                 EscaparSQL(loc_cCodigo), ;
1358:                 "cursor_4c_SigrehprEmpVl")
1359:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpVl")
1360:                 SELECT cursor_4c_SigrehprEmpVl
1361:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.cemps)
1362:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.razas)
1363:             ELSE
1364:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
1365:                 THIS.txt_4c_CdEmpresa.Value = ""
1366:                 THIS.txt_4c_DsEmpresa.Value = ""
1367:                 THIS.AbrirBuscaEmpresa()
1368:             ENDIF
1369:             IF USED("cursor_4c_SigrehprEmpVl")
1370:                 USE IN cursor_4c_SigrehprEmpVl
1371:             ENDIF
1372:         CATCH TO loc_oErro
1373:             MsgErro(loc_oErro.Message, "Erro")
1374:         ENDTRY
1375:     ENDPROC

*-- Linhas 1395 a 1413:
1395:                 loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
1396:                 loc_oBusca.Show()
1397:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1398:                     SELECT (loc_cCursor)
1399:                     THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cemps)
1400:                     THIS.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
1401:                 ENDIF
1402:                 loc_oBusca.Release()
1403:             ENDIF
1404:         CATCH TO loc_oErro
1405:             MsgErro(loc_oErro.Message, "Erro")
1406:         ENDTRY
1407:         IF USED(loc_cCursor)
1408:             USE IN (loc_cCursor)
1409:         ENDIF
1410:     ENDPROC
1411: 
1412:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1413:         IF par_nKeyCode = 115


### BO (C:\4c\projeto\app\classes\sigrehprBO.prg):
*==============================================================================
* SIGREHPRBO.PRG
* Business Object para Relatorio de Historico de Produtos (SIGREHPR)
*
* Herda de: RelatorioBase
* Tabelas: SigMvHst, SigMvEst, SigCdPro, SigCdEmp, SigCdGrp, SigCdPam
*           SigMvCab, SigCdNec, SigOpEtq, SigCdUni, SigPdMvf, SigMvPec
*==============================================================================

DEFINE CLASS sigrehprBO AS RelatorioBase

    *-- Identificacao
    this_cTabela          = "SigMvHst"
    this_cCampoChave      = ""

    *-- Modo de filtragem
    *-- Valores possiveis: 'REFERENCIA', 'CODIGO DE BARRA', 'GERAL'
    this_cTipo            = "REFERENCIA"
    this_nOptTipo         = 1     && 1=Referencia, 2=Codigo de Barras, 3=Geral por Referencia

    *-- Filtro: Grupo de Estoque (SigCdGrp)
    this_cCdGrEstoque     = ""    && cgrus / MaxLength 10
    this_cDsGrEstoque     = ""    && dgrus / MaxLength 20

    *-- Filtro: Estoque (SigCdEst)
    this_cCdEstoque       = ""    && MaxLength 10
    this_cDsEstoque       = ""    && MaxLength 40

    *-- Filtro: Produto (SigCdPro)
    this_cCdCodigo        = ""    && cpros / MaxLength 14
    this_cDsCodigo        = ""    && dpros / MaxLength 40

    *-- Filtro: Periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro: Codigo de Barras (SigOpEtq.cbars / SigCdPro.cbars)
    this_nCdBarra         = 0

    *-- Filtro: Empresa (SigCdEmp)
    this_cEmpresa         = ""    && cemps / MaxLength 3
    this_cDesEmpresa      = ""    && razas

    *-- Opcoes de impressao
    this_nOptObs          = 2     && 1=Sim, 2=Nao, 3=C/Documento
    this_nImpMedio        = 1     && 1=Sim, 2=Nao

    *-- Dados calculados para cabecalho do relatorio
    this_cNomeEmpresa     = ""    && SigCdEmp.razas (empresa selecionada)
    this_cTitulo1         = ""    && Titulo principal fixo
    this_cTitulo2         = ""    && Subtitulo (grupo/estoque/empresa filtrados)
    this_cPeriodo         = ""    && Periodo formatado "dd/mm/aa a dd/mm/aa"

    *-- Cursors de saida
    this_cCursorDados     = "CsRelatorio"    && Cursor com registros do historico
    this_cCursorCabecalho = "CsCabecalho"    && Cursor com dados de cabecalho para FRX

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            THIS.this_cTipo       = "REFERENCIA"
            THIS.this_nOptTipo    = 1
            THIS.this_nOptObs     = 2
            THIS.this_nImpMedio   = 1
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cTitulo1    = "Hist" + CHR(243) + "rico de Produtos"
            loc_lSucesso          = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena preparacao dos dados conforme modo de filtragem
    * Popula CsCabecalho e CsRelatorio (modo 3) ou CrSigMvHst (modo 1/2)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        PRIVATE ldDtInicial, ldDtFinal
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cEmp, loc_cGrEst, loc_cCdEstoque, loc_cDsEstoque
        LOCAL loc_cCdCodigo, loc_cDsCodigo, loc_nCdBarra, loc_nImpMedio
        LOCAL loc_lObs
        LOCAL loc_cTitulo2Grp, loc_cTitulo2Est, loc_cTitulo2Emp

        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            THIS.LimparCursors()

            *-- Capturar filtros das propriedades
            loc_cEmp       = PADR(ALLTRIM(THIS.this_cEmpresa), 3)
            loc_cGrEst     = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cCdEstoque = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cDsEstoque = THIS.this_cDsEstoque
            loc_cCdCodigo  = PADR(THIS.this_cCdCodigo, 14)
            loc_cDsCodigo  = THIS.this_cDsCodigo
            loc_nCdBarra   = THIS.this_nCdBarra
            loc_nImpMedio  = THIS.this_nImpMedio
            loc_lObs       = INLIST(THIS.this_nOptObs, 1, 3)

            *-- Converter datas para DATETIME com hora (necessario para BETWEEN em SigMvHst.datas)
            ldDtInicial = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtInicial, CTOD('01/01/1900'))) + '000000'), ;
                '@R 9999-99-99 99:99:99') + [}])
            ldDtFinal = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtFinal, CTOD('01/01/1900'))) + '235959'), ;
                '@R 9999-99-99 99:99:99') + [}])

            *-- Buscar nome da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), ;
                "cursor_4c_CrEmpSrh")
            IF loc_nResult > 0
                SELECT cursor_4c_CrEmpSrh
                GO TOP
                IF !EOF()
                    THIS.this_cNomeEmpresa = ALLTRIM(cursor_4c_CrEmpSrh.razas)
                ENDIF
                USE IN cursor_4c_CrEmpSrh
            ENDIF

            *-- Montar periodo formatado
            THIS.this_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- Montar titulo2 (grupo / estoque / empresa filtrados)
            loc_cTitulo2Grp = IIF(EMPTY(loc_cGrEst), "", ;
                ALLTRIM(THIS.this_cCdGrEstoque) + " - " + ALLTRIM(THIS.this_cDsGrEstoque))
            loc_cTitulo2Est = IIF(EMPTY(loc_cCdEstoque), "", ;
                IIF(EMPTY(loc_cGrEst), "", CHR(13)) + ;
                ALLTRIM(THIS.this_cCdEstoque) + " - " + ALLTRIM(THIS.this_cDsEstoque))
            loc_cTitulo2Emp = IIF(EMPTY(loc_cEmp), "", ;
                " / " + ALLTRIM(THIS.this_cEmpresa) + " - " + ALLTRIM(THIS.this_cDesEmpresa))
            THIS.this_cTitulo2 = loc_cTitulo2Grp + loc_cTitulo2Est + loc_cTitulo2Emp

            *-- Buscar tabela de unidades de medida (usada para verificar peso)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cunis, cestos FROM SigCdUni", ;
                "CrTmpUni")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar unidades de medida"
            ELSE
                SELECT CrTmpUni
                INDEX ON cunis TAG cunis

                DO CASE
                CASE THIS.this_nOptTipo = 3
                    loc_lSucesso = THIS.PrepararDadosGeral(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_lObs, loc_nImpMedio)
                OTHERWISE
                    loc_lSucesso = THIS.PrepararDadosRef(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_cCdCodigo, loc_cDsCodigo, ;
                        loc_nCdBarra, loc_lObs, loc_nImpMedio)
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosGeral - Modo 3: Geral Por Referencia
    * Cruza SigMvEst com SigMvHst para todos os produtos do estoque filtrado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosGeral(par_cEmp, par_cGrEst, par_cCdEstoque, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cCodPro, loc_cEmpDopNums, loc_cEmpDnps
        LOCAL loc_cGrupoos, loc_cContaos, loc_cGrupods, loc_cContads
        LOCAL loc_cCunis, loc_cDpros

        loc_lSucesso = .F.
        loc_lErro    = .F.

        *-- Cursor de cabecalho (modo 3: sem Produto/Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Opcao N(1), Obs L, ImpMedio L, ImpPeso L, TRACO L)
        INSERT INTO CsCabecalho (NomeEmpresa, Titulo1, Titulo2, Periodo, Opcao, Obs, ImpMedio, ImpPeso) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, 3, par_lObs, (par_nImpMedio = 1), .F.)

        *-- Selecionar posicoes de estoque (SigMvEst JOIN SigCdPro)
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT a.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, " + ;
            "a.spesos, b.cunis, b.cunips " + ;
            "FROM SigMvEst a, SigCdPro b " + ;
            "WHERE a.emps = " + EscaparSQL(par_cEmp) + ;
            " AND a.grupos = " + EscaparSQL(par_cGrEst) + ;
            " AND a.estos = " + EscaparSQL(par_cCdEstoque) + ;
            " AND a.cpros = b.cpros", ;
            "TmpEst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar dados do estoque"
            RETURN .F.
        ENDIF
        SELECT TmpEst
        INDEX ON emps   TAG emps
        INDEX ON grupos TAG grupos
        INDEX ON estos  TAG estos
        INDEX ON cpros  TAG cpros

        *-- Selecionar historico de movimentos (SigMvHst) com parametros de data
        IF USED("TmpHis")
            USE IN TmpHis
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT emps, grupos, estos, dopes, numes, empgruests, empdopnums, " + ;
            "cpros, datas, qtds, sqtds, opers, codbarras, unitmeds, moedmeds, " + ;
            "obs, CidChaves, pesos, spesos " + ;
            "FROM SigMvHst " + ;
            "WHERE empgruests = " + EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal " + ;
            "ORDER BY emps, grupos, estos, cpros, CidChaves", ;
            "TmpHis")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico (geral)"
            RETURN .F.
        ENDIF
        SELECT TmpHis
        INDEX ON empgruests TAG empgruests
        INDEX ON cpros      TAG cpros

        *-- JOIN local VFP: TmpEst x TmpHis -> CsRelatorio (READWRITE para REPLACE em seguida)
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        SELECT a.cpros, b.datas, a.codcors, a.codtams, a.estos, a.grupos, ;
               b.emps, b.dopes, b.numes, b.empdopnums, b.qtds, b.opers, ;
               b.sqtds, b.codbarras, b.unitmeds, b.moedmeds, b.obs, ;
               SPACE(40) AS dpros, SPACE(3)  AS cunis, ;
               SPACE(10) AS grupoos, SPACE(10) AS contaos, ;
               SPACE(10) AS grupods, SPACE(10) AS contads, ;
               b.CidChaves, b.pesos, b.spesos, a.cunips ;
        FROM TmpEst a, TmpHis b ;
        WHERE a.emps + a.grupos + a.estos = b.empgruests AND a.cpros = b.cpros ;
        ORDER BY b.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, b.CidChaves ;
        INTO CURSOR CsRelatorio READWRITE

        *-- Enriquecer cada registro com descricoes e grupos contabeis
        SELECT CsRelatorio
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cCodPro     = CsRelatorio.cpros
            loc_cEmpDopNums = CsRelatorio.empdopnums
            loc_cEmpDnps    = LEFT(CsRelatorio.empdopnums, 23) + ;
                              STR(VAL(RIGHT(CsRelatorio.empdopnums, 6)), 10)
            loc_cGrupoos    = ""
            loc_cContaos    = ""
            loc_cGrupods    = ""
            loc_cContads    = ""
            loc_cCunis      = ""
            loc_cDpros      = ""

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                    loc_cContaos = ALLTRIM(TprMvCab.contaos)
                    loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                    loc_cContads = ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: buscar em SigCdNec usando chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                            loc_cContaos = ALLTRIM(TprMvCab.contaos)
                            loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                            loc_cContads = ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lErro
                *-- Buscar descricao e unidade do produto
                IF USED("TmpPro")
                    USE IN TmpPro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, dpros, cunis FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(loc_cCodPro), ;
                    "TmpPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar produto"
                    loc_lErro = .T.
                ELSE
                    SELECT TmpPro
                    GO TOP
                    IF !EOF()
                        loc_cCunis = ALLTRIM(TmpPro.cunis)
                        loc_cDpros = ALLTRIM(TmpPro.dpros)
                    ENDIF
                    USE IN TmpPro
                ENDIF
            ENDIF

            IF !loc_lErro
                SELECT CsRelatorio
                REPLACE CsRelatorio.grupoos WITH loc_cGrupoos
                REPLACE CsRelatorio.contaos WITH loc_cContaos
                REPLACE CsRelatorio.grupods WITH loc_cGrupods
                REPLACE CsRelatorio.contads WITH loc_cContads
                REPLACE CsRelatorio.cunis   WITH loc_cCunis
                REPLACE CsRelatorio.dpros   WITH loc_cDpros

                *-- Verificar se unidade e de peso (cestos='3') para flag ImpPeso
                IF SEEK(loc_cCunis, "CrTmpUni")
                    IF CrTmpUni.cestos = '3'
                        SELECT CsCabecalho
                        GO TOP
                        REPLACE CsCabecalho.ImpPeso WITH .T.
                        SELECT CsRelatorio
                    ELSE
                        REPLACE CsRelatorio.pesos  WITH 0
                        REPLACE CsRelatorio.spesos WITH 0
                    ENDIF
                ENDIF
            ENDIF

        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        SELECT CsRelatorio
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosRef - Modo 1 (Referencia) e Modo 2 (Codigo de Barra)
    * Processa SigMvHst para um produto especifico ou por codigo de barras
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosRef(par_cEmp, par_cGrEst, par_cCdEstoque, ;
                                          par_cCdCodigo, par_cDsCodigo, ;
                                          par_nCdBarra, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cUnidade, loc_cGrupo, loc_cProduto, loc_cNmCodigo, loc_cCdBarra
        LOCAL loc_cWhereHis, loc_cOrderBy, loc_cSQL
        LOCAL loc_nTipoEstos, loc_lImpPeso, loc_lImpMedio
        LOCAL loc_cCorIni, loc_cCorFim, loc_cTamIni, loc_cTamFim
        LOCAL loc_cEmpDopNums, loc_cEmpDnps, loc_cNota, loc_lPrimeira
        LOCAL loc_lOpExiste, loc_cNop
        LOCAL loc_nNdope, loc_nNume, loc_cDopePeca, loc_cEDN, loc_cNotaPeca

        loc_lSucesso  = .F.
        loc_lErro     = .F.
        loc_cNmCodigo = ALLTRIM(par_cCdCodigo) + " - " + ALLTRIM(par_cDsCodigo)
        loc_cCdBarra  = ALLTRIM(STR(par_nCdBarra, 8))

        *-- Buscar dados do produto em SigCdPro
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cunis, cgrus, cpros, dpros, cunips FROM SigCdPro " + ;
            "WHERE cpros = " + EscaparSQL(par_cCdCodigo), ;
            "CrSigCdPro")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar produto"
            RETURN .F.
        ENDIF
        SELECT CrSigCdPro
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCdCodigo)
            RETURN .F.
        ENDIF
        loc_cUnidade = "Unid: " + ALLTRIM(CrSigCdPro.cunis)
        loc_cGrupo   = ALLTRIM(CrSigCdPro.cgrus)

        *-- Buscar tipo de estoque do grupo (SigCdGrp.tipoestos)
        IF USED("CrSigCdGrp")
            USE IN CrSigCdGrp
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT tipoestos FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cGrupo), ;
            "CrSigCdGrp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar grupo de estoque"
            RETURN .F.
        ENDIF
        SELECT CrSigCdGrp
        GO TOP
        loc_nTipoEstos = 0
        IF !EOF()
            loc_nTipoEstos = CrSigCdGrp.tipoestos
        ENDIF

        *-- Montar WHERE e ORDER BY conforme modo e tipo de estoque
        loc_cCorIni = SPACE(4)
        loc_cCorFim = REPLICATE(CHR(254), 4)
        loc_cTamIni = SPACE(2)
        loc_cTamFim = REPLICATE(CHR(254), 2)

        DO CASE
        CASE THIS.this_nOptTipo = 1  && Referencia por produto
            loc_cProduto  = "Produto: " + loc_cNmCodigo
            loc_cWhereHis = "empgruests = " + ;
                EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
                " AND cpros = " + EscaparSQL(par_cCdCodigo)

            DO CASE
            CASE loc_nTipoEstos = 2  && Codigo/Cor
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, CidChaves, opers"
            CASE loc_nTipoEstos = 3  && Codigo/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codtams, CidChaves, opers"
            CASE loc_nTipoEstos = 4  && Codigo/Cor/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, codtams, CidChaves, opers"
            OTHERWISE  && Apenas codigo simples
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, CidChaves, opers"
            ENDCASE

        CASE THIS.this_nOptTipo = 2  && Codigo de Barra
            loc_cProduto  = "Produto: (" + loc_cCdBarra + ") / " + loc_cNmCodigo
            loc_cWhereHis = "emps = " + EscaparSQL(par_cEmp) + ;
                            " AND codbarras = " + TRANSFORM(par_nCdBarra) + ;
                            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
            loc_cOrderBy  = "emps, codbarras, CidChaves"
        ENDCASE

        *-- Verificar se unidade e de peso para ImpPeso do cabecalho
        loc_lImpPeso = .F.
        IF SEEK(ALLTRIM(CrSigCdPro.cunis), "CrTmpUni")
            loc_lImpPeso = (CrTmpUni.cestos = '3')
        ENDIF

        *-- Cursor de cabecalho (modo 1/2: com Produto e Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Produto C(80), Unidade C(20), Opcao N(1), Obs L, ImpPeso L, ;
            ImpMedio L, TRACO L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO CsCabecalho ;
            (NomeEmpresa, Titulo1, Titulo2, Periodo, Produto, Unidade, ;
             Opcao, Obs, ImpPeso, ImpMedio, Traco) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, loc_cProduto, loc_cUnidade, ;
                    THIS.this_nOptTipo, par_lObs, loc_lImpPeso, loc_lImpMedio, par_lObs)

        *-- Query principal em SigMvHst com placeholders para campos enriquecidos
        IF USED("CrSigMvHst")
            USE IN CrSigMvHst
        ENDIF
        loc_cSQL = "SELECT emps, grupos, estos, cpros, codcors, codtams, " + ;
                   "CidChaves, codbarras, dopes, numes, qtds, opers, sqtds, " + ;
                   "unitmeds, moedmeds, obs, empdopnums, empos, datas, " + ;
                   "SPACE(10) AS grupoos, SPACE(10) AS grupods, " + ;
                   "SPACE(10) AS contaos, SPACE(10) AS contads, " + ;
                   "pesos, spesos, " + ;
                   "SPACE(40) AS dpros, SPACE(3) AS cunis, SPACE(3) AS cunips " + ;
                   "FROM SigMvHst " + ;
                   "WHERE " + loc_cWhereHis + ;
                   " ORDER BY " + loc_cOrderBy
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvHst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico"
            RETURN .F.
        ENDIF

        *-- Enriquecer registros com descricoes, grupos contabeis e observacoes
        SELECT CrSigMvHst
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cEmpDopNums = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 6)
            loc_cEmpDnps    = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 10)
            loc_cNota       = ""

            *-- Substituir campos de descricao com dados do produto ja carregado
            SELECT CrSigMvHst
            REPLACE CrSigMvHst.dpros  WITH ALLTRIM(CrSigCdPro.dpros)
            REPLACE CrSigMvHst.cunis  WITH ALLTRIM(CrSigCdPro.cunis)
            REPLACE CrSigMvHst.cunips WITH ALLTRIM(CrSigCdPro.cunips)

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cNota = ALLTRIM(TprMvCab.Notas)
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                    REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                    REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                    REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: SigCdNec com chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            SELECT CrSigMvHst
                            REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                            REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                            REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                            REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            *-- Processar observacao com documento (optObs = 3 = C/Documento)
            IF !loc_lErro AND THIS.this_nOptObs = 3
                IF EMPTY(loc_cNota)
                    *-- Verificar se documento e operacao de producao (SigCdOpd)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 Dopps FROM SigCdOpd " + ;
                        "WHERE Dopps = " + EscaparSQL(CrSigMvHst.dopes), ;
                        "cursor_4c_CkOpd")
                    loc_lOpExiste = (loc_nResult > 0 AND !EOF("cursor_4c_CkOpd"))
                    IF USED("cursor_4c_CkOpd")
                        USE IN cursor_4c_CkOpd
                    ENDIF

                    IF loc_lOpExiste
                        *-- Buscar ordens de producao vinculadas (SigPdMvf)
                        IF USED("cursor_4c_Mfas")
                            USE IN cursor_4c_Mfas
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Nops FROM SigPdMvf " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopps = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numps = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_Mfas")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar OPs de produ" + CHR(231) + CHR(227) + "o"
                            loc_lErro = .T.
                        ELSE
                            *-- Deduplicar OPs (varias linhas podem apontar para mesma OP)
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                            CREATE CURSOR cursor_4c_Ops (Nops C(6))
                            INDEX ON Nops TAG Nops

                            SELECT cursor_4c_Mfas
                            GO TOP
                            SCAN
                                SET DECIMALS TO 0
                                loc_cNop = STR(INT(cursor_4c_Mfas.Nops / 10000), 6)
                                SET DECIMALS TO 2
                                SELECT cursor_4c_Ops
                                IF !SEEK(loc_cNop)
                                    APPEND BLANK
                                    REPLACE Nops WITH loc_cNop
                                ENDIF
                                SELECT cursor_4c_Mfas
                            ENDSCAN

                            *-- Montar texto de observacao concatenando numeros de OP
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_Ops
                            GO TOP
                            SCAN
                                loc_cNota = loc_cNota + ;
                                    IIF(loc_lPrimeira, "Ref. OP: ", " / ") + ;
                                    ALLTRIM(cursor_4c_Ops.Nops)
                                loc_lPrimeira = .F.
                            ENDSCAN

                            IF !EMPTY(loc_cNota)
                                SELECT CrSigMvHst
                                REPLACE CrSigMvHst.obs WITH loc_cNota
                            ENDIF

                            IF USED("cursor_4c_Mfas")
                                USE IN cursor_4c_Mfas
                            ENDIF
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                        ENDIF

                    ELSE
                        *-- Nao e OP: buscar pecas no SigMvPec
                        IF USED("cursor_4c_EstPe")
                            USE IN cursor_4c_EstPe
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Emps, Dopes, Numes, Codigos FROM SigMvPec " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopes = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numes = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_EstPe")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar pe" + CHR(231) + "as"
                            loc_lErro = .T.
                        ELSE
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_EstPe
                            GO TOP
                            SCAN
                                IF loc_lErro
                                    EXIT
                                ENDIF

                                *-- Calcular nDope e Numes a partir do campo Codigos (N10)
                                SET DECIMALS TO 0
                                loc_nNdope = VAL(LEFT(STR(cursor_4c_EstPe.Codigos, 10), 4))
                                loc_nNume  = VAL(RIGHT(STR(cursor_4c_EstPe.Codigos, 10), 6))
                                SET DECIMALS TO 2

                                *-- Buscar Dopes em SigCdOpe pelo numero sequencial
                                IF USED("cursor_4c_Ope")
                                    USE IN cursor_4c_Ope
                                ENDIF
                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT Dopes FROM SigCdOpe " + ;
                                    "WHERE nDopes = " + TRANSFORM(loc_nNdope), ;
                                    "cursor_4c_Ope")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_Ope
                                    GO TOP
                                    IF !EOF()
                                        loc_cDopePeca = ALLTRIM(cursor_4c_Ope.Dopes)
                                        loc_cEDN = cursor_4c_EstPe.Emps + ;
                                                   loc_cDopePeca + ;
                                                   STR(loc_nNume, 6)

                                        *-- Buscar nota fiscal em SigMvCab
                                        IF USED("cursor_4c_Est2")
                                            USE IN cursor_4c_Est2
                                        ENDIF
                                        loc_nResult = SQLEXEC(gnConnHandle, ;
                                            "SELECT Notas FROM SigMvCab " + ;
                                            "WHERE empdopnums = " + EscaparSQL(loc_cEDN), ;
                                            "cursor_4c_Est2")
                                        IF loc_nResult > 0
                                            SELECT cursor_4c_Est2
                                            GO TOP
                                            IF !EOF()
                                                loc_cNotaPeca = ALLTRIM(cursor_4c_Est2.Notas)
                                                IF !EMPTY(loc_cNotaPeca)
                                                    SELECT CrSigMvHst
                                                    REPLACE CrSigMvHst.obs WITH ;
                                                        IIF(loc_lPrimeira, ;
                                                            "Ref. N.F.: ", ;
                                                            CrSigMvHst.obs + " / ") + ;
                                                        loc_cNotaPeca
                                                    loc_lPrimeira = .F.
                                                ENDIF
                                            ENDIF
                                            USE IN cursor_4c_Est2
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_Ope
                                ENDIF

                                SELECT cursor_4c_EstPe
                            ENDSCAN

                            IF USED("cursor_4c_EstPe")
                                USE IN cursor_4c_EstPe
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    *-- Nota da NF ja preenchida: substituir observacao diretamente
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.obs WITH "Ref. N.F.: " + loc_cNota
                ENDIF
            ENDIF

            SELECT CrSigMvHst
        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        *-- Cursor auxiliar de configuracao para o relatorio FRX
        IF USED("TempCab")
            USE IN TempCab
        ENDIF
        CREATE CURSOR TempCab (ImpMedio L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO TempCab (ImpMedio) VALUES (loc_lImpMedio)

        *-- Cursor de estrutura auxiliar (referenciado pelo relatorio FRX)
        IF USED("TmpHist")
            USE IN TmpHist
        ENDIF
        CREATE CURSOR TmpHist (;
            CPros C(14), CodCors C(4), CodTams C(4), Datas D, ;
            Numes N(6,0), Dopes C(20), Qtds N(12,3), Opers C(1), ;
            SQtds N(12,3), UnitMeds N(16,6), MoedMeds C(3), Codbarras N(8,0))

        SELECT CrSigMvHst
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Pre-visualizacao do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                *-- Posicionar cursor de dados correto no inicio
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                *-- Escolher relatorio: SigRehp1 (sem coluna peso) ou SigRehp2 (com peso)
                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") PREVIEW NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") PREVIEW NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursors - Fecha todos os cursores abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursors()
        LOCAL loc_aCursors[19], loc_nI
        loc_aCursors[1]  = "CsRelatorio"
        loc_aCursors[2]  = "CsCabecalho"
        loc_aCursors[3]  = "CrTmpUni"
        loc_aCursors[4]  = "TmpEst"
        loc_aCursors[5]  = "TmpHis"
        loc_aCursors[6]  = "TprMvCab"
        loc_aCursors[7]  = "TmpPro"
        loc_aCursors[8]  = "CrSigCdPro"
        loc_aCursors[9]  = "CrSigCdGrp"
        loc_aCursors[10] = "CrSigMvHst"
        loc_aCursors[11] = "TempCab"
        loc_aCursors[12] = "TmpHist"
        loc_aCursors[13] = "cursor_4c_CrEmpSrh"
        loc_aCursors[14] = "cursor_4c_Mfas"
        loc_aCursors[15] = "cursor_4c_Ops"
        loc_aCursors[16] = "cursor_4c_EstPe"
        loc_aCursors[17] = "cursor_4c_Ope"
        loc_aCursors[18] = "cursor_4c_Est2"
        loc_aCursors[19] = "cursor_4c_CkOpd"
        FOR loc_nI = 1 TO 19
            IF USED(loc_aCursors[loc_nI])
                USE IN (loc_aCursors[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

