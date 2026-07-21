CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'linhas' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'reffs' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'notas' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'grupods' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'contads' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'jobs' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3726: INSERT coluna 'citens' NAO EXISTE na tabela 'sigmvhst'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'dopps' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'numps' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'nops' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'datas' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'dataps' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'usuars' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'cgrus' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'codcors' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'codtams' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'grupos' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'contas' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'empdnps' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3864: INSERT coluna 'dtgeras' NAO EXISTE na tabela 'sigmvitn'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'dopps' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'numps' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'nops' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'datas' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'dataps' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'usuars' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'grupos' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'contas' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'empdnps' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'dtgeras' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~3904: INSERT coluna 'cpro2s' NAO EXISTE na tabela 'sigmvits'
- [SQL-SCHEMA] Linha ~4097: INSERT coluna 'emps' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~4097: INSERT coluna 'usuarios' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~4097: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'


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
 

-- Tabela: sigmvhst
CREATE TABLE [dbo].[SigMvHst](
	[cpros] [char](14) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[datars] [datetime] NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[dopes] [char](20) NOT NULL,
	[empos] [char](3) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[estos] [char](10) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[opers] [char](1) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[sqtds] [numeric](11, 3) NOT NULL,
	[teqtds] [numeric](11, 3) NOT NULL,
	[totas] [numeric](11, 2) NOT NULL,
	[tsqtds] [numeric](11, 3) NOT NULL,
	[units] [numeric](15, 6) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[locals] [char](10) NOT NULL,
	[codbarras] [numeric](14, 0) NOT NULL,
	[unitmeds] [numeric](15, 6) NOT NULL,
	[moedmeds] [char](3) NOT NULL,
	[recalmeds] [bit] NOT NULL,
	[auditors] [char](10) NOT NULL,
	[dtaudits] [datetime] NULL,
	[obs] [text] NULL,
	[cidchaves] [char](20) NOT NULL,
	[pesos] [numeric](15, 3) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[empgruests] [char](23) NOT NULL,
	[dtalts] [datetime] NULL,
	[oridopnums] [char](29) NOT NULL,
	[seqs] [numeric](10, 0) NOT NULL,
	[spesos] [numeric](15, 3) NOT NULL,
	[unitmfis] [numeric](15, 6) NOT NULL,
	[bcipis] [numeric](15, 2) NOT NULL,
	[medipis] [numeric](15, 6) NOT NULL,
 

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

-- Tabela: sigmvits
CREATE TABLE [dbo].[SigMvIts](
	[citens] [numeric](4, 0) NOT NULL,
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[codembs] [char](3) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[aqtds] [numeric](9, 3) NOT NULL,
	[qtdembs] [numeric](5, 1) NOT NULL,
	[aqtdembs] [numeric](5, 1) NOT NULL,
	[qtbaixas] [numeric](9, 3) NOT NULL,
	[prembs] [numeric](9, 3) NOT NULL,
	[codembents] [char](3) NOT NULL,
	[qtdents] [numeric](9, 3) NOT NULL,
	[codbarras] [numeric](14, 0) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtbxprods] [numeric](9, 3) NOT NULL,
	[qtprods] [numeric](9, 3) NOT NULL,
	[datatrans] [datetime] NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[qtreservas] [numeric](9, 3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[compris] [numeric](6, 2) NOT NULL,
	[dtalts] [datetime] NULL,
	[chaveexterna] [char](33) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrGlpBO.prg):

--- BO Linhas 101 a 111 ---
101:         ENDIF
102:     ENDPROC
103: 
104:     *--------------------------------------------------------------------------
105:     * CarregarComposicao - Carrega cursor crSigCdCom (tipos de composicao)
106:     * SELECT a.Tipos, a.Custos, b.CGrus FROM SigCdTpc a, SigCdCom b
107:     * WHERE a.Tipos = b.Tipos
108:     * Resultado: cursor crSigCdCom indexado por Tipos+CGrus
109:     *--------------------------------------------------------------------------
110:     PROCEDURE CarregarComposicao()
111:         LOCAL loc_lSucesso, loc_cSQL

--- BO Linhas 103 a 113 ---
103: 
104:     *--------------------------------------------------------------------------
105:     * CarregarComposicao - Carrega cursor crSigCdCom (tipos de composicao)
106:     * SELECT a.Tipos, a.Custos, b.CGrus FROM SigCdTpc a, SigCdCom b
107:     * WHERE a.Tipos = b.Tipos
108:     * Resultado: cursor crSigCdCom indexado por Tipos+CGrus
109:     *--------------------------------------------------------------------------
110:     PROCEDURE CarregarComposicao()
111:         LOCAL loc_lSucesso, loc_cSQL
112:         loc_lSucesso = .F.
113: 

--- BO Linhas 114 a 124 ---
114:         TRY
115:             IF USED("crSigCdCom")
116:                 USE IN crSigCdCom
117:             ENDIF
118: 
119:             loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
120:                        "FROM SigCdTpc a, SigCdCom b " + ;
121:                        "WHERE a.Tipos = b.Tipos"
122: 
123:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCom") > 0
124:                 SELECT crSigCdCom

--- BO Linhas 120 a 130 ---
120:                        "FROM SigCdTpc a, SigCdCom b " + ;
121:                        "WHERE a.Tipos = b.Tipos"
122: 
123:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCom") > 0
124:                 SELECT crSigCdCom
125:                 INDEX ON Tipos + CGrus TAG Tipos
126:                 loc_lSucesso = .T.
127:             ELSE
128:                 MsgErro("Falha ao carregar tipos de composi" + CHR(231) + CHR(227) + "o (crSigCdCom)", "Erro")
129:             ENDIF
130:         CATCH TO loc_oErro

--- BO Linhas 178 a 188 ---
178: 
179:             IF crSigCdPam.AutComps <> 1
180:                 SELECT (loc_cCompo)
181:                 SCAN
182:                     *-- Acesso direto: SCAN itera loc_cCompo, WA corrente no inicio de cada iter
183:                     loc_cCGrus = CGrus
184:                     loc_cMats  = ALLTRIM(Mats)
185:                     loc_nQtds  = Qtds
186:                     loc_nPesos = Pesos
187:                     IF USED("crSigCdCom")
188:                         SELECT crSigCdCom

--- BO Linhas 185 a 195 ---
185:                     loc_nQtds  = Qtds
186:                     loc_nPesos = Pesos
187:                     IF USED("crSigCdCom")
188:                         SELECT crSigCdCom
189:                         GO TOP IN crSigCdCom
190:                         LOCATE FOR CGrus = m.loc_cCGrus AND Custos = 1
191:                         IF !EOF("crSigCdCom")
192:                             loc_cSQL = "SELECT a.cUnis, a.cUnips, b.BPesos " + ;
193:                                        "FROM SigCdPro a, SigCdGrp b " + ;
194:                                        "WHERE a.CPros = " + EscaparSQL(loc_cMats) + " AND " + ;
195:                                        "a.CGrus = b.CGrus"

--- BO Linhas 190 a 200 ---
190:                         LOCATE FOR CGrus = m.loc_cCGrus AND Custos = 1
191:                         IF !EOF("crSigCdCom")
192:                             loc_cSQL = "SELECT a.cUnis, a.cUnips, b.BPesos " + ;
193:                                        "FROM SigCdPro a, SigCdGrp b " + ;
194:                                        "WHERE a.CPros = " + EscaparSQL(loc_cMats) + " AND " + ;
195:                                        "a.CGrus = b.CGrus"
196: 
197:                             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSomaGru") > 0
198:                                 GO TOP IN crSomaGru
199:                                 IF INLIST(crSomaGru.BPesos, 1, 3)
200:                                     loc_cSQL = "SELECT Fators FROM SigCdUni WHERE Cunis = '" + ;

--- BO Linhas 266 a 276 ---
266:                 ENDIF
267:             ENDSCAN
268: 
269:             SELECT SelOperacao
270:             SCAN
271:                 loc_cSQL = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
272:                            "FROM SigCdOpd " + ;
273:                            "WHERE Dopps = '" + ALLTRIM(SelOperacao.Dopes) + "'"
274:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
275:                     SELECT LocalOpe
276:                     APPEND FROM DBF("xTmpOpe")

--- BO Linhas 268 a 278 ---
268: 
269:             SELECT SelOperacao
270:             SCAN
271:                 loc_cSQL = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
272:                            "FROM SigCdOpd " + ;
273:                            "WHERE Dopps = '" + ALLTRIM(SelOperacao.Dopes) + "'"
274:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
275:                     SELECT LocalOpe
276:                     APPEND FROM DBF("xTmpOpe")
277:                 ENDIF
278:                 IF USED("xTmpOpe")

--- BO Linhas 287 a 297 ---
287:             GO TOP
288:             loc_nRegistro = RECCOUNT()
289: 
290:             loc_nReservado = 0
291:             DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
292:                 loc_nReservado = fGerUniqueKey(DTOS(Datas), , , loc_nRegistro + 1)
293:             ENDDO
294:             loc_nInicio = loc_nReservado - loc_nRegistro
295: 
296:             loc_nRerSeq = 0
297:             DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0

--- BO Linhas 303 a 313 ---
303:             SCAN
304:                 loc_nInicio  = loc_nInicio  + 1
305:                 loc_nIniSeq  = loc_nIniSeq  + 1
306:                 loc_nNewOpe  = crSigMvHst.Opers
307: 
308:                 REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
309:                         Seqs      WITH loc_nIniSeq
310: 
311:                 =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
312:                              crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
313:                              crSigMvHst.CodTams, gnConnHandle)

