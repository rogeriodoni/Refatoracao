CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1681: Coluna 'contas' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.contas)
- [SQL-SCHEMA] Linha ~1681: Coluna 'empos' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.empos)
- [SQL-SCHEMA] Linha ~1681: Coluna 'empos' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.empos)
- [SQL-SCHEMA] Linha ~1681: Coluna 'contas' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.contas)
- [SQL-SCHEMA] Linha ~1681: Coluna 'localizas' NAO EXISTE na tabela 'sigmvesl' (referenciada como A.localizas)
- [SQL-SCHEMA] Linha ~1681: Coluna 'contas' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.contas)
- [SQL-SCHEMA] Linha ~1681: Coluna 'empos' NAO EXISTE na tabela 'sigmvesl' (referenciada como a.empos)
- [SQL-SCHEMA] Linha ~2004: INSERT coluna 'empresa' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2004: INSERT coluna 'chaveprimaria' NAO EXISTE na tabela 'logauditoria'
- [SQL-SCHEMA] Linha ~2004: INSERT coluna 'detalhes' NAO EXISTE na tabela 'logauditoria'


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
 

-- Tabela: sigmvesl
CREATE TABLE [dbo].[sigmvesl](
	[cidchaves] [char](20) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[dtalts] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[estos] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[sqtds] [numeric](11, 3) NOT NULL,
	[spesos] [numeric](14, 3) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigrecntBO.prg):

--- BO Linhas 205 a 215 ---
205:                     THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
206:                     EXIT
207:                 ENDIF
208: 
209:                 *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
210:                 loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
211:                            "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
212:                            "FROM (" + ;
213:                            " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
214:                            " FROM SigOpEtq A " + ;
215:                            " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;

--- BO Linhas 208 a 218 ---
208: 
209:                 *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
210:                 loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
211:                            "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
212:                            "FROM (" + ;
213:                            " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
214:                            " FROM SigOpEtq A " + ;
215:                            " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
216:                            "  ON b.cpros = a.cpros " + ;
217:                            " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
218:                            " AND a.contas NOT IN ('15000100','15000141') " + ;

--- BO Linhas 212 a 222 ---
212:                            "FROM (" + ;
213:                            " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
214:                            " FROM SigOpEtq A " + ;
215:                            " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
216:                            "  ON b.cpros = a.cpros " + ;
217:                            " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
218:                            " AND a.contas NOT IN ('15000100','15000141') " + ;
219:                            " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
220:                            " UNION ALL " + ;
221:                            " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
222:                            " FROM SigMvesl a, SigCdpro b " + ;

--- BO Linhas 213 a 223 ---
213:                            " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
214:                            " FROM SigOpEtq A " + ;
215:                            " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
216:                            "  ON b.cpros = a.cpros " + ;
217:                            " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
218:                            " AND a.contas NOT IN ('15000100','15000141') " + ;
219:                            " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
220:                            " UNION ALL " + ;
221:                            " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
222:                            " FROM SigMvesl a, SigCdpro b " + ;
223:                            " WHERE a.CPros = b.Cpros " + ;

--- BO Linhas 214 a 224 ---
214:                            " FROM SigOpEtq A " + ;
215:                            " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
216:                            "  ON b.cpros = a.cpros " + ;
217:                            " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
218:                            " AND a.contas NOT IN ('15000100','15000141') " + ;
219:                            " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
220:                            " UNION ALL " + ;
221:                            " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
222:                            " FROM SigMvesl a, SigCdpro b " + ;
223:                            " WHERE a.CPros = b.Cpros " + ;
224:                            " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;

--- BO Linhas 222 a 232 ---
222:                            " FROM SigMvesl a, SigCdpro b " + ;
223:                            " WHERE a.CPros = b.Cpros " + ;
224:                            " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
225:                            " AND a.estos NOT IN ('15000100','15000141') " + ;
226:                            " AND a.cpros + a.locals NOT IN " + ;
227:                            "  (SELECT cpros + localizas FROM sigopetq) " + ;
228:                            " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
229:                            ") a WHERE Grupos <> SPACE(10)"
230: 
231:                 IF !EMPTY(loc_lcLocalizacao)
232:                     loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;

