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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg) - TRECHOS RELEVANTES PARA PASS SQL (4101 linhas total):

*-- Linhas 1138 a 1156:
1138: 
1139:     *--------------------------------------------------------------------------
1140:     * ValidarContaEmitente - KeyPress em txt_4c__Conta do Emitente (Valid do
1141:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT
1142:     * exato por Iclis e, sem match, abre o picker com o valor digitado como
1143:     * prefixo. A checagem de acesso do legado roda no funil PreencherEmitente
1144:     * (ver VerificarAcessoConta), que cobre os tres campos do container.
1145:     *--------------------------------------------------------------------------
1146:     PROCEDURE ValidarContaEmitente(par_nKeyCode, par_nShiftAltCtrl)
1147:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1148: 
1149:         IF par_nKeyCode = 115
1150:             THIS.AbrirBuscaContaEmitente()
1151:             RETURN
1152:         ENDIF
1153:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1154:             RETURN
1155:         ENDIF
1156: 

*-- Linhas 1162 a 1181:
1162:         ENDIF
1163: 
1164:         TRY
1165:             loc_nResult = SQLEXEC(gnConnHandle, ;
1166:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1167:                 "cursor_4c_EmitenteVal")
1168:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1169:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1170:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1171:             ELSE
1172:                 THIS.AbrirBuscaContaEmitente()
1173:             ENDIF
1174:             IF USED("cursor_4c_EmitenteVal")
1175:                 USE IN cursor_4c_EmitenteVal
1176:             ENDIF
1177:         CATCH TO loc_oErro
1178:             MsgErro(loc_oErro.Message, "Erro")
1179:         ENDTRY
1180:     ENDPROC
1181: 

*-- Linhas 1202 a 1234:
1202:             ENDIF
1203: 
1204:             IF EMPTY(loc_cValor)
1205:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1206:             ELSE
1207:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1208:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1209:                            " ORDER BY Iclis"
1210:             ENDIF
1211:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1212: 
1213:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1214:                     AND !EMPTY(loc_cValor)
1215:                 IF USED("cursor_4c_BuscaEmitente")
1216:                     USE IN cursor_4c_BuscaEmitente
1217:                 ENDIF
1218:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1219:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaEmitente")
1220:             ENDIF
1221: 
1222:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1223:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1224:             ELSE
1225:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1226:                 IF VARTYPE(loc_oBusca) = "O"
1227:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1228:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1229:                     IF loc_oBusca.Mostrar()
1230:                         loc_cCpf = ""
1231:                         IF USED("cursor_4c_BuscaEmitente")
1232:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1233:                         ENDIF
1234:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1281 a 1300:
1281:         ENDIF
1282: 
1283:         TRY
1284:             loc_nResult = SQLEXEC(gnConnHandle, ;
1285:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1286:                 "cursor_4c_EmitenteVal")
1287:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1288:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1289:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1290:             ELSE
1291:                 THIS.AbrirBuscaCpfEmitente()
1292:             ENDIF
1293:             IF USED("cursor_4c_EmitenteVal")
1294:                 USE IN cursor_4c_EmitenteVal
1295:             ENDIF
1296:         CATCH TO loc_oErro
1297:             MsgErro(loc_oErro.Message, "Erro")
1298:         ENDTRY
1299: 
1300:         IF LEN(loc_cVal) = 14

*-- Linhas 1330 a 1362:
1330:             ENDIF
1331: 
1332:             IF EMPTY(loc_cValor)
1333:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1334:             ELSE
1335:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1336:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1337:                            " ORDER BY Cpfs"
1338:             ENDIF
1339:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1340: 
1341:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1342:                     AND !EMPTY(loc_cValor)
1343:                 IF USED("cursor_4c_BuscaEmitente")
1344:                     USE IN cursor_4c_BuscaEmitente
1345:                 ENDIF
1346:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1347:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaEmitente")
1348:             ENDIF
1349: 
1350:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1351:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1352:             ELSE
1353:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1354:                 IF VARTYPE(loc_oBusca) = "O"
1355:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1356:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1357:                     IF loc_oBusca.Mostrar()
1358:                         loc_cConta = ""
1359:                         IF USED("cursor_4c_BuscaEmitente")
1360:                             loc_cConta = ALLTRIM(cursor_4c_BuscaEmitente.Iclis)
1361:                         ENDIF
1362:                         THIS.PreencherEmitente(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;

*-- Linhas 1398 a 1417:
1398:         ENDIF
1399: 
1400:         TRY
1401:             loc_nResult = SQLEXEC(gnConnHandle, ;
1402:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1403:                 "cursor_4c_EmitenteVal")
1404:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1405:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1406:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1407:             ELSE
1408:                 THIS.AbrirBuscaNomeEmitente()
1409:             ENDIF
1410:             IF USED("cursor_4c_EmitenteVal")
1411:                 USE IN cursor_4c_EmitenteVal
1412:             ENDIF
1413:         CATCH TO loc_oErro
1414:             MsgErro(loc_oErro.Message, "Erro")
1415:         ENDTRY
1416:     ENDPROC
1417: 

*-- Linhas 1437 a 1469:
1437:             ENDIF
1438: 
1439:             IF EMPTY(loc_cValor)
1440:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1441:             ELSE
1442:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1443:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1444:                            " ORDER BY Rclis"
1445:             ENDIF
1446:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1447: 
1448:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1449:                     AND !EMPTY(loc_cValor)
1450:                 IF USED("cursor_4c_BuscaEmitente")
1451:                     USE IN cursor_4c_BuscaEmitente
1452:                 ENDIF
1453:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1454:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaEmitente")
1455:             ENDIF
1456: 
1457:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1458:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1459:             ELSE
1460:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1461:                 IF VARTYPE(loc_oBusca) = "O"
1462:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1463:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1464:                     IF loc_oBusca.Mostrar()
1465:                         loc_cCpf = ""
1466:                         IF USED("cursor_4c_BuscaEmitente")
1467:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1468:                         ENDIF
1469:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1529 a 1547:
1529: 
1530:     *--------------------------------------------------------------------------
1531:     * ValidarContaOrigem - KeyPress em txt_4c__Conta (equivalente ao Valid do
1532:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT exato
1533:     * por Iclis e, sem match, abre o picker com o valor digitado como prefixo.
1534:     *--------------------------------------------------------------------------
1535:     PROCEDURE ValidarContaOrigem(par_nKeyCode, par_nShiftAltCtrl)
1536:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1537: 
1538:         IF par_nKeyCode = 115
1539:             THIS.AbrirBuscaContaOrigem()
1540:             RETURN
1541:         ENDIF
1542:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1543:             RETURN
1544:         ENDIF
1545: 
1546:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1547:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)

*-- Linhas 1554 a 1573:
1554:         ENDIF
1555: 
1556:         TRY
1557:             loc_nResult = SQLEXEC(gnConnHandle, ;
1558:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1559:                 "cursor_4c_OrigemVal")
1560:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1561:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1562:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1563:             ELSE
1564:                 THIS.AbrirBuscaContaOrigem()
1565:             ENDIF
1566:             IF USED("cursor_4c_OrigemVal")
1567:                 USE IN cursor_4c_OrigemVal
1568:             ENDIF
1569:         CATCH TO loc_oErro
1570:             MsgErro(loc_oErro.Message, "Erro")
1571:         ENDTRY
1572:     ENDPROC
1573: 

*-- Linhas 1596 a 1628:
1596:             ENDIF
1597: 
1598:             IF EMPTY(loc_cValor)
1599:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1600:             ELSE
1601:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1602:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1603:                            " ORDER BY Iclis"
1604:             ENDIF
1605:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1606: 
1607:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1608:                     AND !EMPTY(loc_cValor)
1609:                 IF USED("cursor_4c_BuscaOrigem")
1610:                     USE IN cursor_4c_BuscaOrigem
1611:                 ENDIF
1612:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1613:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaOrigem")
1614:             ENDIF
1615: 
1616:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1617:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1618:             ELSE
1619:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1620:                 IF VARTYPE(loc_oBusca) = "O"
1621:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1622:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1623:                     IF loc_oBusca.Mostrar()
1624:                         loc_cCpf = ""
1625:                         IF USED("cursor_4c_BuscaOrigem")
1626:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1627:                         ENDIF
1628:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1644 a 1662:
1644:     *--------------------------------------------------------------------------
1645:     * ValidarCpfOrigem - KeyPress em txt_4c__Cpf (equivalente ao Valid do
1646:     * get_Cpf legado). Monta o CPF/CNPJ formatado (com pontuacao, igual ao
1647:     * valor gravado em SigCdCli.Cpfs), faz o SELECT exato e, sem match, abre
1648:     * o picker; ao final valida o digito verificador com ValidarCPF/ValidarCNPJ
1649:     * (regra #13 - delegar ao validador novo, nao ao wrapper do legado).
1650:     *--------------------------------------------------------------------------
1651:     PROCEDURE ValidarCpfOrigem(par_nKeyCode, par_nShiftAltCtrl)
1652:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1653:               loc_oOrig, loc_oErro
1654: 
1655:         IF par_nKeyCode = 115
1656:             THIS.AbrirBuscaCpfOrigem()
1657:             RETURN
1658:         ENDIF
1659:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1660:             RETURN
1661:         ENDIF
1662: 

*-- Linhas 1682 a 1701:
1682:         ENDIF
1683: 
1684:         TRY
1685:             loc_nResult = SQLEXEC(gnConnHandle, ;
1686:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1687:                 "cursor_4c_OrigemVal")
1688:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1689:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1690:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1691:             ELSE
1692:                 THIS.AbrirBuscaCpfOrigem()
1693:             ENDIF
1694:             IF USED("cursor_4c_OrigemVal")
1695:                 USE IN cursor_4c_OrigemVal
1696:             ENDIF
1697:         CATCH TO loc_oErro
1698:             MsgErro(loc_oErro.Message, "Erro")
1699:         ENDTRY
1700: 
1701:         IF LEN(loc_cVal) = 14

*-- Linhas 1732 a 1764:
1732:             ENDIF
1733: 
1734:             IF EMPTY(loc_cValor)
1735:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1736:             ELSE
1737:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1738:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1739:                            " ORDER BY Cpfs"
1740:             ENDIF
1741:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1742: 
1743:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1744:                     AND !EMPTY(loc_cValor)
1745:                 IF USED("cursor_4c_BuscaOrigem")
1746:                     USE IN cursor_4c_BuscaOrigem
1747:                 ENDIF
1748:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1749:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaOrigem")
1750:             ENDIF
1751: 
1752:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1753:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1754:             ELSE
1755:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1756:                 IF VARTYPE(loc_oBusca) = "O"
1757:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1758:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1759:                     IF loc_oBusca.Mostrar()
1760:                         loc_cConta = ""
1761:                         IF USED("cursor_4c_BuscaOrigem")
1762:                             loc_cConta = ALLTRIM(cursor_4c_BuscaOrigem.Iclis)
1763:                         ENDIF
1764:                         THIS.PreencherOrigem(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;

*-- Linhas 1779 a 1797:
1779: 
1780:     *--------------------------------------------------------------------------
1781:     * ValidarNomeOrigem - KeyPress em txt_4c__DConta (equivalente ao Valid do
1782:     * get_DConta legado). Faz o SELECT exato por Rclis e, sem match, abre o
1783:     * picker com o valor digitado como filtro "contem".
1784:     *--------------------------------------------------------------------------
1785:     PROCEDURE ValidarNomeOrigem(par_nKeyCode, par_nShiftAltCtrl)
1786:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1787: 
1788:         IF par_nKeyCode = 115
1789:             THIS.AbrirBuscaNomeOrigem()
1790:             RETURN
1791:         ENDIF
1792:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1797:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)

*-- Linhas 1804 a 1823:
1804:         ENDIF
1805: 
1806:         TRY
1807:             loc_nResult = SQLEXEC(gnConnHandle, ;
1808:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1809:                 "cursor_4c_OrigemVal")
1810:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1811:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1812:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1813:             ELSE
1814:                 THIS.AbrirBuscaNomeOrigem()
1815:             ENDIF
1816:             IF USED("cursor_4c_OrigemVal")
1817:                 USE IN cursor_4c_OrigemVal
1818:             ENDIF
1819:         CATCH TO loc_oErro
1820:             MsgErro(loc_oErro.Message, "Erro")
1821:         ENDTRY
1822:     ENDPROC
1823: 

*-- Linhas 1853 a 1889:
1853:             ENDIF
1854: 
1855:             IF EMPTY(loc_cValor)
1856:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1857:             ELSE
1858:                 *-- optFiltro = 2 ("Filtro") procura por CONTEM; = 1 ("Lista")
1859:                 *-- procura por COMECA COM (ver cabecalho deste metodo)
1860:                 loc_cPadrao = IIF(loc_oOrig.obj_4c_OptFiltro.Value = 2, ;
1861:                     "%" + loc_cValor + "%", loc_cValor + "%")
1862:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1863:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL(loc_cPadrao) + ;
1864:                            " ORDER BY Rclis"
1865:             ENDIF
1866:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1867: 
1868:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1869:                     AND !EMPTY(loc_cValor)
1870:                 IF USED("cursor_4c_BuscaOrigem")
1871:                     USE IN cursor_4c_BuscaOrigem
1872:                 ENDIF
1873:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1874:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaOrigem")
1875:             ENDIF
1876: 
1877:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1878:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1879:             ELSE
1880:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1881:                 IF VARTYPE(loc_oBusca) = "O"
1882:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1883:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1884:                     IF loc_oBusca.Mostrar()
1885:                         loc_cCpf = ""
1886:                         IF USED("cursor_4c_BuscaOrigem")
1887:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1888:                         ENDIF
1889:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;

*-- Linhas 1962 a 2002:
1962:     *
1963:     * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
1964:     * a compensacao +29 do pgf_4c_Paginas.Top = -29.
1965:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
1966:     * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
1967:     * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
1968:     *--------------------------------------------------------------------------
1969:     PROTECTED PROCEDURE ConfigurarGradesHistorico()
1970:         LOCAL loc_oPagina, loc_oErro
1971:         TRY
1972:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1973: 
1974:             *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
1975:             loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
1976:             WITH loc_oPagina.grd_4c_Cheque
1977:                 .Top                = 124 + 29
1978:                 .Left               = 8
1979:                 .Width              = 981
1980:                 .Height             = 228
1981:                 .HeaderHeight       = 0
1982:                 .ColumnCount        = 12
1983:                 .FontName           = "Tahoma"
1984:                 .FontSize           = 8
1985:                 .RowHeight          = 18
1986:                 .ScrollBars         = 2
1987:                 .DeleteMark         = .F.
1988:                 .RecordMark         = .F.
1989:                 .ForeColor          = RGB(0, 0, 0)
1990:                 .BackColor          = RGB(255, 255, 255)
1991:                 .GridLineColor      = RGB(238, 238, 238)
1992:                 .HighlightBackColor = RGB(255, 255, 255)
1993:                 .HighlightForeColor = RGB(15, 41, 104)
1994:                 .HighlightStyle     = 2
1995:                 .ReadOnly           = .T.
1996:                 .Themes             = .F.
1997:                 .Visible            = .T.
1998:             ENDWITH
1999:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Cheque, 12)
2000: 
2001:             *-- Colunas 1..10 travadas (Movable/Resizable = .F. no dump); as
2002:             *-- colunas 11 e 12 nao declaram essas duas e ficam no default

*-- Linhas 2031 a 2049:
2031:                 .FontSize           = 8
2032:                 .RowHeight          = 18
2033:                 .ScrollBars         = 2
2034:                 .DeleteMark         = .F.
2035:                 *-- RecordMark = .T. eh declaracao EXPLICITA do SCX legado -
2036:                 *-- GradeMovimenta eh a unica das tres grades que exibe a barra
2037:                 *-- de marcacao de registro (PILAR 1)
2038:                 .RecordMark         = .T.
2039:                 .ForeColor          = RGB(0, 0, 0)
2040:                 .BackColor          = RGB(255, 255, 255)
2041:                 .GridLineColor      = RGB(238, 238, 238)
2042:                 .HighlightBackColor = RGB(255, 255, 255)
2043:                 .HighlightForeColor = RGB(15, 41, 104)
2044:                 .HighlightStyle     = 2
2045:                 .ReadOnly           = .T.
2046:                 .Themes             = .F.
2047:                 .Visible            = .T.
2048:             ENDWITH
2049:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Movimenta, 9)

*-- Linhas 2064 a 2082:
2064:                 .HeaderHeight       = 16
2065:                 .RowHeight          = 18
2066:                 .ScrollBars         = 2
2067:                 .DeleteMark         = .F.
2068:                 .RecordMark         = .F.
2069:                 .ForeColor          = RGB(0, 0, 0)
2070:                 .BackColor          = RGB(255, 255, 255)
2071:                 .GridLineColor      = RGB(238, 238, 238)
2072:                 .HighlightBackColor = RGB(255, 255, 255)
2073:                 .HighlightForeColor = RGB(15, 41, 104)
2074:                 .HighlightStyle     = 2
2075:                 .ReadOnly           = .T.
2076:                 .Themes             = .F.
2077:                 .Visible            = .T.
2078:             ENDWITH
2079:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Prorrog, 1)
2080:         CATCH TO loc_oErro
2081:             MsgErro(loc_oErro.Message + CHR(13) + ;
2082:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 2504 a 2543:
2504:             loc_oPagina.grd_4c_Prorrog.Refresh()
2505: 
2506:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
2507:                 SELECT (loc_cAliasAnt)
2508:             ENDIF
2509:         CATCH TO loc_oErro
2510:             MsgErro(loc_oErro.Message + CHR(13) + ;
2511:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2512:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.RepintarGradesHistorico")
2513:         ENDTRY
2514:     ENDPROC
2515: 
2516:     *--------------------------------------------------------------------------
2517:     * CarregarDados - Transcricao do SqlDados legado.
2518:     *
2519:     * Monta os cursores do Historico e vincula as grades:
2520:     *   cursor_4c_Cheque    (SigChe + coluna Tipo) -> grd_4c_Cheque
2521:     *   cursor_4c_Movimento (SigCqChm)             -> grd_4c_Movimenta
2522:     *   cursor_4c_Prorrog   (SigChea)              -> grd_4c_Prorrog
2523:     *   cursor_4c_ChequeP   (auxiliar: Nums com historico em SigCheh - eh o
2524:     *                        'LocalChP' do legado, que marca a coluna Tipo)
2525:     * Os alias sao os declarados em SigOpChiBO.this_cCursor*.
2526:     *
2527:     * Cada SQLEXEC vai para cursor_4c_Temp e o alias definitivo eh recriado
2528:     * READWRITE a partir dele: SQLEXEC direto sobre o alias ligado a uma grade
2529:     * fecha e recria o alias, zerando o ColumnCount da grade.
2530:     *--------------------------------------------------------------------------
2531:     PROCEDURE CarregarDados()
2532:         LOCAL loc_lSucesso, loc_lModoTeste, loc_lOk, loc_oErro
2533:         LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
2534:         LOCAL loc_cConta, loc_cEmitente, loc_cFiltroEmi, loc_cNumCheque, loc_cAcesso
2535:         LOCAL loc_cSQLChe, loc_cSQLChP, loc_cSQLMov, loc_cSQLPro
2536:         loc_lSucesso = .F.
2537: 
2538:         loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2539:                          (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
2540: 
2541:         *-- RETURN sempre FORA de TRY/CATCH
2542:         IF loc_lModoTeste OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
2543:             RETURN .F.

*-- Linhas 2574 a 2752:
2574:             *-- Ramo 1 (legado: If !Empty(get_Conta.Value)) - historico COMPLETO
2575:             *-- da conta de origem, SEM recorte de periodo
2576:             IF !EMPTY(loc_cConta)
2577:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2578:                     " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
2579:                     " ORDER BY a.Vencs"
2580:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2581:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2582:                     " WHERE a.Iclis = " + EscaparSQL(loc_cConta)
2583:             ENDIF
2584: 
2585:             *-- Ramo 2 (legado: IF pcAcesso = 'TOTAL') - SOBREPOE o ramo 1:
2586:             *-- recorta pelo periodo de vencimento e, havendo conta de emitente
2587:             *-- informada, restringe a ConOrigs/Contat (legado: lcChecaC)
2588:             IF loc_cAcesso == "TOTAL"
2589:                 loc_cEmitente  = ALLTRIM(THIS.this_oBusinessObject.this_cContaEmitente)
2590:                 loc_cFiltroEmi = ""
2591:                 IF !EMPTY(loc_cEmitente)
2592:                     loc_cFiltroEmi = " AND (a.ConOrigs = " + EscaparSQL(loc_cEmitente) + ;
2593:                         " OR a.Contat = " + EscaparSQL(loc_cEmitente) + ")"
2594:                 ENDIF
2595:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2596:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2597:                     " AND " + FormatarDataSQL(loc_tFim) + ;
2598:                     loc_cFiltroEmi + ;
2599:                     " ORDER BY a.Vencs"
2600:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2601:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2602:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2603:                     " AND " + FormatarDataSQL(loc_tFim)
2604:             ENDIF
2605: 
2606:             *-- Ramo 3 (legado: IF pcAcesso = 'CARTEIRA') - SOBREPOE os
2607:             *-- anteriores: UM cheque especifico vindo da carteira
2608:             IF loc_cAcesso == "CARTEIRA"
2609:                 loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
2610:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2611:                     " AND " + FormatarDataSQL(loc_tFim) + ;
2612:                     " AND a.Bancos = "   + EscaparSQL(THIS.this_cParamBancos) + ;
2613:                     " AND a.Agencias = " + EscaparSQL(THIS.this_cParamAgencias) + ;
2614:                     " AND a.nContas = "  + EscaparSQL(THIS.this_cParamNContas) + ;
2615:                     " AND a.nCheques = " + EscaparSQL(THIS.this_cParamNCheques) + ;
2616:                     " ORDER BY a.Vencs"
2617:                 loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
2618:                     " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
2619:                     " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
2620:                     " AND " + FormatarDataSQL(loc_tFim)
2621:             ENDIF
2622: 
2623:             *-- Sem acesso irrestrito e sem conta de origem nenhum dos tres
2624:             *-- ramos monta consulta - o legado nem chega aqui, porque o
2625:             *-- Ok.Click exige a conta antes de trocar de pagina
2626:             IF EMPTY(loc_cSQLChe)
2627:                 MsgAviso("Informe a conta de origem antes de consultar o " + ;
2628:                     "hist" + CHR(243) + "rico.", "Aten" + CHR(231) + CHR(227) + "o")
2629:                 loc_lOk = .F.
2630:             ENDIF
2631: 
2632:             *-- 1) cursor auxiliar: Nums que possuem historico em SigCheh
2633:             IF loc_lOk
2634:                 THIS.FecharCursor("cursor_4c_ChequeP")
2635:                 THIS.FecharCursor("cursor_4c_Temp")
2636:                 IF SQLEXEC(gnConnHandle, loc_cSQLChP, "cursor_4c_Temp") < 0
2637:                     MsgErro("Erro ao consultar o hist" + CHR(243) + "rico dos cheques." + ;
2638:                         CHR(13) + CapturarErroSQL(), "FormSigOpChi.CarregarDados")
2639:                     loc_lOk = .F.
2640:                 ELSE
2641:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_ChequeP READWRITE
2642:                     THIS.FecharCursor("cursor_4c_Temp")
2643:                     SELECT cursor_4c_ChequeP
2644:                     INDEX ON Nums TAG Nums
2645:                 ENDIF
2646:             ENDIF
2647: 
2648:             *-- 2) cursor principal da GradeCheque
2649:             IF loc_lOk
2650:                 THIS.FecharCursor("cursor_4c_Cheque")
2651:                 THIS.FecharCursor("cursor_4c_Temp")
2652:                 IF SQLEXEC(gnConnHandle, loc_cSQLChe, "cursor_4c_Temp") < 0
2653:                     MsgErro("Erro ao consultar os cheques." + CHR(13) + CapturarErroSQL(), ;
2654:                         "FormSigOpChi.CarregarDados")
2655:                     loc_lOk = .F.
2656:                 ELSE
2657:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Cheque READWRITE
2658:                     THIS.FecharCursor("cursor_4c_Temp")
2659:                 ENDIF
2660:             ENDIF
2661: 
2662:             *-- 3) marca com "S" o cheque que tem historico (legado: Scan +
2663:             *-- Seek em LocalChP + Replace Tipo With [S]) e cria os TAGs que a
2664:             *-- ordenacao por cabecalho de coluna usa
2665:             loc_cNumCheque = ""
2666:             IF loc_lOk
2667:                 SELECT cursor_4c_Cheque
2668:                 SCAN
2669:                     IF SEEK(Nums, "cursor_4c_ChequeP", "Nums")
2670:                         REPLACE Tipo WITH "S"
2671:                     ENDIF
2672:                 ENDSCAN
2673: 
2674:                 THIS.IndexarCursorCheque()
2675: 
2676:                 *-- Legado: Go Bottom / lcNum = CrSigChe.Nums - o ultimo cheque
2677:                 *-- na ordem de vencimento eh quem alimenta as duas grades de
2678:                 *-- detalhe. Nums vai SEM ALLTRIM: eh char(8) e o SQL Server
2679:                 *-- compara char com blank-padding
2680:                 IF RECCOUNT("cursor_4c_Cheque") > 0
2681:                     GO BOTTOM
2682:                     loc_cNumCheque = cursor_4c_Cheque.Nums
2683:                 ENDIF
2684: 
2685:                 *-- Legado: Update CrSigChe Set DtEmis = Nvl(DtEmis, Ctod([]))
2686:                 *-- - sem isso a Column12 (Emissao) recebe TTOD(.NULL.)
2687:                 REPLACE ALL DtEmis WITH CTOT("") FOR ISNULL(DtEmis)
2688:                 GO TOP
2689:             ENDIF
2690: 
2691:             *-- 4) grades de detalhe do cheque corrente. Legado: Requery de
2692:             *-- CrSigCqChm e CrSigChea, cujas queries sao as do AddCursor do Init:
2693:             *--   Select * From SigCqChm Where Nums = ?lcNum Order By Nums, Dtsis Desc
2694:             *--   Select * From SigChea  Where Nums = ?lcNum
2695:             IF loc_lOk
2696:                 loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + ;
2697:                     EscaparSQL(loc_cNumCheque) + " ORDER BY Nums, Dtsis DESC"
2698:                 loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + ;
2699:                     EscaparSQL(loc_cNumCheque)
2700: 
2701:                 THIS.FecharCursor("cursor_4c_Movimento")
2702:                 THIS.FecharCursor("cursor_4c_Temp")
2703:                 IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
2704:                     MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
2705:                         "o do cheque." + CHR(13) + CapturarErroSQL(), ;
2706:                         "FormSigOpChi.CarregarDados")
2707:                     loc_lOk = .F.
2708:                 ELSE
2709:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
2710:                     THIS.FecharCursor("cursor_4c_Temp")
2711:                 ENDIF
2712:             ENDIF
2713: 
2714:             IF loc_lOk
2715:                 THIS.FecharCursor("cursor_4c_Prorrog")
2716:                 THIS.FecharCursor("cursor_4c_Temp")
2717:                 IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
2718:                     MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
2719:                         "es do cheque." + CHR(13) + CapturarErroSQL(), ;
2720:                         "FormSigOpChi.CarregarDados")
2721:                     loc_lOk = .F.
2722:                 ELSE
2723:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
2724:                     THIS.FecharCursor("cursor_4c_Temp")
2725:                 ENDIF
2726:             ENDIF
2727: 
2728:             *-- 5) vinculo das grades. O legado so vincula havendo registro:
2729:             *-- "If Reccount('CrSigChe') > 0"
2730:             IF loc_lOk AND RECCOUNT("cursor_4c_Cheque") > 0
2731:                 THIS.VincularGradeCheque()
2732:                 THIS.VincularGradeMovimenta()
2733:                 THIS.VincularGradeProrrog()
2734: 
2735:                 *-- Carrega no BO o cheque corrente, para que as acoes sobre a
2736:                 *-- linha selecionada leiam as propriedades do BO
2737:                 SELECT cursor_4c_Cheque
2738:                 GO TOP
2739:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2740: 
2741:                 *-- Rede de seguranca: o legado conta com o GradeCheque.
2742:                 *-- AfterRowColChange disparando sozinho ao vincular RecordSource
2743:                 *-- (VincularGradeCheque, chamado acima) para corrigir Documento/
2744:                 *-- Carteira/Followup/Caption do registro do GO TOP (o SqlDados
2745:                 *-- carrega Movimento/Prorrog do GO BOTTOM so para obter lcNum).
2746:                 *-- Chamar aqui tambem garante o mesmo resultado mesmo que o
2747:                 *-- AfterRowColChange nao dispare sozinho neste ponto do ciclo
2748:                 *-- de vida do form (ex.: pagina ainda nao esta ActivePage).
2749:                 THIS.AtualizarEstadoChequeAtual()
2750:             ENDIF
2751: 
2752:             THIS.RepintarGradesHistorico()

