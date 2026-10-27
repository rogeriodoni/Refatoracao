# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERACAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CONTAT, VENCS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, LOPAGINA, NUMS, CIDCHAVES, CPFS, PRORROGAS

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
  Column1.ControlSource = ""
  DeleteMark = .F.
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
	lcWherChe = [Select a.*, ' ' as Tipo From SigChe a Where a.Iclis = ?lcCliente Order By a.Vencs]
	lcWherChP = [Select distinct b.Nums From SigChe a Left Join SigCheh b On a.Nums = b.Nums Where a.Iclis = ?lcCliente ]
	lcWherChe = [Select a.*, ' ' as Tipo From SigChe a Where a.Vencs Between ?llDatai And ?llDataf &lcChecaC Order By a.Vencs]
	lcWherChP = [Select distinct b.Nums From SigChe a Left Join SigCheh b On a.Nums = b.Nums Where a.Vencs Between ?llDatai And ?llDataf ]
	lcWherChe = [Select a.*, ' ' as Tipo From SigChe a Where a.Vencs Between ?llDatai And ?llDataf ] +;
	lcWherChP = [Select distinct b.Nums From SigChe a Left Join SigCheh b On a.Nums = b.Nums Where a.Vencs Between ?llDatai And ?llDataf ]
ThisForm.podatamgr.SqlExecute(lcWherChP,'LocalChP')
Select LocalChP
ThisForm.podatamgr.SqlExecute(lcWherChe,'CrSigChe')
Select CrSigChe
	If Seek(CrSigChe.Nums,'LocalchP','Nums')
Select CrSigChe
Update CrSigChe Set DtEmis = Nvl(DtEmis, Ctod([]))
		.Column9.ControlSource = "CrSigChe.Emps"
		.Column1.ControlSource = "Ttod(CrSigChe.Vencs)"
		.Column2.ControlSource = "CrSigChe.Bancos"
		.Column3.ControlSource = "CrSigChe.Agencias"
		.Column4.ControlSource = "CrSigChe.ncontas"
		.Column5.ControlSource = "CrSigChe.ncheques"
		.Column6.ControlSource = "CrSigChe.valors"
		.Column7.ControlSource = "CrSigChe.grucarts"
		.Column8.ControlSource = "CrSigChe.concarts"
		.Column10.ControlSource = "CrSigChe.Numeros"
		.Column11.ControlSource = "CrSigChe.UMovs"
		.Column12.ControlSource = "Ttod(CrSigChe.DtEmis)"
		.Column1.ControlSource = "CrSigCqChm.Codigos"
		.Column2.ControlSource = "CrSigCqChm.Nalineas"
		.Column3.ControlSource = "ttod(CrSigCqChm.dtents)"
		.Column4.ControlSource = "CrSigCqChm.gruorigs"
		.Column5.ControlSource = "CrSigCqChm.conorigs"
		.Column6.ControlSource = "CrSigCqChm.grupos"
		.Column7.ControlSource = "CrSigCqChm.contas"
		.Column8.ControlSource = "CrSigCqChm.Numlotes"
		.Column9.ControlSource = "CrSigCqChm.protocolos"
		.Column1.ControlSource = "ttod(CrSigChea.Vencs)"
lcQueryOper  = [Select * From SigCdOpt ]
lcQueryGccr  = [Select Codigos, Descrs From SigCdGcr ]
lcQueryParam = [Select EmpMasters, GrupoJuros, ContaJuros, GrupoRecs, ContaRecs, GrupoPags, ContaPags, DiaPrors From SigCdPam ]
lcQueryEmp   = [Select * From SigCdEmp ]
lcQueryCli   = [Select * From SigCdCli Where Iclis = ?lcCliente ]
lcQueryChm   = [Select * From SigCqChm Where Nums = ?lcNum Order By Nums, Dtsis Desc ]
lcQueryChea  = [Select * From SigChea Where Nums = ?lcNum ]
lcQueryCha   = [Select * From SigChea Where Nums = ?lcNum ]
lcQueryMccr  = [Select * From SigMvCcr Where CidChaves = ?CidChav ]
lcQueryLanc  = [Select * From SigClLan Where CidChaves = ?Cidchav ]
Select CrSigCdGcr
Select crSigCdOpt
Select CrSigCdEmp
			Select CrSigCdCli
		lcQuery = [Select Iclis, Cpfs, Rclis From SigCdCli Where Cpfs = ?Cgc1 ]
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrSigCdCli')
		Select CrSigCdCli
				ThisForm.poDataMgr.SqlExecute([Select Rclis,Iclis,Cpfs,Conjuges,Inativas From SigCdCli Where Rtrim(RClis) Like ?lcTmp ], 'CrSigCdCli')
				Select CrSigCdCli
				Select CrSigCdCli
Select crSigChe
Select crSigCdOpt
	Select TempChq
	Insert Into TempChq (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
	Select crSigCdCli
Select CrSigCqChm
Select CrSigChea
	.Column1.ControlSource = "CrSigCqChm.Codigos"
	.Column2.ControlSource = "CrSigCqChm.Nalineas"
	.Column3.ControlSource = "CrSigCqChm.dtents"
	.Column4.ControlSource = "CrSigCqChm.gruorigs"
	.Column5.ControlSource = "CrSigCqChm.conorigs"
	.Column6.ControlSource = "CrSigCqChm.grupos"
	.Column7.ControlSource = "CrSigCqChm.contas"
	.Column8.ControlSource = "CrSigCqChm.Numlotes"
	.Column9.ControlSource = "CrSigCqChm.protocolos"
	.Column1.ControlSource = "ttod(CrSigChea.Vencs)"
	Select CrSigCheH
Select crSigChe
			Select CrSigCdCli
		lcQuery = [Select Iclis, Cpfs, Rclis From SigCdCli Where Cpfs = ?Cgc1 ]
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrSigCdCli')
		Select CrSigCdCli
			ThisForm.poDataMgr.SqlExecute([Select Rclis,Iclis,Cpfs,Conjuges,Inativas From SigCdCli Where Rtrim(RClis) Like ?lcTmp ], 'CrSigCdCli')
			Select CrSigCdCli

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg) - TRECHOS RELEVANTES PARA PASS SQL (4064 linhas total):

*-- Linhas 1104 a 1122:
1104: 
1105:     *--------------------------------------------------------------------------
1106:     * ValidarContaEmitente - KeyPress em txt_4c__Conta do Emitente (Valid do
1107:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT
1108:     * exato por Iclis e, sem match, abre o picker com o valor digitado como
1109:     * prefixo. A checagem de acesso do legado roda no funil PreencherEmitente
1110:     * (ver VerificarAcessoConta), que cobre os tres campos do container.
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE ValidarContaEmitente(par_nKeyCode, par_nShiftAltCtrl)
1113:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1114: 
1115:         IF par_nKeyCode = 115
1116:             THIS.AbrirBuscaContaEmitente()
1117:             RETURN
1118:         ENDIF
1119:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1120:             RETURN
1121:         ENDIF
1122: 

*-- Linhas 1128 a 1147:
1128:         ENDIF
1129: 
1130:         TRY
1131:             loc_nResult = SQLEXEC(gnConnHandle, ;
1132:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1133:                 "cursor_4c_EmitenteVal")
1134:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1135:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1136:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1137:             ELSE
1138:                 THIS.AbrirBuscaContaEmitente()
1139:             ENDIF
1140:             IF USED("cursor_4c_EmitenteVal")
1141:                 USE IN cursor_4c_EmitenteVal
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message, "Erro")
1145:         ENDTRY
1146:     ENDPROC
1147: 

