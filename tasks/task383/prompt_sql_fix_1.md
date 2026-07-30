CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1861: Tabela 'SigCdCrf' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1913: Tabela 'SigCdCrf' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1978: Tabela 'SigCdCrf' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~2348: Tabela 'SigCdCri' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~2348: Coluna 'qtds' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.Qtds)
- [SQL-SCHEMA] Linha ~2348: Coluna 'cods' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.Cods)
- [SQL-SCHEMA] Linha ~2348: Coluna 'cpros' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.Cpros)
- [SQL-SCHEMA] Linha ~2348: Coluna 'estos' NAO EXISTE na tabela 'sigcdcli' (referenciada como c.Estos)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdcli
CREATE TABLE [dbo].[SIGCDCLI](
	[idcontas] [numeric](6, 0) NOT NULL,
	[bairs] [char](40) NOT NULL,
	[ccargs] [char](10) NOT NULL,
	[cepcobs] [char](9) NOT NULL,
	[ceps] [char](9) NOT NULL,
	[ceptrabs] [char](9) NOT NULL,
	[cfos] [char](10) NOT NULL,
	[cidas] [char](30) NOT NULL,
	[cidcobs] [char](20) NOT NULL,
	[cidtrabs] [char](20) NOT NULL,
	[codtifs] [char](3) NOT NULL,
	[coletors] [numeric](1, 0) NOT NULL,
	[comis] [numeric](5, 2) NOT NULL,
	[compls] [char](50) NOT NULL,
	[concilias] [numeric](1, 0) NOT NULL,
	[conjuges] [char](40) NOT NULL,
	[contacobs] [char](10) NOT NULL,
	[contamats] [char](10) NOT NULL,
	[contavens] [char](10) NOT NULL,
	[cpfs] [char](20) NOT NULL,
	[dataincs] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[ddds] [char](4) NOT NULL,
	[dtalts] [datetime] NULL,
	[dtcasas] [datetime] NULL,
	[dtfilms] [datetime] NULL,
	[dtncons] [datetime] NULL,
	[emails] [char](50) NOT NULL,
	[emps] [char](3) NOT NULL,
	[endcobs] [char](80) NOT NULL,
	[endes] [char](60) NOT NULL,
	[endtrabs] [char](48) NOT NULL,
	[estas] [char](2) NOT NULL,
	[estcivils] [char](20) NOT NULL,
	[estcobs] [char](2) NOT NULL,
	[esttrabs] [char](2) NOT NULL,
	[faxs] [char](20) NOT NULL,
	[figjpgs] [text] NULL,
	[figuras] [image] NULL,
	[fpubls] [char](3) NOT NULL,
	[grupocobs] [char](10) NOT NULL,
	[grupomats] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grupovens] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[limcres] [numeric](11, 2) NOT NULL,
	[lprecos] [char](30) NOT NULL,
	[maes] [char](50) NOT NULL,
	[nacionals] [char](15) NOT NULL,
	[nascs] [datetime] NULL,
	[nclis] [numeric](10, 0) NOT NULL,
	[nums] [char](10) NOT NULL,
	[obs] [text] NULL,
	[paicobs] [char](30) NOT NULL,
	[pais] [char](50) NOT NULL,
	[paises] [char](30) NOT NULL,
	[paitrabs] [char](30) NOT NULL,
	[profiss] [char](20) NOT NULL,
	[ramals] [char](4) NOT NULL,
	[razaos] [char](50) NOT NULL,
	[rclis] [char](50) NOT NULL,
	[rgconjuges] [char](13) NOT NULL,
	[rgs] [char](20) NOT NULL,
	[sexos] [char](1) NOT NULL,
	[tabds] [char](10) NOT NULL,
	[tel1s] [char](20) NOT NULL,
	[tel2s] [char](20) NOT NULL,
	[tpcads] [numeric](1, 0) NOT NULL,
	[tpclis] [numeric](1, 0) NOT NULL,
	[transps] [char](10) NOT NULL,
	[ultcomps] [datetime] NULL,
	[vcolets] [numeric](3, 0) NOT NULL,
	[baicobs] [char](20) NOT NULL,
	[gerbals] [numeric](1, 0) NOT NULL,
	[grufals] [char](10) NOT NULL,
	[pagfals] [numeric](1, 0) NOT NULL,
	[recfals] [numeric](1, 0) NOT NULL,
	[senhas] [char](10) NOT NULL,
	[suframas] [char](15) NOT NULL,
	[ccontabs] [char](10) NOT NULL,
	[codigos] [char](10) NOT NULL,
	[conprods] [char](10) NOT NULL,
	[contacents] [char](10) NOT NULL,
	[contato] [char](40) NOT NULL,
	[contats] [char](20) NOT NULL,
	[dtfats] [datetime] NULL,
	[dtmacums] [datetime] NULL,
	[grupocents] [char](10) NOT NULL,
	[gruprods] [char](10) NOT NULL,
	[hists] [char](30) NOT NULL,
	[intconts] [numeric](1, 0) NOT NULL,
	[ma
-- (truncado)


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formcrf.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\crfBO.prg):

