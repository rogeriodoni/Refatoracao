CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1313: INSERT coluna 'rclis' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1313: INSERT coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1313: INSERT coluna 'mensagems' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1356: UPDATE coluna 'rclis' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1356: UPDATE coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1356: UPDATE coluna 'mensagems' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1702: INSERT coluna 'rclis' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1702: INSERT coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1702: INSERT coluna 'mensagems' NAO EXISTE na tabela 'sigalert'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigalert
CREATE TABLE [dbo].[sigalert](
	[acaos] [char](10) NOT NULL,
	[contas] [char](10) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dtalert2s] [datetime] NOT NULL,
	[dtalerts] [datetime] NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[msg1s] [text] NOT NULL,
	[msg2s] [text] NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
	[priors] [numeric](1, 0) NOT NULL,
	[usualerts] [char](10) NOT NULL,
	[usuars] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pkchaves] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SigAudit]    Script Date: 08/12/2025 10:07:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):

--- BO Linhas 113 a 123 ---
113:                 THIS.this_cDopes       = TratarNulo(Dopes,       "C")
114:                 THIS.this_nNumes       = TratarNulo(Numes,       "N")
115:                 THIS.this_cAcaos       = TratarNulo(Acaos,       "C")
116:                 THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
117:                 THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
118:                 THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
119:                 THIS.this_cEmails      = TratarNulo(Emails,      "C")
120:                 THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
121:                 THIS.this_cRclis       = TratarNulo(Rclis,       "C")
122:                 THIS.this_nPriors      = TratarNulo(Priors,      "N")
123:                 IF THIS.this_nPriors = 1

--- BO Linhas 114 a 124 ---
114:                 THIS.this_nNumes       = TratarNulo(Numes,       "N")
115:                 THIS.this_cAcaos       = TratarNulo(Acaos,       "C")
116:                 THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
117:                 THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
118:                 THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
119:                 THIS.this_cEmails      = TratarNulo(Emails,      "C")
120:                 THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
121:                 THIS.this_cRclis       = TratarNulo(Rclis,       "C")
122:                 THIS.this_nPriors      = TratarNulo(Priors,      "N")
123:                 IF THIS.this_nPriors = 1
124:                     THIS.this_cPrioridade = "URGENTE"

--- BO Linhas 116 a 126 ---
116:                 THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
117:                 THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
118:                 THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
119:                 THIS.this_cEmails      = TratarNulo(Emails,      "C")
120:                 THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
121:                 THIS.this_cRclis       = TratarNulo(Rclis,       "C")
122:                 THIS.this_nPriors      = TratarNulo(Priors,      "N")
123:                 IF THIS.this_nPriors = 1
124:                     THIS.this_cPrioridade = "URGENTE"
125:                 ELSE
126:                     IF THIS.this_nPriors = 2

--- BO Linhas 177 a 187 ---
177:                 THIS.this_cDopes    = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 4, 20))
178:                 THIS.this_nNumes    = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
179:                 THIS.this_cUsuars   = gc_4c_UsuarioLogado
180: 
181:                 loc_cSQL = "INSERT INTO SigAlert " + ;
182:                     "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
183:                     "Emails, Mensagems, Msg1s, Priors, Acaos, " + ;
184:                     "Usuars, DtAlerts, EmpDopNums) VALUES (" + ;
185:                     EscaparSQL(THIS.this_cPkChaves) + ", " + ;
186:                     EscaparSQL(THIS.this_cEmps) + ", " + ;
187:                     EscaparSQL(THIS.this_cDopes) + ", " + ;

--- BO Linhas 178 a 188 ---
178:                 THIS.this_nNumes    = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
179:                 THIS.this_cUsuars   = gc_4c_UsuarioLogado
180: 
181:                 loc_cSQL = "INSERT INTO SigAlert " + ;
182:                     "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
183:                     "Emails, Mensagems, Msg1s, Priors, Acaos, " + ;
184:                     "Usuars, DtAlerts, EmpDopNums) VALUES (" + ;
185:                     EscaparSQL(THIS.this_cPkChaves) + ", " + ;
186:                     EscaparSQL(THIS.this_cEmps) + ", " + ;
187:                     EscaparSQL(THIS.this_cDopes) + ", " + ;
188:                     FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;

--- BO Linhas 222 a 232 ---
222:                 THIS.this_cUsuars = gc_4c_UsuarioLogado
223: 
224:                 loc_cSQL = "UPDATE SigAlert SET " + ;
225:                     "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
226:                     "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
227:                     "Rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
228:                     "Emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
229:                     "Mensagems = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
230:                     "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
231:                     "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
232:                     "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;