*-- Linhas 1168 a 1200:
1168:             ENDIF
1169: 
1170:             IF EMPTY(loc_cValor)
1171:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1172:             ELSE
1173:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1174:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1175:                            " ORDER BY Iclis"
1176:             ENDIF
1177:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1178: 
1179:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1180:                     AND !EMPTY(loc_cValor)
1181:                 IF USED("cursor_4c_BuscaEmitente")
1182:                     USE IN cursor_4c_BuscaEmitente
1183:                 ENDIF
1184:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1185:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaEmitente")
1186:             ENDIF
1187: 
1188:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1189:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1190:             ELSE
1191:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1192:                 IF VARTYPE(loc_oBusca) = "O"
1193:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1194:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1195:                     IF loc_oBusca.Mostrar()
1196:                         loc_cCpf = ""
1197:                         IF USED("cursor_4c_BuscaEmitente")
1198:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1199:                         ENDIF
1200:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1247 a 1266:
1247:         ENDIF
1248: 
1249:         TRY
1250:             loc_nResult = SQLEXEC(gnConnHandle, ;
1251:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1252:                 "cursor_4c_EmitenteVal")
1253:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1254:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1255:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1256:             ELSE
1257:                 THIS.AbrirBuscaCpfEmitente()
1258:             ENDIF
1259:             IF USED("cursor_4c_EmitenteVal")
1260:                 USE IN cursor_4c_EmitenteVal
1261:             ENDIF
1262:         CATCH TO loc_oErro
1263:             MsgErro(loc_oErro.Message, "Erro")
1264:         ENDTRY
1265: 
1266:         IF LEN(loc_cVal) = 14