--- BO Linhas 33 a 43 ---
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             DODEFAULT()
37:             THIS.this_cTabela     = "SigCdCrf"
38:             THIS.this_cCampoChave = "Cods"
39:             loc_lSucesso = .T.
40:         CATCH TO loException
41:             MostrarErro(loException, "crfBO.Init")
42:         ENDTRY
43: 

--- BO Linhas 62 a 72 ---
62:         TRY
63:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
64:                 IF !USED("cursor_4c_Dados")
65:                     SET NULL ON
66:                     CREATE CURSOR cursor_4c_Dados ;
67:                         (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
68:                          Conferido N(1,0), cIdChaves C(10), DesVends C(50))
69:                     SET NULL OFF
70:                 ENDIF
71:                 loc_lSucesso = .T.
72:             ELSE

--- BO Linhas 68 a 78 ---
68:                          Conferido N(1,0), cIdChaves C(10), DesVends C(50))
69:                     SET NULL OFF
70:                 ENDIF
71:                 loc_lSucesso = .T.
72:             ELSE
73:                 loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
74:                            " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
75:                            " FROM SigCdCrf a" + ;
76:                            " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
77:                            " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
78: 

--- BO Linhas 78 a 88 ---
78: 
79:                 IF !EMPTY(par_cFiltro)
80:                     loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
81:                 ENDIF
82: 
83:                 loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"
84: 
85:                 IF USED("cursor_4c_Dados")
86:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
87:                     IF loc_nResultado >= 0
88:                         SELECT cursor_4c_Dados

--- BO Linhas 113 a 123 ---
113: 
114:         RETURN loc_lSucesso
115:     ENDPROC
116: 
117:     *==========================================================================
118:     * CarregarPorCodigo - Carrega contagem pelo codigo Cods
119:     *==========================================================================
120:     PROCEDURE CarregarPorCodigo(par_cCodigo)
121:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
122:         loc_lSucesso = .F.
123: 

--- BO Linhas 120 a 130 ---
120:     PROCEDURE CarregarPorCodigo(par_cCodigo)
121:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
122:         loc_lSucesso = .F.
123: 
124:         TRY
125:             loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
126:                        " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
127:                        " FROM SigCdCrf a" + ;
128:                        " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
129:                        " WHERE a.Cods = " + EscaparSQL(par_cCodigo)
130: 

--- BO Linhas 124 a 134 ---
124:         TRY
125:             loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
126:                        " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
127:                        " FROM SigCdCrf a" + ;
128:                        " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
129:                        " WHERE a.Cods = " + EscaparSQL(par_cCodigo)
130: 
131:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
132: 
133:             IF loc_nResultado >= 0
134:                 IF RECCOUNT("cursor_4c_Carrega") > 0

--- BO Linhas 160 a 170 ---
160:         loc_lSucesso = .F.
161: 
162:         TRY
163:             IF USED(par_cAliasCursor)
164:                 SELECT (par_cAliasCursor)
165:                 THIS.this_cCods      = TratarNulo(Cods,      "C")
166:                 THIS.this_cEmps      = TratarNulo(Emps,      "C")
167:                 THIS.this_cVends     = TratarNulo(Vends,     "C")
168:                 THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
169:                 THIS.this_dDatas     = TratarNulo(Datas,     "D")
170:                 THIS.this_nConferido = TratarNulo(Conferido, "N")

--- BO Linhas 185 a 195 ---
185:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
186:         loc_lSucesso = .F.
187:         loc_nProxId  = 1
188: 
189:         TRY
190:             loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
191:                        " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"
192: 
193:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")
194: 
195:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0

--- BO Linhas 186 a 196 ---
186:         loc_lSucesso = .F.
187:         loc_nProxId  = 1
188: 
189:         TRY
190:             loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
191:                        " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"
192: 
193:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")
194: 
195:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
196:                 SELECT cursor_4c_MaxId