--- BO Linhas 223 a 233 ---
223: 
224:                 loc_cSQL = "UPDATE SigAlert SET " + ;
225:                     "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
226:                     "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
227:                     "Rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
228:                     "Emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
229:                     "Mensagems = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
230:                     "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
231:                     "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
232:                     "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;
233:                     "Usuars = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;

--- BO Linhas 224 a 234 ---
224:                 loc_cSQL = "UPDATE SigAlert SET " + ;
225:                     "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
226:                     "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
227:                     "Rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
228:                     "Emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
229:                     "Mensagems = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
230:                     "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
231:                     "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
232:                     "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;
233:                     "Usuars = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
234:                     "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums) + " " + ;

--- BO Linhas 291 a 301 ---
291:             SET NULL ON
292:             IF USED("cursor_4c_Dados")
293:                 USE IN cursor_4c_Dados
294:             ENDIF
295:             CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
296:                 Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
297:                 mensagems M NULL, prioridade C(15) NULL, ;
298:                 EmpDopNums C(29) NULL, Acaos C(10) NULL)
299:             INDEX ON Contas TAG Contas
300:             INDEX ON Rclis  TAG Rclis
301:             INDEX ON emails TAG Emails

--- BO Linhas 292 a 302 ---
292:             IF USED("cursor_4c_Dados")
293:                 USE IN cursor_4c_Dados
294:             ENDIF
295:             CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
296:                 Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
297:                 mensagems M NULL, prioridade C(15) NULL, ;
298:                 EmpDopNums C(29) NULL, Acaos C(10) NULL)
299:             INDEX ON Contas TAG Contas
300:             INDEX ON Rclis  TAG Rclis
301:             INDEX ON emails TAG Emails
302:             SET NULL OFF

--- BO Linhas 295 a 305 ---
295:             CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
296:                 Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
297:                 mensagems M NULL, prioridade C(15) NULL, ;
298:                 EmpDopNums C(29) NULL, Acaos C(10) NULL)
299:             INDEX ON Contas TAG Contas
300:             INDEX ON Rclis  TAG Rclis
301:             INDEX ON emails TAG Emails
302:             SET NULL OFF
303: 
304:             *-- Buscar dados da movimentacao (cabecalho + cliente)
305:             IF USED("cursor_4c_MvCab")

--- BO Linhas 296 a 306 ---
296:                 Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
297:                 mensagems M NULL, prioridade C(15) NULL, ;
298:                 EmpDopNums C(29) NULL, Acaos C(10) NULL)
299:             INDEX ON Contas TAG Contas
300:             INDEX ON Rclis  TAG Rclis
301:             INDEX ON emails TAG Emails
302:             SET NULL OFF
303: 
304:             *-- Buscar dados da movimentacao (cabecalho + cliente)
305:             IF USED("cursor_4c_MvCab")
306:                 USE IN cursor_4c_MvCab

--- BO Linhas 303 a 313 ---
303: 
304:             *-- Buscar dados da movimentacao (cabecalho + cliente)
305:             IF USED("cursor_4c_MvCab")
306:                 USE IN cursor_4c_MvCab
307:             ENDIF
308:             loc_cSQL = "SELECT a.EmpDopNums, a.Jobs, b.Rclis, a.ObsCabMovs, a.Obses " + ;
309:                        "FROM SigMvcab a INNER JOIN SigCdCli b ON a.Jobs = b.Iclis " + ;
310:                        "WHERE a.EmpDopNums = " + EscaparSQL(par_cPrDopes)
311:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") >= 1
312:                 SELECT cursor_4c_MvCab
313:                 GO TOP

--- BO Linhas 315 a 325 ---
315:                 *-- Buscar alertas configurados em SigCdAle
316:                 IF USED("cursor_4c_Ale")
317:                     USE IN cursor_4c_Ale
318:                 ENDIF
319:                 loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
320:                            "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
321:                            "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
322:                            "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
323:                            "ELSE 'NORMAL' END AS prioridade, " + ;
324:                            "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
325:                            "'" + par_cPrDopes + "' AS EmpDopNums " + ;

--- BO Linhas 350 a 360 ---
350:                             ENDIF
351:                         ENDIF
352: 
353:                         SELECT cursor_4c_Dados
354:                         INSERT INTO cursor_4c_Dados ;
355:                             (Checks, grupos, Contas, Rclis, emails, ;
356:                              mensagems, prioridade, EmpDopNums, Acaos) ;
357:                             VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
358:                                     cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
359:                                     cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
360:                                     cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)

--- BO Linhas 351 a 361 ---
351:                         ENDIF
352: 
353:                         SELECT cursor_4c_Dados
354:                         INSERT INTO cursor_4c_Dados ;
355:                             (Checks, grupos, Contas, Rclis, emails, ;
356:                              mensagems, prioridade, EmpDopNums, Acaos) ;
357:                             VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
358:                                     cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
359:                                     cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
360:                                     cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
361:                         SELECT cursor_4c_Ale