*-- Linhas 1296 a 1328:
1296:             ENDIF
1297: 
1298:             IF EMPTY(loc_cValor)
1299:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1300:             ELSE
1301:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1302:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1303:                            " ORDER BY Cpfs"
1304:             ENDIF
1305:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1306: 
1307:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1308:                     AND !EMPTY(loc_cValor)
1309:                 IF USED("cursor_4c_BuscaEmitente")
1310:                     USE IN cursor_4c_BuscaEmitente
1311:                 ENDIF
1312:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1313:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaEmitente")
1314:             ENDIF
1315: 
1316:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1317:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1318:             ELSE
1319:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1320:                 IF VARTYPE(loc_oBusca) = "O"
1321:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1322:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1323:                     IF loc_oBusca.Mostrar()
1324:                         loc_cConta = ""
1325:                         IF USED("cursor_4c_BuscaEmitente")
1326:                             loc_cConta = ALLTRIM(cursor_4c_BuscaEmitente.Iclis)
1327:                         ENDIF
1328:                         THIS.PreencherEmitente(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;

*-- Linhas 1364 a 1383:
1364:         ENDIF
1365: 
1366:         TRY
1367:             loc_nResult = SQLEXEC(gnConnHandle, ;
1368:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1369:                 "cursor_4c_EmitenteVal")
1370:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1371:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1372:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1373:             ELSE
1374:                 THIS.AbrirBuscaNomeEmitente()
1375:             ENDIF
1376:             IF USED("cursor_4c_EmitenteVal")
1377:                 USE IN cursor_4c_EmitenteVal
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             MsgErro(loc_oErro.Message, "Erro")
1381:         ENDTRY
1382:     ENDPROC
1383: 

*-- Linhas 1403 a 1435:
1403:             ENDIF
1404: 
1405:             IF EMPTY(loc_cValor)
1406:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1407:             ELSE
1408:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1409:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1410:                            " ORDER BY Rclis"
1411:             ENDIF
1412:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1413: 
1414:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1415:                     AND !EMPTY(loc_cValor)
1416:                 IF USED("cursor_4c_BuscaEmitente")
1417:                     USE IN cursor_4c_BuscaEmitente
1418:                 ENDIF
1419:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1420:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaEmitente")
1421:             ENDIF
1422: 
1423:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1424:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1425:             ELSE
1426:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1427:                 IF VARTYPE(loc_oBusca) = "O"
1428:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1429:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1430:                     IF loc_oBusca.Mostrar()
1431:                         loc_cCpf = ""
1432:                         IF USED("cursor_4c_BuscaEmitente")
1433:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1434:                         ENDIF
1435:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1495 a 1513:
1495: 
1496:     *--------------------------------------------------------------------------
1497:     * ValidarContaOrigem - KeyPress em txt_4c__Conta (equivalente ao Valid do
1498:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT exato
1499:     * por Iclis e, sem match, abre o picker com o valor digitado como prefixo.
1500:     *--------------------------------------------------------------------------
1501:     PROCEDURE ValidarContaOrigem(par_nKeyCode, par_nShiftAltCtrl)
1502:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1503: 
1504:         IF par_nKeyCode = 115
1505:             THIS.AbrirBuscaContaOrigem()
1506:             RETURN
1507:         ENDIF
1508:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1509:             RETURN
1510:         ENDIF
1511: 
1512:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1513:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)

*-- Linhas 1520 a 1539:
1520:         ENDIF
1521: 
1522:         TRY
1523:             loc_nResult = SQLEXEC(gnConnHandle, ;
1524:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1525:                 "cursor_4c_OrigemVal")
1526:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1527:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1528:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1529:             ELSE
1530:                 THIS.AbrirBuscaContaOrigem()
1531:             ENDIF
1532:             IF USED("cursor_4c_OrigemVal")
1533:                 USE IN cursor_4c_OrigemVal
1534:             ENDIF
1535:         CATCH TO loc_oErro
1536:             MsgErro(loc_oErro.Message, "Erro")
1537:         ENDTRY
1538:     ENDPROC
1539: 

*-- Linhas 1562 a 1594:
1562:             ENDIF
1563: 
1564:             IF EMPTY(loc_cValor)
1565:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1566:             ELSE
1567:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1568:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1569:                            " ORDER BY Iclis"
1570:             ENDIF
1571:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1572: 
1573:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1574:                     AND !EMPTY(loc_cValor)
1575:                 IF USED("cursor_4c_BuscaOrigem")
1576:                     USE IN cursor_4c_BuscaOrigem
1577:                 ENDIF
1578:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1579:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaOrigem")
1580:             ENDIF
1581: 
1582:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1583:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1584:             ELSE
1585:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1586:                 IF VARTYPE(loc_oBusca) = "O"
1587:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1588:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1589:                     IF loc_oBusca.Mostrar()
1590:                         loc_cCpf = ""
1591:                         IF USED("cursor_4c_BuscaOrigem")
1592:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1593:                         ENDIF
1594:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1610 a 1628:
1610:     *--------------------------------------------------------------------------
1611:     * ValidarCpfOrigem - KeyPress em txt_4c__Cpf (equivalente ao Valid do
1612:     * get_Cpf legado). Monta o CPF/CNPJ formatado (com pontuacao, igual ao
1613:     * valor gravado em SigCdCli.Cpfs), faz o SELECT exato e, sem match, abre
1614:     * o picker; ao final valida o digito verificador com ValidarCPF/ValidarCNPJ
1615:     * (regra #13 - delegar ao validador novo, nao ao wrapper do legado).
1616:     *--------------------------------------------------------------------------
1617:     PROCEDURE ValidarCpfOrigem(par_nKeyCode, par_nShiftAltCtrl)
1618:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1619:               loc_oOrig, loc_oErro
1620: 
1621:         IF par_nKeyCode = 115
1622:             THIS.AbrirBuscaCpfOrigem()
1623:             RETURN
1624:         ENDIF
1625:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1626:             RETURN
1627:         ENDIF
1628: 

*-- Linhas 1648 a 1667:
1648:         ENDIF
1649: 
1650:         TRY
1651:             loc_nResult = SQLEXEC(gnConnHandle, ;
1652:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1653:                 "cursor_4c_OrigemVal")
1654:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1655:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1656:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1657:             ELSE
1658:                 THIS.AbrirBuscaCpfOrigem()
1659:             ENDIF
1660:             IF USED("cursor_4c_OrigemVal")
1661:                 USE IN cursor_4c_OrigemVal
1662:             ENDIF
1663:         CATCH TO loc_oErro
1664:             MsgErro(loc_oErro.Message, "Erro")
1665:         ENDTRY
1666: 
1667:         IF LEN(loc_cVal) = 14

*-- Linhas 1698 a 1730:
1698:             ENDIF
1699: 
1700:             IF EMPTY(loc_cValor)
1701:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1702:             ELSE
1703:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1704:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1705:                            " ORDER BY Cpfs"
1706:             ENDIF
1707:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1708: 
1709:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1710:                     AND !EMPTY(loc_cValor)
1711:                 IF USED("cursor_4c_BuscaOrigem")
1712:                     USE IN cursor_4c_BuscaOrigem
1713:                 ENDIF
1714:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1715:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaOrigem")
1716:             ENDIF
1717: 
1718:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1719:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1720:             ELSE
1721:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1722:                 IF VARTYPE(loc_oBusca) = "O"
1723:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1724:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1725:                     IF loc_oBusca.Mostrar()
1726:                         loc_cConta = ""
1727:                         IF USED("cursor_4c_BuscaOrigem")
1728:                             loc_cConta = ALLTRIM(cursor_4c_BuscaOrigem.Iclis)
1729:                         ENDIF
1730:                         THIS.PreencherOrigem(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;

*-- Linhas 1745 a 1763:
1745: 
1746:     *--------------------------------------------------------------------------
1747:     * ValidarNomeOrigem - KeyPress em txt_4c__DConta (equivalente ao Valid do
1748:     * get_DConta legado). Faz o SELECT exato por Rclis e, sem match, abre o
1749:     * picker com o valor digitado como filtro "contem".
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE ValidarNomeOrigem(par_nKeyCode, par_nShiftAltCtrl)
1752:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1753: 
1754:         IF par_nKeyCode = 115
1755:             THIS.AbrirBuscaNomeOrigem()
1756:             RETURN
1757:         ENDIF
1758:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1759:             RETURN
1760:         ENDIF
1761: 
1762:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1763:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)

*-- Linhas 1770 a 1789:
1770:         ENDIF
1771: 
1772:         TRY
1773:             loc_nResult = SQLEXEC(gnConnHandle, ;
1774:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1775:                 "cursor_4c_OrigemVal")
1776:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1777:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1778:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1779:             ELSE
1780:                 THIS.AbrirBuscaNomeOrigem()
1781:             ENDIF
1782:             IF USED("cursor_4c_OrigemVal")
1783:                 USE IN cursor_4c_OrigemVal
1784:             ENDIF
1785:         CATCH TO loc_oErro
1786:             MsgErro(loc_oErro.Message, "Erro")
1787:         ENDTRY
1788:     ENDPROC
1789: 

*-- Linhas 1819 a 1855:
1819:             ENDIF
1820: 
1821:             IF EMPTY(loc_cValor)
1822:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1823:             ELSE
1824:                 *-- optFiltro = 2 ("Filtro") procura por CONTEM; = 1 ("Lista")
1825:                 *-- procura por COMECA COM (ver cabecalho deste metodo)
1826:                 loc_cPadrao = IIF(loc_oOrig.obj_4c_OptFiltro.Value = 2, ;
1827:                     "%" + loc_cValor + "%", loc_cValor + "%")
1828:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1829:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL(loc_cPadrao) + ;
1830:                            " ORDER BY Rclis"
1831:             ENDIF
1832:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1833: 
1834:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1835:                     AND !EMPTY(loc_cValor)
1836:                 IF USED("cursor_4c_BuscaOrigem")
1837:                     USE IN cursor_4c_BuscaOrigem
1838:                 ENDIF
1839:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1840:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaOrigem")
1841:             ENDIF
1842: 
1843:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1844:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1845:             ELSE
1846:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1847:                 IF VARTYPE(loc_oBusca) = "O"
1848:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1849:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1850:                     IF loc_oBusca.Mostrar()
1851:                         loc_cCpf = ""
1852:                         IF USED("cursor_4c_BuscaOrigem")
1853:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1854:                         ENDIF
1855:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1927 a 1967:
1927:     *
1928:     * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
1929:     * a compensacao +29 do pgf_4c_Paginas.Top = -29.
1930:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
1931:     * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
1932:     * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
1933:     *--------------------------------------------------------------------------
1934:     PROTECTED PROCEDURE ConfigurarGradesHistorico()
1935:         LOCAL loc_oPagina, loc_oErro
1936:         TRY
1937:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1938: 
1939:             *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
1940:             loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
1941:             WITH loc_oPagina.grd_4c_Cheque
1942:                 .Top                = 124 + 29
1943:                 .Left               = 8
1944:                 .Width              = 981
1945:                 .Height             = 228
1946:                 .HeaderHeight       = 0
1947:                 .ColumnCount        = 12
1948:                 .FontName           = "Tahoma"
1949:                 .FontSize           = 8
1950:                 .RowHeight          = 18
1951:                 .ScrollBars         = 2
1952:                 .DeleteMark         = .F.
1953:                 .RecordMark         = .F.
1954:                 .ForeColor          = RGB(0, 0, 0)
1955:                 .BackColor          = RGB(255, 255, 255)
1956:                 .GridLineColor      = RGB(238, 238, 238)
1957:                 .HighlightBackColor = RGB(255, 255, 255)
1958:                 .HighlightForeColor = RGB(15, 41, 104)
1959:                 .HighlightStyle     = 2
1960:                 .ReadOnly           = .T.
1961:                 .Themes             = .F.
1962:                 .Visible            = .T.
1963:             ENDWITH
1964:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Cheque, 12)
1965: 
1966:             *-- Colunas 1..10 travadas (Movable/Resizable = .F. no dump); as
1967:             *-- colunas 11 e 12 nao declaram essas duas e ficam no default

*-- Linhas 1996 a 2014:
1996:                 .FontSize           = 8
1997:                 .RowHeight          = 18
1998:                 .ScrollBars         = 2
1999:                 .DeleteMark         = .F.
2000:                 *-- RecordMark = .T. eh declaracao EXPLICITA do SCX legado -
2001:                 *-- GradeMovimenta eh a unica das tres grades que exibe a barra
2002:                 *-- de marcacao de registro (PILAR 1)
2003:                 .RecordMark         = .T.
2004:                 .ForeColor          = RGB(0, 0, 0)
2005:                 .BackColor          = RGB(255, 255, 255)
2006:                 .GridLineColor      = RGB(238, 238, 238)
2007:                 .HighlightBackColor = RGB(255, 255, 255)
2008:                 .HighlightForeColor = RGB(15, 41, 104)
2009:                 .HighlightStyle     = 2
2010:                 .ReadOnly           = .T.
2011:                 .Themes             = .F.
2012:                 .Visible            = .T.
2013:             ENDWITH
2014:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Movimenta, 9)