*-- Linhas 2761 a 2803:
2761:     ENDPROC
2762: 
2763:     *--------------------------------------------------------------------------
2764:     * VincularGradeCheque - ColumnCount -> RecordSource -> ControlSource ->
2765:     * Width -> Header1.Caption. A ordem eh obrigatoria: RecordSource recalcula
2766:     * as larguras das colunas para o default, entao Width e caption vem por
2767:     * ultimo. ControlSource e DynamicFore/BackColor transcritos do SqlDados.
2768:     *--------------------------------------------------------------------------
2769:     PROTECTED PROCEDURE VincularGradeCheque()
2770:         LOCAL loc_oGrade
2771:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
2772: 
2773:         WITH loc_oGrade
2774:             .ColumnCount  = 12
2775:             .RecordSource = "cursor_4c_Cheque"
2776: 
2777:             .Column1.ControlSource  = "TTOD(cursor_4c_Cheque.Vencs)"
2778:             .Column2.ControlSource  = "cursor_4c_Cheque.Bancos"
2779:             .Column3.ControlSource  = "cursor_4c_Cheque.Agencias"
2780:             .Column4.ControlSource  = "cursor_4c_Cheque.nContas"
2781:             .Column5.ControlSource  = "cursor_4c_Cheque.nCheques"
2782:             .Column6.ControlSource  = "cursor_4c_Cheque.Valors"
2783:             .Column7.ControlSource  = "cursor_4c_Cheque.GruCarts"
2784:             .Column8.ControlSource  = "cursor_4c_Cheque.ConCarts"
2785:             .Column9.ControlSource  = "cursor_4c_Cheque.Emps"
2786:             .Column10.ControlSource = "cursor_4c_Cheque.Numeros"
2787:             .Column11.ControlSource = "cursor_4c_Cheque.UMovs"
2788:             .Column12.ControlSource = "TTOD(cursor_4c_Cheque.DtEmis)"
2789: 
2790:             .Column1.Width  = 80
2791:             .Column2.Width  = 35
2792:             .Column3.Width  = 49
2793:             .Column4.Width  = 90
2794:             .Column5.Width  = 60
2795:             .Column6.Width  = 115
2796:             .Column7.Width  = 95
2797:             .Column8.Width  = 95
2798:             .Column9.Width  = 31
2799:             .Column10.Width = 58
2800:             .Column11.Width = 150
2801:             .Column12.Width = 80
2802: 
2803:             .Column1.Header1.Caption  = "Vencimento"