--- BO Linhas 353 a 363 ---
353:                         SELECT cursor_4c_Dados
354:                         INSERT INTO cursor_4c_Dados ;
355:                             (Checks, grupos, Contas, Rclis, emails, ;
356:                              mensagems, prioridade, EmpDopNums, Acaos) ;
357:                             VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
358:                                     cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
359:                                     cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
360:                                     cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
361:                         SELECT cursor_4c_Ale
362:                     ENDSCAN
363:                 ELSE

--- BO Linhas 354 a 364 ---
354:                         INSERT INTO cursor_4c_Dados ;
355:                             (Checks, grupos, Contas, Rclis, emails, ;
356:                              mensagems, prioridade, EmpDopNums, Acaos) ;
357:                             VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
358:                                     cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
359:                                     cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
360:                                     cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
361:                         SELECT cursor_4c_Ale
362:                     ENDSCAN
363:                 ELSE
364:                     MsgErro("Falha ao buscar alertas configurados.", "Erro")

--- BO Linhas 367 a 377 ---
367:                 *-- Buscar destinatarios de SigCdPam (grupos de alerta parametrizados)
368:                 IF USED("cursor_4c_Pam")
369:                     USE IN cursor_4c_Pam
370:                 ENDIF
371:                 loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
372:                            "CLI.rclis, CLI.emails, '' AS prioridade " + ;
373:                            "FROM SigCdPam PAM " + ;
374:                            "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"
375:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") >= 1
376:                     SELECT cursor_4c_Pam
377:                     GO TOP

--- BO Linhas 391 a 401 ---
391:                                 LOOP
392:                             ENDIF
393:                         ENDIF
394: 
395:                         loc_cConta = cursor_4c_Pam.Contas
396:                         loc_cRclis = cursor_4c_Pam.Rclis
397:                         SELECT cursor_4c_Dados
398:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
399:                                AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
400:                         IF EOF()
401:                             INSERT INTO cursor_4c_Dados ;

--- BO Linhas 394 a 404 ---
394: 
395:                         loc_cConta = cursor_4c_Pam.Contas
396:                         loc_cRclis = cursor_4c_Pam.Rclis
397:                         SELECT cursor_4c_Dados
398:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
399:                                AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
400:                         IF EOF()
401:                             INSERT INTO cursor_4c_Dados ;
402:                                 (Checks, grupos, Contas, Rclis, emails, ;
403:                                  EmpDopNums, Acaos, prioridade) ;
404:                                 VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;

--- BO Linhas 397 a 407 ---
397:                         SELECT cursor_4c_Dados
398:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
399:                                AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
400:                         IF EOF()
401:                             INSERT INTO cursor_4c_Dados ;
402:                                 (Checks, grupos, Contas, Rclis, emails, ;
403:                                  EmpDopNums, Acaos, prioridade) ;
404:                                 VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;
405:                                         loc_cRclis, cursor_4c_Pam.emails, ;
406:                                         par_cPrDopes, par_cEscolha, "NORMAL")
407:                         ENDIF

--- BO Linhas 400 a 410 ---
400:                         IF EOF()
401:                             INSERT INTO cursor_4c_Dados ;
402:                                 (Checks, grupos, Contas, Rclis, emails, ;
403:                                  EmpDopNums, Acaos, prioridade) ;
404:                                 VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;
405:                                         loc_cRclis, cursor_4c_Pam.emails, ;
406:                                         par_cPrDopes, par_cEscolha, "NORMAL")
407:                         ENDIF
408:                         SELECT cursor_4c_Pam
409:                     ENDSCAN
410:                 ELSE

--- BO Linhas 457 a 467 ---
457:                 USE IN cursor_4c_OpeBaixa
458:             ENDIF
459: 
460:             *-- Tentar buscar na ALERTA primeiro (alertas ja enviados para baixa)
461:             loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, " + ;
462:                        "SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
463:                        "Msg1s AS Mensagems, 1 AS Checks " + ;
464:                        "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
465:                        " AND Acaos = 'BAIXAR'"
466:             IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
467:                 *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)

--- BO Linhas 458 a 468 ---
458:             ENDIF
459: 
460:             *-- Tentar buscar na ALERTA primeiro (alertas ja enviados para baixa)
461:             loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, " + ;
462:                        "SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
463:                        "Msg1s AS Mensagems, 1 AS Checks " + ;
464:                        "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
465:                        " AND Acaos = 'BAIXAR'"
466:             IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
467:                 *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)
468:                 loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;