--- BO Linhas 306 a 316 ---
306:                 loc_nNewOpe  = crSigMvHst.Opers
307: 
308:                 REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
309:                         Seqs      WITH loc_nIniSeq
310: 
311:                 =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
312:                              crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
313:                              crSigMvHst.CodTams, gnConnHandle)
314:                 =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
315:             ENDSCAN
316: 

--- BO Linhas 307 a 317 ---
307: 
308:                 REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
309:                         Seqs      WITH loc_nIniSeq
310: 
311:                 =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
312:                              crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
313:                              crSigMvHst.CodTams, gnConnHandle)
314:                 =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
315:             ENDSCAN
316: 
317:             loc_lSucesso = .T.

--- BO Linhas 308 a 318 ---
308:                 REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
309:                         Seqs      WITH loc_nIniSeq
310: 
311:                 =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
312:                              crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
313:                              crSigMvHst.CodTams, gnConnHandle)
314:                 =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
315:             ENDSCAN
316: 
317:             loc_lSucesso = .T.
318:         CATCH TO loc_oErro

--- BO Linhas 309 a 319 ---
309:                         Seqs      WITH loc_nIniSeq
310: 
311:                 =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
312:                              crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
313:                              crSigMvHst.CodTams, gnConnHandle)
314:                 =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
315:             ENDSCAN
316: 
317:             loc_lSucesso = .T.
318:         CATCH TO loc_oErro
319:             MsgErro(loc_oErro.Message, "Erro")

--- BO Linhas 361 a 371 ---
361:         RETURN loc_lSucesso
362:     ENDPROC
363: 
364:     *--------------------------------------------------------------------------
365:     * Processar - Executa a globalizacao/reserva automatica
366:     * Reproduz a logica do PROCEDURE Click do botao Processar do legado (1637 linhas)
367:     * par_dPrevisao: data de previsao de entrega
368:     * par_dGeracao: data de geracao da ordem
369:     * Requer: cursores TmpFinal/TmpSaldo/TmpSaldG/crSigCdPam/crSigCdPac disponiveis
370:     *--------------------------------------------------------------------------
371:     PROCEDURE Processar(par_dPrevisao, par_dGeracao)

--- BO Linhas 429 a 439 ---
429:             SELECT crSigCdPam
430: 
431:             loc_cDoppPad = crSigCdPam.DoppPads
432:             loc_cDope    = crSigCdPam.TransfRes
433: 
434:             THIS.CursorQuery("SigCdOpd", "crSigCdOpd", "Dopps", loc_cDoppPad)
435: 
436:             loc_nNump = 0
437:             IF !THIS.this_lReserva
438:                 IF crSigCdPam.GlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
439:                     loc_nNump = THIS.this_nNumeroDaOp

--- BO Linhas 439 a 449 ---
439:                     loc_nNump = THIS.this_nNumeroDaOp
440:                 ELSE
441:                     loc_nNump = fGerUniqueKey(loc_cDoppPad)
442:                 ENDIF
443: 
444:                 loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(loc_nNump)
445:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") < 1
446:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpi)")
447:                     loc_lSucesso = .F.
448:                 ENDIF
449:                 IF RECCOUNT("TmpOpi") > 0

--- BO Linhas 466 a 476 ---
466:             loc_nNumpe  = (loc_nNump * 10000) + 1
467: 
468:             IF USED("TmpEmpH")
469:                 USE IN TmpEmpH
470:             ENDIF
471:             CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
472:                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
473:                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
474:                                     QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
475:             INDEX ON cGrus + cMats TAG GruMat
476:             INDEX ON cMats + cpro2s TAG CMats

--- BO Linhas 469 a 479 ---
469:                 USE IN TmpEmpH
470:             ENDIF
471:             CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
472:                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
473:                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
474:                                     QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
475:             INDEX ON cGrus + cMats TAG GruMat
476:             INDEX ON cMats + cpro2s TAG CMats
477: 
478:             IF USED("TmpPedra")
479:                 USE IN TmpPedra

--- BO Linhas 470 a 480 ---
470:             ENDIF
471:             CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
472:                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
473:                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
474:                                     QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
475:             INDEX ON cGrus + cMats TAG GruMat
476:             INDEX ON cMats + cpro2s TAG CMats
477: 
478:             IF USED("TmpPedra")
479:                 USE IN TmpPedra
480:             ENDIF

--- BO Linhas 471 a 481 ---
471:             CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
472:                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
473:                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
474:                                     QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
475:             INDEX ON cGrus + cMats TAG GruMat
476:             INDEX ON cMats + cpro2s TAG CMats
477: 
478:             IF USED("TmpPedra")
479:                 USE IN TmpPedra
480:             ENDIF
481:             CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;

--- BO Linhas 476 a 486 ---
476:             INDEX ON cMats + cpro2s TAG CMats
477: 
478:             IF USED("TmpPedra")
479:                 USE IN TmpPedra
480:             ENDIF
481:             CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
482:                                      Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
483:                                      QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
484:                                      QtdGReqs N(12,3), Pesos N(12,3))
485:             INDEX ON cGrus + cMats TAG GruMat
486:             INDEX ON cMats TAG CMats

--- BO Linhas 480 a 490 ---
480:             ENDIF
481:             CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
482:                                      Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
483:                                      QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
484:                                      QtdGReqs N(12,3), Pesos N(12,3))
485:             INDEX ON cGrus + cMats TAG GruMat
486:             INDEX ON cMats TAG CMats
487:             INDEX ON cMats + Grupos + Contas TAG MatGruCon
488: 
489:             IF USED("TmpMatPrz")
490:                 USE IN TmpMatPrz

--- BO Linhas 482 a 492 ---
482:                                      Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
483:                                      QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
484:                                      QtdGReqs N(12,3), Pesos N(12,3))
485:             INDEX ON cGrus + cMats TAG GruMat
486:             INDEX ON cMats TAG CMats
487:             INDEX ON cMats + Grupos + Contas TAG MatGruCon
488: 
489:             IF USED("TmpMatPrz")
490:                 USE IN TmpMatPrz
491:             ENDIF
492:             CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), PrazoEnts D, QtBaixas N(12,3))

--- BO Linhas 502 a 512 ---
502:             SELECT crTpmMvItn
503:             INDEX ON Cpros TAG Cpros
504: 
505:             IF !THIS.this_lReserva
506:                 SELECT TmpFinal
507:                 INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
508:                 SET ORDER TO Cpros
509:                 GO TOP
510: 
511:                 DO WHILE !EOF("TmpFinal")
512:                     IF TmpFinal.Produzir <> 0

--- BO Linhas 509 a 519 ---
509:                 GO TOP
510: 
511:                 DO WHILE !EOF("TmpFinal")
512:                     IF TmpFinal.Produzir <> 0
513:                         THIS.CursorQuery("SigCdPro", "crSigCdPro", "CPros", TmpFinal.CPros)
514:                         THIS.CursorQuery("SigCdLin", "CrSigCdLin", "Linhas", TmpFinal.Linhas)
515:                         THIS.CursorQuery("SigCdGrp", "CrSigCdGrp", "CGrus",  CrSigCdPro.Cgrus, "Mercs, GeraTubs")
516:                         THIS.CursorQuery("SigCdGpr", "CrSigCdGpr", "Codigos", CrSigCdGrp.Mercs, "MatPrincs, cpqtds")
517: 
518:                         IF EMPTY(crSigCdPac.OpPdCompra) OR ;
519:                            (!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs = 1)