*-- Linhas 2029 a 2047:
2029:                 .HeaderHeight       = 16
2030:                 .RowHeight          = 18
2031:                 .ScrollBars         = 2
2032:                 .DeleteMark         = .F.
2033:                 .RecordMark         = .F.
2034:                 .ForeColor          = RGB(0, 0, 0)
2035:                 .BackColor          = RGB(255, 255, 255)
2036:                 .GridLineColor      = RGB(238, 238, 238)
2037:                 .HighlightBackColor = RGB(255, 255, 255)
2038:                 .HighlightForeColor = RGB(15, 41, 104)
2039:                 .HighlightStyle     = 2
2040:                 .ReadOnly           = .T.
2041:                 .Themes             = .F.
2042:                 .Visible            = .T.
2043:             ENDWITH
2044:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Prorrog, 1)
2045:         CATCH TO loc_oErro
2046:             MsgErro(loc_oErro.Message + CHR(13) + ;
2047:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 2469 a 2508:
2469:             loc_oPagina.grd_4c_Prorrog.Refresh()
2470: 
2471:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
2472:                 SELECT (loc_cAliasAnt)
2473:             ENDIF
2474:         CATCH TO loc_oErro
2475:             MsgErro(loc_oErro.Message + CHR(13) + ;
2476:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2477:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.RepintarGradesHistorico")
2478:         ENDTRY
2479:     ENDPROC
2480: 
2481:     *--------------------------------------------------------------------------
2482:     * CarregarDados - Transcricao do SqlDados legado.
2483:     *
2484:     * Monta os cursores do Historico e vincula as grades:
2485:     *   cursor_4c_Cheque    (SigChe + coluna Tipo) -> grd_4c_Cheque
2486:     *   cursor_4c_Movimento (SigCqChm)             -> grd_4c_Movimenta
2487:     *   cursor_4c_Prorrog   (SigChea)              -> grd_4c_Prorrog
2488:     *   cursor_4c_ChequeP   (auxiliar: Nums com historico em SigCheh - eh o
2489:     *                        'LocalChP' do legado, que marca a coluna Tipo)
2490:     * Os alias sao os declarados em SigOpChiBO.this_cCursor*.
2491:     *
2492:     * Cada SQLEXEC vai para cursor_4c_Temp e o alias definitivo eh recriado
2493:     * READWRITE a partir dele: SQLEXEC direto sobre o alias ligado a uma grade
2494:     * fecha e recria o alias, zerando o ColumnCount da grade.
2495:     *--------------------------------------------------------------------------
2496:     PROCEDURE CarregarDados()
2497:         LOCAL loc_lSucesso, loc_lModoTeste, loc_lOk, loc_oErro
2498:         LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
2499:         LOCAL loc_cConta, loc_cEmitente, loc_cFiltroEmi, loc_cNumCheque, loc_cAcesso
2500:         LOCAL loc_cSQLChe, loc_cSQLChP, loc_cSQLMov, loc_cSQLPro
2501:         loc_lSucesso = .F.
2502: 
2503:         loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2504:                          (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
2505: 
2506:         *-- RETURN sempre FORA de TRY/CATCH
2507:         IF loc_lModoTeste OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
2508:             RETURN .F.

*-- Linhas 2539 a 2717:
2539:             *-- Ramo 1 (legado: If !Empty(get_Conta.Value)) - historico COMPLETO
2540:             *-- da conta de origem, SEM recorte de periodo
2541:             IF !EMPTY(loc_cConta)
2542:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2543:                     " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
2544:                     " ORDER BY a.Vencs"
2545:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2546:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2547:                     " WHERE a.Iclis = " + EscaparSQL(loc_cConta)
2548:             ENDIF
2549: 
2550:             *-- Ramo 2 (legado: IF pcAcesso = 'TOTAL') - SOBREPOE o ramo 1:
2551:             *-- recorta pelo periodo de vencimento e, havendo conta de emitente
2552:             *-- informada, restringe a ConOrigs/Contat (legado: lcChecaC)
2553:             IF loc_cAcesso == "TOTAL"
2554:                 loc_cEmitente  = ALLTRIM(THIS.this_oBusinessObject.this_cContaEmitente)
2555:                 loc_cFiltroEmi = ""
2556:                 IF !EMPTY(loc_cEmitente)
2557:                     loc_cFiltroEmi = " AND (a.ConOrigs = " + EscaparSQL(loc_cEmitente) + ;
2558:                         " OR a.Contat = " + EscaparSQL(loc_cEmitente) + ")"
2559:                 ENDIF
2560:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2561:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2562:                     " AND " + FormatarDataSQL(loc_tFim) + ;
2563:                     loc_cFiltroEmi + ;
2564:                     " ORDER BY a.Vencs"
2565:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2566:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2567:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2568:                     " AND " + FormatarDataSQL(loc_tFim)
2569:             ENDIF
2570: 
2571:             *-- Ramo 3 (legado: IF pcAcesso = 'CARTEIRA') - SOBREPOE os
2572:             *-- anteriores: UM cheque especifico vindo da carteira
2573:             IF loc_cAcesso == "CARTEIRA"
2574:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2575:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2576:                     " AND " + FormatarDataSQL(loc_tFim) + ;
2577:                     " AND a.Bancos = "   + EscaparSQL(THIS.this_cParamBancos) + ;
2578:                     " AND a.Agencias = " + EscaparSQL(THIS.this_cParamAgencias) + ;
2579:                     " AND a.nContas = "  + EscaparSQL(THIS.this_cParamNContas) + ;
2580:                     " AND a.nCheques = " + EscaparSQL(THIS.this_cParamNCheques) + ;
2581:                     " ORDER BY a.Vencs"
2582:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2583:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2584:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2585:                     " AND " + FormatarDataSQL(loc_tFim)
2586:             ENDIF
2587: 
2588:             *-- Sem acesso irrestrito e sem conta de origem nenhum dos tres
2589:             *-- ramos monta consulta - o legado nem chega aqui, porque o
2590:             *-- Ok.Click exige a conta antes de trocar de pagina
2591:             IF EMPTY(loc_cSQLChe)
2592:                 MsgAviso("Informe a conta de origem antes de consultar o " + ;
2593:                     "hist" + CHR(243) + "rico.", "Aten" + CHR(231) + CHR(227) + "o")
2594:                 loc_lOk = .F.
2595:             ENDIF
2596: 
2597:             *-- 1) cursor auxiliar: Nums que possuem historico em SigCheh
2598:             IF loc_lOk
2599:                 THIS.FecharCursor("cursor_4c_ChequeP")
2600:                 THIS.FecharCursor("cursor_4c_Temp")
2601:                 IF SQLEXEC(gnConnHandle, loc_cSQLChP, "cursor_4c_Temp") < 0
2602:                     MsgErro("Erro ao consultar o hist" + CHR(243) + "rico dos cheques." + ;
2603:                         CHR(13) + CapturarErroSQL(), "FormSigOpChi.CarregarDados")
2604:                     loc_lOk = .F.
2605:                 ELSE
2606:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_ChequeP READWRITE
2607:                     THIS.FecharCursor("cursor_4c_Temp")
2608:                     SELECT cursor_4c_ChequeP
2609:                     INDEX ON Nums TAG Nums
2610:                 ENDIF
2611:             ENDIF
2612: 
2613:             *-- 2) cursor principal da GradeCheque
2614:             IF loc_lOk
2615:                 THIS.FecharCursor("cursor_4c_Cheque")
2616:                 THIS.FecharCursor("cursor_4c_Temp")
2617:                 IF SQLEXEC(gnConnHandle, loc_cSQLChe, "cursor_4c_Temp") < 0
2618:                     MsgErro("Erro ao consultar os cheques." + CHR(13) + CapturarErroSQL(), ;
2619:                         "FormSigOpChi.CarregarDados")
2620:                     loc_lOk = .F.
2621:                 ELSE
2622:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Cheque READWRITE
2623:                     THIS.FecharCursor("cursor_4c_Temp")
2624:                 ENDIF
2625:             ENDIF
2626: 
2627:             *-- 3) marca com "S" o cheque que tem historico (legado: Scan +
2628:             *-- Seek em LocalChP + Replace Tipo With [S]) e cria os TAGs que a
2629:             *-- ordenacao por cabecalho de coluna usa
2630:             loc_cNumCheque = ""
2631:             IF loc_lOk
2632:                 SELECT cursor_4c_Cheque
2633:                 SCAN
2634:                     IF SEEK(Nums, "cursor_4c_ChequeP", "Nums")
2635:                         REPLACE Tipo WITH "S"
2636:                     ENDIF
2637:                 ENDSCAN
2638: 
2639:                 THIS.IndexarCursorCheque()
2640: 
2641:                 *-- Legado: Go Bottom / lcNum = CrSigChe.Nums - o ultimo cheque
2642:                 *-- na ordem de vencimento eh quem alimenta as duas grades de
2643:                 *-- detalhe. Nums vai SEM ALLTRIM: eh char(8) e o SQL Server
2644:                 *-- compara char com blank-padding
2645:                 IF RECCOUNT("cursor_4c_Cheque") > 0
2646:                     GO BOTTOM
2647:                     loc_cNumCheque = cursor_4c_Cheque.Nums
2648:                 ENDIF
2649: 
2650:                 *-- Legado: Update CrSigChe Set DtEmis = Nvl(DtEmis, Ctod([]))
2651:                 *-- - sem isso a Column12 (Emissao) recebe TTOD(.NULL.)
2652:                 REPLACE ALL DtEmis WITH CTOT("") FOR ISNULL(DtEmis)
2653:                 GO TOP
2654:             ENDIF
2655: 
2656:             *-- 4) grades de detalhe do cheque corrente. Legado: Requery de
2657:             *-- CrSigCqChm e CrSigChea, cujas queries sao as do AddCursor do Init:
2658:             *--   Select * From SigCqChm Where Nums = ?lcNum Order By Nums, Dtsis Desc
2659:             *--   Select * From SigChea  Where Nums = ?lcNum
2660:             IF loc_lOk
2661:                 loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + ;
2662:                     EscaparSQL(loc_cNumCheque) + " ORDER BY Nums, Dtsis DESC"
2663:                 loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + ;
2664:                     EscaparSQL(loc_cNumCheque)
2665: 
2666:                 THIS.FecharCursor("cursor_4c_Movimento")
2667:                 THIS.FecharCursor("cursor_4c_Temp")
2668:                 IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
2669:                     MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
2670:                         "o do cheque." + CHR(13) + CapturarErroSQL(), ;
2671:                         "FormSigOpChi.CarregarDados")
2672:                     loc_lOk = .F.
2673:                 ELSE
2674:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
2675:                     THIS.FecharCursor("cursor_4c_Temp")
2676:                 ENDIF
2677:             ENDIF
2678: 
2679:             IF loc_lOk
2680:                 THIS.FecharCursor("cursor_4c_Prorrog")
2681:                 THIS.FecharCursor("cursor_4c_Temp")
2682:                 IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
2683:                     MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
2684:                         "es do cheque." + CHR(13) + CapturarErroSQL(), ;
2685:                         "FormSigOpChi.CarregarDados")
2686:                     loc_lOk = .F.
2687:                 ELSE
2688:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
2689:                     THIS.FecharCursor("cursor_4c_Temp")
2690:                 ENDIF
2691:             ENDIF
2692: 
2693:             *-- 5) vinculo das grades. O legado so vincula havendo registro:
2694:             *-- "If Reccount('CrSigChe') > 0"
2695:             IF loc_lOk AND RECCOUNT("cursor_4c_Cheque") > 0
2696:                 THIS.VincularGradeCheque()
2697:                 THIS.VincularGradeMovimenta()
2698:                 THIS.VincularGradeProrrog()
2699: 
2700:                 *-- Carrega no BO o cheque corrente, para que as acoes sobre a
2701:                 *-- linha selecionada leiam as propriedades do BO
2702:                 SELECT cursor_4c_Cheque
2703:                 GO TOP
2704:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2705: 
2706:                 *-- Rede de seguranca: o legado conta com o GradeCheque.
2707:                 *-- AfterRowColChange disparando sozinho ao vincular RecordSource
2708:                 *-- (VincularGradeCheque, chamado acima) para corrigir Documento/
2709:                 *-- Carteira/Followup/Caption do registro do GO TOP (o SqlDados
2710:                 *-- carrega Movimento/Prorrog do GO BOTTOM so para obter lcNum).
2711:                 *-- Chamar aqui tambem garante o mesmo resultado mesmo que o
2712:                 *-- AfterRowColChange nao dispare sozinho neste ponto do ciclo
2713:                 *-- de vida do form (ex.: pagina ainda nao esta ActivePage).
2714:                 THIS.AtualizarEstadoChequeAtual()
2715:             ENDIF
2716: 
2717:             THIS.RepintarGradesHistorico()