--- BO Linhas 464 a 474 ---
464:                        "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
465:                        " AND Acaos = 'BAIXAR'"
466:             IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
467:                 *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)
468:                 loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
469:                            "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
470:                            "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
471:                            "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
472:                            "ELSE 'NORMAL' END AS prioridade, " + ;
473:                            "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
474:                            "SPACE(29) AS EmpDopNums, '" + par_cEscolha + "' AS Acaos " + ;

--- BO Linhas 477 a 487 ---
477:                            "WHERE ALE.Dopes IN " + par_cDope + " AND ALE.baixas = 1"
478:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeBaixa")
479:             ENDIF
480: 
481:             IF USED("cursor_4c_OpeBaixa")
482:                 *-- Buscar emails e prioridade para cada conta
483:                 SELECT cursor_4c_OpeBaixa
484:                 GO TOP
485:                 SCAN
486:                     IF USED("cursor_4c_CliEmail")
487:                         USE IN cursor_4c_CliEmail

--- BO Linhas 484 a 494 ---
484:                 GO TOP
485:                 SCAN
486:                     IF USED("cursor_4c_CliEmail")
487:                         USE IN cursor_4c_CliEmail
488:                     ENDIF
489:                     loc_cSQL = "SELECT a.Emails, " + ;
490:                                "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
491:                                "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
492:                                "ELSE 'NORMAL' END AS prioridade, b.mensagems " + ;
493:                                "FROM SigCdCli a INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
494:                                "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;

--- BO Linhas 487 a 497 ---
487:                         USE IN cursor_4c_CliEmail
488:                     ENDIF
489:                     loc_cSQL = "SELECT a.Emails, " + ;
490:                                "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
491:                                "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
492:                                "ELSE 'NORMAL' END AS prioridade, b.mensagems " + ;
493:                                "FROM SigCdCli a INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
494:                                "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;
495:                                "' AND b.Dopes = '" + ALLTRIM(cursor_4c_OpeBaixa.Dopes) + "'"
496:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
497:                     IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")

--- BO Linhas 494 a 504 ---
494:                                "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;
495:                                "' AND b.Dopes = '" + ALLTRIM(cursor_4c_OpeBaixa.Dopes) + "'"
496:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
497:                     IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")
498:                         SELECT cursor_4c_OpeBaixa
499:                         REPLACE emails     WITH cursor_4c_CliEmail.Emails
500:                         REPLACE prioridade WITH cursor_4c_CliEmail.prioridade
501:                         REPLACE mensagems  WITH cursor_4c_CliEmail.mensagems
502:                     ENDIF
503:                     SELECT cursor_4c_OpeBaixa
504:                 ENDSCAN

--- BO Linhas 496 a 506 ---
496:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
497:                     IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")
498:                         SELECT cursor_4c_OpeBaixa
499:                         REPLACE emails     WITH cursor_4c_CliEmail.Emails
500:                         REPLACE prioridade WITH cursor_4c_CliEmail.prioridade
501:                         REPLACE mensagems  WITH cursor_4c_CliEmail.mensagems
502:                     ENDIF
503:                     SELECT cursor_4c_OpeBaixa
504:                 ENDSCAN
505:                 loc_lResultado = .T.
506:             ENDIF

--- BO Linhas 566 a 576 ---
566:                 OTHERWISE
567:                     loc_nPriors = 3
568:             ENDCASE
569: 
570:             loc_cSQL = "INSERT INTO SigAlert " + ;
571:                 "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
572:                 "Emails, Mensagems, Msg1s, Priors, Acaos, Usuars, DtAlerts, EmpDopNums) " + ;
573:                 "VALUES (" + ;
574:                 EscaparSQL(par_cPkChaves) + ", " + ;
575:                 EscaparSQL(SUBSTR(par_cEmpDopNums, 1, 3)) + ", " + ;
576:                 EscaparSQL(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20))) + ", " + ;

--- BO Linhas 567 a 577 ---
567:                     loc_nPriors = 3
568:             ENDCASE
569: 
570:             loc_cSQL = "INSERT INTO SigAlert " + ;
571:                 "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
572:                 "Emails, Mensagems, Msg1s, Priors, Acaos, Usuars, DtAlerts, EmpDopNums) " + ;
573:                 "VALUES (" + ;
574:                 EscaparSQL(par_cPkChaves) + ", " + ;
575:                 EscaparSQL(SUBSTR(par_cEmpDopNums, 1, 3)) + ", " + ;
576:                 EscaparSQL(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20))) + ", " + ;
577:                 FormatarNumeroSQL(VAL(SUBSTR(par_cEmpDopNums, 24, 6))) + ", " + ;


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg
- BO: C:\4c\projeto\app\classes\SigPrEmlBO.prg
