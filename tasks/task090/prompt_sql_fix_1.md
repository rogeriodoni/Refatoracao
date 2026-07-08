CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2657: Coluna 'codcors' NAO EXISTE na tabela 'sigmvitn' (referenciada como c.CodCors)
- [SQL-SCHEMA] Linha ~2657: Coluna 'codtams' NAO EXISTE na tabela 'sigmvitn' (referenciada como c.CodTams)
- [SQL-SCHEMA] Linha ~2657: Coluna 'totitens' NAO EXISTE na tabela 'sigmvitn' (referenciada como c.TotItens)
- [SQL-SCHEMA] Linha ~2657: Coluna 'codcors' NAO EXISTE na tabela 'sigmvitn' (referenciada como c.CodCors)
- [SQL-SCHEMA] Linha ~2657: Coluna 'codtams' NAO EXISTE na tabela 'sigmvitn' (referenciada como c.CodTams)
- [SQL-SCHEMA] Linha ~2780: Coluna 'cpros' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~2780: Coluna 'empos' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.EmpOs)
- [SQL-SCHEMA] Linha ~2780: Coluna 'dopeos' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.DopeOs)
- [SQL-SCHEMA] Linha ~2780: Coluna 'numeos' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.NumeOs)
- [SQL-SCHEMA] Linha ~2780: Coluna 'cbars' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.Cbars)
- [SQL-SCHEMA] Linha ~2780: Coluna 'cpros' NAO EXISTE na tabela 'sigpdmvf' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~2823: Coluna 'cpros' NAO EXISTE na tabela 'sigopdev' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~2823: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~2823: Coluna 'codbarras' NAO EXISTE na tabela 'sigopdev' (referenciada como a.codbarras)
- [SQL-SCHEMA] Linha ~2823: Coluna 'cpros' NAO EXISTE na tabela 'sigopdev' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~2852: Coluna 'cpros' NAO EXISTE na tabela 'sigopdev' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~2852: Coluna 'qtds' NAO EXISTE na tabela 'sigopdev' (referenciada como a.Qtds)
- [SQL-SCHEMA] Linha ~2852: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~2852: Coluna 'cpros' NAO EXISTE na tabela 'sigopdev' (referenciada como a.Cpros)
- [SQL-SCHEMA] Linha ~3293: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~3293: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~3293: INSERT coluna 'descricao' NAO EXISTE na tabela 'logauditoria'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: logauditoria
CREATE TABLE [dbo].[LogAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [varchar](100) NOT NULL,
	[Operacao] [varchar](10) NOT NULL,
	[ChaveRegistro] [varchar](100) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[DadosAnteriores] [nvarchar](max) NULL,
	[DadosNovos] [nvarchar](max) NULL,
	[IP] [varchar](50) NULL,
	[Estacao] [varchar](100) NULL,
 

-- Tabela: sigmvitn
CREATE TABLE [dbo].[SigMvItn](
	[aqtds] [numeric](9, 3) NOT NULL,
	[citens] [numeric](10, 0) NOT NULL,
	[codbarras] [numeric](14, 0) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[datatrans] [datetime] NULL,
	[descvals] [numeric](7, 2) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dpros] [char](65) NOT NULL,
	[emps] [char](3) NOT NULL,
	[etiesps] [bit] NOT NULL,
	[fators] [numeric](8, 3) NOT NULL,
	[fatvals] [numeric](15, 6) NOT NULL,
	[fvals] [bit] NOT NULL,
	[iconfs] [bit] NOT NULL,
	[locals] [char](10) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[moefats] [char](3) NOT NULL,
	[moevals] [numeric](15, 6) NOT NULL,
	[notas] [char](6) NOT NULL,
	[nrcons] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[obs] [text] NULL,
	[opers] [char](1) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtbaixas] [numeric](9, 3) NOT NULL,
	[qtbxprods] [numeric](9, 3) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[qtprods] [numeric](9, 3) NOT NULL,
	[totas] [numeric](11, 2) NOT NULL,
	[tpesos] [numeric](11, 2) NOT NULL,
	[unitembs] [numeric](11, 4) NOT NULL,
	[units] [numeric](15, 6) NOT NULL,
	[univals] [numeric](15, 6) NOT NULL,
	[vcoms] [numeric](8, 2) NOT NULL,
	[aliqs] [numeric](4, 2) NOT NULL,
	[sitribs] [char](2) NOT NULL,
	[tpipis] [char](1) NOT NULL,
	[valipis] [numeric](11, 2) NOT NULL,
	[aliqicms] [numeric](5, 2) NOT NULL,
	[valdescs] [numeric](9, 2) NOT NULL,
	[empos] [char](3) NOT NULL,
	[moevs] [char](3) NOT NULL,
	[utilizas] [numeric](4, 0) NOT NULL,
	[ncodigos] [numeric](10, 0) NOT NULL,
	[qtreservas] [numeric](9, 3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[nlotes] [numeric](10, 0) NOT NULL,
	[dtalts] [datetime] NULL,
	[empdopnums] [char](29) NOT NULL,
	[baseicms] [numeric](11, 2) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[unit2s] [numeric](15, 6) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[valrats] [numeric](14, 6) NOT NULL,
	[codlprecs] [numeric](6, 0) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[motdscs] [char](10) NOT NULL,
	[tipos] [char](1) NOT NULL,
	[unitinfs] [numeric](14, 6) NOT NULL,
	[cpro2s] [char](50) NOT NULL,
	[abrevis] [char](3) NOT NULL,
	[bcicmss] [numeric](15, 2) NOT NULL,
	[bcipis] [numeric](15, 2) NOT NULL,
	[icms] [numeric](15, 2) NOT NULL,
	[icmss] [numeric](15, 2) NOT NULL,
	[pdescs] [numeric](5, 2) NOT NULL,
	[nchvtbds] [numeric](6, 0) NOT NULL,
	[idpro] [numeric](10, 0) NOT NULL,
	[unitorigs] [numeric](14, 6) NOT NULL,
	[origmercs] [char](1) NOT NULL,
	[baseicm2s] [numeric](11, 2) NOT NULL,
	[baseicm3s] [numeric](11, 2) NOT NULL,
	[baseipi2s] [numeric](11, 2) NOT NULL,
	[baseipi3s] [numeric](11, 2) NOT NULL,
	[cfops] [char](10) NOT NULL,
	[ratdacs] [numeric](11, 2) NOT NULL,
	[ratfrts] [numeric](11, 2) NOT NULL,
	[raticmds] [numeric](11, 2) NOT NULL,
	[raticms] [numeric](11, 2) NOT NULL,
	[ratsegs] [numeric](11, 2) NOT NULL,
	[sittricms] [char](3) 
-- (truncado)

-- Tabela: sigopdev
CREATE TABLE [dbo].[SigOpDev](
	[tpcodigos] [numeric](1, 0) NOT NULL,
	[valobxs] [numeric](11, 2) NOT NULL,
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[codigos] [numeric](10, 0) NOT NULL,
	[datatrans] [datetime] NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[locals] [char](10) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
 

-- Tabela: sigpdmvf
CREATE TABLE [dbo].[SigPdMvf](
	[codpds] [char](14) NOT NULL,
	[contads] [char](10) NOT NULL,
	[contaos] [char](10) NOT NULL,
	[dataes] [datetime] NULL,
	[dataps] [datetime] NULL,
	[datars] [datetime] NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[dopes] [char](20) NOT NULL,
	[dopps] [char](20) NOT NULL,
	[emps] [char](3) NOT NULL,
	[etiqs] [bit] NOT NULL,
	[finals] [datetime] NULL,
	[grupods] [char](10) NOT NULL,
	[grupoos] [char](10) NOT NULL,
	[inicios] [datetime] NULL,
	[nenvs] [numeric](10, 0) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[numes] [numeric](10, 0) NOT NULL,
	[numps] [numeric](10, 0) NOT NULL,
	[obsps] [text] NULL,
	[obss] [text] NULL,
	[opers] [char](1) NOT NULL,
	[ordems] [numeric](2, 0) NOT NULL,
	[pesos] [numeric](11, 3) NOT NULL,
	[qtds] [numeric](11, 3) NOT NULL,
	[unids] [char](3) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[cretrabs] [char](6) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdnps] [char](33) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[ordemos] [numeric](2, 0) NOT NULL,
	[tmpmins] [numeric](5, 0) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigReEspBO.prg):

--- BO Linhas 6 a 16 ---
6: * Relatorios FRX: SigReEsp.frx (por movimentacao), SigReEs2.frx (por tipo)
7: *
8: * Filtros mapeados do form legado SIGREESP:
9: *   - Periodo (datas inicial/final + tipo: lancamento/entrega/alt/fechamento)
10: *   - Operacao/movimentacao (nome + numero PV)
11: *   - Tipo de operacao (codigo + descricao de SigCdTom)
12: *   - Conta (getCdEstoque/getDsEstoque - ContaDs/ContaOs de SigMvCab)
13: *   - Vendedor (getCdVendedor/getDsVendedor - Vends de SigMvCab)
14: *   - Cidade / Estado/UF
15: *   - Situacao dos pedidos (Encerrados/Abertos/Ambos)
16: *   - Opcao de impressao (Vendedor/Cidade/Data Encerramento)

--- BO Linhas 201 a 211 ---
201:             IF loc_lnResult < 1
202:                 THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es (crSigCdOpe)"
203:                 loc_lSucesso = .F.
204:             ENDIF
205: 
206:             * Razao social da empresa
207:             loc_lnResult = SQLEXEC(gnConnHandle, ;
208:                 "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
209:                 "crSigCdEmp")
210:             IF loc_lnResult >= 1 AND USED("crSigCdEmp") AND !EOF("crSigCdEmp")
211:                 loc_lcNmEmpresa = ALLTRIM(crSigCdEmp.Razas)

--- BO Linhas 211 a 221 ---
211:                 loc_lcNmEmpresa = ALLTRIM(crSigCdEmp.Razas)
212:             ELSE
213:                 loc_lcNmEmpresa = ""
214:             ENDIF
215: 
216:             * Parametros da empresa (TransfRes para identificar operacao de reserva)
217:             SQLEXEC(gnConnHandle, ;
218:                 "SELECT TOP 1 TransfRes FROM SigCdPam", ;
219:                 "crSigCdPam")
220: 
221:             * Monta titulo do relatorio

--- BO Linhas 254 a 264 ---
254:             GO TOP
255:             LOCATE FOR Dopes = loc_lcNmOperacao
256: 
257:             * Monta query principal contra SigMvCab / SigMvItn / SigCdCli / SigCdOpe
258:             loc_lcQuery = [Select a.Emps, a.Dopes, a.Numes, c.Iclis, c.Rclis, c.Cidas, c.Estas, ] + ;
259:                           [a.Qtds, b.Utilizados, a.QtBaixas, a.QtReservas, b.Nops, b.Vends, ] + ;
260:                           [b.Datas, b.PrazoEnts, b.DtFechas ] + ;
261:                           [From SigMvCab b, SigMvItn a, SigCdCli c, SigCdOpe o ] + ;
262:                           [Where b.EmpDopNums = a.EmpDopNums And ] + ;
263:                           IIF(EMPTY(loc_lcNmOperacao), [o.TipoOps = ] + STR(loc_lnTpOpe), ;
264:                               [b.Dopes = '] + loc_lcNmOperacao + [' ]) + [ And ] + ;

--- BO Linhas 291 a 301 ---
291:             SELECT a.Emps, a.Dopes, a.Numes, a.Iclis, a.Rclis, a.Cidas, a.Estas, a.Utilizados, a.Nops, ;
292:                 a.Vends, NVL(TTOD(a.Datas), {}) AS Datas, ;
293:                 NVL(TTOD(IIF(EMPTY(a.PrazoEnts), a.Datas, a.PrazoEnts)), {}) AS DtEnts, ;
294:                 NVL(TTOD(a.DtFechas), {}) AS DataEps, ;
295:                 a.Emps + '-' + b.Abrevs + ':' + STR(a.Numes, 6) AS Abrevs, ;
296:                 SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtdBs, ;
297:                 SUM(IIF(a.Utilizados=1, a.Qtds, a.QtReservas)) AS QtdNps ;
298:               FROM ResPed1 a, CrSigCdOpe b ;
299:               WHERE a.Dopes = b.Dopes ;
300:              GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;
301:              INTO CURSOR ResPed

--- BO Linhas 292 a 302 ---
292:                 a.Vends, NVL(TTOD(a.Datas), {}) AS Datas, ;
293:                 NVL(TTOD(IIF(EMPTY(a.PrazoEnts), a.Datas, a.PrazoEnts)), {}) AS DtEnts, ;
294:                 NVL(TTOD(a.DtFechas), {}) AS DataEps, ;
295:                 a.Emps + '-' + b.Abrevs + ':' + STR(a.Numes, 6) AS Abrevs, ;
296:                 SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtdBs, ;
297:                 SUM(IIF(a.Utilizados=1, a.Qtds, a.QtReservas)) AS QtdNps ;
298:               FROM ResPed1 a, CrSigCdOpe b ;
299:               WHERE a.Dopes = b.Dopes ;
300:              GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;
301:              INTO CURSOR ResPed
302: 

--- BO Linhas 299 a 309 ---
299:               WHERE a.Dopes = b.Dopes ;
300:              GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;
301:              INTO CURSOR ResPed
302: 
303:             * Total por pedido para calculo de percentuais
304:             SELECT Emps + Dopes + STR(Numes,6) AS EmpDopNums, SUM(Qtds) AS Qtds ;
305:               FROM ResPed INTO CURSOR TotPed GROUP BY 1
306:             SELECT TotPed
307:             INDEX ON EmpDopNums TAG EmpDopNums
308: 
309:             * Cursor Fabricado: quantidade produzida por pedido

--- BO Linhas 305 a 315 ---
305:               FROM ResPed INTO CURSOR TotPed GROUP BY 1
306:             SELECT TotPed
307:             INDEX ON EmpDopNums TAG EmpDopNums
308: 
309:             * Cursor Fabricado: quantidade produzida por pedido
310:             CREATE CURSOR Fabricado (Emps C(3), Dopes C(20), Numes N(6), Qtds N(10,3), QtdCancs N(12,3))
311:             INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
312: 
313:             SELECT DISTINCT Emps, Dopes, Numes FROM ResPed INTO CURSOR TmpFab
314: 
315:             * Calcula Fabricado: loop por pedido

--- BO Linhas 317 a 327 ---
317:             SELECT TmpFab
318:             SCAN WHILE loc_lScanOk1
319:                 LOCAL loc_Tqtd, loc_xQtd, loc_lnQtdCanc, loc_QtdTot
320:                 loc_lcEdn = TmpFab.Emps + TmpFab.Dopes + STR(TmpFab.Numes, 6)
321: 
322:                 loc_lcQuery = [Select a.EmpdopNums, b.chksubn, b.Lccs, Sum(a.Qtds) as Qtds ] + ;
323:                               [From SigOpPic a, SigCdNec b ] + ;
324:                               [Where a.EmpDopNums = '] + loc_lcEdn + [' And ] + ;
325:                               [a.EmpDopNops = b.EmpDNps ] + ;
326:                               [Group by a.EmpdopNums, b.ChkSubn, b.Lccs]
327: 

--- BO Linhas 331 a 341 ---
331:                     loc_lScanOk1 = .F.
332:                     EXIT
333:                 ENDIF
334: 
335:                 SELECT csQtde
336:                 SUM Qtds TO loc_Tqtd
337:                 SUM Qtds TO loc_xQtd FOR ChkSubn
338:                 SUM Qtds TO loc_lnQtdCanc FOR ChkSubn AND Lccs
339: 
340:                 SELECT TotPed
341:                 =SEEK(loc_lcEdn)

--- BO Linhas 332 a 342 ---
332:                     EXIT
333:                 ENDIF
334: 
335:                 SELECT csQtde
336:                 SUM Qtds TO loc_Tqtd
337:                 SUM Qtds TO loc_xQtd FOR ChkSubn
338:                 SUM Qtds TO loc_lnQtdCanc FOR ChkSubn AND Lccs
339: 
340:                 SELECT TotPed
341:                 =SEEK(loc_lcEdn)
342:                 loc_QtdTot = loc_xQtd

--- BO Linhas 333 a 343 ---
333:                 ENDIF
334: 
335:                 SELECT csQtde
336:                 SUM Qtds TO loc_Tqtd
337:                 SUM Qtds TO loc_xQtd FOR ChkSubn
338:                 SUM Qtds TO loc_lnQtdCanc FOR ChkSubn AND Lccs
339: 
340:                 SELECT TotPed
341:                 =SEEK(loc_lcEdn)
342:                 loc_QtdTot = loc_xQtd
343: 

--- BO Linhas 344 a 354 ---
344:                 IF loc_QtdTot > 0
345:                     IF !SEEK(loc_lcEdn, "Fabricado", "EmpDopNum")
346:                         INSERT INTO Fabricado (Emps, Dopes, Numes) ;
347:                             VALUES (TmpFab.Emps, TmpFab.Dopes, TmpFab.Numes)
348:                     ENDIF
349:                     REPLACE Qtds WITH loc_QtdTot, QtdCancs WITH loc_lnQtdCanc IN Fabricado
350:                 ENDIF
351:             ENDSCAN
352: 
353:             IF !loc_lSucesso
354:                 SET ESCAPE &loc_lcEscape.

--- BO Linhas 357 a 367 ---
357:                 loc_lSucesso = .F.
358:             ENDIF
359: 
360:             * Cria cursor principal do relatorio
361:             CREATE CURSOR csRelatorio (Tipos C(1), Iclis C(10), Rclis C(40), Emps C(3), Dopes C(20), ;
362:                             Numes N(6), Datas D, DtEnts D, Qtds N(12,2), Qtdfs N(12,2), ;
363:                             PQtdes N(12,2), Vends C(10), Lts N(10), Ltis N(10), DtEncs D, Nops N(10), ;
364:                             Qps N(10), Qpes N(10), Pecs N(12,2), Qtdpcs N(12,2), QtdPces N(12,2), ;
365:                             Mltes N(12,2), Qltis N(10), Pltis N(12,2), Mltis N(12,2), Abrevs C(15), ;
366:                             Utilizados N(2), cidas C(30), Estas C(2), Cpros C(14), Valors N(12,2), ;
367:                             Citens N(10), QtdCancs N(12,2), QtReservas N(12,2), QtdMovs N(12,2), ;

--- BO Linhas 361 a 371 ---
361:             CREATE CURSOR csRelatorio (Tipos C(1), Iclis C(10), Rclis C(40), Emps C(3), Dopes C(20), ;
362:                             Numes N(6), Datas D, DtEnts D, Qtds N(12,2), Qtdfs N(12,2), ;
363:                             PQtdes N(12,2), Vends C(10), Lts N(10), Ltis N(10), DtEncs D, Nops N(10), ;
364:                             Qps N(10), Qpes N(10), Pecs N(12,2), Qtdpcs N(12,2), QtdPces N(12,2), ;
365:                             Mltes N(12,2), Qltis N(10), Pltis N(12,2), Mltis N(12,2), Abrevs C(15), ;
366:                             Utilizados N(2), cidas C(30), Estas C(2), Cpros C(14), Valors N(12,2), ;
367:                             Citens N(10), QtdCancs N(12,2), QtReservas N(12,2), QtdMovs N(12,2), ;
368:                             QtdMovPds N(12,2), QtProds N(12,2), QtdPdProds N(12,2), ValUnits N(12,4), ;
369:                             PProds N(12,2), PMovPds N(12,2), PMovs N(12,2), ValMovs N(12,2), ;
370:                             ValMovPds N(12,2), ValProds N(12,2), PValProds N(12,2), ;
371:                             PValMovPds N(12,2), PValMovs N(12,2))

--- BO Linhas 385 a 395 ---
385:                 SCATTER MEMVAR
386:                 loc_lcEdn = m.Emps + m.Dopes + STR(m.Numes, 6)
387: 
388:                 SELECT Fabricado
389:                 SEEK loc_lcEdn
390:                 m.QtdFs    = Fabricado.Qtds + m.QtdNps
391:                 m.QtdCancs = Fabricado.QtdCancs
392:                 m.QtReservas = m.QtdNps
393: 
394:                 IF (m.Qtds - m.QtdBs = 0)
395:                     m.QtdFs = m.Qtds

--- BO Linhas 389 a 399 ---
389:                 SEEK loc_lcEdn
390:                 m.QtdFs    = Fabricado.Qtds + m.QtdNps
391:                 m.QtdCancs = Fabricado.QtdCancs
392:                 m.QtReservas = m.QtdNps
393: 
394:                 IF (m.Qtds - m.QtdBs = 0)
395:                     m.QtdFs = m.Qtds
396:                     IF EMPTY(m.DataEps)
397:                         loc_lnResult = SQLEXEC(gnConnHandle, ;
398:                             "SELECT Datas FROM SigBxEst WHERE EmpDopNumB = " + EscaparSQL(loc_lcEdn), ;
399:                             "crSigBxEst")

--- BO Linhas 390 a 400 ---
390:                 m.QtdFs    = Fabricado.Qtds + m.QtdNps
391:                 m.QtdCancs = Fabricado.QtdCancs
392:                 m.QtReservas = m.QtdNps
393: 
394:                 IF (m.Qtds - m.QtdBs = 0)
395:                     m.QtdFs = m.Qtds
396:                     IF EMPTY(m.DataEps)
397:                         loc_lnResult = SQLEXEC(gnConnHandle, ;
398:                             "SELECT Datas FROM SigBxEst WHERE EmpDopNumB = " + EscaparSQL(loc_lcEdn), ;
399:                             "crSigBxEst")
400:                         IF loc_lnResult >= 1 AND USED("crSigBxEst")

--- BO Linhas 406 a 416 ---
406:                             ENDSCAN
407:                         ENDIF
408:                     ENDIF
409:                 ENDIF
410: 
411:                 m.DtEncs = IIF(m.Utilizados = 1 OR m.Qtds - m.QtdNps <= 0 OR ;
412:                               (m.Qtds - m.QtdBs = 0 AND m.Nops = 0 AND m.Utilizados = 0), ;
413:                                m.Datas, IIF(EMPTY(m.Dataeps), DATE(), m.Dataeps))
414:                 m.Pqtdes = IIF(m.Qtds <> 0, (m.QtdFs / m.Qtds * 100), 0)
415:                 m.Lts    = m.DtEncs - m.Datas
416:                 m.Ltis   = IIF(!EMPTY(m.DataEps), (m.DataEps - m.DtEnts), (m.DtEncs - m.DtEnts))

--- BO Linhas 407 a 417 ---
407:                         ENDIF
408:                     ENDIF
409:                 ENDIF
410: 
411:                 m.DtEncs = IIF(m.Utilizados = 1 OR m.Qtds - m.QtdNps <= 0 OR ;
412:                               (m.Qtds - m.QtdBs = 0 AND m.Nops = 0 AND m.Utilizados = 0), ;
413:                                m.Datas, IIF(EMPTY(m.Dataeps), DATE(), m.Dataeps))
414:                 m.Pqtdes = IIF(m.Qtds <> 0, (m.QtdFs / m.Qtds * 100), 0)
415:                 m.Lts    = m.DtEncs - m.Datas
416:                 m.Ltis   = IIF(!EMPTY(m.DataEps), (m.DataEps - m.DtEnts), (m.DtEncs - m.DtEnts))
417:                 m.Ltis   = IIF(m.Ltis < 0, 0, m.Ltis)

--- BO Linhas 409 a 419 ---
409:                 ENDIF
410: 
411:                 m.DtEncs = IIF(m.Utilizados = 1 OR m.Qtds - m.QtdNps <= 0 OR ;
412:                               (m.Qtds - m.QtdBs = 0 AND m.Nops = 0 AND m.Utilizados = 0), ;
413:                                m.Datas, IIF(EMPTY(m.Dataeps), DATE(), m.Dataeps))
414:                 m.Pqtdes = IIF(m.Qtds <> 0, (m.QtdFs / m.Qtds * 100), 0)
415:                 m.Lts    = m.DtEncs - m.Datas
416:                 m.Ltis   = IIF(!EMPTY(m.DataEps), (m.DataEps - m.DtEnts), (m.DtEncs - m.DtEnts))
417:                 m.Ltis   = IIF(m.Ltis < 0, 0, m.Ltis)
418:                 m.Tipos  = '1'
419:                 m.Valors = 0

--- BO Linhas 415 a 425 ---
415:                 m.Lts    = m.DtEncs - m.Datas
416:                 m.Ltis   = IIF(!EMPTY(m.DataEps), (m.DataEps - m.DtEnts), (m.DtEncs - m.DtEnts))
417:                 m.Ltis   = IIF(m.Ltis < 0, 0, m.Ltis)
418:                 m.Tipos  = '1'
419:                 m.Valors = 0
420:                 m.Cpros  = ''
421: 
422:                 * Cotacao da moeda (1 = sem conversao)
423:                 loc_lnCotaOpera = 1
424:                 IF !EMPTY(loc_lcMoeda)
425:                     TRY

--- BO Linhas 430 a 440 ---
430:                     CATCH
431:                         loc_lnCotaOpera = 1
432:                     ENDTRY
433:                 ENDIF
434: 
435:                 loc_lnFiltro = IIF(m.Qtds - m.Qtdfs <= 0, 1, 2)
436: 
437:                 IF (loc_lnOpcao = loc_lnFiltro) OR (loc_lnOpcao = 3)
438:                     SELECT csRelatorio
439:                     APPEND BLANK
440:                     GATHER MEMVAR

--- BO Linhas 438 a 448 ---
438:                     SELECT csRelatorio
439:                     APPEND BLANK
440:                     GATHER MEMVAR
441: 
442:                     IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;

--- BO Linhas 439 a 449 ---
439:                     APPEND BLANK
440:                     GATHER MEMVAR
441: 
442:                     IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;

--- BO Linhas 440 a 450 ---
440:                     GATHER MEMVAR
441: 
442:                     IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;

--- BO Linhas 441 a 451 ---
441: 
442:                     IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;

--- BO Linhas 442 a 452 ---
442:                     IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;

--- BO Linhas 443 a 453 ---
443:                         loc_lcQuery = [Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;

--- BO Linhas 444 a 454 ---
444:                                       [b.chksubn, b.Lccs, a.Nops, c.CodCors, c.CodTams, ] + ;
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;
454:                                       [And a.CodTams = c.CodTams ] + ;

--- BO Linhas 445 a 455 ---
445:                                       [c.QtReservas, c.QtProds, a.Qtds as QtdOps, c.Totas as Totas, c.TotItens from ] + ;
446:                                       [(Select c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, c.moedas, ] + ;
447:                                       [Case When d.CodCors is not null Then d.CodCors Else space(4) End as CodCors, ] + ;
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;
454:                                       [And a.CodTams = c.CodTams ] + ;
455:                                       [Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] + ;

--- BO Linhas 448 a 458 ---
448:                                       [Case When d.CodTams is not null Then d.CodTams Else space(4) End as CodTams, ] + ;
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;
454:                                       [And a.CodTams = c.CodTams ] + ;
455:                                       [Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] + ;
456:                                       [Where c.EmpDopNums = '] + loc_lcEdn + ['] + ;
457:                                       [Order by c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, a.Nops]
458: 

--- BO Linhas 449 a 459 ---
449:                                       [d.QtReservas, c.Qtds as TotItens, c.Totas, ] + ;
450:                                       [Case When d.Qtds is not null Then d.Qtds Else c.Qtds End as Qtprods ] + ;
451:                                       [From SigMvItn c Left Join SigMvIts d On c.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;
454:                                       [And a.CodTams = c.CodTams ] + ;
455:                                       [Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] + ;
456:                                       [Where c.EmpDopNums = '] + loc_lcEdn + ['] + ;
457:                                       [Order by c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, a.Nops]
458: 
459:                         IF SQLEXEC(gnConnHandle, loc_lcQuery, "csQtde") < 1

--- BO Linhas 452 a 462 ---
452:                                       [Where c.EmpDopNums = '] + loc_lcEdn + [' ) c ] + ;
453:                                       [left Join SigOpPic a On a.EmpDopNums = c.EmpDopNums And a.Cpros = c.Cpros And a.Citens = c.Citens And a.CodCors = c.CodCors ] + ;
454:                                       [And a.CodTams = c.CodTams ] + ;
455:                                       [Left Join SigCdNec b On a.EmpDopNops = b.EmpDNps ] + ;
456:                                       [Where c.EmpDopNums = '] + loc_lcEdn + ['] + ;
457:                                       [Order by c.Emps, c.Dopes, c.Numes, c.EmpdopNums, c.Citens, c.Cpros, a.Nops]
458: 
459:                         IF SQLEXEC(gnConnHandle, loc_lcQuery, "csQtde") < 1
460:                             THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csQtde-ped)"
461:                             loc_lSucesso = .F.
462:                             loc_lScanOk2 = .F.

--- BO Linhas 461 a 471 ---
461:                             loc_lSucesso = .F.
462:                             loc_lScanOk2 = .F.
463:                             EXIT
464:                         ENDIF
465: 
466:                         SELECT Emps, Dopes, Numes, EmpdopNums, Citens, Cpros, ;
467:                             NVL(chksubn, .T.) AS chksubn, NVL(Lccs, .F.) AS Lccs, ;
468:                             NVL(Nops, 0) AS Nops, moedas, ;
469:                             NVL(QtReservas, 0) AS QtReservas, NVL(QtProds, 0) AS QtProds, ;
470:                             NVL(QtdOps, 0) AS QtdOps, Totas, TotItens, CodCors, CodTams ;
471:                             FROM csQtde INTO CURSOR csQtde

--- BO Linhas 465 a 475 ---
465: 
466:                         SELECT Emps, Dopes, Numes, EmpdopNums, Citens, Cpros, ;
467:                             NVL(chksubn, .T.) AS chksubn, NVL(Lccs, .F.) AS Lccs, ;
468:                             NVL(Nops, 0) AS Nops, moedas, ;
469:                             NVL(QtReservas, 0) AS QtReservas, NVL(QtProds, 0) AS QtProds, ;
470:                             NVL(QtdOps, 0) AS QtdOps, Totas, TotItens, CodCors, CodTams ;
471:                             FROM csQtde INTO CURSOR csQtde
472: 
473:                         loc_lnOp    = 0
474:                         loc_lnTotMov = 0
475:                         loc_lnCItem  = 0

--- BO Linhas 480 a 490 ---
480:                                  (csQtde.Nops <> 0 AND csQtde.QtdOps = 0))
481:                                 loc_llInseriu = .F.
482:                                 SELECT csRelatorio
483:                                 GO TOP
484:                                 LOCATE FOR Emps = csQtde.Emps AND Dopes = csQtde.Dopes AND ;
485:                                            Numes = csQtde.Numes AND Cpros = csQtde.Cpros AND ;
486:                                            Citens = csQtde.Citens AND ;
487:                                            IIF(loc_llTpOpe OR csQtde.Nops = 0, .T., Nops = csQtde.Nops)
488: 
489:                                 IF !EOF()
490:                                     REPLACE Qtds WITH Qtds + IIF(!EMPTY(csQtde.Nops), ;

--- BO Linhas 485 a 495 ---
485:                                            Numes = csQtde.Numes AND Cpros = csQtde.Cpros AND ;
486:                                            Citens = csQtde.Citens AND ;
487:                                            IIF(loc_llTpOpe OR csQtde.Nops = 0, .T., Nops = csQtde.Nops)
488: 
489:                                 IF !EOF()
490:                                     REPLACE Qtds WITH Qtds + IIF(!EMPTY(csQtde.Nops), ;
491:                                                 csQtde.QtReservas + csQtde.QtdOps, csQtde.Qtprods)
492:                                     REPLACE QtdPdProds WITH QtdPdProds + csQtde.QtdOps
493:                                     REPLACE QtReservas WITH QtReservas + csQtde.QtReservas
494:                                     REPLACE Pqtdes WITH Pqtdes + ;
495:                                                 IIF(csQtde.chksubn, csQtde.QtReservas + csQtde.QtdOps, csQtde.QtReservas)

--- BO Linhas 497 a 507 ---
497:                                     REPLACE QtdCancs WITH QtdCancs + IIF(csQtde.Lccs, csQtde.QtdOps, 0)
498:                                     REPLACE QtdMovPds WITH QtdMovPds + ;
499:                                                 IIF(csQtde.chksubn AND !csQtde.Lccs, csQtde.QtdOps, 0) + ;
500:                                                 csQtde.QtReservas
501:                                     IF !loc_llTpOpe
502:                                         loc_lnVenda = (csQtde.Totas / csQtde.TotItens) * ;
503:                                                        IIF(m.Qtds = 0, m.QtReservas, m.Qtds)
504:                                         IF !EMPTY(loc_lcMoeda) AND ;
505:                                            ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
506:                                             TRY
507:                                                 loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;

--- BO Linhas 498 a 508 ---
498:                                     REPLACE QtdMovPds WITH QtdMovPds + ;
499:                                                 IIF(csQtde.chksubn AND !csQtde.Lccs, csQtde.QtdOps, 0) + ;
500:                                                 csQtde.QtReservas
501:                                     IF !loc_llTpOpe
502:                                         loc_lnVenda = (csQtde.Totas / csQtde.TotItens) * ;
503:                                                        IIF(m.Qtds = 0, m.QtReservas, m.Qtds)
504:                                         IF !EMPTY(loc_lcMoeda) AND ;
505:                                            ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
506:                                             TRY
507:                                                 loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;
508:                                                                      ResPed.Datas, gnConnHandle)

--- BO Linhas 515 a 525 ---
515:                                         ENDIF
516:                                         REPLACE Valors WITH loc_lnVenda
517:                                     ENDIF
518:                                 ELSE
519:                                     m.tipos     = '2'
520:                                     m.Cpros     = csQtde.Cpros
521:                                     m.Qtds      = IIF(!EMPTY(csQtde.Nops), ;
522:                                                       csQtde.QtReservas + csQtde.QtdOps, ;
523:                                                       csQtde.Qtprods)
524:                                     m.QtdPdProds = csQtde.QtdOps
525:                                     m.QtReservas = csQtde.QtReservas

--- BO Linhas 516 a 526 ---
516:                                         REPLACE Valors WITH loc_lnVenda
517:                                     ENDIF
518:                                 ELSE
519:                                     m.tipos     = '2'
520:                                     m.Cpros     = csQtde.Cpros
521:                                     m.Qtds      = IIF(!EMPTY(csQtde.Nops), ;
522:                                                       csQtde.QtReservas + csQtde.QtdOps, ;
523:                                                       csQtde.Qtprods)
524:                                     m.QtdPdProds = csQtde.QtdOps
525:                                     m.QtReservas = csQtde.QtReservas
526:                                     m.Pqtdes     = IIF(csQtde.chksubn, ;

--- BO Linhas 531 a 541 ---
531:                                                        csQtde.QtdOps, 0) + csQtde.QtReservas
532:                                     m.Nops       = csQtde.Nops
533:                                     m.Lts        = 0
534:                                     m.Ltis       = 0
535:                                     loc_lnVenda  = IIF(loc_llTpOpe, csQtde.Totas, ;
536:                                                        (csQtde.Totas / csQtde.TotItens) * ;
537:                                                        IIF(m.Qtds = 0, m.QtReservas, m.Qtds))
538:                                     IF !EMPTY(loc_lcMoeda) AND ;
539:                                        ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
540:                                         TRY
541:                                             loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;

--- BO Linhas 532 a 542 ---
532:                                     m.Nops       = csQtde.Nops
533:                                     m.Lts        = 0
534:                                     m.Ltis       = 0
535:                                     loc_lnVenda  = IIF(loc_llTpOpe, csQtde.Totas, ;
536:                                                        (csQtde.Totas / csQtde.TotItens) * ;
537:                                                        IIF(m.Qtds = 0, m.QtReservas, m.Qtds))
538:                                     IF !EMPTY(loc_lcMoeda) AND ;
539:                                        ALLTRIM(loc_lcMoeda) <> ALLTRIM(csQtde.Moedas)
540:                                         TRY
541:                                             loc_lnCotaVenda = fBuscarCotacao(csQtde.Moedas, ;
542:                                                                  ResPed.Datas, gnConnHandle)

--- BO Linhas 546 a 556 ---
546:                                             ENDIF
547:                                         CATCH
548:                                         ENDTRY
549:                                     ENDIF
550:                                     m.Valors    = loc_lnVenda
551:                                     m.ValUnits  = IIF(csQtde.TotItens <> 0, ;
552:                                                       m.Valors / csQtde.TotItens, 0)
553:                                     m.QtdCancs  = IIF(csQtde.Lccs, csQtde.QtdOps, 0)
554:                                     m.Citens    = csQtde.Citens
555:                                     SELECT csRelatorio
556:                                     APPEND BLANK

--- BO Linhas 547 a 557 ---
547:                                         CATCH
548:                                         ENDTRY
549:                                     ENDIF
550:                                     m.Valors    = loc_lnVenda
551:                                     m.ValUnits  = IIF(csQtde.TotItens <> 0, ;
552:                                                       m.Valors / csQtde.TotItens, 0)
553:                                     m.QtdCancs  = IIF(csQtde.Lccs, csQtde.QtdOps, 0)
554:                                     m.Citens    = csQtde.Citens
555:                                     SELECT csRelatorio
556:                                     APPEND BLANK
557:                                     GATHER MEMVAR

--- BO Linhas 561 a 571 ---
561:                                 * Movimentacoes por tipo de operacao (quando llTpOpe ativo)
562:                                 IF loc_llTpOpe
563:                                     IF csQtde.Nops <> 0 AND csQtde.chksubn AND !csQtde.Lccs
564:                                         IF (loc_lnOp <> csQtde.Nops AND loc_lnCItem <> csQtde.Citens) OR ;
565:                                            (loc_lnOp <> csQtde.Nops AND loc_lnCItem = csQtde.Citens)
566:                                             loc_lcSql = [Select a.Cpros, Sum(a.Qtds) as QtMovs from SigOpEtq a Inner Join ] + ;
567:                                                         [(Select top 1 a.Emps, a.Dopps, a.Numps, a.EmpDNps, a.Codpds from SigPdMvf a ] + ;
568:                                                         [Inner Join SigOpPic b On a.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?loc_lcEdn ] + ;
569:                                                         [And b.Citens = ?csQtde.Citens And b.CodCors = ?csQtde.CodCors And b.CodTams = ?csQtde.CodTams ] + ;
570:                                                         [order by a.cidchaves desc) b ] + ;
571:                                                         [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;

--- BO Linhas 564 a 574 ---
564:                                         IF (loc_lnOp <> csQtde.Nops AND loc_lnCItem <> csQtde.Citens) OR ;
565:                                            (loc_lnOp <> csQtde.Nops AND loc_lnCItem = csQtde.Citens)
566:                                             loc_lcSql = [Select a.Cpros, Sum(a.Qtds) as QtMovs from SigOpEtq a Inner Join ] + ;
567:                                                         [(Select top 1 a.Emps, a.Dopps, a.Numps, a.EmpDNps, a.Codpds from SigPdMvf a ] + ;
568:                                                         [Inner Join SigOpPic b On a.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?loc_lcEdn ] + ;
569:                                                         [And b.Citens = ?csQtde.Citens And b.CodCors = ?csQtde.CodCors And b.CodTams = ?csQtde.CodTams ] + ;
570:                                                         [order by a.cidchaves desc) b ] + ;
571:                                                         [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;
572:                                                         [And a.EmpOs+a.DopeOs+str(a.NumeOs,6) = ?loc_lcEdn And a.Nops = ?csQtde.Nops ] + ;
573:                                                         [Inner Join SigMvHst c On a.Cbars = c.Codbarras ] + ;
574:                                                         [Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + ;

--- BO Linhas 567 a 577 ---
567:                                                         [(Select top 1 a.Emps, a.Dopps, a.Numps, a.EmpDNps, a.Codpds from SigPdMvf a ] + ;
568:                                                         [Inner Join SigOpPic b On a.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?loc_lcEdn ] + ;
569:                                                         [And b.Citens = ?csQtde.Citens And b.CodCors = ?csQtde.CodCors And b.CodTams = ?csQtde.CodTams ] + ;
570:                                                         [order by a.cidchaves desc) b ] + ;
571:                                                         [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;
572:                                                         [And a.EmpOs+a.DopeOs+str(a.NumeOs,6) = ?loc_lcEdn And a.Nops = ?csQtde.Nops ] + ;
573:                                                         [Inner Join SigMvHst c On a.Cbars = c.Codbarras ] + ;
574:                                                         [Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + ;
575:                                                         loc_lcTpOpeM + [Group By a.Cpros]
576:                                             IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpMov") >= 1 ;
577:                                                AND USED("CrTmpMov") AND !EOF("CrTmpMov")

--- BO Linhas 568 a 578 ---
568:                                                         [Inner Join SigOpPic b On a.Nops = b.Nops where b.Nops = ?csQtde.Nops And b.Empdopnums = ?loc_lcEdn ] + ;
569:                                                         [And b.Citens = ?csQtde.Citens And b.CodCors = ?csQtde.CodCors And b.CodTams = ?csQtde.CodTams ] + ;
570:                                                         [order by a.cidchaves desc) b ] + ;
571:                                                         [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;
572:                                                         [And a.EmpOs+a.DopeOs+str(a.NumeOs,6) = ?loc_lcEdn And a.Nops = ?csQtde.Nops ] + ;
573:                                                         [Inner Join SigMvHst c On a.Cbars = c.Codbarras ] + ;
574:                                                         [Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + ;
575:                                                         loc_lcTpOpeM + [Group By a.Cpros]
576:                                             IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpMov") >= 1 ;
577:                                                AND USED("CrTmpMov") AND !EOF("CrTmpMov")
578:                                                 loc_lnOp     = csQtde.Nops

--- BO Linhas 570 a 580 ---
570:                                                         [order by a.cidchaves desc) b ] + ;
571:                                                         [On a.Emps = b.Emps And a.Dopes = b.Dopps And a.Numes = b.Numps ] + ;
572:                                                         [And a.EmpOs+a.DopeOs+str(a.NumeOs,6) = ?loc_lcEdn And a.Nops = ?csQtde.Nops ] + ;
573:                                                         [Inner Join SigMvHst c On a.Cbars = c.Codbarras ] + ;
574:                                                         [Inner Join SigCdOpe d On c.Dopes = d.Dopes And d.TipoOps in ] + ;
575:                                                         loc_lcTpOpeM + [Group By a.Cpros]
576:                                             IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpMov") >= 1 ;
577:                                                AND USED("CrTmpMov") AND !EOF("CrTmpMov")
578:                                                 loc_lnOp     = csQtde.Nops
579:                                                 loc_lnCItem  = csQtde.Citens
580:                                                 loc_lnTotMov = CrTmpMov.QtMovs

--- BO Linhas 604 a 614 ---
604:                                             IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrxOpe") >= 1 ;
605:                                                AND USED("CrxOpe") AND !EOF("CrxOpe")
606:                                                 loc_lnCodigo = (CrxOpe.nDopes * 1000000) + CrxOpe.Numes
607: 
608:                                                 IF !EMPTY(loc_lcTpOpeE)
609:                                                     loc_lcQuery = [Select a.Cpros, count(c.Dopes) as QtMovs from ] + ;
610:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
611:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
612:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
613:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
614:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;

--- BO Linhas 605 a 615 ---
605:                                                AND USED("CrxOpe") AND !EOF("CrxOpe")
606:                                                 loc_lnCodigo = (CrxOpe.nDopes * 1000000) + CrxOpe.Numes
607: 
608:                                                 IF !EMPTY(loc_lcTpOpeE)
609:                                                     loc_lcQuery = [Select a.Cpros, count(c.Dopes) as QtMovs from ] + ;
610:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
611:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
612:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
613:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
614:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
615:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;

--- BO Linhas 609 a 619 ---
609:                                                     loc_lcQuery = [Select a.Cpros, count(c.Dopes) as QtMovs from ] + ;
610:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
611:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
612:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
613:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
614:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
615:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
616:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
617:                                                                   [Union All ] + ;
618:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
619:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;

--- BO Linhas 611 a 621 ---
611:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
612:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
613:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
614:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
615:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
616:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
617:                                                                   [Union All ] + ;
618:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
619:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
620:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
621:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;

--- BO Linhas 613 a 623 ---
613:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
614:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
615:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
616:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
617:                                                                   [Union All ] + ;
618:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
619:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
620:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
621:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
622:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
623:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;

--- BO Linhas 618 a 628 ---
618:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
619:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
620:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
621:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
622:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
623:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;
624:                                                                   [Inner Join SigMvHst b On a.codbarras = b.Codbarras ] + ;
625:                                                                   [Left Join SigCdOpe c On b.Dopes = c.Dopes And c.TipoOps in ] + ;
626:                                                                   loc_lcTpOpeM + [ Group By a.Cpros ]
627:                                                     IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
628:                                                         SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;

--- BO Linhas 619 a 629 ---
619:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
620:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
621:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
622:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
623:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;
624:                                                                   [Inner Join SigMvHst b On a.codbarras = b.Codbarras ] + ;
625:                                                                   [Left Join SigCdOpe c On b.Dopes = c.Dopes And c.TipoOps in ] + ;
626:                                                                   loc_lcTpOpeM + [ Group By a.Cpros ]
627:                                                     IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
628:                                                         SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
629:                                                             INTO CURSOR TmpEmpenho

--- BO Linhas 621 a 631 ---
621:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
622:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeE + [ And ] + ;
623:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;
624:                                                                   [Inner Join SigMvHst b On a.codbarras = b.Codbarras ] + ;
625:                                                                   [Left Join SigCdOpe c On b.Dopes = c.Dopes And c.TipoOps in ] + ;
626:                                                                   loc_lcTpOpeM + [ Group By a.Cpros ]
627:                                                     IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
628:                                                         SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
629:                                                             INTO CURSOR TmpEmpenho
630:                                                         REPLACE QtdMovPds WITH QtdMovPds - TmpEmpenho.QtMovs ;
631:                                                             IN csRelatorio

--- BO Linhas 633 a 643 ---
633:                                                             IN csRelatorio
634:                                                     ENDIF
635:                                                 ENDIF
636: 
637:                                                 IF !EMPTY(loc_lcTpOpeC)
638:                                                     loc_lcQuery = [Select a.Cpros, Sum(a.Qtds) as QtMovs from ] + ;
639:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
640:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
641:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
642:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
643:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;

--- BO Linhas 634 a 644 ---
634:                                                     ENDIF
635:                                                 ENDIF
636: 
637:                                                 IF !EMPTY(loc_lcTpOpeC)
638:                                                     loc_lcQuery = [Select a.Cpros, Sum(a.Qtds) as QtMovs from ] + ;
639:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
640:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
641:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
642:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
643:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
644:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;

--- BO Linhas 638 a 648 ---
638:                                                     loc_lcQuery = [Select a.Cpros, Sum(a.Qtds) as QtMovs from ] + ;
639:                                                                   [(Select d.cpros, d.codbarras, d.Qtds ] + ;
640:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
641:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
642:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
643:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
644:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
645:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
646:                                                                   [Union All ] + ;
647:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
648:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;

--- BO Linhas 640 a 650 ---
640:                                                                   [From SigMvPec a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
641:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
642:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
643:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
644:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
645:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
646:                                                                   [Union All ] + ;
647:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
648:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
649:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
650:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;

--- BO Linhas 642 a 652 ---
642:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
643:                                                                   [a.EmpSubns = '] + go_4c_Sistema.cCodEmpresa + [' And ] + ;
644:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
645:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros ] + ;
646:                                                                   [Union All ] + ;
647:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
648:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
649:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
650:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
651:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
652:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;

--- BO Linhas 647 a 657 ---
647:                                                                   [Select d.cpros, d.codbarras, d.Qtds ] + ;
648:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
649:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
650:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
651:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
652:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;
653:                                                                   [Group By a.Cpros ]
654:                                                     IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
655:                                                         SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
656:                                                             INTO CURSOR TmpEmpenho
657:                                                         REPLACE QtdMovPds WITH QtdMovPds - TmpEmpenho.QtMovs ;

--- BO Linhas 648 a 658 ---
648:                                                                   [From SigOpDev a, SigMvCab b, SigCdOpe c, SigMvItn d ] + ;
649:                                                                   [Where a.Codigos = ] + STR(loc_lnCodigo) + [ And ] + ;
650:                                                                   [a.EmpDopnums = b.EmpDopNums And ] + ;
651:                                                                   [b.Dopes = c.Dopes And c.TipoOps in ] + loc_lcTpOpeC + [ And ] + ;
652:                                                                   [b.EmpDopNums = d.EmpDopNums And d.Cpros = ?csQtde.Cpros) a ] + ;
653:                                                                   [Group By a.Cpros ]
654:                                                     IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpEmpenho") >= 1
655:                                                         SELECT NVL(QtMovs, 0) AS QtMovs FROM TmpEmpenho ;
656:                                                             INTO CURSOR TmpEmpenho
657:                                                         REPLACE QtdMovPds WITH QtdMovPds - TmpEmpenho.QtMovs ;
658:                                                             IN csRelatorio

--- BO Linhas 666 a 676 ---
666:                                 ENDIF
667: 
668:                                 * Totaliza cabecalho do pedido (linha Tipos='1') com acumulados de itens (Tipos='2')
669:                                 SELECT csRelatorio
670:                                 loc_lnReg = RECNO()
671:                                 SELECT SUM(Qtds) AS Qtds, SUM(QtReservas) AS QtReservas, ;
672:                                     SUM(QtdCancs) AS QtdCancs, SUM(QtProds) AS QtProds, ;
673:                                     SUM(QtdMovPds) AS QtdMovPds, SUM(QtdMovs) AS QtdMovs, ;
674:                                     SUM(QtdPdProds) AS QtdPdProds, SUM(Valors) AS Valors, ;
675:                                     SUM(NVL(QtProds * ValUnits, 0)) AS TotProds, ;
676:                                     SUM(NVL(QtdMovPds * ValUnits, 0)) AS TotMovPds, ;

--- BO Linhas 682 a 692 ---
682:                                 SELECT csRelatorio
683:                                 GO TOP
684:                                 LOCATE FOR Emps + Dopes + STR(Numes,6) = loc_lcEdn AND Tipos = '1'
685:                                 IF !EOF()
686:                                     LOCAL loc_lnQtds
687:                                     loc_lnQtds = NVL(TmpTotal.Qtds, 0)
688:                                     LOCAL loc_lnVs
689:                                     loc_lnVs = NVL(TmpTotal.Valors, 0)
690:                                     REPLACE Qtds WITH loc_lnQtds, ;
691:                                         QtReservas WITH NVL(TmpTotal.QtReservas, 0), ;
692:                                         QtdCancs WITH NVL(TmpTotal.QtdCancs, 0), ;

--- BO Linhas 685 a 695 ---
685:                                 IF !EOF()
686:                                     LOCAL loc_lnQtds
687:                                     loc_lnQtds = NVL(TmpTotal.Qtds, 0)
688:                                     LOCAL loc_lnVs
689:                                     loc_lnVs = NVL(TmpTotal.Valors, 0)
690:                                     REPLACE Qtds WITH loc_lnQtds, ;
691:                                         QtReservas WITH NVL(TmpTotal.QtReservas, 0), ;
692:                                         QtdCancs WITH NVL(TmpTotal.QtdCancs, 0), ;
693:                                         QtProds WITH NVL(TmpTotal.QtProds, 0), ;
694:                                         QtdMovPds WITH NVL(TmpTotal.QtdMovPds, 0), ;
695:                                         QtdMovs WITH NVL(TmpTotal.QtdMovs, 0), ;

--- BO Linhas 727 a 737 ---
727: 
728:             * Linha de totais gerais
729:             SELECT csRelatorio
730:             IF !EOF()
731:                 SELECT '5' AS Tipos, SUM(1) AS Qps, ;
732:                         SUM(IIF(Qtds - Qtdfs <= 0, 1, 0)) AS Qpes, ;
733:                         SUM(Qtds) AS QtdPcs, SUM(QtdFs) AS QtdPces, ;
734:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, Lts, 0)) AS Lts, ;
735:                         SUM(IIF(Ltis > 0, 1, 0)) AS Qltis, SUM(Ltis) AS Ltis, ;
736:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, 1, 0)) AS Qmpes, ;
737:                         SUM(QtdCancs) AS QtdCancs ;

--- BO Linhas 728 a 738 ---
728:             * Linha de totais gerais
729:             SELECT csRelatorio
730:             IF !EOF()
731:                 SELECT '5' AS Tipos, SUM(1) AS Qps, ;
732:                         SUM(IIF(Qtds - Qtdfs <= 0, 1, 0)) AS Qpes, ;
733:                         SUM(Qtds) AS QtdPcs, SUM(QtdFs) AS QtdPces, ;
734:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, Lts, 0)) AS Lts, ;
735:                         SUM(IIF(Ltis > 0, 1, 0)) AS Qltis, SUM(Ltis) AS Ltis, ;
736:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, 1, 0)) AS Qmpes, ;
737:                         SUM(QtdCancs) AS QtdCancs ;
738:                    FROM csRelatorio WHERE tipos <> '2' ;