*-- Linhas 2848 a 2885:
2848:     ENDPROC
2849: 
2850:     *--------------------------------------------------------------------------
2851:     * VincularGradeMovimenta - ControlSource/Width/Caption de GradeMovimenta
2852:     * (SigCqChm), transcritos do SqlDados e do dump legado
2853:     *--------------------------------------------------------------------------
2854:     PROTECTED PROCEDURE VincularGradeMovimenta()
2855:         LOCAL loc_oGrade
2856:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Movimenta
2857: 
2858:         WITH loc_oGrade
2859:             .ColumnCount  = 9
2860:             .RecordSource = "cursor_4c_Movimento"
2861: 
2862:             .Column1.ControlSource = "cursor_4c_Movimento.Codigos"
2863:             .Column2.ControlSource = "cursor_4c_Movimento.Nalineas"
2864:             .Column3.ControlSource = "TTOD(cursor_4c_Movimento.DtEnts)"
2865:             .Column4.ControlSource = "cursor_4c_Movimento.GruOrigs"
2866:             .Column5.ControlSource = "cursor_4c_Movimento.ConOrigs"
2867:             .Column6.ControlSource = "cursor_4c_Movimento.Grupos"
2868:             .Column7.ControlSource = "cursor_4c_Movimento.Contas"
2869:             .Column8.ControlSource = "cursor_4c_Movimento.NumLotes"
2870:             .Column9.ControlSource = "cursor_4c_Movimento.Protocolos"
2871: 
2872:             .Column1.Width = 157
2873:             .Column2.Width = 40
2874:             .Column3.Width = 80
2875:             .Column4.Width = 90
2876:             .Column5.Width = 90
2877:             .Column6.Width = 90
2878:             .Column7.Width = 90
2879:             .Column8.Width = 90
2880:             .Column9.Width = 90
2881: 
2882:             .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2883:             .Column2.Header1.Caption = "Alinea"
2884:             .Column3.Header1.Caption = "Entrada"
2885:             .Column4.Header1.Caption = "Grupo/Origem"