--- BO Linhas 510 a 520 ---
510: 
511:                 DO WHILE !EOF("TmpFinal")
512:                     IF TmpFinal.Produzir <> 0
513:                         THIS.CursorQuery("SigCdPro", "crSigCdPro", "CPros", TmpFinal.CPros)
514:                         THIS.CursorQuery("SigCdLin", "CrSigCdLin", "Linhas", TmpFinal.Linhas)
515:                         THIS.CursorQuery("SigCdGrp", "CrSigCdGrp", "CGrus",  CrSigCdPro.Cgrus, "Mercs, GeraTubs")
516:                         THIS.CursorQuery("SigCdGpr", "CrSigCdGpr", "Codigos", CrSigCdGrp.Mercs, "MatPrincs, cpqtds")
517: 
518:                         IF EMPTY(crSigCdPac.OpPdCompra) OR ;
519:                            (!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs = 1)
520: 

--- BO Linhas 537 a 547 ---
537:                                     loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
538:                                     loc_nQtBaixado = loc_nQtdLim
539:                                 ENDIF
540: 
541:                                 IF (loc_cClinha + loc_cReff + loc_cCPros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD <> ;
542:                                     TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
543:                                     TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
544:                                    loc_nLnVezes > 1
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros

--- BO Linhas 538 a 548 ---
538:                                     loc_nQtBaixado = loc_nQtdLim
539:                                 ENDIF
540: 
541:                                 IF (loc_cClinha + loc_cReff + loc_cCPros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD <> ;
542:                                     TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
543:                                     TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
544:                                    loc_nLnVezes > 1
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors

--- BO Linhas 541 a 551 ---
541:                                 IF (loc_cClinha + loc_cReff + loc_cCPros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD <> ;
542:                                     TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
543:                                     TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
544:                                    loc_nLnVezes > 1
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs

--- BO Linhas 543 a 553 ---
543:                                     TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
544:                                    loc_nLnVezes > 1
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1

--- BO Linhas 544 a 554 ---
544:                                    loc_nLnVezes > 1
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1
554:                                     loc_cNota    = TmpFinal.Notas

--- BO Linhas 545 a 555 ---
545: 
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1
554:                                     loc_cNota    = TmpFinal.Notas
555:                                     loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

--- BO Linhas 546 a 556 ---
546:                                     loc_cClinha  = TmpFinal.Linhas
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1
554:                                     loc_cNota    = TmpFinal.Notas
555:                                     loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
556:                                     loc_cCidC    = DTOS(par_dGeracao) + ;

--- BO Linhas 547 a 557 ---
547:                                     loc_cCPros   = TmpFinal.CPros
548:                                     loc_cCor     = TmpFinal.CodCors
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1
554:                                     loc_cNota    = TmpFinal.Notas
555:                                     loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
556:                                     loc_cCidC    = DTOS(par_dGeracao) + ;
557:                                                    TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;

--- BO Linhas 549 a 559 ---
549:                                     loc_cTam     = TmpFinal.CodTams
550:                                     loc_cReff    = TmpFinal.Reffs
551:                                     loc_cGrupoD  = TmpFinal.GrupoDs
552:                                     loc_cContaD  = TmpFinal.ContaDs
553:                                     loc_nSeqs    = loc_nSeqs + 1
554:                                     loc_cNota    = TmpFinal.Notas
555:                                     loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
556:                                     loc_cCidC    = DTOS(par_dGeracao) + ;
557:                                                    TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
558:                                                    THIS.this_cSigKey
559: 

--- BO Linhas 556 a 566 ---
556:                                     loc_cCidC    = DTOS(par_dGeracao) + ;
557:                                                    TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
558:                                                    THIS.this_cSigKey
559: 
560:                                     INSERT INTO crSigPdMvf ;
561:                                         (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
562:                                          Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, ;
563:                                          cIdChaves, EmpDopNums, EmpDNps) ;
564:                                     VALUES ;
565:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
566:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, ;

--- BO Linhas 557 a 567 ---
557:                                                    TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
558:                                                    THIS.this_cSigKey
559: 
560:                                     INSERT INTO crSigPdMvf ;
561:                                         (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
562:                                          Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, ;
563:                                          cIdChaves, EmpDopNums, EmpDNps) ;
564:                                     VALUES ;
565:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
566:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, ;
567:                                          crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;

--- BO Linhas 558 a 568 ---
558:                                                    THIS.this_cSigKey
559: 
560:                                     INSERT INTO crSigPdMvf ;
561:                                         (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
562:                                          Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, ;
563:                                          cIdChaves, EmpDopNums, EmpDNps) ;
564:                                     VALUES ;
565:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
566:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, ;
567:                                          crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
568:                                          loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCPros, ;

--- BO Linhas 575 a 585 ---
575:                                     loc_cIds = DTOS(par_dGeracao) + ;
576:                                                TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
577:                                                THIS.this_cSigKey
578: 
579:                                     INSERT INTO crSigCdNec ;
580:                                         (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, ;
581:                                          Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) ;
582:                                     VALUES ;
583:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
584:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, loc_nTPeso, ;
585:                                          crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;

--- BO Linhas 576 a 586 ---
576:                                                TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
577:                                                THIS.this_cSigKey
578: 
579:                                     INSERT INTO crSigCdNec ;
580:                                         (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, ;
581:                                          Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) ;
582:                                     VALUES ;
583:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
584:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, loc_nTPeso, ;
585:                                          crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
586:                                          loc_cGrupoD, loc_cContaD, loc_cIds, ;

--- BO Linhas 583 a 593 ---
583:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
584:                                          DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, loc_nTPeso, ;
585:                                          crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
586:                                          loc_cGrupoD, loc_cContaD, loc_cIds, ;
587:                                          go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
588:                                          TmpFinal.Jobs)
589: 
590:                                     INSERT INTO GrSigCdNei ;
591:                                         (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
592:                                          cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
593:                                     VALUES ;

--- BO Linhas 586 a 596 ---
586:                                          loc_cGrupoD, loc_cContaD, loc_cIds, ;
587:                                          go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
588:                                          TmpFinal.Jobs)
589: 
590:                                     INSERT INTO GrSigCdNei ;
591:                                         (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
592:                                          cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
593:                                     VALUES ;
594:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
595:                                          loc_nNopComp, loc_nNopComp, loc_cLcMat, crSigCdPro.Dpros, ;
596:                                          crSigCdPro.Cunis, ;

--- BO Linhas 587 a 597 ---
587:                                          go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
588:                                          TmpFinal.Jobs)
589: 
590:                                     INSERT INTO GrSigCdNei ;
591:                                         (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
592:                                          cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
593:                                     VALUES ;
594:                                         (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
595:                                          loc_nNopComp, loc_nNopComp, loc_cLcMat, crSigCdPro.Dpros, ;
596:                                          crSigCdPro.Cunis, ;
597:                                          IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;

--- BO Linhas 625 a 635 ---
625:                                 loc_cMoedas  = SPACE(3)
626: 
627:                                 loc_cSQL = "SELECT * " + ;
628:                                            "FROM SigMvItn " + ;
629:                                            "WHERE EmpDopNums = '" + ;
630:                                            ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6) + ;
631:                                            "' AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
632: 
633:                                 IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
634:                                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEestI)")
635:                                     loc_lSucesso = .F.

--- BO Linhas 635 a 645 ---
635:                                     loc_lSucesso = .F.
636:                                 ENDIF
637: 
638:                                 SELECT TempEestI
639:                                 SCAN
640:                                     IF CItens = TmpFinal.Citens
641:                                         loc_nUnits  = TempEestI.Units
642:                                         loc_cMoedas = TempEestI.Moedas
643:                                         EXIT
644:                                     ENDIF
645:                                 ENDSCAN

--- BO Linhas 643 a 653 ---
643:                                         EXIT
644:                                     ENDIF
645:                                 ENDSCAN
646: 
647:                                 INSERT INTO crSigOpPic ;
648:                                     (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
649:                                      Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
650:                                      Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;

--- BO Linhas 644 a 654 ---
644:                                     ENDIF
645:                                 ENDSCAN
646: 
647:                                 INSERT INTO crSigOpPic ;
648:                                     (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
649:                                      Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
650:                                      Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;

--- BO Linhas 645 a 655 ---
645:                                 ENDSCAN
646: 
647:                                 INSERT INTO crSigOpPic ;
648:                                     (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
649:                                      Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
650:                                      Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;

--- BO Linhas 646 a 656 ---
646: 
647:                                 INSERT INTO crSigOpPic ;
648:                                     (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
649:                                      Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
650:                                      Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
656:                                      TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;

--- BO Linhas 649 a 659 ---
649:                                      Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
650:                                      Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
656:                                      TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
657:                                      loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
658:                                      ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
659:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;

--- BO Linhas 651 a 661 ---
651:                                      Dpros, CodTgOps, Citens) ;
652:                                 VALUES ;
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
656:                                      TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
657:                                      loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
658:                                      ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
659:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
660:                                      TmpFinal.Notas, TmpFinal.Emps, ;
661:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;

--- BO Linhas 653 a 663 ---
653:                                     (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
654:                                      TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
656:                                      TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
657:                                      loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
658:                                      ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
659:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
660:                                      TmpFinal.Notas, TmpFinal.Emps, ;
661:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
662:                                      TmpFinal.Dpros, ;
663:                                      IIF(USED("DbParam"), DbParam.CodTgOps, 0), ;

--- BO Linhas 655 a 665 ---
655:                                      TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
656:                                      TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
657:                                      loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
658:                                      ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
659:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
660:                                      TmpFinal.Notas, TmpFinal.Emps, ;
661:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
662:                                      TmpFinal.Dpros, ;
663:                                      IIF(USED("DbParam"), DbParam.CodTgOps, 0), ;
664:                                      TmpFinal.cItens)
665: 

--- BO Linhas 659 a 669 ---
659:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
660:                                      TmpFinal.Notas, TmpFinal.Emps, ;
661:                                      go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
662:                                      TmpFinal.Dpros, ;
663:                                      IIF(USED("DbParam"), DbParam.CodTgOps, 0), ;
664:                                      TmpFinal.cItens)
665: 
666:                                 *-- Processar itens de estoque (TempEestI baixas)
667:                                 SELECT TempEestI
668:                                 loc_nBaixa = loc_nQtBaixado
669:                                 SCAN WHILE loc_nBaixa > 0

--- BO Linhas 665 a 675 ---
665: 
666:                                 *-- Processar itens de estoque (TempEestI baixas)
667:                                 SELECT TempEestI
668:                                 loc_nBaixa = loc_nQtBaixado
669:                                 SCAN WHILE loc_nBaixa > 0
670:                                     loc_pEdn = ALLTRIM(TempEestI.Emps) + ALLTRIM(TempEestI.Dopes) + ;
671:                                                STR(TempEestI.Numes, 6)
672:                                     loc_pItn = TempEestI.Citens
673:                                     loc_pIds = TempEestI.cIdChaves
674: 
675:                                     IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) <> 0

--- BO Linhas 667 a 677 ---
667:                                 SELECT TempEestI
668:                                 loc_nBaixa = loc_nQtBaixado
669:                                 SCAN WHILE loc_nBaixa > 0
670:                                     loc_pEdn = ALLTRIM(TempEestI.Emps) + ALLTRIM(TempEestI.Dopes) + ;
671:                                                STR(TempEestI.Numes, 6)
672:                                     loc_pItn = TempEestI.Citens
673:                                     loc_pIds = TempEestI.cIdChaves
674: 
675:                                     IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) <> 0
676:                                         loc_cSQL = "SELECT * FROM SigMvIts " + ;
677:                                                    "WHERE EmpDopNums = '" + loc_pEdn + ;

--- BO Linhas 673 a 683 ---
673:                                     loc_pIds = TempEestI.cIdChaves
674: 
675:                                     IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) <> 0
676:                                         loc_cSQL = "SELECT * FROM SigMvIts " + ;
677:                                                    "WHERE EmpDopNums = '" + loc_pEdn + ;
678:                                                    "' AND CItens = '" + ALLTRIM(loc_pItn) + "'"
679:                                         IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
680:                                             MsgErro("Favor Reinicializar o Processo!!!", ;
681:                                                     "Falha na Conex" + CHR(227) + "o (TempEsti2)")
682:                                             loc_lSucesso = .F.
683:                                         ENDIF

--- BO Linhas 724 a 734 ---
724:             *-- Consolidar GrSigCdNei -> CrSigCdNei e empenhar TmpEmpH
725:             SELECT GrSigCdNei
726:             GO TOP
727:             SCAN
728:                 SELECT crSigCdNec
729:                 LOCATE FOR Emps = GrSigCdNei.Emps AND ;
730:                             Dopps = GrSigCdNei.Dopps AND ;
731:                             Numps = GrSigCdNei.Nops
732:                 IF !EOF("crSigCdNec")
733:                     SELECT CrSigCdNei
734:                     APPEND BLANK

--- BO Linhas 725 a 735 ---
725:             SELECT GrSigCdNei
726:             GO TOP
727:             SCAN
728:                 SELECT crSigCdNec
729:                 LOCATE FOR Emps = GrSigCdNei.Emps AND ;
730:                             Dopps = GrSigCdNei.Dopps AND ;
731:                             Numps = GrSigCdNei.Nops
732:                 IF !EOF("crSigCdNec")
733:                     SELECT CrSigCdNei
734:                     APPEND BLANK
735:                     GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;

--- BO Linhas 726 a 736 ---
726:             GO TOP
727:             SCAN
728:                 SELECT crSigCdNec
729:                 LOCATE FOR Emps = GrSigCdNei.Emps AND ;
730:                             Dopps = GrSigCdNei.Dopps AND ;
731:                             Numps = GrSigCdNei.Nops
732:                 IF !EOF("crSigCdNec")
733:                     SELECT CrSigCdNei
734:                     APPEND BLANK
735:                     GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
736:                                                    cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves

--- BO Linhas 730 a 740 ---
730:                             Dopps = GrSigCdNei.Dopps AND ;
731:                             Numps = GrSigCdNei.Nops
732:                 IF !EOF("crSigCdNec")
733:                     SELECT CrSigCdNei
734:                     APPEND BLANK
735:                     GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
736:                                                    cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves
737:                 ENDIF
738:                 SELECT GrSigCdNei
739:             ENDSCAN
740: 

--- BO Linhas 731 a 741 ---
731:                             Numps = GrSigCdNei.Nops
732:                 IF !EOF("crSigCdNec")
733:                     SELECT CrSigCdNei
734:                     APPEND BLANK
735:                     GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
736:                                                    cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves
737:                 ENDIF
738:                 SELECT GrSigCdNei
739:             ENDSCAN
740: 
741:             *-- Processar empenhamentos de TmpEmpH -> crSigMvItn/crSigBxEst

--- BO Linhas 745 a 755 ---
745:             SCAN WHILE !EOF("TmpEmpH")
746:                 IF TmpEmpH.Qtds > 0
747:                     loc_cIdc = fUniqueIds()
748: 
749:                     INSERT INTO crSigMvItn ;
750:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
751:                          Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
752:                          cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;

--- BO Linhas 746 a 756 ---
746:                 IF TmpEmpH.Qtds > 0
747:                     loc_cIdc = fUniqueIds()
748: 
749:                     INSERT INTO crSigMvItn ;
750:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
751:                          Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
752:                          cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
756:                          par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;

--- BO Linhas 747 a 757 ---
747:                     loc_cIdc = fUniqueIds()
748: 
749:                     INSERT INTO crSigMvItn ;
750:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
751:                          Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
752:                          cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
756:                          par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
757:                          TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;

--- BO Linhas 750 a 760 ---
750:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
751:                          Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
752:                          cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
756:                          par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
757:                          TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
758:                          SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
759:                          TmpEmpH.Pesos, loc_cIdc, ;
760:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;

--- BO Linhas 752 a 762 ---
752:                          cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
756:                          par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
757:                          TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
758:                          SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
759:                          TmpEmpH.Pesos, loc_cIdc, ;
760:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
761:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
762:                          par_dGeracao, TmpEmpH.cpro2s)