--- BO Linhas 227 a 237 ---
227:                            "  (SELECT cpros + localizas FROM sigopetq) " + ;
228:                            " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
229:                            ") a WHERE Grupos <> SPACE(10)"
230: 
231:                 IF !EMPTY(loc_lcLocalizacao)
232:                     loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
233:                                EscaparSQL(loc_lcLocalizacao + "%")
234:                 ENDIF
235: 
236:                 loc_cSQL = loc_cSQL + ;
237:                            " GROUP BY localizas, grupos, contas, empos" + ;

--- BO Linhas 232 a 242 ---
232:                     loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
233:                                EscaparSQL(loc_lcLocalizacao + "%")
234:                 ENDIF
235: 
236:                 loc_cSQL = loc_cSQL + ;
237:                            " GROUP BY localizas, grupos, contas, empos" + ;
238:                            " HAVING SUM(qtde) <> 0"
239: 
240:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
241:                 IF loc_nResult < 1
242:                     THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;

--- BO Linhas 246 a 256 ---
246: 
247:                 *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
248:                 SELECT crTmpLocal
249:                 GO TOP
250:                 SCAN
251:                     IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
252:                         DELETE
253:                         LOOP
254:                     ENDIF
255:                     SELECT crTmpLocal
256:                 ENDSCAN

--- BO Linhas 253 a 263 ---
253:                         LOOP
254:                     ENDIF
255:                     SELECT crTmpLocal
256:                 ENDSCAN
257: 
258:                 SELECT Localizas, SUM(Qtde) AS Qtds ;
259:                     FROM crTmpLocal WHERE 0=0 ;
260:                     GROUP BY Localizas ;
261:                     INTO CURSOR csTotLocal READWRITE
262: 
263:                 IF RECCOUNT("csTotLocal") = 0

--- BO Linhas 255 a 265 ---
255:                     SELECT crTmpLocal
256:                 ENDSCAN
257: 
258:                 SELECT Localizas, SUM(Qtde) AS Qtds ;
259:                     FROM crTmpLocal WHERE 0=0 ;
260:                     GROUP BY Localizas ;
261:                     INTO CURSOR csTotLocal READWRITE
262: 
263:                 IF RECCOUNT("csTotLocal") = 0
264:                     THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
265:                         "localiza" + CHR(231) + CHR(245) + "es contadas."

--- BO Linhas 265 a 275 ---
265:                         "localiza" + CHR(231) + CHR(245) + "es contadas."
266:                     EXIT
267:                 ENDIF
268: 
269:                 SELECT csTotLocal
270:                 INDEX ON Localizas TAG Locals
271:                 GO TOP
272: 
273:                 *-- Gera cursor de resultado conforme OptLocal
274:                 DO CASE
275:                 CASE loc_lnLocal = 1

--- BO Linhas 275 a 285 ---
275:                 CASE loc_lnLocal = 1
276:                     SELECT DISTINCT a.DataS, ;
277:                         NVL(a.Locals, "") AS Locals, ;
278:                         NVL(a.Qtds, 0) AS Qtds, ;
279:                         NVL(a.vends, "") AS vends, ;
280:                         NVL(b.empos, "") AS empos, ;
281:                         NVL(b.Localizas, "") AS Localizas, ;
282:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
283:                         FROM crTmpLocal b ;
284:                         FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
285:                         INTO CURSOR csRel READWRITE

--- BO Linhas 276 a 286 ---
276:                     SELECT DISTINCT a.DataS, ;
277:                         NVL(a.Locals, "") AS Locals, ;
278:                         NVL(a.Qtds, 0) AS Qtds, ;
279:                         NVL(a.vends, "") AS vends, ;
280:                         NVL(b.empos, "") AS empos, ;
281:                         NVL(b.Localizas, "") AS Localizas, ;
282:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
283:                         FROM crTmpLocal b ;
284:                         FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
285:                         INTO CURSOR csRel READWRITE
286:                 CASE loc_lnLocal = 2

