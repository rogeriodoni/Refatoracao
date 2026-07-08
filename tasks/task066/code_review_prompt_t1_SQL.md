# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, DATAS, CODS, VENDS, CPROS, GRUPOS, ESTOS, CUNIS, 0, USUAR, ICLIS, JOBS, USUARS, INATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, DATAS, CODS, VENDS, CPROS, GRUPOS, ESTOS, CUNIS, 0, USUAR, ICLIS, JOBS, USUARS, INATIVAS

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
Insert Into csCabecalho (NomeEmpresa, Titulo, Titulo2) Values (lcEmpresa, lcTitulo, lcTitulo2)
lcQuery = [Select a.cods, a.datas, a.vends, a.emps, b.cpros, b.grupos, b.estos, b.qtds, b.estoque ] + ;
			[from sigcdcrf a ] + ;
			[join sigcdcri b on a.cods = b.cods ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery,[crSigCdCrf])<1)
Select crSigCdCrf
lcQuery = [Select a.Emps, a.Grupos, a.Estos, a.cpros, sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr ] + ;  
	[From SigMvEst a ] + ;    
	[Join SigCdpro b on a.CPros = b.Cpros ] + ;    
	[Join SigCdCli c on a.Estos = c.Iclis ] + ;    
	[join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas ] + ;   
If (Thisform.poDataMgr.SqlExecute(lcQuery,[crTmpCrf])<1)
Select crTmpCrf
	If Not Seek(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros,[crSigCdCrf],[Produto])
		Delete 
	Select crTmpCrf
Select crTmpCrf
Select Emps, grupos, estos, cpros, Sum(Qtde) As Qtds From crTmpCrf Where 0=0 Group By Emps, grupos, estos, cpros Into Cursor csTotLocal Readwrite
Select csTotLocal
	Select Distinct a.DataS, nvl(a.Emps,'') As emps, nvl(a.grupos,'') as grupos, nvl(a.estos,'') as estos, nvl(a.cpros,'') as cpros, ;
		From crTmpCrf b ;
		full outer join crSigCdCrf a On a.emps = b.emps ;
	Select Distinct a.DataS, nvl(a.Emps,'') As emps, nvl(a.grupos,'') as grupos, nvl(a.estos,'') as estos, nvl(a.cpros,'') as cpros, ;
		From crSigCdCrf a ;
		left Join crTmpCrf b On a.emps = b.emps ;
	Select Distinct a.DataS, nvl(a.Emps,'') As emps, nvl(a.grupos,'') as grupos, nvl(a.estos,'') as estos, nvl(a.cpros,'') as cpros, ;
		From crTmpCrf b ;
		left Join crSigCdCrf a On a.emps = b.emps ;
	Select a.DataS, nvl(a.Emps,'') As emps, nvl(a.grupos,'') as grupos, nvl(a.estos,'') as estos, nvl(a.cpros,'') as cpros, ;
		From crTmpCrf b ;
		left Join crSigCdCrf a On a.emps = b.emps ;
Select csRel
Select DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
	From csRel ;
Select crRel
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+This.Value+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVends
	If Seek(Padr(This.Value,10),'CrSigVends','Iclis')
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+lcVends+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVendsf
	If Seek(This.Value,'CrSigVends','Rclis')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1682 linhas total):