--- BO Linhas 753 a 763 ---
753:                     VALUES ;
754:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
755:                          (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
756:                          par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
757:                          TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
758:                          SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
759:                          TmpEmpH.Pesos, loc_cIdc, ;
760:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
761:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
762:                          par_dGeracao, TmpEmpH.cpro2s)
763:                 ENDIF

--- BO Linhas 757 a 767 ---
757:                          TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
758:                          SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
759:                          TmpEmpH.Pesos, loc_cIdc, ;
760:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
761:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
762:                          par_dGeracao, TmpEmpH.cpro2s)
763:                 ENDIF
764:             ENDSCAN
765: 
766:             *-- Processar pedras de SelPedra -> crSigMvIts
767:             SELECT SelPedra

--- BO Linhas 769 a 779 ---
769:             SCAN WHILE !EOF("SelPedra")
770:                 IF !EMPTY(SelPedra.Cpros) AND SelPedra.Qtds > 0
771:                     loc_cIdc = fUniqueIds()
772: 
773:                     INSERT INTO crSigMvIts ;
774:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
775:                          Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, ;
776:                          DtGeras, cpro2s) ;
777:                     VALUES ;
778:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, par_nNump, ;
779:                          par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;

--- BO Linhas 770 a 780 ---
770:                 IF !EMPTY(SelPedra.Cpros) AND SelPedra.Qtds > 0
771:                     loc_cIdc = fUniqueIds()
772: 
773:                     INSERT INTO crSigMvIts ;
774:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
775:                          Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, ;
776:                          DtGeras, cpro2s) ;
777:                     VALUES ;
778:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, par_nNump, ;
779:                          par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;
780:                          gc_4c_UsuarioLogado, SelPedra.Qtds, SelPedra.Cpros, ;