--- BO Linhas 279 a 289 ---
279:                         NVL(a.vends, "") AS vends, ;
280:                         NVL(b.empos, "") AS empos, ;
281:                         NVL(b.Localizas, "") AS Localizas, ;
282:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
283:                         FROM crTmpLocal b ;
284:                         FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
285:                         INTO CURSOR csRel READWRITE
286:                 CASE loc_lnLocal = 2
287:                     SELECT DISTINCT a.DataS, ;
288:                         NVL(a.Locals, "") AS Locals, ;
289:                         NVL(a.Qtds, 0) AS Qtds, ;

--- BO Linhas 286 a 296 ---
286:                 CASE loc_lnLocal = 2
287:                     SELECT DISTINCT a.DataS, ;
288:                         NVL(a.Locals, "") AS Locals, ;
289:                         NVL(a.Qtds, 0) AS Qtds, ;
290:                         NVL(a.vends, "") AS vends, ;
291:                         NVL(b.empos, "") AS empos, ;
292:                         NVL(b.Localizas, "") AS Localizas, ;
293:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
294:                         FROM crSigCdCnl a ;
295:                         LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
296:                         WHERE NVL(a.Qtds, 0) <> 0 ;

--- BO Linhas 287 a 297 ---
287:                     SELECT DISTINCT a.DataS, ;
288:                         NVL(a.Locals, "") AS Locals, ;
289:                         NVL(a.Qtds, 0) AS Qtds, ;
290:                         NVL(a.vends, "") AS vends, ;
291:                         NVL(b.empos, "") AS empos, ;
292:                         NVL(b.Localizas, "") AS Localizas, ;
293:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
294:                         FROM crSigCdCnl a ;
295:                         LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
296:                         WHERE NVL(a.Qtds, 0) <> 0 ;
297:                         INTO CURSOR csRel READWRITE

--- BO Linhas 290 a 300 ---
290:                         NVL(a.vends, "") AS vends, ;
291:                         NVL(b.empos, "") AS empos, ;
292:                         NVL(b.Localizas, "") AS Localizas, ;
293:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
294:                         FROM crSigCdCnl a ;
295:                         LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
296:                         WHERE NVL(a.Qtds, 0) <> 0 ;
297:                         INTO CURSOR csRel READWRITE
298:                 CASE loc_lnLocal = 3
299:                     SELECT DISTINCT a.DataS, ;
300:                         NVL(a.Locals, "") AS Locals, ;

--- BO Linhas 298 a 308 ---
298:                 CASE loc_lnLocal = 3
299:                     SELECT DISTINCT a.DataS, ;
300:                         NVL(a.Locals, "") AS Locals, ;
301:                         NVL(a.Qtds, 0) AS Qtds, ;
302:                         NVL(a.vends, "") AS vends, ;
303:                         NVL(b.empos, "") AS empos, ;
304:                         NVL(b.Localizas, "") AS Localizas, ;
305:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
306:                         FROM crTmpLocal b ;
307:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
308:                         WHERE NVL(a.Qtds, 0) = 0 ;

--- BO Linhas 299 a 309 ---
299:                     SELECT DISTINCT a.DataS, ;
300:                         NVL(a.Locals, "") AS Locals, ;
301:                         NVL(a.Qtds, 0) AS Qtds, ;
302:                         NVL(a.vends, "") AS vends, ;
303:                         NVL(b.empos, "") AS empos, ;
304:                         NVL(b.Localizas, "") AS Localizas, ;
305:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
306:                         FROM crTmpLocal b ;
307:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
308:                         WHERE NVL(a.Qtds, 0) = 0 ;
309:                         INTO CURSOR csRel READWRITE

--- BO Linhas 302 a 312 ---
302:                         NVL(a.vends, "") AS vends, ;
303:                         NVL(b.empos, "") AS empos, ;
304:                         NVL(b.Localizas, "") AS Localizas, ;
305:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
306:                         FROM crTmpLocal b ;
307:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
308:                         WHERE NVL(a.Qtds, 0) = 0 ;
309:                         INTO CURSOR csRel READWRITE
310:                 CASE loc_lnLocal = 4
311:                     SELECT DISTINCT a.DataS, ;
312:                         NVL(a.Locals, "") AS Locals, ;