*-- Linhas 1046 a 1101:
1046:             loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
1047:         ENDIF
1048: 
1049:         loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
1050:                    "FROM SigCdCli a " + ;
1051:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1052:                    "AND (b.Coletors <> 10 " + ;
1053:                    "OR (b.Coletors = 10 " + ;
1054:                    "AND a.IClis NOT IN (" + ;
1055:                    "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
1056:                    "WHERE c.Jobs NOT IN (" + ;
1057:                    "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
1058:                    "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
1059:         IF !EMPTY(loc_cGrPadVens)
1060:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrPadVens)
1061:         ENDIF
1062:         loc_cSQL = loc_cSQL + " AND a.Inativas <> 2" + ;
1063:                    " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1064:                    " ORDER BY a.rclis"
1065: 
1066:         IF USED("cursor_4c_BuscaVend")
1067:             USE IN SELECT("cursor_4c_BuscaVend")
1068:         ENDIF
1069:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
1070:         IF loc_nResult > 0
1071:             IF RECCOUNT("cursor_4c_BuscaVend") > 0
1072:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1073:                 IF VARTYPE(loc_oLookup) = "O"
1074:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaVend"
1075:                     loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
1076:                         "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
1077:                     IF loc_oLookup.Mostrar()
1078:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1079:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1080:                     ENDIF
1081:                 ENDIF
1082:             ELSE
1083:                 MsgAviso("Nenhum vendedor encontrado.", "Aviso")
1084:             ENDIF
1085:             IF USED("cursor_4c_BuscaVend")
1086:                 USE IN SELECT("cursor_4c_BuscaVend")
1087:             ENDIF
1088:         ELSE
1089:             MsgErro("Erro ao buscar vendedores.", "Erro")
1090:         ENDIF
1091:     ENDPROC
1092: 
1093:     *==========================================================================
1094:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Grupo de Estoque
1095:     *==========================================================================
1096: 
1097:     *--------------------------------------------------------------------------
1098:     * TeclaCdGrEstoque - Handler KeyPress de txt_4c_Cd_GrEstoque (cod grupo)
1099:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1100:     *--------------------------------------------------------------------------
1101:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1137 a 1174:
1137:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1138:             RETURN
1139:         ENDIF
1140:         loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1141:                    "WHERE Codigos = " + EscaparSQL(loc_cValor)
1142:         IF USED("cursor_4c_GrEstVal")
1143:             USE IN SELECT("cursor_4c_GrEstVal")
1144:         ENDIF
1145:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal")
1146:         IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstVal")
1147:             SELECT cursor_4c_GrEstVal
1148:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Codigos)
1149:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Descrs)
1150:         ELSE
1151:             MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
1152:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1153:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
1154:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1155:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1156:             THIS.AbrirBuscaGrEstoque()
1157:         ENDIF
1158:         IF USED("cursor_4c_GrEstVal")
1159:             USE IN SELECT("cursor_4c_GrEstVal")
1160:         ENDIF
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * ValidarDsGrEstoque - Valida descricao (busca reversa); abre lookup
1165:     *   Equivalente ao Get_Ds_GrEstoque.Valid (fAcessoContab 'D') do legado.
1166:     *--------------------------------------------------------------------------
1167:     PROCEDURE ValidarDsGrEstoque()
1168:         LOCAL loc_cValor, loc_oPagina
1169:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1170:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
1171:         IF EMPTY(loc_cValor)
1172:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1173:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1174:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""