--- BO Linhas 236 a 246 ---
236: 
237:                 SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
238:                 loc_lTransacao = .T.
239: 
240:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
241:                     INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
242:                     VALUES (
243:                         <<EscaparSQL(THIS.this_cCods)>>,
244:                         <<EscaparSQL(THIS.this_cEmps)>>,
245:                         <<EscaparSQL(THIS.this_cVends)>>,
246:                         <<FormatarDataSQL(THIS.this_dDatas)>>,

--- BO Linhas 296 a 306 ---
296: 
297:                 SCAN WHILE loc_lSucesso
298:                     loc_cIdChave = SYS(2015)
299:                     loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
300:                     loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
301:                     loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
302:                     loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
303:                     loc_nCBars   = TratarNulo(CBars,   "N")
304:                     loc_nQtds    = TratarNulo(QtdCtg,  "N")
305:                     loc_nEstoque = TratarNulo(qtde,    "N")
306:                     loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

--- BO Linhas 297 a 307 ---
297:                 SCAN WHILE loc_lSucesso
298:                     loc_cIdChave = SYS(2015)
299:                     loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
300:                     loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
301:                     loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
302:                     loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
303:                     loc_nCBars   = TratarNulo(CBars,   "N")
304:                     loc_nQtds    = TratarNulo(QtdCtg,  "N")
305:                     loc_nEstoque = TratarNulo(qtde,    "N")
306:                     loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)
307: 