--- BO Linhas 310 a 320 ---
310:                 CASE loc_lnLocal = 4
311:                     SELECT DISTINCT a.DataS, ;
312:                         NVL(a.Locals, "") AS Locals, ;
313:                         NVL(a.Qtds, 0) AS Qtds, ;
314:                         NVL(a.vends, "") AS vends, ;
315:                         NVL(b.empos, "") AS empos, ;
316:                         NVL(b.Localizas, "") AS Localizas, ;
317:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
318:                         FROM crTmpLocal b ;
319:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
320:                         WHERE NVL(a.Qtds, 0) <> ;

--- BO Linhas 311 a 321 ---
311:                     SELECT DISTINCT a.DataS, ;
312:                         NVL(a.Locals, "") AS Locals, ;
313:                         NVL(a.Qtds, 0) AS Qtds, ;
314:                         NVL(a.vends, "") AS vends, ;
315:                         NVL(b.empos, "") AS empos, ;
316:                         NVL(b.Localizas, "") AS Localizas, ;
317:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
318:                         FROM crTmpLocal b ;
319:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
320:                         WHERE NVL(a.Qtds, 0) <> ;
321:                             IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;

--- BO Linhas 314 a 324 ---
314:                         NVL(a.vends, "") AS vends, ;
315:                         NVL(b.empos, "") AS empos, ;
316:                         NVL(b.Localizas, "") AS Localizas, ;
317:                         IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
318:                         FROM crTmpLocal b ;
319:                         LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
320:                         WHERE NVL(a.Qtds, 0) <> ;
321:                             IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
322:                         INTO CURSOR csRel READWRITE
323:                 ENDCASE
324: 

--- BO Linhas 321 a 331 ---
321:                             IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
322:                         INTO CURSOR csRel READWRITE
323:                 ENDCASE
324: 
325:                 *-- Agrega resultado final com campos de nivel decompostos
326:                 SELECT Datas, Locals, Vends, Empos, Localizas, ;
327:                     SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
328:                     SPACE(100) AS Descr, ;
329:                     LEFT(Locals, 2) AS Nivel1s, ;
330:                     SUBSTR(Locals, 3, 2) AS Nivel2s, ;
331:                     SUBSTR(Locals, 5, 2) AS Nivel3s, ;

--- BO Linhas 329 a 339 ---
329:                     LEFT(Locals, 2) AS Nivel1s, ;
330:                     SUBSTR(Locals, 3, 2) AS Nivel2s, ;
331:                     SUBSTR(Locals, 5, 2) AS Nivel3s, ;
332:                     SUBSTR(Locals, 7, 3) AS Nivel4s ;
333:                     FROM csRel ;
334:                     GROUP BY Datas, Locals, Vends, Empos, Localizas ;
335:                     INTO CURSOR crRel READWRITE
336: 
337:                 *-- Enriquece descricao com nivel 3
338:                 IF !USED("cursor_4c_SigLcNv3")
339:                     SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")

--- BO Linhas 499 a 509 ---
499:         RETURN .F.
500:     ENDPROC
501: 
502:     *--------------------------------------------------------------------------
503:     * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
504:     * data, empresa e filtro de localizacao) para fins de auditoria/log.
505:     *--------------------------------------------------------------------------
506:     PROCEDURE ObterChavePrimaria()
507:         LOCAL loc_cChave
508:         loc_cChave = "RELCNT|" + ;
509:                      IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;

--- BO Linhas 515 a 525 ---
515:         RETURN loc_cChave
516:     ENDPROC
517: 
518:     *--------------------------------------------------------------------------
519:     * RegistrarAuditoria - Registra operacao de execucao do relatorio na
520:     * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
521:     *--------------------------------------------------------------------------
522:     PROCEDURE RegistrarAuditoria(par_cOperacao)
523:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
524:         loc_lSucesso = .F.
525:         IF EMPTY(par_cOperacao)

--- BO Linhas 529 a 539 ---
529:             RETURN .F.
530:         ENDIF
531:         TRY
532:             loc_cChave = THIS.ObterChavePrimaria()
533:             loc_cSQL = "INSERT INTO LogAuditoria " + ;
534:                        "(Empresa, Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
535:                        "VALUES (" + ;
536:                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
537:                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
538:                        "GETDATE(), " + ;
539:                        EscaparSQL("Relatorio_Contagem") + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg
- BO: C:\4c\projeto\app\classes\sigrecntBO.prg