*-- Linhas 1185 a 1224:
1185:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1186:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1187:         IF USED("cursor_4c_BuscaGrEst")
1188:             USE IN SELECT("cursor_4c_BuscaGrEst")
1189:         ENDIF
1190:         loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
1191:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrEst")
1192:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrEst") > 0
1193:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1194:             IF VARTYPE(loc_oLookup) = "O"
1195:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaGrEst"
1196:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaGrEst", "Codigos", "Descrs", ;
1197:                     "Grupo de Estoque")
1198:                 IF loc_oLookup.Mostrar()
1199:                     loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1200:                     loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1201:                     loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1202:                     loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1203:                 ENDIF
1204:             ENDIF
1205:         ELSE
1206:             MsgAviso("Nenhum grupo de estoque encontrado.", "Aviso")
1207:         ENDIF
1208:         IF USED("cursor_4c_BuscaGrEst")
1209:             USE IN SELECT("cursor_4c_BuscaGrEst")
1210:         ENDIF
1211:     ENDPROC
1212: 
1213:     *==========================================================================
1214:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Conta de Estoque
1215:     *==========================================================================
1216: 
1217:     *--------------------------------------------------------------------------
1218:     * TeclaCdEstoque - Handler KeyPress de txt_4c_Cd_Estoque (cod conta)
1219:     *   Bloqueia entrada se GrEstoque nao informado (equivalente ao When legado).
1220:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1221:     *--------------------------------------------------------------------------
1222:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
1223:         LOCAL loc_oPagina
1224:         loc_oPagina = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1269 a 1308:
1269:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1270:             RETURN
1271:         ENDIF
1272:         loc_cSQL = "SELECT TOP 1 a.IClis, a.RClis " + ;
1273:                    "FROM SigCdCli a " + ;
1274:                    "WHERE a.IClis = " + EscaparSQL(loc_cValor)
1275:         IF !EMPTY(loc_cGrupo)
1276:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1277:         ENDIF
1278:         IF USED("cursor_4c_EstVal")
1279:             USE IN SELECT("cursor_4c_EstVal")
1280:         ENDIF
1281:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
1282:         IF loc_nResult > 0 AND !EOF("cursor_4c_EstVal")
1283:             SELECT cursor_4c_EstVal
1284:             loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_EstVal.IClis)
1285:             loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_EstVal.RClis)
1286:         ELSE
1287:             MsgAviso("Conta de estoque n" + CHR(227) + "o encontrada.", "Aviso")
1288:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1289:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1290:             THIS.AbrirBuscaEstoque()
1291:         ENDIF
1292:         IF USED("cursor_4c_EstVal")
1293:             USE IN SELECT("cursor_4c_EstVal")
1294:         ENDIF
1295:     ENDPROC
1296: 
1297:     *--------------------------------------------------------------------------
1298:     * ValidarDsEstoque - Valida descricao da conta; abre busca reversa
1299:     *   Equivalente ao Get_Ds_Estoque.Valid (fAcessoContas 'D') do legado.
1300:     *--------------------------------------------------------------------------
1301:     PROCEDURE ValidarDsEstoque()
1302:         LOCAL loc_cValor, loc_oPagina
1303:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1304:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
1305:         IF EMPTY(loc_cValor)
1306:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1307:             RETURN
1308:         ENDIF

*-- Linhas 1318 a 1361:
1318:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1319:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1320:         IF USED("cursor_4c_BuscaEst")
1321:             USE IN SELECT("cursor_4c_BuscaEst")
1322:         ENDIF
1323:         loc_cSQL = "SELECT a.IClis AS Cods, a.RClis AS Descs " + ;
1324:                    "FROM SigCdCli a " + ;
1325:                    "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1326:         IF !EMPTY(loc_cGrupo)
1327:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1328:         ENDIF
1329:         loc_cSQL = loc_cSQL + " ORDER BY a.RClis"
1330:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1331:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEst") > 0
1332:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1333:             IF VARTYPE(loc_oLookup) = "O"
1334:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaEst"
1335:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaEst", "Cods", "Descs", ;
1336:                     "Conta de Estoque")
1337:                 IF loc_oLookup.Mostrar()
1338:                     loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1339:                     loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1340:                 ENDIF
1341:             ENDIF
1342:         ELSE
1343:             MsgAviso("Nenhuma conta de estoque encontrada.", "Aviso")
1344:         ENDIF
1345:         IF USED("cursor_4c_BuscaEst")
1346:             USE IN SELECT("cursor_4c_BuscaEst")
1347:         ENDIF
1348:     ENDPROC
1349: 
1350:     *==========================================================================
1351:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Produto (get_Produto/get_descricao)
1352:     *==========================================================================
1353: 
1354:     *--------------------------------------------------------------------------
1355:     * TeclaProduto - Handler KeyPress de txt_4c__Produto (codigo do produto)
1356:     *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
1357:     *--------------------------------------------------------------------------
1358:     PROCEDURE TeclaProduto(par_nKeyCode, par_nShiftAltCtrl)
1359:         IF par_nKeyCode = 115
1360:             THIS.AbrirBuscaProduto()
1361:         ENDIF