--- BO Linhas 771 a 781 ---
771:                     loc_cIdc = fUniqueIds()
772: 
773:                     INSERT INTO crSigMvIts ;
774:                         (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
775:                          Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, ;
776:                          DtGeras, cpro2s) ;
777:                     VALUES ;
778:                         (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, par_nNump, ;
779:                          par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;
780:                          gc_4c_UsuarioLogado, SelPedra.Qtds, SelPedra.Cpros, ;
781:                          SPACE(10), SPACE(10), 0, loc_cIdc, ;

--- BO Linhas 779 a 789 ---
779:                          par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;
780:                          gc_4c_UsuarioLogado, SelPedra.Qtds, SelPedra.Cpros, ;
781:                          SPACE(10), SPACE(10), 0, loc_cIdc, ;
782:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
783:                          go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
784:                          par_dGeracao, SelPedra.Cpro2s)
785:                 ENDIF
786:             ENDSCAN
787: 
788:             *-- Executar historico
789:             THIS.GravaHistorico()

--- BO Linhas 817 a 827 ---
817:             IF USED("crSigOpPic") AND RECCOUNT("crSigOpPic") > 0
818:                 SELECT crSigOpPic
819:                 GO TOP
820:                 SCAN
821:                     loc_cSQL = "INSERT INTO SigOpPic " + ;
822:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;

--- BO Linhas 818 a 828 ---
818:                 SELECT crSigOpPic
819:                 GO TOP
820:                 SCAN
821:                     loc_cSQL = "INSERT INTO SigOpPic " + ;
822:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;

--- BO Linhas 819 a 829 ---
819:                 GO TOP
820:                 SCAN
821:                     loc_cSQL = "INSERT INTO SigOpPic " + ;
822:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;

--- BO Linhas 820 a 830 ---
820:                 SCAN
821:                     loc_cSQL = "INSERT INTO SigOpPic " + ;
822:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;

--- BO Linhas 822 a 832 ---
822:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
831:                                EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
832:                                FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;

--- BO Linhas 823 a 833 ---
823:                                "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
831:                                EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
832:                                FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
833:                                FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;

--- BO Linhas 824 a 834 ---
824:                                "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
831:                                EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
832:                                FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
833:                                FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
834:                                FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;

--- BO Linhas 825 a 835 ---
825:                                "Dpros, CodTgOps, Citens) " + ;
826:                                "VALUES (" + ;
827:                                EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
828:                                EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
831:                                EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
832:                                FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
833:                                FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
834:                                FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
835:                                EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;

--- BO Linhas 829 a 839 ---
829:                                FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
830:                                FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
831:                                EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
832:                                FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
833:                                FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
834:                                FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
835:                                EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
836:                                FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
837:                                EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
838:                                FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
839:                                EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;

--- BO Linhas 833 a 843 ---
833:                                FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
834:                                FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
835:                                EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
836:                                FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
837:                                EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
838:                                FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
839:                                EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;
840:                                EscaparSQL(LEFT(crSigOpPic.CodTams, 2)) + ", " + ;
841:                                FormatarNumeroSQL(crSigOpPic.Pesos, 3) + ", " + ;
842:                                FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
843:                                FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;

--- BO Linhas 834 a 844 ---
834:                                FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
835:                                EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
836:                                FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
837:                                EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
838:                                FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
839:                                EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;
840:                                EscaparSQL(LEFT(crSigOpPic.CodTams, 2)) + ", " + ;
841:                                FormatarNumeroSQL(crSigOpPic.Pesos, 3) + ", " + ;
842:                                FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
843:                                FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
844:                                EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;

--- BO Linhas 835 a 845 ---
835:                                EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
836:                                FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
837:                                EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
838:                                FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
839:                                EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;
840:                                EscaparSQL(LEFT(crSigOpPic.CodTams, 2)) + ", " + ;
841:                                FormatarNumeroSQL(crSigOpPic.Pesos, 3) + ", " + ;
842:                                FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
843:                                FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
844:                                EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;
845:                                EscaparSQL(LEFT(crSigOpPic.cIdChaves, 36)) + ", " + ;

--- BO Linhas 842 a 852 ---
842:                                FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
843:                                FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
844:                                EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;
845:                                EscaparSQL(LEFT(crSigOpPic.cIdChaves, 36)) + ", " + ;
846:                                EscaparSQL(LEFT(crSigOpPic.EmpDopNums, 29)) + ", " + ;
847:                                EscaparSQL(LEFT(crSigOpPic.EmpDNps, 33)) + ", " + ;
848:                                EscaparSQL(LEFT(crSigOpPic.Notas, 6)) + ", " + ;
849:                                EscaparSQL(LEFT(crSigOpPic.Empds, 3)) + ", " + ;
850:                                EscaparSQL(LEFT(crSigOpPic.EmpDopNops, 33)) + ", " + ;
851:                                EscaparSQL(LEFT(crSigOpPic.Dpros, 60)) + ", " + ;
852:                                FormatarNumeroSQL(crSigOpPic.CodTgOps, 0) + ", " + ;

--- BO Linhas 843 a 853 ---
843:                                FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
844:                                EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;
845:                                EscaparSQL(LEFT(crSigOpPic.cIdChaves, 36)) + ", " + ;
846:                                EscaparSQL(LEFT(crSigOpPic.EmpDopNums, 29)) + ", " + ;
847:                                EscaparSQL(LEFT(crSigOpPic.EmpDNps, 33)) + ", " + ;
848:                                EscaparSQL(LEFT(crSigOpPic.Notas, 6)) + ", " + ;
849:                                EscaparSQL(LEFT(crSigOpPic.Empds, 3)) + ", " + ;
850:                                EscaparSQL(LEFT(crSigOpPic.EmpDopNops, 33)) + ", " + ;
851:                                EscaparSQL(LEFT(crSigOpPic.Dpros, 60)) + ", " + ;
852:                                FormatarNumeroSQL(crSigOpPic.CodTgOps, 0) + ", " + ;
853:                                EscaparSQL(LEFT(crSigOpPic.Citens, 20)) + ")"

--- BO Linhas 848 a 858 ---
848:                                EscaparSQL(LEFT(crSigOpPic.Notas, 6)) + ", " + ;
849:                                EscaparSQL(LEFT(crSigOpPic.Empds, 3)) + ", " + ;
850:                                EscaparSQL(LEFT(crSigOpPic.EmpDopNops, 33)) + ", " + ;
851:                                EscaparSQL(LEFT(crSigOpPic.Dpros, 60)) + ", " + ;
852:                                FormatarNumeroSQL(crSigOpPic.CodTgOps, 0) + ", " + ;
853:                                EscaparSQL(LEFT(crSigOpPic.Citens, 20)) + ")"
854: 
855:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
856:                         MsgErro("Erro ao gravar ordem de produ" + CHR(231) + CHR(227) + "o no servidor", "Erro")
857:                         loc_lSucesso = .F.
858:                     ENDIF