--- BO Linhas 729 a 739 ---
729:             SELECT csRelatorio
730:             IF !EOF()
731:                 SELECT '5' AS Tipos, SUM(1) AS Qps, ;
732:                         SUM(IIF(Qtds - Qtdfs <= 0, 1, 0)) AS Qpes, ;
733:                         SUM(Qtds) AS QtdPcs, SUM(QtdFs) AS QtdPces, ;
734:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, Lts, 0)) AS Lts, ;
735:                         SUM(IIF(Ltis > 0, 1, 0)) AS Qltis, SUM(Ltis) AS Ltis, ;
736:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, 1, 0)) AS Qmpes, ;
737:                         SUM(QtdCancs) AS QtdCancs ;
738:                    FROM csRelatorio WHERE tipos <> '2' ;
739:                    INTO CURSOR csTotal GROUP BY 1

--- BO Linhas 731 a 741 ---
731:                 SELECT '5' AS Tipos, SUM(1) AS Qps, ;
732:                         SUM(IIF(Qtds - Qtdfs <= 0, 1, 0)) AS Qpes, ;
733:                         SUM(Qtds) AS QtdPcs, SUM(QtdFs) AS QtdPces, ;
734:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, Lts, 0)) AS Lts, ;
735:                         SUM(IIF(Ltis > 0, 1, 0)) AS Qltis, SUM(Ltis) AS Ltis, ;
736:                         SUM(IIF(Qtds - Qtdfs <= 0 AND Utilizados = 0, 1, 0)) AS Qmpes, ;
737:                         SUM(QtdCancs) AS QtdCancs ;
738:                    FROM csRelatorio WHERE tipos <> '2' ;
739:                    INTO CURSOR csTotal GROUP BY 1
740: 
741:                 SELECT csRelatorio