*-- Linhas 2726 a 2768:
2726:     ENDPROC
2727: 
2728:     *--------------------------------------------------------------------------
2729:     * VincularGradeCheque - ColumnCount -> RecordSource -> ControlSource ->
2730:     * Width -> Header1.Caption. A ordem eh obrigatoria: RecordSource recalcula
2731:     * as larguras das colunas para o default, entao Width e caption vem por
2732:     * ultimo. ControlSource e DynamicFore/BackColor transcritos do SqlDados.
2733:     *--------------------------------------------------------------------------
2734:     PROTECTED PROCEDURE VincularGradeCheque()
2735:         LOCAL loc_oGrade
2736:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
2737: 
2738:         WITH loc_oGrade
2739:             .ColumnCount  = 12
2740:             .RecordSource = "cursor_4c_Cheque"
2741: 
2742:             .Column1.ControlSource  = "TTOD(cursor_4c_Cheque.Vencs)"
2743:             .Column2.ControlSource  = "cursor_4c_Cheque.Bancos"
2744:             .Column3.ControlSource  = "cursor_4c_Cheque.Agencias"
2745:             .Column4.ControlSource  = "cursor_4c_Cheque.nContas"
2746:             .Column5.ControlSource  = "cursor_4c_Cheque.nCheques"
2747:             .Column6.ControlSource  = "cursor_4c_Cheque.Valors"
2748:             .Column7.ControlSource  = "cursor_4c_Cheque.GruCarts"
2749:             .Column8.ControlSource  = "cursor_4c_Cheque.ConCarts"
2750:             .Column9.ControlSource  = "cursor_4c_Cheque.Emps"
2751:             .Column10.ControlSource = "cursor_4c_Cheque.Numeros"
2752:             .Column11.ControlSource = "cursor_4c_Cheque.UMovs"
2753:             .Column12.ControlSource = "TTOD(cursor_4c_Cheque.DtEmis)"
2754: 
2755:             .Column1.Width  = 80
2756:             .Column2.Width  = 35
2757:             .Column3.Width  = 49
2758:             .Column4.Width  = 90
2759:             .Column5.Width  = 60
2760:             .Column6.Width  = 115
2761:             .Column7.Width  = 95
2762:             .Column8.Width  = 95
2763:             .Column9.Width  = 31
2764:             .Column10.Width = 58
2765:             .Column11.Width = 150
2766:             .Column12.Width = 80
2767: 
2768:             .Column1.Header1.Caption  = "Vencimento"