--- BO Linhas 863 a 873 ---
863:             IF USED("crSigMvHst") AND RECCOUNT("crSigMvHst") > 0
864:                 SELECT crSigMvHst
865:                 GO TOP
866:                 SCAN
867:                     loc_cSQL = "INSERT INTO SigMvHst " + ;
868:                                "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
869:                                "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers, Linhas, " + ;
870:                                "Reffs, Notas, GrupoDs, ContaDs, Jobs, cItens) " + ;
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;

--- BO Linhas 864 a 874 ---
864:                 SELECT crSigMvHst
865:                 GO TOP
866:                 SCAN
867:                     loc_cSQL = "INSERT INTO SigMvHst " + ;
868:                                "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
869:                                "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers, Linhas, " + ;
870:                                "Reffs, Notas, GrupoDs, ContaDs, Jobs, cItens) " + ;
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;

--- BO Linhas 865 a 875 ---
865:                 GO TOP
866:                 SCAN
867:                     loc_cSQL = "INSERT INTO SigMvHst " + ;
868:                                "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
869:                                "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers, Linhas, " + ;
870:                                "Reffs, Notas, GrupoDs, ContaDs, Jobs, cItens) " + ;
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;

--- BO Linhas 867 a 877 ---
867:                     loc_cSQL = "INSERT INTO SigMvHst " + ;
868:                                "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
869:                                "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers, Linhas, " + ;
870:                                "Reffs, Notas, GrupoDs, ContaDs, Jobs, cItens) " + ;
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;

--- BO Linhas 870 a 880 ---
870:                                "Reffs, Notas, GrupoDs, ContaDs, Jobs, cItens) " + ;
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
878:                                EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
879:                                EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
880:                                EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;

--- BO Linhas 871 a 881 ---
871:                                "VALUES (" + ;
872:                                EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
878:                                EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
879:                                EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
880:                                EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
881:                                EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;

--- BO Linhas 873 a 883 ---
873:                                EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
878:                                EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
879:                                EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
880:                                EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
881:                                EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;
882:                                FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
883:                                EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;

--- BO Linhas 874 a 884 ---
874:                                FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
878:                                EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
879:                                EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
880:                                EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
881:                                EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;
882:                                FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
883:                                EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
884:                                FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;

--- BO Linhas 875 a 885 ---
875:                                FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
876:                                EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
877:                                EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
878:                                EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
879:                                EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
880:                                EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
881:                                EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;
882:                                FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
883:                                EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
884:                                FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
885:                                FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;

--- BO Linhas 882 a 892 ---
882:                                FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
883:                                EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
884:                                FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
885:                                FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
886:                                EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ", " + ;
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;

--- BO Linhas 883 a 893 ---
883:                                EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
884:                                FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
885:                                FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
886:                                EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ", " + ;
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"

--- BO Linhas 884 a 894 ---
884:                                FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
885:                                FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
886:                                EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ", " + ;
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"
894: 

--- BO Linhas 885 a 895 ---
885:                                FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
886:                                EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ", " + ;
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"
894: 
895:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1

--- BO Linhas 886 a 896 ---
886:                                EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ", " + ;
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"
894: 
895:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
896:                         MsgErro("Erro ao gravar hist" + CHR(243) + "rico de movimenta" + CHR(231) + CHR(227) + "o", "Erro")