--- BO Linhas 743 a 753 ---
743:                 SUM Valors FOR tipos = '2' TO loc_lnValors
744: 
745:                 SELECT csRelatorio
746:                 GO BOTTOM
747:                 SCATTER MEMVAR
748:                 m.cpros      = ''
749:                 m.Valors     = loc_lnValors
750:                 m.Qtds       = 0
751:                 m.Pqtdes     = 0
752:                 m.Nops       = 0
753:                 m.Ltis       = 0

--- BO Linhas 745 a 755 ---
745:                 SELECT csRelatorio
746:                 GO BOTTOM
747:                 SCATTER MEMVAR
748:                 m.cpros      = ''
749:                 m.Valors     = loc_lnValors
750:                 m.Qtds       = 0
751:                 m.Pqtdes     = 0
752:                 m.Nops       = 0
753:                 m.Ltis       = 0
754:                 m.QtProds    = 0
755:                 m.QtReservas = 0

--- BO Linhas 768 a 778 ---
768:                 IF THIS.this_nAnaSin = 1 OR loc_llTpOpe
769:                     SELECT SUM(NVL(Valors, 0)) AS TotUnits, ;
770:                         SUM(NVL(QtProds * ValUnits, 0)) AS ValProds, ;
771:                         SUM(NVL(QtdMovPds * ValUnits, 0)) AS ValMovPds, ;
772:                         SUM(NVL(QtdMovs * ValUnits, 0)) AS ValMovs, ;
773:                         SUM(Qtds) AS Qtds, SUM(QtProds) AS QtProds, ;
774:                         SUM(QtdMovPds) AS QtdMovPds, SUM(QtdMovs) AS QtdMovs ;
775:                         FROM csRelatorio WHERE tipos = '2' INTO CURSOR csTotal2
776: 
777:                     m.ValProds   = csTotal2.ValProds
778:                     m.ValMovPds  = csTotal2.ValMovPds