*-- Linhas 2813 a 2850:
2813:     ENDPROC
2814: 
2815:     *--------------------------------------------------------------------------
2816:     * VincularGradeMovimenta - ControlSource/Width/Caption de GradeMovimenta
2817:     * (SigCqChm), transcritos do SqlDados e do dump legado
2818:     *--------------------------------------------------------------------------
2819:     PROTECTED PROCEDURE VincularGradeMovimenta()
2820:         LOCAL loc_oGrade
2821:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Movimenta
2822: 
2823:         WITH loc_oGrade
2824:             .ColumnCount  = 9
2825:             .RecordSource = "cursor_4c_Movimento"
2826: 
2827:             .Column1.ControlSource = "cursor_4c_Movimento.Codigos"
2828:             .Column2.ControlSource = "cursor_4c_Movimento.Nalineas"
2829:             .Column3.ControlSource = "TTOD(cursor_4c_Movimento.DtEnts)"
2830:             .Column4.ControlSource = "cursor_4c_Movimento.GruOrigs"
2831:             .Column5.ControlSource = "cursor_4c_Movimento.ConOrigs"
2832:             .Column6.ControlSource = "cursor_4c_Movimento.Grupos"
2833:             .Column7.ControlSource = "cursor_4c_Movimento.Contas"
2834:             .Column8.ControlSource = "cursor_4c_Movimento.NumLotes"
2835:             .Column9.ControlSource = "cursor_4c_Movimento.Protocolos"
2836: 
2837:             .Column1.Width = 157
2838:             .Column2.Width = 40
2839:             .Column3.Width = 80
2840:             .Column4.Width = 90
2841:             .Column5.Width = 90
2842:             .Column6.Width = 90
2843:             .Column7.Width = 90
2844:             .Column8.Width = 90
2845:             .Column9.Width = 90
2846: 
2847:             .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2848:             .Column2.Header1.Caption = "Alinea"
2849:             .Column3.Header1.Caption = "Entrada"
2850:             .Column4.Header1.Caption = "Grupo/Origem"