--- BO Linhas 887 a 897 ---
887:                                EscaparSQL(LEFT(crSigMvHst.Linhas, 10)) + ", " + ;
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"
894: 
895:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
896:                         MsgErro("Erro ao gravar hist" + CHR(243) + "rico de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
897:                         loc_lSucesso = .F.

--- BO Linhas 888 a 898 ---
888:                                EscaparSQL(LEFT(crSigMvHst.Reffs, 15)) + ", " + ;
889:                                EscaparSQL(LEFT(crSigMvHst.Notas, 6)) + ", " + ;
890:                                EscaparSQL(LEFT(crSigMvHst.GrupoDs, 10)) + ", " + ;
891:                                EscaparSQL(LEFT(crSigMvHst.ContaDs, 10)) + ", " + ;
892:                                EscaparSQL(LEFT(crSigMvHst.Jobs, 20)) + ", " + ;
893:                                EscaparSQL(LEFT(crSigMvHst.cItens, 20)) + ")"
894: 
895:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
896:                         MsgErro("Erro ao gravar hist" + CHR(243) + "rico de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
897:                         loc_lSucesso = .F.
898:                     ENDIF

--- BO Linhas 903 a 913 ---
903:             IF USED("CrSigCdNei") AND RECCOUNT("CrSigCdNei") > 0
904:                 SELECT CrSigCdNei
905:                 GO TOP
906:                 SCAN
907:                     loc_cSQL = "INSERT INTO SigCdNei " + ;
908:                                "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;

--- BO Linhas 904 a 914 ---
904:                 SELECT CrSigCdNei
905:                 GO TOP
906:                 SCAN
907:                     loc_cSQL = "INSERT INTO SigCdNei " + ;
908:                                "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
914:                                FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;

--- BO Linhas 906 a 916 ---
906:                 SCAN
907:                     loc_cSQL = "INSERT INTO SigCdNei " + ;
908:                                "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
914:                                FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
915:                                FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
916:                                EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;

--- BO Linhas 907 a 917 ---
907:                     loc_cSQL = "INSERT INTO SigCdNei " + ;
908:                                "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
914:                                FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
915:                                FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
916:                                EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;
917:                                EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;

--- BO Linhas 908 a 918 ---
908:                                "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
914:                                FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
915:                                FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
916:                                EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;
917:                                EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;
918:                                EscaparSQL(LEFT(CrSigCdNei.cUnis, 6)) + ", " + ;

--- BO Linhas 909 a 919 ---
909:                                "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
910:                                "VALUES (" + ;
911:                                EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
912:                                EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
913:                                FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
914:                                FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
915:                                FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
916:                                EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;
917:                                EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;
918:                                EscaparSQL(LEFT(CrSigCdNei.cUnis, 6)) + ", " + ;
919:                                FormatarNumeroSQL(CrSigCdNei.Pesos, 3) + ", " + ;

--- BO Linhas 917 a 927 ---
917:                                EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;
918:                                EscaparSQL(LEFT(CrSigCdNei.cUnis, 6)) + ", " + ;
919:                                FormatarNumeroSQL(CrSigCdNei.Pesos, 3) + ", " + ;
920:                                FormatarNumeroSQL(CrSigCdNei.Qtds, 3) + ", " + ;
921:                                EscaparSQL(LEFT(CrSigCdNei.TpOps, 5)) + ", " + ;
922:                                EscaparSQL(LEFT(CrSigCdNei.EmpDNps, 33)) + ", " + ;
923:                                EscaparSQL(LEFT(CrSigCdNei.cIdChaves, 36)) + ")"
924: 
925:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
926:                         MsgErro("Erro ao gravar necessidade de material", "Erro")
927:                         loc_lSucesso = .F.

--- BO Linhas 933 a 943 ---
933:             IF USED("crSigCdNec") AND RECCOUNT("crSigCdNec") > 0
934:                 SELECT crSigCdNec
935:                 GO TOP
936:                 SCAN
937:                     loc_cSQL = "INSERT INTO SigCdNec " + ;
938:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
939:                                "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;

--- BO Linhas 934 a 944 ---
934:                 SELECT crSigCdNec
935:                 GO TOP
936:                 SCAN
937:                     loc_cSQL = "INSERT INTO SigCdNec " + ;
938:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
939:                                "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;

--- BO Linhas 936 a 946 ---
936:                 SCAN
937:                     loc_cSQL = "INSERT INTO SigCdNec " + ;
938:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
939:                                "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;

--- BO Linhas 937 a 947 ---
937:                     loc_cSQL = "INSERT INTO SigCdNec " + ;
938:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
939:                                "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;

--- BO Linhas 938 a 948 ---
938:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
939:                                "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;

--- BO Linhas 940 a 950 ---
940:                                "VALUES (" + ;
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;

--- BO Linhas 941 a 951 ---
941:                                EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
942:                                EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
943:                                FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
944:                                "GETDATE(), " + ;
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
951:                                EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;

--- BO Linhas 945 a 955 ---
945:                                FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
951:                                EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
952:                                EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
953:                                EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
954:                                EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"
955: 

--- BO Linhas 946 a 956 ---
946:                                EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
947:                                FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
951:                                EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
952:                                EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
953:                                EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
954:                                EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"
955: 
956:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1

--- BO Linhas 948 a 958 ---
948:                                EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
951:                                EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
952:                                EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
953:                                EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
954:                                EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"
955: 
956:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
957:                         MsgErro("Erro ao gravar necessidade de empenho", "Erro")
958:                         loc_lSucesso = .F.

--- BO Linhas 949 a 959 ---
949:                                EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
950:                                EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
951:                                EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
952:                                EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
953:                                EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
954:                                EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"
955: 
956:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
957:                         MsgErro("Erro ao gravar necessidade de empenho", "Erro")
958:                         loc_lSucesso = .F.
959:                     ENDIF

--- BO Linhas 964 a 974 ---
964:             IF USED("crSigPdMvf") AND RECCOUNT("crSigPdMvf") > 0
965:                 SELECT crSigPdMvf
966:                 GO TOP
967:                 SCAN
968:                     loc_cSQL = "INSERT INTO SigPdMvf " + ;
969:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;

--- BO Linhas 965 a 975 ---
965:                 SELECT crSigPdMvf
966:                 GO TOP
967:                 SCAN
968:                     loc_cSQL = "INSERT INTO SigPdMvf " + ;
969:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;

--- BO Linhas 966 a 976 ---
966:                 GO TOP
967:                 SCAN
968:                     loc_cSQL = "INSERT INTO SigPdMvf " + ;
969:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;

--- BO Linhas 968 a 978 ---
968:                     loc_cSQL = "INSERT INTO SigPdMvf " + ;
969:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;

--- BO Linhas 969 a 979 ---
969:                                "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;

--- BO Linhas 970 a 980 ---
970:                                "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
971:                                "cIdChaves, EmpDopNums, EmpDNps) " + ;
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;

--- BO Linhas 972 a 982 ---
972:                                "VALUES (" + ;
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
981:                                EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
982:                                EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;

--- BO Linhas 973 a 983 ---
973:                                EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
974:                                EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
975:                                FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
981:                                EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
982:                                EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
983:                                FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;

--- BO Linhas 976 a 986 ---
976:                                "GETDATE(), " + ;
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
981:                                EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
982:                                EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
983:                                FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;
984:                                EscaparSQL(LEFT(crSigPdMvf.CodPds, 14)) + ", " + ;
985:                                EscaparSQL(LEFT(crSigPdMvf.Unids, 6)) + ", " + ;
986:                                FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;

--- BO Linhas 977 a 987 ---
977:                                FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
981:                                EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
982:                                EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
983:                                FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;
984:                                EscaparSQL(LEFT(crSigPdMvf.CodPds, 14)) + ", " + ;
985:                                EscaparSQL(LEFT(crSigPdMvf.Unids, 6)) + ", " + ;
986:                                FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;
987:                                FormatarNumeroSQL(crSigPdMvf.Qtds, 3) + ", " + ;

--- BO Linhas 978 a 988 ---
978:                                EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
979:                                EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
980:                                EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
981:                                EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
982:                                EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
983:                                FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;
984:                                EscaparSQL(LEFT(crSigPdMvf.CodPds, 14)) + ", " + ;
985:                                EscaparSQL(LEFT(crSigPdMvf.Unids, 6)) + ", " + ;
986:                                FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;
987:                                FormatarNumeroSQL(crSigPdMvf.Qtds, 3) + ", " + ;
988:                                FormatarNumeroSQL(crSigPdMvf.Ordems, 0) + ", " + ;

--- BO Linhas 986 a 996 ---
986:                                FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;
987:                                FormatarNumeroSQL(crSigPdMvf.Qtds, 3) + ", " + ;
988:                                FormatarNumeroSQL(crSigPdMvf.Ordems, 0) + ", " + ;
989:                                EscaparSQL(LEFT(crSigPdMvf.cIdChaves, 36)) + ", " + ;
990:                                EscaparSQL(LEFT(crSigPdMvf.EmpDopNums, 29)) + ", " + ;
991:                                EscaparSQL(LEFT(crSigPdMvf.EmpDNps, 33)) + ")"
992: 
993:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
994:                         MsgErro("Erro ao gravar pedido de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
995:                         loc_lSucesso = .F.
996:                     ENDIF

--- BO Linhas 1001 a 1011 ---
1001:             IF USED("crSigMvItn") AND RECCOUNT("crSigMvItn") > 0
1002:                 SELECT crSigMvItn
1003:                 GO TOP
1004:                 SCAN
1005:                     loc_cSQL = "INSERT INTO SigMvItn " + ;
1006:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;

--- BO Linhas 1002 a 1012 ---
1002:                 SELECT crSigMvItn
1003:                 GO TOP
1004:                 SCAN
1005:                     loc_cSQL = "INSERT INTO SigMvItn " + ;
1006:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;

--- BO Linhas 1003 a 1013 ---
1003:                 GO TOP
1004:                 SCAN
1005:                     loc_cSQL = "INSERT INTO SigMvItn " + ;
1006:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;

--- BO Linhas 1005 a 1015 ---
1005:                     loc_cSQL = "INSERT INTO SigMvItn " + ;
1006:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;

--- BO Linhas 1006 a 1016 ---
1006:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;

--- BO Linhas 1007 a 1017 ---
1007:                                "Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, " + ;
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;

--- BO Linhas 1008 a 1018 ---
1008:                                "cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) " + ;
1009:                                "VALUES (" + ;
1010:                                EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;

--- BO Linhas 1011 a 1021 ---
1011:                                EscaparSQL(LEFT(crSigMvItn.Dopps, 20)) + ", " + ;
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;

--- BO Linhas 1012 a 1022 ---
1012:                                FormatarNumeroSQL(crSigMvItn.Numps, 0) + ", " + ;
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;

--- BO Linhas 1013 a 1023 ---
1013:                                FormatarNumeroSQL(crSigMvItn.Nops, 0) + ", " + ;
1014:                                EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
1015:                                FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;

--- BO Linhas 1016 a 1026 ---
1016:                                FormatarDataSQL(crSigMvItn.Datas) + ", " + ;
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;

--- BO Linhas 1017 a 1027 ---
1017:                                FormatarDataSQL(crSigMvItn.Dataps) + ", " + ;
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;

--- BO Linhas 1018 a 1028 ---
1018:                                EscaparSQL(LEFT(crSigMvItn.Usuars, 20)) + ", " + ;
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;

--- BO Linhas 1019 a 1029 ---
1019:                                FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
1029:                                EscaparSQL(LEFT(crSigMvItn.EmpDNps, 33)) + ", " + ;

--- BO Linhas 1020 a 1030 ---
1020:                                EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
1021:                                EscaparSQL(LEFT(crSigMvItn.cGrus, 3)) + ", " + ;
1022:                                EscaparSQL(LEFT(crSigMvItn.CodCors, 4)) + ", " + ;
1023:                                EscaparSQL(LEFT(crSigMvItn.CodTams, 2)) + ", " + ;
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
1029:                                EscaparSQL(LEFT(crSigMvItn.EmpDNps, 33)) + ", " + ;
1030:                                FormatarDataSQL(crSigMvItn.DtGeras) + ", " + ;

--- BO Linhas 1024 a 1034 ---
1024:                                EscaparSQL(LEFT(crSigMvItn.Grupos, 10)) + ", " + ;
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
1029:                                EscaparSQL(LEFT(crSigMvItn.EmpDNps, 33)) + ", " + ;
1030:                                FormatarDataSQL(crSigMvItn.DtGeras) + ", " + ;
1031:                                EscaparSQL(LEFT(crSigMvItn.cpro2s, 10)) + ")"
1032: 
1033:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1034:                         MsgErro("Erro ao gravar empenhamento de material", "Erro")

--- BO Linhas 1025 a 1035 ---
1025:                                EscaparSQL(LEFT(crSigMvItn.Contas, 10)) + ", " + ;
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
1029:                                EscaparSQL(LEFT(crSigMvItn.EmpDNps, 33)) + ", " + ;
1030:                                FormatarDataSQL(crSigMvItn.DtGeras) + ", " + ;
1031:                                EscaparSQL(LEFT(crSigMvItn.cpro2s, 10)) + ")"
1032: 
1033:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1034:                         MsgErro("Erro ao gravar empenhamento de material", "Erro")
1035:                         loc_lSucesso = .F.

--- BO Linhas 1026 a 1036 ---
1026:                                FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
1027:                                EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
1028:                                EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
1029:                                EscaparSQL(LEFT(crSigMvItn.EmpDNps, 33)) + ", " + ;
1030:                                FormatarDataSQL(crSigMvItn.DtGeras) + ", " + ;
1031:                                EscaparSQL(LEFT(crSigMvItn.cpro2s, 10)) + ")"
1032: 
1033:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1034:                         MsgErro("Erro ao gravar empenhamento de material", "Erro")
1035:                         loc_lSucesso = .F.
1036:                     ENDIF

--- BO Linhas 1041 a 1051 ---
1041:             IF USED("crSigMvIts") AND RECCOUNT("crSigMvIts") > 0
1042:                 SELECT crSigMvIts
1043:                 GO TOP
1044:                 SCAN
1045:                     loc_cSQL = "INSERT INTO SigMvIts " + ;
1046:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;

--- BO Linhas 1042 a 1052 ---
1042:                 SELECT crSigMvIts
1043:                 GO TOP
1044:                 SCAN
1045:                     loc_cSQL = "INSERT INTO SigMvIts " + ;
1046:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;

--- BO Linhas 1043 a 1053 ---
1043:                 GO TOP
1044:                 SCAN
1045:                     loc_cSQL = "INSERT INTO SigMvIts " + ;
1046:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;

--- BO Linhas 1045 a 1055 ---
1045:                     loc_cSQL = "INSERT INTO SigMvIts " + ;
1046:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;

--- BO Linhas 1046 a 1056 ---
1046:                                "(Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, " + ;
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;

--- BO Linhas 1047 a 1057 ---
1047:                                "Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, " + ;
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;

--- BO Linhas 1048 a 1058 ---
1048:                                "DtGeras, cpro2s) " + ;
1049:                                "VALUES (" + ;
1050:                                EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;

--- BO Linhas 1051 a 1061 ---
1051:                                EscaparSQL(LEFT(crSigMvIts.Dopps, 20)) + ", " + ;
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;
1059:                                FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
1060:                                EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;

--- BO Linhas 1052 a 1062 ---
1052:                                FormatarNumeroSQL(crSigMvIts.Numps, 0) + ", " + ;
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;
1059:                                FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
1060:                                EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;

--- BO Linhas 1053 a 1063 ---
1053:                                FormatarNumeroSQL(crSigMvIts.Nops, 0) + ", " + ;
1054:                                EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
1055:                                FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;
1059:                                FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
1060:                                EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;

--- BO Linhas 1056 a 1066 ---
1056:                                FormatarDataSQL(crSigMvIts.Datas) + ", " + ;
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;
1059:                                FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
1060:                                EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
1064:                                EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
1065:                                EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ", " + ;
1066:                                EscaparSQL(LEFT(crSigMvIts.EmpDNps, 33)) + ", " + ;

--- BO Linhas 1057 a 1067 ---
1057:                                FormatarDataSQL(crSigMvIts.Dataps) + ", " + ;
1058:                                EscaparSQL(LEFT(crSigMvIts.Usuars, 20)) + ", " + ;
1059:                                FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
1060:                                EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
1064:                                EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
1065:                                EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ", " + ;
1066:                                EscaparSQL(LEFT(crSigMvIts.EmpDNps, 33)) + ", " + ;
1067:                                FormatarDataSQL(crSigMvIts.DtGeras) + ", " + ;

--- BO Linhas 1061 a 1071 ---
1061:                                EscaparSQL(LEFT(crSigMvIts.Grupos, 10)) + ", " + ;
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
1064:                                EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
1065:                                EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ", " + ;
1066:                                EscaparSQL(LEFT(crSigMvIts.EmpDNps, 33)) + ", " + ;
1067:                                FormatarDataSQL(crSigMvIts.DtGeras) + ", " + ;
1068:                                EscaparSQL(LEFT(crSigMvIts.cpro2s, 10)) + ")"
1069: 
1070:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1071:                         MsgErro("Erro ao gravar subitem de movimenta" + CHR(231) + CHR(227) + "o", "Erro")

--- BO Linhas 1062 a 1072 ---
1062:                                EscaparSQL(LEFT(crSigMvIts.Contas, 10)) + ", " + ;
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
1064:                                EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
1065:                                EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ", " + ;
1066:                                EscaparSQL(LEFT(crSigMvIts.EmpDNps, 33)) + ", " + ;
1067:                                FormatarDataSQL(crSigMvIts.DtGeras) + ", " + ;
1068:                                EscaparSQL(LEFT(crSigMvIts.cpro2s, 10)) + ")"
1069: 
1070:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1071:                         MsgErro("Erro ao gravar subitem de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
1072:                         loc_lSucesso = .F.

--- BO Linhas 1063 a 1073 ---
1063:                                FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
1064:                                EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
1065:                                EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ", " + ;
1066:                                EscaparSQL(LEFT(crSigMvIts.EmpDNps, 33)) + ", " + ;
1067:                                FormatarDataSQL(crSigMvIts.DtGeras) + ", " + ;
1068:                                EscaparSQL(LEFT(crSigMvIts.cpro2s, 10)) + ")"
1069: 
1070:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
1071:                         MsgErro("Erro ao gravar subitem de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
1072:                         loc_lSucesso = .F.
1073:                     ENDIF

--- BO Linhas 1094 a 1104 ---
1094:         TRY
1095:             IF USED("crImpressao")
1096:                 USE IN crImpressao
1097:             ENDIF
1098: 
1099:             SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
1100:                    Saldo, Estoque, Produzir, ;
1101:                    IIF(EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
1102:             FROM TmpFinal ;
1103:             ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
1104:             INTO CURSOR crImpressao READWRITE

--- BO Linhas 1098 a 1108 ---
1098: 
1099:             SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
1100:                    Saldo, Estoque, Produzir, ;
1101:                    IIF(EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
1102:             FROM TmpFinal ;
1103:             ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
1104:             INTO CURSOR crImpressao READWRITE
1105: 
1106:             SELECT crImpressao
1107:             GO TOP
1108:             IF EOF("crImpressao")

--- BO Linhas 1169 a 1179 ---
1169:                     THIS.this_cSigKey     = TratarNulo(SigKey,     "C")
1170:                 ENDIF
1171:                 IF TYPE(par_cAliasCursor + ".EmphPdr") != "U"
1172:                     THIS.this_nEmphPdr    = TratarNulo(EmphPdr,    "N")
1173:                 ENDIF
1174:                 IF TYPE(par_cAliasCursor + ".Datas") != "U"
1175:                     THIS.this_dData       = TratarNulo(Datas,      "D")
1176:                 ENDIF
1177:                 IF TYPE(par_cAliasCursor + ".Previsao") != "U"
1178:                     THIS.this_dPrevisao   = TratarNulo(Previsao,   "D")
1179:                 ENDIF

--- BO Linhas 1170 a 1180 ---
1170:                 ENDIF
1171:                 IF TYPE(par_cAliasCursor + ".EmphPdr") != "U"
1172:                     THIS.this_nEmphPdr    = TratarNulo(EmphPdr,    "N")
1173:                 ENDIF
1174:                 IF TYPE(par_cAliasCursor + ".Datas") != "U"
1175:                     THIS.this_dData       = TratarNulo(Datas,      "D")
1176:                 ENDIF
1177:                 IF TYPE(par_cAliasCursor + ".Previsao") != "U"
1178:                     THIS.this_dPrevisao   = TratarNulo(Previsao,   "D")
1179:                 ENDIF
1180:                 IF TYPE(par_cAliasCursor + ".Geracao") != "U"

--- BO Linhas 1189 a 1199 ---
1189:         RETURN loc_lSucesso
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     * Inserir - Override de BusinessBase.Inserir()
1194:     * Delega ao metodo Processar() com as datas de previsao e geracao do BO
1195:     * Antes de chamar: preencher this_dPrevisao e this_dGeracao
1196:     *--------------------------------------------------------------------------
1197:     PROCEDURE Inserir()
1198:         LOCAL loc_lSucesso
1199:         loc_lSucesso = .F.

--- BO Linhas 1234 a 1244 ---
1234:         LOCAL loc_cSQL
1235:         loc_cSQL = ""
1236: 
1237:         TRY
1238:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
1239:                        "(Emps, Usuarios, Tabela, Operacao, ChavePrimaria, DataHora) " + ;
1240:                        "VALUES (" + ;
1241:                        EscaparSQL(LEFT(go_4c_Sistema.cCodEmpresa, 3)) + ", " + ;
1242:                        EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20)) + ", " + ;
1243:                        "'SigOpPic', " + ;
1244:                        EscaparSQL(LEFT(par_cOperacao, 1)) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg
- BO: C:\4c\projeto\app\classes\SigPrGlpBO.prg