--- BO Linhas 784 a 794 ---
784:                     m.PValMovs   = IIF(csTotal2.TotUnits<>0, ;
785:                                        (csTotal2.ValMovs / csTotal2.TotUnits) * 100, 0)
786:                     m.QtProds    = csTotal2.QtProds
787:                     m.QtdMovPds  = csTotal2.QtdMovPds
788:                     m.QtdMovs    = csTotal2.QtdMovs
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)

--- BO Linhas 785 a 795 ---
785:                                        (csTotal2.ValMovs / csTotal2.TotUnits) * 100, 0)
786:                     m.QtProds    = csTotal2.QtProds
787:                     m.QtdMovPds  = csTotal2.QtdMovPds
788:                     m.QtdMovs    = csTotal2.QtdMovs
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
795:                 ENDIF

--- BO Linhas 786 a 796 ---
786:                     m.QtProds    = csTotal2.QtProds
787:                     m.QtdMovPds  = csTotal2.QtdMovPds
788:                     m.QtdMovs    = csTotal2.QtdMovs
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
795:                 ENDIF
796: 

--- BO Linhas 787 a 797 ---
787:                     m.QtdMovPds  = csTotal2.QtdMovPds
788:                     m.QtdMovs    = csTotal2.QtdMovs
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
795:                 ENDIF
796: 
797:                 SELECT csRelatorio