*-- Linhas 2897 a 2961:
2897:     ENDPROC
2898: 
2899:     *--------------------------------------------------------------------------
2900:     * VincularGradeProrrog - ControlSource/Width/Caption de GradeProrrog
2901:     * (SigChea - vencimentos das prorrogacoes do cheque corrente)
2902:     *--------------------------------------------------------------------------
2903:     PROTECTED PROCEDURE VincularGradeProrrog()
2904:         LOCAL loc_oGrade
2905:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Prorrog
2906: 
2907:         WITH loc_oGrade
2908:             .ColumnCount             = 1
2909:             .RecordSource            = "cursor_4c_Prorrog"
2910:             .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
2911:             .Column1.Width           = 83
2912:             .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
2913:         ENDWITH
2914:     ENDPROC
2915: 
2916:     *--------------------------------------------------------------------------
2917:     * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados
2918:     * (carga inicial) e por AcaoProcurarClick (mescla dos cheques encontrados
2919:     * pelo dialogo de busca). Fatorado para nao duplicar o bloco em dois
2920:     * lugares - mesmas dez expressoes do SqlDados legado.
2921:     *--------------------------------------------------------------------------
2922:     PROTECTED PROCEDURE IndexarCursorCheque()
2923:         SELECT cursor_4c_Cheque
2924:         INDEX ON DTOS(Vencs) + Bancos + Agencias + nContas + nCheques TAG Venc
2925:         INDEX ON Bancos + Agencias + nContas + nCheques TAG Cheque
2926:         INDEX ON Agencias + nContas + nCheques TAG Agencia
2927:         INDEX ON Agencias + nContas TAG AgenciaCta
2928:         INDEX ON Agencias + nCheques TAG AgenciaChe
2929:         INDEX ON nContas + nCheques TAG Conta
2930:         INDEX ON nCheques TAG NCheque
2931:         INDEX ON STR(Valors, 12, 2) + Bancos + Agencias + nContas + nCheques TAG Valor
2932:         INDEX ON Numeros TAG Numeros
2933:         INDEX ON Nums TAG Nums
2934:         SET ORDER TO Venc
2935:     ENDPROC
2936: 
2937:     *--------------------------------------------------------------------------
2938:     * ConfigurarCursorProtocolo - Cursor local usado por AcaoProtocoloClick,
2939:     * equivalente ao "Create Cursor TempChq" que o Init legado executa uma
2940:     * unica vez. Chamado uma vez em InicializarForm.
2941:     *--------------------------------------------------------------------------
2942:     PROTECTED PROCEDURE ConfigurarCursorProtocolo()
2943:         LOCAL loc_oErro
2944:         TRY
2945:             IF !USED("cursor_4c_Protocolo")
2946:                 CREATE CURSOR cursor_4c_Protocolo (Bancos C(3), Agencias C(4), ;
2947:                     NContas C(10), NCheques C(6), Vencs D NULL, Valors N(12, 2), ;
2948:                     Emps C(3), Iclis C(10), Grclis C(10), Contas C(10), ;
2949:                     Grupos C(10), ValPags N(12, 2), Nums C(8), Protocolos C(8), Obss M)
2950:                 INDEX ON Bancos + Agencias + NContas + NCheques TAG Cheque
2951:             ENDIF
2952:         CATCH TO loc_oErro
2953:             MsgErro(loc_oErro.Message + CHR(13) + ;
2954:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2955:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarCursorProtocolo")
2956:         ENDTRY
2957:     ENDPROC
2958: 
2959:     *--------------------------------------------------------------------------
2960:     * ExigirChequeSelecionado - Guarda comum aos 8 botoes de cmg_4c_Botoes:
2961:     * nenhum deles tem sentido sem uma linha corrente em cursor_4c_Cheque (o

*-- Linhas 2980 a 3018:
2980:     * CmdOkClick e nao muda por linha), Documento.Enabled (ChkRegister
2981:     * SigCdPgr/SigMvCab x2), Carteira.Enabled (ChkRegister SIGCCCHM) e o
2982:     * texto do ultimo Followup (SigCheh). ChkRegister nao existe na nova
2983:     * arquitetura (regra do projeto) - substituido por SELECT COUNT(*).
2984:     *--------------------------------------------------------------------------
2985:     PROTECTED PROCEDURE AtualizarEstadoChequeAtual()
2986:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
2987:               loc_lDocEnab, loc_lCartEnab, loc_cHist, loc_cRclis, loc_cCpfs, loc_oErro
2988: 
2989:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
2990:             RETURN
2991:         ENDIF
2992: 
2993:         TRY
2994:             SELECT cursor_4c_Cheque
2995:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2996: 
2997:             *-- Caption (legado: ramo "If ThisForm.Acesso")
2998:             IF THIS.this_lAcesso
2999:                 loc_cRclis = ""
3000:                 loc_cCpfs  = ""
3001:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3002:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + ;
3003:                     EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cIClis)), "cursor_4c_CliCaption")
3004:                 IF loc_nResultado > 0 AND USED("cursor_4c_CliCaption") AND !EOF("cursor_4c_CliCaption")
3005:                     loc_cRclis = ALLTRIM(cursor_4c_CliCaption.Rclis)
3006:                     loc_cCpfs  = ALLTRIM(cursor_4c_CliCaption.Cpfs)
3007:                 ENDIF
3008:                 THIS.FecharCursor("cursor_4c_CliCaption")
3009:                 *-- Caption guardado no BO (this_cCaptionAtual eh a fonte unica
3010:                 *-- que BOParaForm espelha ao recarregar a tela)
3011:                 THIS.this_oBusinessObject.this_cCaptionAtual = ;
3012:                     "Hist" + CHR(243) + "rico de Cheques de: " + ;
3013:                     ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
3014:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
3015:                 THIS.AtualizarTituloCabecalho()
3016:             ENDIF
3017: 
3018:             *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',