*-- Linhas 1392 a 1427:
1392:             loc_oPagina.txt_4c__descricao.Value = ""
1393:             RETURN
1394:         ENDIF
1395:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
1396:                    "WHERE cpros = " + EscaparSQL(loc_cValor)
1397:         IF USED("cursor_4c_ProdVal")
1398:             USE IN SELECT("cursor_4c_ProdVal")
1399:         ENDIF
1400:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1401:         IF loc_nResult > 0 AND !EOF("cursor_4c_ProdVal")
1402:             SELECT cursor_4c_ProdVal
1403:             loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(cursor_4c_ProdVal.cpros)
1404:             loc_oPagina.txt_4c__descricao.Value = ALLTRIM(cursor_4c_ProdVal.dpros)
1405:         ELSE
1406:             MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Aviso")
1407:             loc_oPagina.txt_4c__Produto.Value   = ""
1408:             loc_oPagina.txt_4c__descricao.Value = ""
1409:             THIS.AbrirBuscaProduto()
1410:         ENDIF
1411:         IF USED("cursor_4c_ProdVal")
1412:             USE IN SELECT("cursor_4c_ProdVal")
1413:         ENDIF
1414:     ENDPROC
1415: 
1416:     *--------------------------------------------------------------------------
1417:     * ValidarDescProduto - Valida descricao (busca reversa em SigCdPro.dpros)
1418:     *   Equivalente ao get_descricao.Valid (fwBuscaExt SigCdPro DPros) do legado.
1419:     *--------------------------------------------------------------------------
1420:     PROCEDURE ValidarDescProduto()
1421:         LOCAL loc_cValor, loc_oPagina
1422:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1423:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
1424:         IF EMPTY(loc_cValor)
1425:             loc_oPagina.txt_4c__Produto.Value = ""
1426:             RETURN
1427:         ENDIF

*-- Linhas 1436 a 1473:
1436:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1437:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1438:         IF USED("cursor_4c_BuscaProd")
1439:             USE IN SELECT("cursor_4c_BuscaProd")
1440:         ENDIF
1441:         loc_cSQL    = "SELECT cpros, dpros FROM SigCdPro ORDER BY dpros"
1442:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
1443:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
1444:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1445:             IF VARTYPE(loc_oLookup) = "O"
1446:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaProd"
1447:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
1448:                     "Sele" + CHR(231) + CHR(227) + "o de Produto")
1449:                 IF loc_oLookup.Mostrar()
1450:                     loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1451:                     loc_oPagina.txt_4c__descricao.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1452:                 ENDIF
1453:             ENDIF
1454:         ELSE
1455:             MsgAviso("Nenhum produto encontrado.", "Aviso")
1456:         ENDIF
1457:         IF USED("cursor_4c_BuscaProd")
1458:             USE IN SELECT("cursor_4c_BuscaProd")
1459:         ENDIF
1460:     ENDPROC
1461: 
1462:     *--------------------------------------------------------------------------
1463:     * ConfigurarPermissoesOptLocal - Controla visibilidade das opcoes do OptLocal
1464:     *   No original: se usuario NAO tem acesso DIFERENCA e nao e '4CONTROL',
1465:     *   esconde opcoes 1,2,3 (mostra apenas "Diferencas"). Caso contrario, todas.
1466:     *   Na nova arquitetura sem fChecaAcesso, default = mostrar todas as opcoes.
1467:     *--------------------------------------------------------------------------
1468:     PROTECTED PROCEDURE ConfigurarPermissoesOptLocal()
1469:         LOCAL loc_oPagina, loc_lMostrarTodas, loc_cUsuario
1470:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
1471:         loc_lMostrarTodas = .T.
1472:         loc_cUsuario     = ""
1473:         IF TYPE("gc_4c_UsuarioLogado") = "C"


### BO (C:\4c\projeto\app\classes\sigrecrfBO.prg):
*==============================================================================
* SIGRECRFBO.PRG
* Business Object para Relatorio de Contagem por Referencia
*
* Herda de: RelatorioBase
* Form: Formsigrecrf.prg
* Relatorio original: sigrecrf.SCX / SigReCrf.FRX
*==============================================================================