--- BO Linhas 788 a 798 ---
788:                     m.QtdMovs    = csTotal2.QtdMovs
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
795:                 ENDIF
796: 
797:                 SELECT csRelatorio
798:                 APPEND BLANK

--- BO Linhas 789 a 799 ---
789:                     m.PProds     = IIF(csTotal2.Qtds<>0, ;
790:                                        (csTotal2.QtProds / csTotal2.Qtds) * 100, 0)
791:                     m.PMovPds    = IIF(csTotal2.Qtds<>0, ;
792:                                        (csTotal2.QtdMovPds / csTotal2.Qtds) * 100, 0)
793:                     m.PMovs      = IIF(csTotal2.Qtds<>0, ;
794:                                        (csTotal2.QtdMovs / csTotal2.Qtds) * 100, 0)
795:                 ENDIF
796: 
797:                 SELECT csRelatorio
798:                 APPEND BLANK
799:                 GATHER MEMVAR

--- BO Linhas 1046 a 1056 ---
1046:         TRY
1047:             loc_cOperacao = IIF(EMPTY(par_cOperacao), "REPORT", ALLTRIM(par_cOperacao))
1048:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
1049:                                ALLTRIM(gc_4c_UsuarioLogado), "SYSTEM")
1050: 
1051:             *-- Monta descricao com filtros usados na execucao
1052:             loc_cDescricao = "Relat" + CHR(243) + "rio: SigReEsp"
1053:             IF !EMPTY(THIS.this_cNmOperacao)
1054:                 loc_cDescricao = loc_cDescricao + " | Opera" + CHR(231) + CHR(227) + "o=" + ;
1055:                                  ALLTRIM(THIS.this_cNmOperacao)
1056:             ENDIF