*-- Linhas 3028 a 3090:
3028:                 loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
3029:                 loc_cKey2 = cursor_4c_Movimento.EmpDopNums
3030: 
3031:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3032:                     "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + ;
3033:                     EscaparSQL(ALLTRIM(loc_cEmpr)) + " AND Dopes = " + EscaparSQL(loc_cDope) + ;
3034:                     " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), "cursor_4c_DocVal")
3035:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3036:                     loc_lDocEnab = .T.
3037:                 ENDIF
3038:                 THIS.FecharCursor("cursor_4c_DocVal")
3039: 
3040:                 IF !loc_lDocEnab
3041:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3042:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3043:                         EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3044:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3045:                         loc_lDocEnab = .T.
3046:                     ENDIF
3047:                     THIS.FecharCursor("cursor_4c_DocVal")
3048:                 ENDIF
3049: 
3050:                 IF !loc_lDocEnab
3051:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3052:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3053:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3054:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3055:                         loc_lDocEnab = .T.
3056:                     ENDIF
3057:                     THIS.FecharCursor("cursor_4c_DocVal")
3058:                 ENDIF
3059:             ENDIF
3060:             THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(7).Enabled = loc_lDocEnab
3061: 
3062:             *-- Carteira.Enabled (legado: ChkRegister('SIGCCCHM', 'Nums', CrSigChe.Nums))
3063:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3064:                 "SELECT COUNT(*) AS nExiste FROM SIGCCCHM WHERE Nums = " + ;
3065:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)), "cursor_4c_DocVal")
3066:             loc_lCartEnab = loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3067:             THIS.FecharCursor("cursor_4c_DocVal")
3068:             THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(5).Enabled = loc_lCartEnab
3069: 
3070:             *-- Ultimo followup (legado: CursorQuery SigCheh + Index On Datas
3071:             *-- Descending + Go Top)
3072:             loc_cHist = ""
3073:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3074:                 "SELECT TOP 1 Hists FROM SigCheh WHERE Nums = " + ;
3075:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)) + ;
3076:                 " ORDER BY Datas DESC", "cursor_4c_FollowupVal")
3077:             IF loc_nResultado > 0 AND USED("cursor_4c_FollowupVal") AND !EOF("cursor_4c_FollowupVal")
3078:                 loc_cHist = TratarNulo(cursor_4c_FollowupVal.Hists, "")
3079:             ENDIF
3080:             THIS.FecharCursor("cursor_4c_FollowupVal")
3081:             *-- Fonte unica no BO; a tela espelha (BOParaForm faz o mesmo ao
3082:             *-- recarregar, para o campo nao "esquecer" o texto)
3083:             THIS.this_oBusinessObject.this_cUltimoFollowup = loc_cHist
3084:             THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = loc_cHist
3085:         CATCH TO loc_oErro
3086:             MsgErro(loc_oErro.Message + CHR(13) + ;
3087:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3088:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AtualizarEstadoChequeAtual")
3089:         ENDTRY
3090:     ENDPROC

*-- Linhas 3111 a 3151:
3111:             loc_oPagina.grd_4c_Movimenta.RecordSource = ""
3112:             loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
3113: 
3114:             loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
3115:                 " ORDER BY Nums, Dtsis DESC"
3116:             loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)
3117: 
3118:             THIS.FecharCursor("cursor_4c_Movimento")
3119:             THIS.FecharCursor("cursor_4c_Temp")
3120:             IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
3121:                 MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
3122:                     "o do cheque." + CHR(13) + CapturarErroSQL(), ;
3123:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3124:             ELSE
3125:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
3126:             ENDIF
3127:             THIS.FecharCursor("cursor_4c_Temp")
3128: 
3129:             THIS.FecharCursor("cursor_4c_Prorrog")
3130:             THIS.FecharCursor("cursor_4c_Temp")
3131:             IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
3132:                 MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
3133:                     "es do cheque." + CHR(13) + CapturarErroSQL(), ;
3134:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3135:             ELSE
3136:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
3137:             ENDIF
3138:             THIS.FecharCursor("cursor_4c_Temp")
3139: 
3140:             THIS.VincularGradeMovimenta()
3141:             THIS.VincularGradeProrrog()
3142:             THIS.AtualizarEstadoChequeAtual()
3143:             THIS.RepintarGradesHistorico()
3144:         CATCH TO loc_oErro
3145:             MsgErro(loc_oErro.Message + CHR(13) + ;
3146:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3147:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.GradeChequeAfterRowColChange")
3148:         ENDTRY
3149:     ENDPROC
3150: 
3151:     *--------------------------------------------------------------------------

*-- Linhas 3186 a 3204:
3186: 
3187:         TRY
3188:             loc_nRecno = RECNO("cursor_4c_Cheque")
3189:             SELECT cursor_4c_Cheque
3190:             SET ORDER TO (loc_cOrd)
3191:             IF BETWEEN(loc_nRecno, 1, RECCOUNT())
3192:                 GO RECORD (loc_nRecno)
3193:             ENDIF
3194: 
3195:             loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3196:             FOR loc_nI = 1 TO 6
3197:                 loc_oGrade.Columns(loc_nI).Header1.BackColor = ;
3198:                     IIF(loc_nI = par_nColuna, RGB(220, 255, 220), RGB(192, 192, 192))
3199:             ENDFOR
3200:             loc_oGrade.Refresh()
3201:         CATCH TO loc_oErro
3202:             MsgErro(loc_oErro.Message + CHR(13) + ;
3203:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3204:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.OrdenarGradeCheque")

*-- Linhas 3304 a 3337:
3304: 
3305:                 IF USED("cursor_4c_SigChe") AND RECCOUNT("cursor_4c_SigChe") > 0 AND ;
3306:                         USED("cursor_4c_Cheque")
3307:                     SELECT cursor_4c_SigChe
3308:                     SCAN
3309:                         loc_cNums = Nums
3310:                         IF !SEEK(loc_cNums, "cursor_4c_Cheque", "Nums")
3311:                             SCATTER MEMVAR MEMO
3312:                             SELECT cursor_4c_Cheque
3313:                             APPEND BLANK
3314:                             GATHER MEMVAR MEMO
3315:                             REPLACE Tipo WITH IIF(USED("cursor_4c_ChequeP") AND ;
3316:                                 SEEK(loc_cNums, "cursor_4c_ChequeP", "Nums"), "S", " ")
3317:                         ENDIF
3318:                         SELECT cursor_4c_SigChe
3319:                     ENDSCAN
3320: 
3321:                     THIS.IndexarCursorCheque()
3322:                     SELECT cursor_4c_Cheque
3323:                     GO TOP
3324:                     THIS.AtualizarEstadoChequeAtual()
3325:                     THIS.RepintarGradesHistorico()
3326:                 ENDIF
3327: 
3328:                 loc_oBusca.Release()
3329:             ENDIF
3330:         CATCH TO loc_oErro
3331:             MsgErro(loc_oErro.Message + CHR(13) + ;
3332:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3333:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProcurarClick")
3334:         ENDTRY
3335: 
3336:         *-- Legado: ThisForm.Pagina.Historico.Refresh + GradeCheque.SetFocus +
3337:         *-- GradeCheque.Column1.Text1.SetFocus

*-- Linhas 3346 a 3377:
3346:     * crSigCdOpt (Operacaos = CrSigChe.Umovs); bloqueia com aviso se
3347:     * Tipos = "CR" e Prorrogas <> 1; senao "Do Form SigOpChp With ThisForm".
3348:     * crSigCdOpt nao existe como cursor global nesta migracao - substituido
3349:     * por SELECT direto em SigCdOpt. SigOpChp ainda nao foi migrado.
3350:     *--------------------------------------------------------------------------
3351:     PROCEDURE AcaoProrrogaClick()
3352:         LOCAL loc_nResultado, loc_cTipos, loc_nProrrogas, loc_lPode, loc_oForm, loc_oErro
3353: 
3354:         IF !THIS.ExigirChequeSelecionado()
3355:             RETURN
3356:         ENDIF
3357: 
3358:         loc_lPode = .T.
3359:         TRY
3360:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3361:                 "SELECT TOP 1 Tipos, Prorrogas FROM SigCdOpt WHERE Operacaos = " + ;
3362:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cUMovs)), "cursor_4c_OptVal")
3363:             IF loc_nResultado > 0 AND USED("cursor_4c_OptVal") AND !EOF("cursor_4c_OptVal")
3364:                 loc_cTipos     = ALLTRIM(cursor_4c_OptVal.Tipos)
3365:                 loc_nProrrogas = NVL(cursor_4c_OptVal.Prorrogas, 0)
3366:                 IF loc_cTipos == "CR" AND loc_nProrrogas != 1
3367:                     MsgAviso("Imposs" + CHR(237) + "vel prorrogar cheques que n" + CHR(227) + ;
3368:                         "o estejam pendentes...", "Aten" + CHR(231) + CHR(227) + "o!!!")
3369:                     loc_lPode = .F.
3370:                 ENDIF
3371:             ENDIF
3372:             THIS.FecharCursor("cursor_4c_OptVal")
3373:         CATCH TO loc_oErro
3374:             MsgErro(loc_oErro.Message, "Erro")
3375:             loc_lPode = .F.
3376:         ENDTRY
3377: 