--- BO Linhas 304 a 314 ---
304:                     loc_nQtds    = TratarNulo(QtdCtg,  "N")
305:                     loc_nEstoque = TratarNulo(qtde,    "N")
306:                     loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)
307: 
308:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
309:                         INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
310:                         VALUES (
311:                             <<EscaparSQL(loc_cIdChave)>>,
312:                             <<EscaparSQL(THIS.this_cCods)>>,
313:                             <<EscaparSQL(loc_cEmps)>>,
314:                             <<EscaparSQL(loc_cGrupos)>>,

--- BO Linhas 354 a 364 ---
354:             SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
355:             loc_lTransacao = .T.
356: 
357:             *-- Exclui itens existentes
358:             loc_nResultado = SQLEXEC(gnConnHandle, ;
359:                 "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))
360: 
361:             IF loc_nResultado < 0
362:                 MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
363:             ELSE
364:                 *-- Exclui cabecalho existente

--- BO Linhas 361 a 371 ---
361:             IF loc_nResultado < 0
362:                 MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
363:             ELSE
364:                 *-- Exclui cabecalho existente
365:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
366:                     "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))
367: 
368:                 IF loc_nResultado < 0
369:                     MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
370:                 ELSE
371:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW

--- BO Linhas 367 a 377 ---
367: 
368:                 IF loc_nResultado < 0
369:                     MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
370:                 ELSE
371:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
372:                         INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
373:                         VALUES (
374:                             <<EscaparSQL(THIS.this_cCods)>>,
375:                             <<EscaparSQL(THIS.this_cEmps)>>,
376:                             <<EscaparSQL(THIS.this_cVends)>>,
377:                             <<FormatarDataSQL(THIS.this_dDatas)>>,

--- BO Linhas 422 a 432 ---
422:             ELSE
423:                 SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
424:                 loc_lTransacao = .T.
425: 
426:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
427:                     "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))
428: 
429:                 IF loc_nResultado < 0
430:                     MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
431:                 ELSE
432:                     loc_nResultado = SQLEXEC(gnConnHandle, ;

--- BO Linhas 428 a 438 ---
428: 
429:                 IF loc_nResultado < 0
430:                     MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
431:                 ELSE
432:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
433:                         "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))
434: 
435:                     IF loc_nResultado >= 0
436:                         SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
437:                         loc_lTransacao = .F.
438:                         THIS.RegistrarAuditoria("DELETE")

--- BO Linhas 508 a 518 ---
508:         TRY
509:             IF USED(THIS.this_cCursorItens)
510:                 USE IN (THIS.this_cCursorItens)
511:             ENDIF
512: 
513:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
514:                        " SUM(a.sqtds) AS qtde," + ;
515:                        " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
516:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
517:                        " FROM SigMvEst a" + ;
518:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;

--- BO Linhas 513 a 523 ---
513:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
514:                        " SUM(a.sqtds) AS qtde," + ;
515:                        " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
516:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
517:                        " FROM SigMvEst a" + ;
518:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
519:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
520:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
521:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
522:                        " AND b.cunis = 'UN'" + ;
523:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;

--- BO Linhas 514 a 524 ---
514:                        " SUM(a.sqtds) AS qtde," + ;
515:                        " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
516:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
517:                        " FROM SigMvEst a" + ;
518:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
519:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
520:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
521:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
522:                        " AND b.cunis = 'UN'" + ;
523:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
524:                        " HAVING SUM(a.sqtds) <> 0" + ;

--- BO Linhas 518 a 528 ---
518:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
519:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
520:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
521:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
522:                        " AND b.cunis = 'UN'" + ;
523:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
524:                        " HAVING SUM(a.sqtds) <> 0" + ;
525:                        " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"
526: 
527:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)
528: 

--- BO Linhas 520 a 530 ---
520:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
521:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
522:                        " AND b.cunis = 'UN'" + ;
523:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
524:                        " HAVING SUM(a.sqtds) <> 0" + ;
525:                        " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"
526: 
527:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)
528: 
529:             IF loc_nResultado >= 0
530:                 SELECT (THIS.this_cCursorItens)

--- BO Linhas 542 a 552 ---
542:     ENDPROC
543: 
544:     *==========================================================================
545:     * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
546:     * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
547:     * par_cCodigo      : codigo da contagem (Cods)
548:     * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
549:     *==========================================================================
550:     PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
551:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
552:         loc_lSucesso = .F.

--- BO Linhas 555 a 565 ---
555:             IF USED(THIS.this_cCursorItens)
556:                 USE IN (THIS.this_cCursorItens)
557:             ENDIF
558: 
559:             *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
560:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
561:                        " SUM(a.sqtds) AS qtde," + ;
562:                        " ISNULL(" + ;
563:                        "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
564:                        "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;

--- BO Linhas 558 a 568 ---
558: 
559:             *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
560:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
561:                        " SUM(a.sqtds) AS qtde," + ;
562:                        " ISNULL(" + ;
563:                        "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
564:                        "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;

--- BO Linhas 559 a 569 ---
559:             *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
560:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
561:                        " SUM(a.sqtds) AS qtde," + ;
562:                        " ISNULL(" + ;
563:                        "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
564:                        "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
569:                        " FROM SigMvEst a" + ;

--- BO Linhas 560 a 570 ---
560:             loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
561:                        " SUM(a.sqtds) AS qtde," + ;
562:                        " ISNULL(" + ;
563:                        "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
564:                        "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
569:                        " FROM SigMvEst a" + ;
570:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;

--- BO Linhas 561 a 571 ---
561:                        " SUM(a.sqtds) AS qtde," + ;
562:                        " ISNULL(" + ;
563:                        "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
564:                        "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
569:                        " FROM SigMvEst a" + ;
570:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
571:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;

--- BO Linhas 565 a 575 ---
565:                        "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
569:                        " FROM SigMvEst a" + ;
570:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
571:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
572:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
573:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
574:                        " AND b.cunis = 'UN'" + ;
575:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;

--- BO Linhas 566 a 576 ---
566:                        "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
567:                        " AS QtdCtg," + ;
568:                        " b.dpros AS Descr, b.cbars AS CBars" + ;
569:                        " FROM SigMvEst a" + ;
570:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
571:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
572:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
573:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
574:                        " AND b.cunis = 'UN'" + ;
575:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
576:                        " HAVING SUM(a.sqtds) <> 0"

--- BO Linhas 570 a 580 ---
570:                        " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
571:                        " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
572:                        " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
573:                        " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
574:                        " AND b.cunis = 'UN'" + ;
575:                        " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
576:                        " HAVING SUM(a.sqtds) <> 0"
577: 
578:             IF par_lSoContados
579:                 *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
580:                 loc_cSQL = loc_cSQL + ;

--- BO Linhas 577 a 587 ---
577: 
578:             IF par_lSoContados
579:                 *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
580:                 loc_cSQL = loc_cSQL + ;
581:                            " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
582:                            " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
583:                            " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
584:                            " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
585:             ENDIF
586: 
587:             loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

--- BO Linhas 578 a 588 ---
578:             IF par_lSoContados
579:                 *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
580:                 loc_cSQL = loc_cSQL + ;
581:                            " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
582:                            " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
583:                            " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
584:                            " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
585:             ENDIF
586: 
587:             loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"
588: 

--- BO Linhas 579 a 589 ---
579:                 *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
580:                 loc_cSQL = loc_cSQL + ;
581:                            " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
582:                            " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
583:                            " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
584:                            " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
585:             ENDIF
586: 
587:             loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"
588: 
589:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

--- BO Linhas 582 a 592 ---
582:                            " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
583:                            " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
584:                            " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
585:             ENDIF
586: 
587:             loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"
588: 
589:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)
590: 
591:             IF loc_nResultado >= 0
592:                 SELECT (THIS.this_cCursorItens)

--- BO Linhas 611 a 621 ---
611:         loc_lSucesso = .F.
612: 
613:         TRY
614:             loc_nResultado = SQLEXEC(gnConnHandle, ;
615:                 "UPDATE SigCdCrf SET Conferido = 1" + ;
616:                 " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
617:                 " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))
618: 
619:             IF loc_nResultado >= 0
620:                 THIS.this_nConferido = 1
621:                 loc_lSucesso = .T.

--- BO Linhas 637 a 647 ---
637:         loc_lSucesso = .F.
638: 
639:         TRY
640:             loc_nResultado = SQLEXEC(gnConnHandle, ;
641:                 "UPDATE SigCdCrf SET Conferido = 0" + ;
642:                 " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
643:                 " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))
644: 
645:             IF loc_nResultado >= 0
646:                 THIS.this_nConferido = 0
647:                 loc_lSucesso = .T.


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formcrf.prg
- BO: C:\4c\projeto\app\classes\crfBO.prg
