CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1334: Tabela 'SigCdGcc' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1378: Tabela 'SigCdNop' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~2090: Tabela 'SigCdNop' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormFea.prg):

--- Linhas 1315 a 1355 ---
1315:         LOCAL loc_cSql, loc_cEmpr
1316:         loc_cEmpr = THIS.this_cPEmps
1317: 
1318:         TRY
1319:             *-- crSigCdPac - parametros de conta do balanco
1320:             IF !USED("crSigCdPac")
1321:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
1322:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
1323:             ENDIF
1324: 
1325:             *-- crSigCdPam - parametros de material do balanco
1326:             IF !USED("crSigCdPam")
1327:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
1328:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
1329:             ENDIF
1330: 
1331:             *-- TmpGccr - grupos de balanco da empresa (SigCdGcc)
1332:             *-- Campos: Codigos (BalCodigo), Descrs (BalDescrs), UnifBals, GruFals, etc.
1333:             IF !USED("TmpGccr")
1334:                 loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals, BalCodigo, BalDescrs FROM SigCdGcc " + ;
1335:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr)
1336:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
1337:                     SELECT TmpGccr
1338:                     INDEX ON BalCodigo  TAG BalCodigo
1339:                     INDEX ON BalDescrs  TAG BalDescrs
1340:                     SET ORDER TO BalCodigo
1341:                 ENDIF
1342:             ENDIF
1343: 
1344:             *-- TmpCli - contas de balanco (clientes/contas correntes)
1345:             IF !USED("TmpCli")
1346:                 loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
1347:                            "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
1348:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
1349:                     SELECT TmpCli
1350:                     INDEX ON BalCodigo TAG BalCodigo
1351:                     INDEX ON BalNome   TAG BalNome
1352:                     SET ORDER TO BalCodigo
1353:                 ENDIF
1354:             ENDIF
1355: 

--- Linhas 1359 a 1399 ---
1359:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
1360:                     SELECT TmpPro
1361:                     INDEX ON CPros TAG CPros
1362:                     SET ORDER TO CPros
1363:                 ENDIF
1364:             ENDIF
1365: 
1366:             *-- crSigOpOpt - opcoes de operacao (SigOpOpt)
1367:             IF !USED("crSigOpOpt")
1368:                 loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
1369:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
1370:                     SELECT crSigOpOpt
1371:                     INDEX ON Cods TAG Cods
1372:                     SET ORDER TO Cods
1373:                 ENDIF
1374:             ENDIF
1375: 
1376:             *-- LocalOpp - tipos de operacao de producao (SigCdNop)
1377:             IF !USED("LocalOpp")
1378:                 loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
1379:                 IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
1380:                     SELECT LocalOpp
1381:                     INDEX ON Dopps TAG Dopps
1382:                     SET ORDER TO Dopps
1383:                 ENDIF
1384:             ENDIF
1385: 
1386:             *-- crSigCdOpe - tipos de operacao de estoque (SigCdOpe)
1387:             IF !USED("crSigCdOpe")
1388:                 loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
1389:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
1390:                     SELECT crSigCdOpe
1391:                     INDEX ON Dopes TAG Dopes
1392:                     SET ORDER TO Dopes
1393:                 ENDIF
1394:             ENDIF
1395: 
1396:         CATCH TO loc_oErro
1397:             MsgErro("Erro em CarregarDadosAuxiliares:" + CHR(13) + loc_oErro.Message, "FormFea")
1398:         ENDTRY
1399:     ENDPROC

--- Linhas 2071 a 2111 ---
2071: 
2072:         *-- Garantir TmpPro / crSigOpOpt / LocalOpp / crSigCdOpe carregados
2073:         IF !USED("TmpPro")
2074:             loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
2075:             IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
2076:                 SELECT TmpPro
2077:                 INDEX ON CPros TAG CPros
2078:                 SET ORDER TO CPros
2079:             ENDIF
2080:         ENDIF
2081:         IF !USED("crSigOpOpt")
2082:             loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
2083:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
2084:                 SELECT crSigOpOpt
2085:                 INDEX ON Cods TAG Cods
2086:                 SET ORDER TO Cods
2087:             ENDIF
2088:         ENDIF
2089:         IF !USED("LocalOpp")
2090:             loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
2091:             IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
2092:                 SELECT LocalOpp
2093:                 INDEX ON Dopps TAG Dopps
2094:                 SET ORDER TO Dopps
2095:             ENDIF
2096:         ENDIF
2097:         IF !USED("crSigCdOpe")
2098:             loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
2099:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
2100:                 SELECT crSigCdOpe
2101:                 INDEX ON Dopes TAG Dopes
2102:                 SET ORDER TO Dopes
2103:             ENDIF
2104:         ENDIF
2105: 
2106:         *-- Obter codigo do FCX corrente
2107:         loc_nCodigosFcx = 0
2108:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2109:             loc_nCodigosFcx = crSigCdFcx.Codigos
2110:         ENDIF
2111: 



## Trechos relevantes do BO (C:\4c\projeto\app\classes\FeaBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormFea.prg
- BO: C:\4c\projeto\app\classes\FeaBO.prg