*-- Linhas 3481 a 3501:
3481: 
3482:         TRY
3483:             IF USED("cursor_4c_Protocolo")
3484:                 SELECT cursor_4c_Protocolo
3485:                 ZAP
3486:                 INSERT INTO cursor_4c_Protocolo (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
3487:                     VALUES (THIS.this_oBusinessObject.this_cBancos, THIS.this_oBusinessObject.this_cAgencias, ;
3488:                             THIS.this_oBusinessObject.this_cNContas, THIS.this_oBusinessObject.this_cNCheques, ;
3489:                             ConverterParaData(THIS.this_oBusinessObject.this_dVencs), ;
3490:                             THIS.this_oBusinessObject.this_nValors, loc_cProtocolo)
3491:             ENDIF
3492:         CATCH TO loc_oErro
3493:             MsgErro(loc_oErro.Message + CHR(13) + ;
3494:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3495:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProtocoloClick")
3496:         ENDTRY
3497: 
3498:         TRY
3499:             loc_oForm = CREATEOBJECT("FormSigOpIbo", THIS, 1, loc_cCaption)
3500:             IF VARTYPE(loc_oForm) = "O"
3501:                 loc_oForm.Show()

*-- Linhas 3512 a 3530:
3512:     * Numes; SigMvCab por EmpDopNums recalculado; SigMvCab por EmpDopNums do
3513:     * proprio registro de SigCqChm), abrindo SigCdPgr/SigMvExp conforme o
3514:     * primeiro que casar. ChkRegister nao existe na nova arquitetura -
3515:     * substituido por SELECT COUNT(*). FormSigMvExp JA FOI MIGRADO; SigCdPgr
3516:     * ainda nao. O guard "WExist('FORM_')" do legado (bloqueia abrir SigMvExp
3517:     * com a Movimentacao de Estoque aberta) nao tem equivalente nesta
3518:     * arquitetura - nao ha janela "FORM_" para detectar.
3519:     *--------------------------------------------------------------------------
3520:     PROCEDURE AcaoDocumentoClick()
3521:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
3522:               loc_oForm, loc_oErro
3523: 
3524:         IF !THIS.ExigirChequeSelecionado()
3525:             RETURN
3526:         ENDIF
3527:         IF !USED("cursor_4c_Movimento") OR EOF("cursor_4c_Movimento")
3528:             MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o selecionada.", ;
3529:                 "Aten" + CHR(231) + CHR(227) + "o")
3530:             RETURN

*-- Linhas 3539 a 3581:
3539: 
3540:         loc_oForm = .NULL.
3541:         TRY
3542:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3543:                 "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + EscaparSQL(ALLTRIM(loc_cEmpr)) + ;
3544:                 " AND Dopes = " + EscaparSQL(loc_cDope) + " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), ;
3545:                 "cursor_4c_DocVal")
3546:             IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3547:                 THIS.FecharCursor("cursor_4c_DocVal")
3548:                 TRY
3549:                     loc_oForm = CREATEOBJECT("FormSigCdPgr", LEFT(loc_cDope, 1), .T., loc_cEmpr, loc_cDope, loc_nNume)
3550:                 CATCH TO loc_oErro
3551:                     MsgAviso("Tela de Registro de Pagamentos (SigCdPgr) ainda n" + CHR(227) + ;
3552:                         "o foi migrada.", "Indispon" + CHR(237) + "vel")
3553:                 ENDTRY
3554:             ELSE
3555:                 THIS.FecharCursor("cursor_4c_DocVal")
3556:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3557:                     "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3558:                     EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3559:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3560:                     THIS.FecharCursor("cursor_4c_DocVal")
3561:                     loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, loc_cEmpr, .T.)
3562:                 ELSE
3563:                     THIS.FecharCursor("cursor_4c_DocVal")
3564:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3565:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3566:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3567:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3568:                         loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, ;
3569:                             cursor_4c_Movimento.Emps, .T.)
3570:                     ENDIF
3571:                 ENDIF
3572:             ENDIF
3573:             THIS.FecharCursor("cursor_4c_DocVal")
3574: 
3575:             IF VARTYPE(loc_oForm) = "O"
3576:                 loc_oForm.Show()
3577:             ENDIF
3578:         CATCH TO loc_oErro
3579:             MsgErro(loc_oErro.Message + CHR(13) + ;
3580:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3581:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoDocumentoClick")

*-- Linhas 3615 a 3634:
3615:     * FASE 8 - CONSOLIDACAO: hooks de transferencia, funil de carga, estado
3616:     * dos campos e dos botoes.
3617:     *
3618:     * Este form OPERACIONAL nao tem CRUD (o legado SIGOPCHI nao faz Insert/
3619:     * Update/Delete em SigChe - ver cabecalho de SigOpChiBO.prg), mas TEM
3620:     * campos EDITAVEIS que alimentam a operacao: os tres campos do container
3621:     * Origem (Page1) + o OptionGroup Lista/Filtro, os tres campos do container
3622:     * Emitente (Page2) e as duas datas do periodo de vencimento. Por isso
3623:     * FormParaBO/BOParaForm existem de verdade aqui - o bloco ja estava no
3624:     * Init legado, espalhado pelos AddObject, sem esse nome.
3625:     *==========================================================================
3626: 
3627:     *--------------------------------------------------------------------------
3628:     * FormParaBO - Le os campos EDITAVEIS da tela para as propriedades do BO,
3629:     * que sao a FONTE UNICA lida por CarregarDados.
3630:     *
3631:     * PROTECTED porque FormBase declara este hook PROTECTED e VFP9 nao permite
3632:     * ALARGAR o escopo de metodo herdado.
3633:     *
3634:     * Transferencia pura, sem validacao propria: a unica validacao que o


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