*-- Linhas 2862 a 2926:
2862:     ENDPROC
2863: 
2864:     *--------------------------------------------------------------------------
2865:     * VincularGradeProrrog - ControlSource/Width/Caption de GradeProrrog
2866:     * (SigChea - vencimentos das prorrogacoes do cheque corrente)
2867:     *--------------------------------------------------------------------------
2868:     PROTECTED PROCEDURE VincularGradeProrrog()
2869:         LOCAL loc_oGrade
2870:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Prorrog
2871: 
2872:         WITH loc_oGrade
2873:             .ColumnCount             = 1
2874:             .RecordSource            = "cursor_4c_Prorrog"
2875:             .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
2876:             .Column1.Width           = 83
2877:             .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
2878:         ENDWITH
2879:     ENDPROC
2880: 
2881:     *--------------------------------------------------------------------------
2882:     * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados
2883:     * (carga inicial) e por AcaoProcurarClick (mescla dos cheques encontrados
2884:     * pelo dialogo de busca). Fatorado para nao duplicar o bloco em dois
2885:     * lugares - mesmas dez expressoes do SqlDados legado.
2886:     *--------------------------------------------------------------------------
2887:     PROTECTED PROCEDURE IndexarCursorCheque()
2888:         SELECT cursor_4c_Cheque
2889:         INDEX ON DTOS(Vencs) + Bancos + Agencias + nContas + nCheques TAG Venc
2890:         INDEX ON Bancos + Agencias + nContas + nCheques TAG Cheque
2891:         INDEX ON Agencias + nContas + nCheques TAG Agencia
2892:         INDEX ON Agencias + nContas TAG AgenciaCta
2893:         INDEX ON Agencias + nCheques TAG AgenciaChe
2894:         INDEX ON nContas + nCheques TAG Conta
2895:         INDEX ON nCheques TAG NCheque
2896:         INDEX ON STR(Valors, 12, 2) + Bancos + Agencias + nContas + nCheques TAG Valor
2897:         INDEX ON Numeros TAG Numeros
2898:         INDEX ON Nums TAG Nums
2899:         SET ORDER TO Venc
2900:     ENDPROC
2901: 
2902:     *--------------------------------------------------------------------------
2903:     * ConfigurarCursorProtocolo - Cursor local usado por AcaoProtocoloClick,
2904:     * equivalente ao "Create Cursor TempChq" que o Init legado executa uma
2905:     * unica vez. Chamado uma vez em InicializarForm.
2906:     *--------------------------------------------------------------------------
2907:     PROTECTED PROCEDURE ConfigurarCursorProtocolo()
2908:         LOCAL loc_oErro
2909:         TRY
2910:             IF !USED("cursor_4c_Protocolo")
2911:                 CREATE CURSOR cursor_4c_Protocolo (Bancos C(3), Agencias C(4), ;
2912:                     NContas C(10), NCheques C(6), Vencs D NULL, Valors N(12, 2), ;
2913:                     Emps C(3), Iclis C(10), Grclis C(10), Contas C(10), ;
2914:                     Grupos C(10), ValPags N(12, 2), Nums C(8), Protocolos C(8), Obss M)
2915:                 INDEX ON Bancos + Agencias + NContas + NCheques TAG Cheque
2916:             ENDIF
2917:         CATCH TO loc_oErro
2918:             MsgErro(loc_oErro.Message + CHR(13) + ;
2919:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2920:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarCursorProtocolo")
2921:         ENDTRY
2922:     ENDPROC
2923: 
2924:     *--------------------------------------------------------------------------
2925:     * ExigirChequeSelecionado - Guarda comum aos 8 botoes de cmg_4c_Botoes:
2926:     * nenhum deles tem sentido sem uma linha corrente em cursor_4c_Cheque (o

*-- Linhas 2945 a 2983:
2945:     * CmdOkClick e nao muda por linha), Documento.Enabled (ChkRegister
2946:     * SigCdPgr/SigMvCab x2), Carteira.Enabled (ChkRegister SIGCCCHM) e o
2947:     * texto do ultimo Followup (SigCheh). ChkRegister nao existe na nova
2948:     * arquitetura (regra do projeto) - substituido por SELECT COUNT(*).
2949:     *--------------------------------------------------------------------------
2950:     PROTECTED PROCEDURE AtualizarEstadoChequeAtual()
2951:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
2952:               loc_lDocEnab, loc_lCartEnab, loc_cHist, loc_cRclis, loc_cCpfs, loc_oErro
2953: 
2954:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
2955:             RETURN
2956:         ENDIF
2957: 
2958:         TRY
2959:             SELECT cursor_4c_Cheque
2960:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2961: 
2962:             *-- Caption (legado: ramo "If ThisForm.Acesso")
2963:             IF THIS.this_lAcesso
2964:                 loc_cRclis = ""
2965:                 loc_cCpfs  = ""
2966:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2967:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + ;
2968:                     EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cIClis)), "cursor_4c_CliCaption")
2969:                 IF loc_nResultado > 0 AND USED("cursor_4c_CliCaption") AND !EOF("cursor_4c_CliCaption")
2970:                     loc_cRclis = ALLTRIM(cursor_4c_CliCaption.Rclis)
2971:                     loc_cCpfs  = ALLTRIM(cursor_4c_CliCaption.Cpfs)
2972:                 ENDIF
2973:                 THIS.FecharCursor("cursor_4c_CliCaption")
2974:                 *-- Caption guardado no BO (this_cCaptionAtual eh a fonte unica
2975:                 *-- que BOParaForm espelha ao recarregar a tela)
2976:                 THIS.this_oBusinessObject.this_cCaptionAtual = ;
2977:                     "Hist" + CHR(243) + "rico de Cheques de: " + ;
2978:                     ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
2979:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
2980:             ENDIF
2981: 
2982:             *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',
2983:             *-- laCampo1) / ChkRegister('SigMvCab', laCampo3 - EmpDopNums

*-- Linhas 2992 a 3054:
2992:                 loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
2993:                 loc_cKey2 = cursor_4c_Movimento.EmpDopNums
2994: 
2995:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2996:                     "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + ;
2997:                     EscaparSQL(ALLTRIM(loc_cEmpr)) + " AND Dopes = " + EscaparSQL(loc_cDope) + ;
2998:                     " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), "cursor_4c_DocVal")
2999:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3000:                     loc_lDocEnab = .T.
3001:                 ENDIF
3002:                 THIS.FecharCursor("cursor_4c_DocVal")
3003: 
3004:                 IF !loc_lDocEnab
3005:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3006:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3007:                         EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3008:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3009:                         loc_lDocEnab = .T.
3010:                     ENDIF
3011:                     THIS.FecharCursor("cursor_4c_DocVal")
3012:                 ENDIF
3013: 
3014:                 IF !loc_lDocEnab
3015:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3016:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3017:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3018:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3019:                         loc_lDocEnab = .T.
3020:                     ENDIF
3021:                     THIS.FecharCursor("cursor_4c_DocVal")
3022:                 ENDIF
3023:             ENDIF
3024:             THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(7).Enabled = loc_lDocEnab
3025: 
3026:             *-- Carteira.Enabled (legado: ChkRegister('SIGCCCHM', 'Nums', CrSigChe.Nums))
3027:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3028:                 "SELECT COUNT(*) AS nExiste FROM SIGCCCHM WHERE Nums = " + ;
3029:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)), "cursor_4c_DocVal")
3030:             loc_lCartEnab = loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3031:             THIS.FecharCursor("cursor_4c_DocVal")
3032:             THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(5).Enabled = loc_lCartEnab
3033: 
3034:             *-- Ultimo followup (legado: CursorQuery SigCheh + Index On Datas
3035:             *-- Descending + Go Top)
3036:             loc_cHist = ""
3037:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3038:                 "SELECT TOP 1 Hists FROM SigCheh WHERE Nums = " + ;
3039:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)) + ;
3040:                 " ORDER BY Datas DESC", "cursor_4c_FollowupVal")
3041:             IF loc_nResultado > 0 AND USED("cursor_4c_FollowupVal") AND !EOF("cursor_4c_FollowupVal")
3042:                 loc_cHist = TratarNulo(cursor_4c_FollowupVal.Hists, "")
3043:             ENDIF
3044:             THIS.FecharCursor("cursor_4c_FollowupVal")
3045:             *-- Fonte unica no BO; a tela espelha (BOParaForm faz o mesmo ao
3046:             *-- recarregar, para o campo nao "esquecer" o texto)
3047:             THIS.this_oBusinessObject.this_cUltimoFollowup = loc_cHist
3048:             THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = loc_cHist
3049:         CATCH TO loc_oErro
3050:             MsgErro(loc_oErro.Message + CHR(13) + ;
3051:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3052:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AtualizarEstadoChequeAtual")
3053:         ENDTRY
3054:     ENDPROC

*-- Linhas 3075 a 3115:
3075:             loc_oPagina.grd_4c_Movimenta.RecordSource = ""
3076:             loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
3077: 
3078:             loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
3079:                 " ORDER BY Nums, Dtsis DESC"
3080:             loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)
3081: 
3082:             THIS.FecharCursor("cursor_4c_Movimento")
3083:             THIS.FecharCursor("cursor_4c_Temp")
3084:             IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
3085:                 MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
3086:                     "o do cheque." + CHR(13) + CapturarErroSQL(), ;
3087:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3088:             ELSE
3089:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
3090:             ENDIF
3091:             THIS.FecharCursor("cursor_4c_Temp")
3092: 
3093:             THIS.FecharCursor("cursor_4c_Prorrog")
3094:             THIS.FecharCursor("cursor_4c_Temp")
3095:             IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
3096:                 MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
3097:                     "es do cheque." + CHR(13) + CapturarErroSQL(), ;
3098:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3099:             ELSE
3100:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
3101:             ENDIF
3102:             THIS.FecharCursor("cursor_4c_Temp")
3103: 
3104:             THIS.VincularGradeMovimenta()
3105:             THIS.VincularGradeProrrog()
3106:             THIS.AtualizarEstadoChequeAtual()
3107:             THIS.RepintarGradesHistorico()
3108:         CATCH TO loc_oErro
3109:             MsgErro(loc_oErro.Message + CHR(13) + ;
3110:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3111:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.GradeChequeAfterRowColChange")
3112:         ENDTRY
3113:     ENDPROC
3114: 
3115:     *--------------------------------------------------------------------------

*-- Linhas 3150 a 3168:
3150: 
3151:         TRY
3152:             loc_nRecno = RECNO("cursor_4c_Cheque")
3153:             SELECT cursor_4c_Cheque
3154:             SET ORDER TO (loc_cOrd)
3155:             IF BETWEEN(loc_nRecno, 1, RECCOUNT())
3156:                 GO RECORD (loc_nRecno)
3157:             ENDIF
3158: 
3159:             loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3160:             FOR loc_nI = 1 TO 6
3161:                 loc_oGrade.Columns(loc_nI).Header1.BackColor = ;
3162:                     IIF(loc_nI = par_nColuna, RGB(220, 255, 220), RGB(192, 192, 192))
3163:             ENDFOR
3164:             loc_oGrade.Refresh()
3165:         CATCH TO loc_oErro
3166:             MsgErro(loc_oErro.Message + CHR(13) + ;
3167:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3168:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.OrdenarGradeCheque")

*-- Linhas 3268 a 3301:
3268: 
3269:                 IF USED("cursor_4c_SigChe") AND RECCOUNT("cursor_4c_SigChe") > 0 AND ;
3270:                         USED("cursor_4c_Cheque")
3271:                     SELECT cursor_4c_SigChe
3272:                     SCAN
3273:                         loc_cNums = Nums
3274:                         IF !SEEK(loc_cNums, "cursor_4c_Cheque", "Nums")
3275:                             SCATTER MEMVAR MEMO
3276:                             SELECT cursor_4c_Cheque
3277:                             APPEND BLANK
3278:                             GATHER MEMVAR MEMO
3279:                             REPLACE Tipo WITH IIF(USED("cursor_4c_ChequeP") AND ;
3280:                                 SEEK(loc_cNums, "cursor_4c_ChequeP", "Nums"), "S", " ")
3281:                         ENDIF
3282:                         SELECT cursor_4c_SigChe
3283:                     ENDSCAN
3284: 
3285:                     THIS.IndexarCursorCheque()
3286:                     SELECT cursor_4c_Cheque
3287:                     GO TOP
3288:                     THIS.AtualizarEstadoChequeAtual()
3289:                     THIS.RepintarGradesHistorico()
3290:                 ENDIF
3291: 
3292:                 loc_oBusca.Release()
3293:             ENDIF
3294:         CATCH TO loc_oErro
3295:             MsgErro(loc_oErro.Message + CHR(13) + ;
3296:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3297:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProcurarClick")
3298:         ENDTRY
3299: 
3300:         *-- Legado: ThisForm.Pagina.Historico.Refresh + GradeCheque.SetFocus +
3301:         *-- GradeCheque.Column1.Text1.SetFocus

*-- Linhas 3310 a 3341:
3310:     * crSigCdOpt (Operacaos = CrSigChe.Umovs); bloqueia com aviso se
3311:     * Tipos = "CR" e Prorrogas <> 1; senao "Do Form SigOpChp With ThisForm".
3312:     * crSigCdOpt nao existe como cursor global nesta migracao - substituido
3313:     * por SELECT direto em SigCdOpt. SigOpChp ainda nao foi migrado.
3314:     *--------------------------------------------------------------------------
3315:     PROCEDURE AcaoProrrogaClick()
3316:         LOCAL loc_nResultado, loc_cTipos, loc_nProrrogas, loc_lPode, loc_oForm, loc_oErro
3317: 
3318:         IF !THIS.ExigirChequeSelecionado()
3319:             RETURN
3320:         ENDIF
3321: 
3322:         loc_lPode = .T.
3323:         TRY
3324:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3325:                 "SELECT TOP 1 Tipos, Prorrogas FROM SigCdOpt WHERE Operacaos = " + ;
3326:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cUMovs)), "cursor_4c_OptVal")
3327:             IF loc_nResultado > 0 AND USED("cursor_4c_OptVal") AND !EOF("cursor_4c_OptVal")
3328:                 loc_cTipos     = ALLTRIM(cursor_4c_OptVal.Tipos)
3329:                 loc_nProrrogas = NVL(cursor_4c_OptVal.Prorrogas, 0)
3330:                 IF loc_cTipos == "CR" AND loc_nProrrogas != 1
3331:                     MsgAviso("Imposs" + CHR(237) + "vel prorrogar cheques que n" + CHR(227) + ;
3332:                         "o estejam pendentes...", "Aten" + CHR(231) + CHR(227) + "o!!!")
3333:                     loc_lPode = .F.
3334:                 ENDIF
3335:             ENDIF
3336:             THIS.FecharCursor("cursor_4c_OptVal")
3337:         CATCH TO loc_oErro
3338:             MsgErro(loc_oErro.Message, "Erro")
3339:             loc_lPode = .F.
3340:         ENDTRY
3341: 