DEFINE CLASS sigrecrfBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCrf"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cCods              = ""
    this_cProduto           = ""
    this_cDsProduto         = ""
    this_cCdGrEstoque       = ""
    this_cDsGrEstoque       = ""
    this_cCdEstoque         = ""
    this_cDsEstoque         = ""
    this_nOptLocal          = 4

    *-- Estado / controle
    this_cGrPadVens         = ""
    this_lAcessoSomentesDif = .F.

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init - Carrega GrPadVens de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Contagem por Referencia"
        THIS.this_nOptLocal        = 4

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrecrfPam")

            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPam
                IF !EOF()
                    THIS.this_cGrPadVens = ALLTRIM(GrPadVens)
                ENDIF
                USE IN cursor_4c_SigrecrfPam
            ENDIF

            IF EMPTY(THIS.this_cGrPadVens)
                THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores n" + ;
                    CHR(227) + "o est" + CHR(225) + " configurado nos par" + CHR(226) + ;
                    "metros do sistema. Configure antes de prosseguir."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrfBO.Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor crRel para REPORT FORM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cVends, loc_cCods, loc_cPro, loc_cGrupo, loc_cConta, loc_nLocal
        LOCAL loc_cNomeEmpresa, loc_cTitulo2

        loc_lSucesso = .F.

        TRY
            loc_cVends   = ALLTRIM(THIS.this_cConta)
            loc_nLocal   = THIS.this_nOptLocal
            loc_cCods    = ALLTRIM(THIS.this_cCods)
            loc_cPro     = ALLTRIM(THIS.this_cProduto)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- Limpar cursores de execucao anterior
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("crRel")
                USE IN crRel
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF

            *-- Validar data (obrigatoria exceto para Diferencas - OptLocal=4)
            IF loc_nLocal <> 4 AND EMPTY(THIS.this_dData)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ENDIF

            *-- Montar cabecalho do relatorio
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

            loc_cNomeEmpresa = loc_cEmpresa
            loc_cTitulo2     = ""

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpresa), ;
                "cursor_4c_SigrecrfEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfEmp
                IF !EOF()
                    loc_cNomeEmpresa = loc_cEmpresa + " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_SigrecrfEmp
            ENDIF

            IF !EMPTY(loc_cVends)
                loc_cTitulo2 = "Vendedor - " + loc_cVends + " " + ALLTRIM(THIS.this_cDConta)
            ENDIF

            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2)

            *--------------------------------------------------------------
            *-- QUERY 1: Contagens - sigcdcrf JOIN sigcdcri
            *--------------------------------------------------------------
            loc_cWhere = "a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(THIS.this_dData)
                loc_cWhere = loc_cWhere + ;
                    " And CAST(a.Datas AS DATE) = " + FormatarDataSQL(THIS.this_dData)
            ENDIF
            IF !EMPTY(loc_cCods)
                loc_cWhere = loc_cWhere + " And A.Cods = " + EscaparSQL(loc_cCods)
            ENDIF
            IF !EMPTY(loc_cVends)
                loc_cWhere = loc_cWhere + " And A.Vends = " + EscaparSQL(loc_cVends)
            ENDIF
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And b.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And b.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.cods, a.datas, a.vends, a.emps, " + ;
                       "b.cpros, b.grupos, b.estos, b.qtds, b.estoque " + ;
                       "from sigcdcrf a " + ;
                       "join sigcdcri b on a.cods = b.cods " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar contagens (crSigCdCrf)"
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("crSigCdCrf") = 0
                THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdCrf
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produto
            GO TOP

            *--------------------------------------------------------------
            *-- QUERY 2: Estoque - SigMvEst JOIN SigCdpro/SigCdCli/SigCtCtg
            *--------------------------------------------------------------
            loc_cWhere = "a.emps = " + EscaparSQL(loc_cEmpresa)
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And a.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And a.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And a.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.Emps, a.Grupos, a.Estos, a.cpros, " + ;
                       "sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr " + ;
                       "From SigMvEst a " + ;
                       "Join SigCdpro b on a.CPros = b.Cpros " + ;
                       "Join SigCdCli c on a.Estos = c.Iclis " + ;
                       "join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas " + ;
                       "Where " + loc_cWhere + ;
                       " And b.cunis = 'UN'" + ;
                       " group by a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros" + ;
                       " Having sum(sqtds) <> 0" + ;
                       " order by a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar estoque (crTmpCrf)"
                loc_lSucesso = .F.
            ENDIF

            *-- Remover de crTmpCrf itens ausentes em crSigCdCrf
            SELECT crTmpCrf
            GO TOP
            SCAN
                IF !SEEK(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros, ;
                         "crSigCdCrf", "Produto")
                    DELETE
                ENDIF
                SELECT crTmpCrf
            ENDSCAN

            *-- Agregar crTmpCrf por produto
            SELECT crTmpCrf
            SELECT Emps, grupos, estos, cpros, Sum(Qtde) As Qtds ;
                From crTmpCrf ;
                Where NOT DELETED() ;
                Group By Emps, grupos, estos, cpros ;
                Into Cursor csTotLocal READWRITE

            IF RECCOUNT("csTotLocal") = 0
                THIS.this_cMensagemErro = "Nenhum item de estoque encontrado para os filtros."
                loc_lSucesso = .F.
            ENDIF

            SELECT csTotLocal
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produtos
            GO TOP

            *--------------------------------------------------------------
            *-- Aplicar filtro Localizacoes (OptLocal 1=Todas 2=Lidos 3=NaoLidos 4=Diferencas)
            *--------------------------------------------------------------
            DO CASE
            CASE loc_nLocal = 1
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    FULL OUTER JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 2
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crSigCdCrf a ;
                    LEFT JOIN crTmpCrf b ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 3
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) = 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 4
                SELECT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> NVL(b.Qtde,0) ;
                    Into Cursor csRel READWRITE
            ENDCASE

            *-- Agregacao final -> crRel (cursor do REPORT FORM)
            SELECT DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, ;
                Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
                From csRel ;
                Group By DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr ;
                Into Cursor crRel READWRITE

            SELECT crRel
            INDEX ON Vends + Emps + grupos + estos + cpros TAG Locals
            GO TOP

            *-- Limpar cursores intermediarios
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para planilha Excel via REPORT FORM XML
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReCrf_" + ;
                               STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarVendedores - Busca lista de vendedores para lookup no form
    * Popula cursor_4c_SigrecrfVends com iclis, rclis, grupos, situas, Cpfs
    * Filtra por GrPadVens, Emps, acesso do usuario (SigCdAcJ)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarVendedores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfVends")
                USE IN cursor_4c_SigrecrfVends
            ENDIF

            loc_cSQL = "Select a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs " + ;
                       "From SigCdCli a " + ;
                       "Inner Join SigCdGcr b On a.Grupos = b.Codigos " + ;
                       "And (b.Coletors <> 10 Or (b.Coletors = 10 " + ;
                       "And a.IClis Not In (" + ;
                       "Select Distinct c.Jobs From SigCdAcJ c " + ;
                       "Where c.Jobs Not In (" + ;
                       "Select Distinct d.Jobs From SigCdAcJ d " + ;
                       "Where d.Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       ")))) " + ;
                       "And a.grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " And a.Inativas <> 2" + ;
                       " And a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfVends")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar vendedores"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarVendedores")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Busca produto em SigCdPro para lookup no form
    * par_cFiltro: valor digitado
    * par_cTipo:   "C"=por codigo (cpros), "N"=por descricao (dpros)
    * Popula cursor_4c_SigrecrfPro com cpros, dpros
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cFiltro, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCampo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfPro")
                USE IN cursor_4c_SigrecrfPro
            ENDIF

            IF ALLTRIM(par_cTipo) = "C"
                loc_cCampo = "cpros"
            ELSE
                loc_cCampo = "dpros"
            ENDIF

            loc_cSQL = "Select cpros, dpros " + ;
                       "From SigCdPro " + ;
                       "Where " + loc_cCampo + " LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " Order By dpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfPro")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPro
                GO TOP
                loc_lSucesso = !EOF()
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar produto"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarProduto")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem por Referencia,
    * o unico parametro persistido eh GrPadVens, usado no lookup de vendedor.
    * Retorna .T. se carregou com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Referencia eh apenas leitura: consulta SigCdCrf/SigCdCrI/
    * SigMvEst e gera preview via REPORT FORM. Retorna .F. para satisfazer
    * contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto por
    * data, empresa, vendedor e filtro de localizacao) para fins de auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCRF|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cCods) + "|" + ;
                     ALLTRIM(THIS.this_cProduto) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     TRANSFORM(THIS.this_nOptLocal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crRel")
            USE IN crRel
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrfVends")
            USE IN cursor_4c_SigrecrfVends
        ENDIF
        IF USED("cursor_4c_SigrecrfPro")
            USE IN cursor_4c_SigrecrfPro
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