--- BO Linhas 1069 a 1079 ---
1069:             ENDIF
1070:             IF !EMPTY(THIS.this_cCdMoeda)
1071:                 loc_cDescricao = loc_cDescricao + " | Moeda=" + ALLTRIM(THIS.this_cCdMoeda)
1072:             ENDIF
1073: 
1074:             *-- Trunca para o tamanho da coluna Descricao (VARCHAR(500))
1075:             IF LEN(loc_cDescricao) > 500
1076:                 loc_cDescricao = LEFT(loc_cDescricao, 500)
1077:             ENDIF
1078: 
1079:             loc_cSQL = "INSERT INTO LogAuditoria " + ;

--- BO Linhas 1075 a 1085 ---
1075:             IF LEN(loc_cDescricao) > 500
1076:                 loc_cDescricao = LEFT(loc_cDescricao, 500)
1077:             ENDIF
1078: 
1079:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
1080:                        "(Empresa, Usuario, DataHora, Tabela, Operacao, ChavePrimaria, Descricao) " + ;
1081:                        "VALUES (" + ;
1082:                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
1083:                        EscaparSQL(loc_cUsuario) + ", " + ;
1084:                        "GETDATE(), " + ;
1085:                        EscaparSQL("SigReEsp") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg
- BO: C:\4c\projeto\app\classes\SigReEspBO.prg