*-- Linhas 3445 a 3465:
3445: 
3446:         TRY
3447:             IF USED("cursor_4c_Protocolo")
3448:                 SELECT cursor_4c_Protocolo
3449:                 ZAP
3450:                 INSERT INTO cursor_4c_Protocolo (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
3451:                     VALUES (THIS.this_oBusinessObject.this_cBancos, THIS.this_oBusinessObject.this_cAgencias, ;
3452:                             THIS.this_oBusinessObject.this_cNContas, THIS.this_oBusinessObject.this_cNCheques, ;
3453:                             ConverterParaData(THIS.this_oBusinessObject.this_dVencs), ;
3454:                             THIS.this_oBusinessObject.this_nValors, loc_cProtocolo)
3455:             ENDIF
3456:         CATCH TO loc_oErro
3457:             MsgErro(loc_oErro.Message + CHR(13) + ;
3458:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3459:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProtocoloClick")
3460:         ENDTRY
3461: 
3462:         TRY
3463:             loc_oForm = CREATEOBJECT("FormSigOpIbo", THIS, 1, loc_cCaption)
3464:             IF VARTYPE(loc_oForm) = "O"
3465:                 loc_oForm.Show()

*-- Linhas 3476 a 3494:
3476:     * Numes; SigMvCab por EmpDopNums recalculado; SigMvCab por EmpDopNums do
3477:     * proprio registro de SigCqChm), abrindo SigCdPgr/SigMvExp conforme o
3478:     * primeiro que casar. ChkRegister nao existe na nova arquitetura -
3479:     * substituido por SELECT COUNT(*). FormSigMvExp JA FOI MIGRADO; SigCdPgr
3480:     * ainda nao. O guard "WExist('FORM_')" do legado (bloqueia abrir SigMvExp
3481:     * com a Movimentacao de Estoque aberta) nao tem equivalente nesta
3482:     * arquitetura - nao ha janela "FORM_" para detectar.
3483:     *--------------------------------------------------------------------------
3484:     PROCEDURE AcaoDocumentoClick()
3485:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
3486:               loc_oForm, loc_oErro
3487: 
3488:         IF !THIS.ExigirChequeSelecionado()
3489:             RETURN
3490:         ENDIF
3491:         IF !USED("cursor_4c_Movimento") OR EOF("cursor_4c_Movimento")
3492:             MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o selecionada.", ;
3493:                 "Aten" + CHR(231) + CHR(227) + "o")
3494:             RETURN

*-- Linhas 3503 a 3545:
3503: 
3504:         loc_oForm = .NULL.
3505:         TRY
3506:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3507:                 "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + EscaparSQL(ALLTRIM(loc_cEmpr)) + ;
3508:                 " AND Dopes = " + EscaparSQL(loc_cDope) + " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), ;
3509:                 "cursor_4c_DocVal")
3510:             IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3511:                 THIS.FecharCursor("cursor_4c_DocVal")
3512:                 TRY
3513:                     loc_oForm = CREATEOBJECT("FormSigCdPgr", LEFT(loc_cDope, 1), .T., loc_cEmpr, loc_cDope, loc_nNume)
3514:                 CATCH TO loc_oErro
3515:                     MsgAviso("Tela de Registro de Pagamentos (SigCdPgr) ainda n" + CHR(227) + ;
3516:                         "o foi migrada.", "Indispon" + CHR(237) + "vel")
3517:                 ENDTRY
3518:             ELSE
3519:                 THIS.FecharCursor("cursor_4c_DocVal")
3520:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3521:                     "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3522:                     EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3523:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3524:                     THIS.FecharCursor("cursor_4c_DocVal")
3525:                     loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, loc_cEmpr, .T.)
3526:                 ELSE
3527:                     THIS.FecharCursor("cursor_4c_DocVal")
3528:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3529:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3530:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3531:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3532:                         loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, ;
3533:                             cursor_4c_Movimento.Emps, .T.)
3534:                     ENDIF
3535:                 ENDIF
3536:             ENDIF
3537:             THIS.FecharCursor("cursor_4c_DocVal")
3538: 
3539:             IF VARTYPE(loc_oForm) = "O"
3540:                 loc_oForm.Show()
3541:             ENDIF
3542:         CATCH TO loc_oErro
3543:             MsgErro(loc_oErro.Message + CHR(13) + ;
3544:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3545:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoDocumentoClick")

*-- Linhas 3579 a 3598:
3579:     * FASE 8 - CONSOLIDACAO: hooks de transferencia, funil de carga, estado
3580:     * dos campos e dos botoes.
3581:     *
3582:     * Este form OPERACIONAL nao tem CRUD (o legado SIGOPCHI nao faz Insert/
3583:     * Update/Delete em SigChe - ver cabecalho de SigOpChiBO.prg), mas TEM
3584:     * campos EDITAVEIS que alimentam a operacao: os tres campos do container
3585:     * Origem (Page1) + o OptionGroup Lista/Filtro, os tres campos do container
3586:     * Emitente (Page2) e as duas datas do periodo de vencimento. Por isso
3587:     * FormParaBO/BOParaForm existem de verdade aqui - o bloco ja estava no
3588:     * Init legado, espalhado pelos AddObject, sem esse nome.
3589:     *==========================================================================
3590: 
3591:     *--------------------------------------------------------------------------
3592:     * FormParaBO - Le os campos EDITAVEIS da tela para as propriedades do BO,
3593:     * que sao a FONTE UNICA lida por CarregarDados.
3594:     *
3595:     * PROTECTED porque FormBase declara este hook PROTECTED e VFP9 nao permite
3596:     * ALARGAR o escopo de metodo herdado.
3597:     *
3598:     * Transferencia pura, sem validacao propria: a unica validacao que o


### BO (C:\4c\projeto\app\classes\SigOpChiBO.prg):
*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE

