CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1467: INSERT coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1467: INSERT coluna 'mensagems' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1467: INSERT coluna 'prioridade' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1812: INSERT coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1812: INSERT coluna 'mensagems' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1812: INSERT coluna 'prioridade' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1874: UPDATE coluna 'emails' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1874: UPDATE coluna 'mensagems' NAO EXISTE na tabela 'sigalert'
- [SQL-SCHEMA] Linha ~1874: UPDATE coluna 'prioridade' NAO EXISTE na tabela 'sigalert'


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

--- BO Linhas 36 a 46 ---
36:     * Cursores gerenciados pelo BO
37:     *--------------------------------------------------------------------------
38: 
39:     *-- cursor_4c_Total: equivalente a crLocalTotal do legado
40:     *-- Estrutura: Checks N(1), grupos C(10), Contas C(10), Rclis C(30),
41:     *--            emails C(50), mensagems M, prioridade C(15),
42:     *--            EmpDopNums C(29), Acaos C(10)
43:     this_cCursorTotal     = "cursor_4c_Total"
44: 
45:     *-- cursor_4c_AlertaRec: espelho de SigAlert para estrutura de referencia
46:     this_cCursorAlerta    = "cursor_4c_AlertaRec"

--- BO Linhas 182 a 192 ---
182:             ENDIF
183: 
184:             SET NULL ON
185:             CREATE CURSOR (THIS.this_cCursorTotal) ;
186:                 (Checks N(1) NULL, grupos C(10) NULL, Contas C(10) NULL, ;
187:                  Rclis C(30) NULL, emails C(50) NULL, mensagems M NULL, ;
188:                  prioridade C(15) NULL, EmpDopNums C(29) NULL, Acaos C(10) NULL)
189:             SET NULL OFF
190: 
191:             INDEX ON Contas TAG Contas
192:             INDEX ON Rclis  TAG Rclis

--- BO Linhas 183 a 193 ---
183: 
184:             SET NULL ON
185:             CREATE CURSOR (THIS.this_cCursorTotal) ;
186:                 (Checks N(1) NULL, grupos C(10) NULL, Contas C(10) NULL, ;
187:                  Rclis C(30) NULL, emails C(50) NULL, mensagems M NULL, ;
188:                  prioridade C(15) NULL, EmpDopNums C(29) NULL, Acaos C(10) NULL)
189:             SET NULL OFF
190: 
191:             INDEX ON Contas TAG Contas
192:             INDEX ON Rclis  TAG Rclis
193:             INDEX ON Emails TAG Emails

--- BO Linhas 188 a 198 ---
188:                  prioridade C(15) NULL, EmpDopNums C(29) NULL, Acaos C(10) NULL)
189:             SET NULL OFF
190: 
191:             INDEX ON Contas TAG Contas
192:             INDEX ON Rclis  TAG Rclis
193:             INDEX ON Emails TAG Emails
194: 
195:             *-- Obter estrutura de SigAlert (banco ALERTA)
196:             IF THIS.this_nConnAlerta > 0
197:                 IF USED(THIS.this_cCursorAlerta)
198:                     USE IN (THIS.this_cCursorAlerta)

--- BO Linhas 238 a 248 ---
238:                 IF USED("cursor_4c_LocalALE")
239:                     USE IN cursor_4c_LocalALE
240:                 ENDIF
241: 
242:                 loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, CLI.Rclis, " + ;
243:                            "CLI.emails, ALE.mensagems, " + ;
244:                            "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
245:                            "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
246:                            "ELSE 'NORMAL' END AS prioridade, " + ;
247:                            "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
248:                            "ALE.priors, ALE.dopes, " + ;

--- BO Linhas 241 a 251 ---
241: 
242:                 loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, CLI.Rclis, " + ;
243:                            "CLI.emails, ALE.mensagems, " + ;
244:                            "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
245:                            "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
246:                            "ELSE 'NORMAL' END AS prioridade, " + ;
247:                            "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
248:                            "ALE.priors, ALE.dopes, " + ;
249:                            EscaparSQL(par_cEmpDopNums) + " AS EmpDopNums " + ;
250:                            "FROM SigCdAle ALE " + ;
251:                            "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.IClis " + ;

--- BO Linhas 314 a 324 ---
314:                             ENDIF
315:                         ENDIF
316:                     ENDIF
317: 
318:                     INSERT INTO (THIS.this_cCursorTotal) ;
319:                         (Checks, grupos, Contas, Rclis, emails, mensagems, ;
320:                          prioridade, EmpDopNums, Acaos) ;
321:                         VALUES ;
322:                         (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
323:                          cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
324:                          cursor_4c_LocalALE.emails, ;

--- BO Linhas 315 a 325 ---
315:                         ENDIF
316:                     ENDIF
317: 
318:                     INSERT INTO (THIS.this_cCursorTotal) ;
319:                         (Checks, grupos, Contas, Rclis, emails, mensagems, ;
320:                          prioridade, EmpDopNums, Acaos) ;
321:                         VALUES ;
322:                         (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
323:                          cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
324:                          cursor_4c_LocalALE.emails, ;
325:                          NVL(cursor_4c_LocalALE.mensagems, ""), ;

--- BO Linhas 319 a 329 ---
319:                         (Checks, grupos, Contas, Rclis, emails, mensagems, ;
320:                          prioridade, EmpDopNums, Acaos) ;
321:                         VALUES ;
322:                         (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
323:                          cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
324:                          cursor_4c_LocalALE.emails, ;
325:                          NVL(cursor_4c_LocalALE.mensagems, ""), ;
326:                          cursor_4c_LocalALE.prioridade, ;
327:                          par_cEmpDopNums, par_cEscolha)
328: 
329:                     SELECT cursor_4c_LocalALE

--- BO Linhas 320 a 330 ---
320:                          prioridade, EmpDopNums, Acaos) ;
321:                         VALUES ;
322:                         (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
323:                          cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
324:                          cursor_4c_LocalALE.emails, ;
325:                          NVL(cursor_4c_LocalALE.mensagems, ""), ;
326:                          cursor_4c_LocalALE.prioridade, ;
327:                          par_cEmpDopNums, par_cEscolha)
328: 
329:                     SELECT cursor_4c_LocalALE
330:                 ENDSCAN

--- BO Linhas 321 a 331 ---
321:                         VALUES ;
322:                         (cursor_4c_LocalALE.Checks, cursor_4c_LocalALE.grupos, ;
323:                          cursor_4c_LocalALE.Contas, cursor_4c_LocalALE.Rclis, ;
324:                          cursor_4c_LocalALE.emails, ;
325:                          NVL(cursor_4c_LocalALE.mensagems, ""), ;
326:                          cursor_4c_LocalALE.prioridade, ;
327:                          par_cEmpDopNums, par_cEscolha)
328: 
329:                     SELECT cursor_4c_LocalALE
330:                 ENDSCAN
331: 

--- BO Linhas 333 a 343 ---
333:                 IF USED("cursor_4c_LocalPAM")
334:                     USE IN cursor_4c_LocalPAM
335:                 ENDIF
336: 
337:                 loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
338:                            "CLI.rclis, CLI.emails, '' AS prioridade " + ;
339:                            "FROM SigCdPam PAM " + ;
340:                            "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"
341: 
342:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPAM") < 1
343:                     MsgErro("Falha na conex" + CHR(227) + "o (SigCdPam)." + ;

--- BO Linhas 371 a 381 ---
371: 
372:                     loc_lnChecks = cursor_4c_LocalPAM.Checks
373:                     loc_lcGrupos = ""
374:                     loc_lcContas = ALLTRIM(cursor_4c_LocalPAM.Contas)
375:                     loc_lcRclis  = ALLTRIM(cursor_4c_LocalPAM.Rclis)
376:                     loc_lcEmails = ALLTRIM(cursor_4c_LocalPAM.emails)
377: 
378:                     SELECT (THIS.this_cCursorTotal)
379:                     LOCATE FOR ALLTRIM(Contas) = loc_lcContas AND ;
380:                                ALLTRIM(Rclis)  = loc_lcRclis
381:                     IF EOF()

--- BO Linhas 378 a 388 ---
378:                     SELECT (THIS.this_cCursorTotal)
379:                     LOCATE FOR ALLTRIM(Contas) = loc_lcContas AND ;
380:                                ALLTRIM(Rclis)  = loc_lcRclis
381:                     IF EOF()
382:                         INSERT INTO (THIS.this_cCursorTotal) ;
383:                             (Checks, grupos, Contas, Rclis, emails, ;
384:                              EmpDopNums, Acaos, prioridade) ;
385:                             VALUES ;
386:                             (loc_lnChecks, loc_lcGrupos, loc_lcContas, loc_lcRclis, ;
387:                              loc_lcEmails, par_cEmpDopNums, par_cEscolha, "NORMAL")
388:                     ENDIF

--- BO Linhas 379 a 389 ---
379:                     LOCATE FOR ALLTRIM(Contas) = loc_lcContas AND ;
380:                                ALLTRIM(Rclis)  = loc_lcRclis
381:                     IF EOF()
382:                         INSERT INTO (THIS.this_cCursorTotal) ;
383:                             (Checks, grupos, Contas, Rclis, emails, ;
384:                              EmpDopNums, Acaos, prioridade) ;
385:                             VALUES ;
386:                             (loc_lnChecks, loc_lcGrupos, loc_lcContas, loc_lcRclis, ;
387:                              loc_lcEmails, par_cEmpDopNums, par_cEscolha, "NORMAL")
388:                     ENDIF
389: 

--- BO Linhas 424 a 434 ---
424:                 loc_lAbortar = .T.
425:             ENDIF
426: 
427:             IF !loc_lAbortar
428:                 loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, " + ;
429:                            "Numes, SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
430:                            "Msg1s AS Mensagems, 1 AS Checks " + ;
431:                            "FROM SigAlert " + ;
432:                            "WHERE EmpDopNums IN " + par_cEDN + ;
433:                            " AND Acaos = 'BAIXAR'"
434: 

--- BO Linhas 425 a 435 ---
425:             ENDIF
426: 
427:             IF !loc_lAbortar
428:                 loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, " + ;
429:                            "Numes, SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
430:                            "Msg1s AS Mensagems, 1 AS Checks " + ;
431:                            "FROM SigAlert " + ;
432:                            "WHERE EmpDopNums IN " + par_cEDN + ;
433:                            " AND Acaos = 'BAIXAR'"
434: 
435:                 IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, ;

--- BO Linhas 440 a 450 ---
440:                 ENDIF
441:             ENDIF
442: 
443:             IF !loc_lAbortar
444:                 IF RECCOUNT(THIS.this_cCursorOpeBaixa) > 0
445:                     *-- Enriquecer emails/prioridade das baixas via SigCdCli+SigCdAle
446:                     SELECT cursor_4c_OpeBaixa
447:                     SCAN
448:                         loc_lcContasBaixa = ALLTRIM(cursor_4c_OpeBaixa.Contas)
449:                         loc_lcDopesBaixa  = ALLTRIM(cursor_4c_OpeBaixa.Dopes)
450: 

--- BO Linhas 450 a 460 ---
450: 
451:                         IF USED("cursor_4c_TmpCli")
452:                             USE IN cursor_4c_TmpCli
453:                         ENDIF
454: 
455:                         loc_cSQL = "SELECT a.Emails, " + ;
456:                                    "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
457:                                    "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
458:                                    "ELSE 'NORMAL' END AS prioridade, " + ;
459:                                    "b.mensagems " + ;
460:                                    "FROM SigCdCli a " + ;

--- BO Linhas 453 a 463 ---
453:                         ENDIF
454: 
455:                         loc_cSQL = "SELECT a.Emails, " + ;
456:                                    "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
457:                                    "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
458:                                    "ELSE 'NORMAL' END AS prioridade, " + ;
459:                                    "b.mensagems " + ;
460:                                    "FROM SigCdCli a " + ;
461:                                    "INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
462:                                    "WHERE a.Iclis = " + EscaparSQL(loc_lcContasBaixa) + ;
463:                                    " AND b.Dopes = " + EscaparSQL(loc_lcDopesBaixa)

--- BO Linhas 454 a 464 ---
454: 
455:                         loc_cSQL = "SELECT a.Emails, " + ;
456:                                    "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
457:                                    "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
458:                                    "ELSE 'NORMAL' END AS prioridade, " + ;
459:                                    "b.mensagems " + ;
460:                                    "FROM SigCdCli a " + ;
461:                                    "INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
462:                                    "WHERE a.Iclis = " + EscaparSQL(loc_lcContasBaixa) + ;
463:                                    " AND b.Dopes = " + EscaparSQL(loc_lcDopesBaixa)
464: 

--- BO Linhas 465 a 475 ---
465:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli") > 0
466:                             SELECT cursor_4c_TmpCli
467:                             GO TOP
468:                             IF !EOF()
469:                                 SELECT cursor_4c_OpeBaixa
470:                                 REPLACE emails     WITH cursor_4c_TmpCli.emails, ;
471:                                         prioridade WITH cursor_4c_TmpCli.prioridade, ;
472:                                         mensagems  WITH cursor_4c_TmpCli.mensagems
473:                             ENDIF
474:                         ENDIF
475: 

--- BO Linhas 466 a 476 ---
466:                             SELECT cursor_4c_TmpCli
467:                             GO TOP
468:                             IF !EOF()
469:                                 SELECT cursor_4c_OpeBaixa
470:                                 REPLACE emails     WITH cursor_4c_TmpCli.emails, ;
471:                                         prioridade WITH cursor_4c_TmpCli.prioridade, ;
472:                                         mensagems  WITH cursor_4c_TmpCli.mensagems
473:                             ENDIF
474:                         ENDIF
475: 
476:                         SELECT cursor_4c_OpeBaixa

--- BO Linhas 467 a 477 ---
467:                             GO TOP
468:                             IF !EOF()
469:                                 SELECT cursor_4c_OpeBaixa
470:                                 REPLACE emails     WITH cursor_4c_TmpCli.emails, ;
471:                                         prioridade WITH cursor_4c_TmpCli.prioridade, ;
472:                                         mensagems  WITH cursor_4c_TmpCli.mensagems
473:                             ENDIF
474:                         ENDIF
475: 
476:                         SELECT cursor_4c_OpeBaixa
477:                     ENDSCAN

--- BO Linhas 482 a 492 ---
482:                     IF USED(THIS.this_cCursorOpeBaixa)
483:                         USE IN (THIS.this_cCursorOpeBaixa)
484:                     ENDIF
485: 
486:                     loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
487:                                "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
488:                                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
489:                                "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
490:                                "ELSE 'NORMAL' END AS prioridade, " + ;
491:                                "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
492:                                "ALE.priors, ALE.dopes, " + ;

--- BO Linhas 485 a 495 ---
485: 
486:                     loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
487:                                "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
488:                                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
489:                                "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
490:                                "ELSE 'NORMAL' END AS prioridade, " + ;
491:                                "ALE.datas, ALE.dtalts, ALE.pkchaves, " + ;
492:                                "ALE.priors, ALE.dopes, " + ;
493:                                "SPACE(29) AS EmpDopNums, " + ;
494:                                EscaparSQL(THIS.this_cEscolha) + " AS Acaos " + ;
495:                                "FROM SigCdAle ALE " + ;

--- BO Linhas 569 a 579 ---
569: 
570:     *--------------------------------------------------------------------------
571:     * ComposeCorpoEmail - Monta corpo do email a partir dos dados do movimento
572:     * par_cEmpDopNums : EmpDopNums do registro destinatario
573:     * par_cMensagem   : Mensagem customizada do alerta
574:     * par_cPrioridade : Prioridade do alerta
575:     * par_lEhBaixa    : .T. se este email e notificacao de baixa/cancelamento
576:     * par_cEmpDopBaixa: EmpDopNums do movimento baixado (apenas se par_lEhBaixa)
577:     * Retorna string com corpo formatado do email
578:     *--------------------------------------------------------------------------
579:     PROTECTED PROCEDURE ComposeCorpoEmail(par_cEmpDopNums, par_cMensagem, ;

--- BO Linhas 655 a 665 ---
655: 
656:     *--------------------------------------------------------------------------
657:     * RegistrarEmailNoAlerta - Insere registro de email enviado em SigAlert
658:     * par_cContas    : Codigo da conta destinataria
659:     * par_cEmails    : Endereco de email
660:     * par_cMensagem  : Mensagem do alerta (campo mensagems)
661:     * par_cPrioridade: Prioridade do alerta
662:     * par_cEmpDopNums: EmpDopNums do movimento
663:     * par_cTextMsg   : Corpo completo do email composto
664:     * par_cAcao      : Acao: this_cEscolha ou "BAIXAR"
665:     * Retorna .T. se inseriu com sucesso

--- BO Linhas 656 a 666 ---
656:     *--------------------------------------------------------------------------
657:     * RegistrarEmailNoAlerta - Insere registro de email enviado em SigAlert
658:     * par_cContas    : Codigo da conta destinataria
659:     * par_cEmails    : Endereco de email
660:     * par_cMensagem  : Mensagem do alerta (campo mensagems)
661:     * par_cPrioridade: Prioridade do alerta
662:     * par_cEmpDopNums: EmpDopNums do movimento
663:     * par_cTextMsg   : Corpo completo do email composto
664:     * par_cAcao      : Acao: this_cEscolha ou "BAIXAR"
665:     * Retorna .T. se inseriu com sucesso
666:     *--------------------------------------------------------------------------

--- BO Linhas 674 a 684 ---
674: 
675:         TRY
676:             IF THIS.this_nConnAlerta > 0
677:                 loc_cSQL = "INSERT INTO SigAlert " + ;
678:                            "(pkchaves, Emps, Dopes, Numes, Grupos, Contas, " + ;
679:                            "emails, mensagems, prioridade, EmpDopNums, Acaos, " + ;
680:                            "DtAlerts, msg1s, Usuars) VALUES (" + ;
681:                            "CAST(NEWID() AS VARCHAR(36)), " + ;
682:                            EscaparSQL(LEFT(ALLTRIM(SUBSTR(par_cEmpDopNums, 1, 3)), 3)) + ", " + ;
683:                            EscaparSQL(LEFT(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20)), 20)) + ", " + ;
684:                            TRANSFORM(VAL(ALLTRIM(SUBSTR(par_cEmpDopNums, 24, 6)))) + ", " + ;

--- BO Linhas 706 a 716 ---
706: 
707:         RETURN loc_lSucesso
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * EnviarEmails - Envia emails para destinatarios marcados em cursor_4c_Total
712:     * e registra historico em SigAlert (banco ALERTA).
713:     * Retorna .T. se todos os emails foram enviados com sucesso
714:     *--------------------------------------------------------------------------
715:     PROCEDURE EnviarEmails()
716:         LOCAL loc_lSucesso, loc_llOk, loc_lPrimeiro

--- BO Linhas 708 a 718 ---
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * EnviarEmails - Envia emails para destinatarios marcados em cursor_4c_Total
712:     * e registra historico em SigAlert (banco ALERTA).
713:     * Retorna .T. se todos os emails foram enviados com sucesso
714:     *--------------------------------------------------------------------------
715:     PROCEDURE EnviarEmails()
716:         LOCAL loc_lSucesso, loc_llOk, loc_lPrimeiro
717:         LOCAL loc_lcReceptor, loc_lcReceptorCopia, loc_lcAssunto
718:         LOCAL loc_lcTxtMensagem, loc_lcArqAnexo, loc_lcTxtPrioridade

--- BO Linhas 757 a 767 ---
757:                     loc_llOk            = .T.
758: 
759:                     SELECT cursor_4c_Total2
760:                     SCAN
761:                         IF loc_lPrimeiro
762:                             loc_lcReceptor      = ALLTRIM(cursor_4c_Total2.emails)
763:                             loc_lcTxtPrioridade = ALLTRIM(cursor_4c_Total2.prioridade)
764:                             loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade
765: 
766:                             loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
767:                                 cursor_4c_Total2.EmpDopNums, ;

--- BO Linhas 758 a 768 ---
758: 
759:                     SELECT cursor_4c_Total2
760:                     SCAN
761:                         IF loc_lPrimeiro
762:                             loc_lcReceptor      = ALLTRIM(cursor_4c_Total2.emails)
763:                             loc_lcTxtPrioridade = ALLTRIM(cursor_4c_Total2.prioridade)
764:                             loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade
765: 
766:                             loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
767:                                 cursor_4c_Total2.EmpDopNums, ;
768:                                 NVL(cursor_4c_Total2.mensagems, ""), ;

--- BO Linhas 763 a 773 ---
763:                             loc_lcTxtPrioridade = ALLTRIM(cursor_4c_Total2.prioridade)
764:                             loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade
765: 
766:                             loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
767:                                 cursor_4c_Total2.EmpDopNums, ;
768:                                 NVL(cursor_4c_Total2.mensagems, ""), ;
769:                                 cursor_4c_Total2.prioridade, ;
770:                                 .F., "")
771: 
772:                             loc_lPrimeiro = .F.
773:                         ELSE

--- BO Linhas 764 a 774 ---
764:                             loc_lcAssunto       = "ALERTA - " + loc_lcTxtPrioridade
765: 
766:                             loc_lcTxtMensagem = THIS.ComposeCorpoEmail( ;
767:                                 cursor_4c_Total2.EmpDopNums, ;
768:                                 NVL(cursor_4c_Total2.mensagems, ""), ;
769:                                 cursor_4c_Total2.prioridade, ;
770:                                 .F., "")
771: 
772:                             loc_lPrimeiro = .F.
773:                         ELSE
774:                             IF !EMPTY(ALLTRIM(cursor_4c_Total2.emails))

--- BO Linhas 769 a 779 ---
769:                                 cursor_4c_Total2.prioridade, ;
770:                                 .F., "")
771: 
772:                             loc_lPrimeiro = .F.
773:                         ELSE
774:                             IF !EMPTY(ALLTRIM(cursor_4c_Total2.emails))
775:                                 loc_lcReceptorCopia = loc_lcReceptorCopia + ;
776:                                     IIF(EMPTY(loc_lcReceptorCopia), "", ",") + ;
777:                                     ALLTRIM(cursor_4c_Total2.emails)
778:                             ENDIF
779:                         ENDIF

--- BO Linhas 772 a 782 ---
772:                             loc_lPrimeiro = .F.
773:                         ELSE
774:                             IF !EMPTY(ALLTRIM(cursor_4c_Total2.emails))
775:                                 loc_lcReceptorCopia = loc_lcReceptorCopia + ;
776:                                     IIF(EMPTY(loc_lcReceptorCopia), "", ",") + ;
777:                                     ALLTRIM(cursor_4c_Total2.emails)
778:                             ENDIF
779:                         ENDIF
780: 
781:                         THIS.RegistrarEmailNoAlerta( ;
782:                             cursor_4c_Total2.Contas, ;

--- BO Linhas 778 a 788 ---
778:                             ENDIF
779:                         ENDIF
780: 
781:                         THIS.RegistrarEmailNoAlerta( ;
782:                             cursor_4c_Total2.Contas, ;
783:                             cursor_4c_Total2.emails, ;
784:                             NVL(cursor_4c_Total2.mensagems, ""), ;
785:                             cursor_4c_Total2.prioridade, ;
786:                             cursor_4c_Total2.EmpDopNums, ;
787:                             loc_lcTxtMensagem, ;
788:                             THIS.this_cEscolha)

--- BO Linhas 779 a 789 ---
779:                         ENDIF
780: 
781:                         THIS.RegistrarEmailNoAlerta( ;
782:                             cursor_4c_Total2.Contas, ;
783:                             cursor_4c_Total2.emails, ;
784:                             NVL(cursor_4c_Total2.mensagems, ""), ;
785:                             cursor_4c_Total2.prioridade, ;
786:                             cursor_4c_Total2.EmpDopNums, ;
787:                             loc_lcTxtMensagem, ;
788:                             THIS.this_cEscolha)
789: 

--- BO Linhas 780 a 790 ---
780: 
781:                         THIS.RegistrarEmailNoAlerta( ;
782:                             cursor_4c_Total2.Contas, ;
783:                             cursor_4c_Total2.emails, ;
784:                             NVL(cursor_4c_Total2.mensagems, ""), ;
785:                             cursor_4c_Total2.prioridade, ;
786:                             cursor_4c_Total2.EmpDopNums, ;
787:                             loc_lcTxtMensagem, ;
788:                             THIS.this_cEscolha)
789: 
790:                         SELECT cursor_4c_Total2

--- BO Linhas 801 a 811 ---
801:                         loc_llOk = .F.
802:                     ENDIF
803: 
804:                     WAIT CLEAR
805: 
806:                     *-- Processar emails de baixa (se existirem)
807:                     IF loc_llOk AND THIS.this_lTemOpeBaixa AND ;
808:                        USED(THIS.this_cCursorOpeBaixa) AND ;
809:                        RECCOUNT(THIS.this_cCursorOpeBaixa) > 0
810: 
811:                         loc_lcReceptor      = ""

--- BO Linhas 816 a 826 ---
816: 
817:                         SELECT cursor_4c_OpeBaixa
818:                         SCAN
819:                             loc_lcEmpDopBaixa   = cursor_4c_OpeBaixa.EmpDopNums
820:                             loc_lcContasBaixa   = ALLTRIM(cursor_4c_OpeBaixa.Contas)
821:                             loc_lcEmailsBaixa   = ALLTRIM(cursor_4c_OpeBaixa.emails)
822:                             loc_lcMensagemBaixa = NVL(cursor_4c_OpeBaixa.mensagems, "")
823:                             loc_lcPrioridadeBaixa = ALLTRIM(cursor_4c_OpeBaixa.prioridade)
824:                             loc_lcAcaoBaixa     = ALLTRIM(cursor_4c_OpeBaixa.Acaos)
825: 
826:                             IF loc_lPrimeiro

--- BO Linhas 817 a 827 ---
817:                         SELECT cursor_4c_OpeBaixa
818:                         SCAN
819:                             loc_lcEmpDopBaixa   = cursor_4c_OpeBaixa.EmpDopNums
820:                             loc_lcContasBaixa   = ALLTRIM(cursor_4c_OpeBaixa.Contas)
821:                             loc_lcEmailsBaixa   = ALLTRIM(cursor_4c_OpeBaixa.emails)
822:                             loc_lcMensagemBaixa = NVL(cursor_4c_OpeBaixa.mensagems, "")
823:                             loc_lcPrioridadeBaixa = ALLTRIM(cursor_4c_OpeBaixa.prioridade)
824:                             loc_lcAcaoBaixa     = ALLTRIM(cursor_4c_OpeBaixa.Acaos)
825: 
826:                             IF loc_lPrimeiro
827:                                 loc_lcReceptor      = loc_lcEmailsBaixa

--- BO Linhas 818 a 828 ---
818:                         SCAN
819:                             loc_lcEmpDopBaixa   = cursor_4c_OpeBaixa.EmpDopNums
820:                             loc_lcContasBaixa   = ALLTRIM(cursor_4c_OpeBaixa.Contas)
821:                             loc_lcEmailsBaixa   = ALLTRIM(cursor_4c_OpeBaixa.emails)
822:                             loc_lcMensagemBaixa = NVL(cursor_4c_OpeBaixa.mensagems, "")
823:                             loc_lcPrioridadeBaixa = ALLTRIM(cursor_4c_OpeBaixa.prioridade)
824:                             loc_lcAcaoBaixa     = ALLTRIM(cursor_4c_OpeBaixa.Acaos)
825: 
826:                             IF loc_lPrimeiro
827:                                 loc_lcReceptor      = loc_lcEmailsBaixa
828:                                 loc_lcTxtPrioridade = loc_lcPrioridadeBaixa

--- BO Linhas 919 a 929 ---
919:         ENDIF
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * OrdenarPorColuna - Ordena cursor_4c_Total pelo tag solicitado
924:     * par_cTag: "Contas" | "Rclis" | "Emails"
925:     *--------------------------------------------------------------------------
926:     PROCEDURE OrdenarPorColuna(par_cTag)
927:         IF USED(THIS.this_cCursorTotal)
928:             SELECT (THIS.this_cCursorTotal)
929:             DO CASE

--- BO Linhas 929 a 939 ---
929:             DO CASE
930:             CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
931:                 SET ORDER TO TAG Contas
932:             CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
933:                 SET ORDER TO TAG Rclis
934:             CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
935:                 SET ORDER TO TAG Emails
936:             ENDCASE
937:             GO TOP
938:         ENDIF
939:     ENDPROC

--- BO Linhas 930 a 940 ---
930:             CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
931:                 SET ORDER TO TAG Contas
932:             CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
933:                 SET ORDER TO TAG Rclis
934:             CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
935:                 SET ORDER TO TAG Emails
936:             ENDCASE
937:             GO TOP
938:         ENDIF
939:     ENDPROC
940: 

--- BO Linhas 963 a 973 ---
963:                     THIS.this_cNumes  = TratarNulo(Numes,      "C")
964:                 ENDIF
965: 
966:                 THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
967:                 THIS.this_cContas     = TratarNulo(Contas,     "C")
968:                 THIS.this_cEmails     = TratarNulo(emails,     "C")
969:                 THIS.this_cMensagems  = TratarNulo(mensagems,  "C")
970:                 THIS.this_cPrioridade = TratarNulo(prioridade, "C")
971:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
972:                 THIS.this_cAcaos      = TratarNulo(Acaos,      "C")
973: 

--- BO Linhas 964 a 974 ---
964:                 ENDIF
965: 
966:                 THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
967:                 THIS.this_cContas     = TratarNulo(Contas,     "C")
968:                 THIS.this_cEmails     = TratarNulo(emails,     "C")
969:                 THIS.this_cMensagems  = TratarNulo(mensagems,  "C")
970:                 THIS.this_cPrioridade = TratarNulo(prioridade, "C")
971:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
972:                 THIS.this_cAcaos      = TratarNulo(Acaos,      "C")
973: 
974:                 IF TYPE("DtAlerts") = "T" OR TYPE("DtAlerts") = "D"

--- BO Linhas 965 a 975 ---
965: 
966:                 THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
967:                 THIS.this_cContas     = TratarNulo(Contas,     "C")
968:                 THIS.this_cEmails     = TratarNulo(emails,     "C")
969:                 THIS.this_cMensagems  = TratarNulo(mensagems,  "C")
970:                 THIS.this_cPrioridade = TratarNulo(prioridade, "C")
971:                 THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
972:                 THIS.this_cAcaos      = TratarNulo(Acaos,      "C")
973: 
974:                 IF TYPE("DtAlerts") = "T" OR TYPE("DtAlerts") = "D"
975:                     THIS.this_tDtAlerts = NVL(DtAlerts, {})

--- BO Linhas 1019 a 1029 ---
1019:             loc_tData  = IIF(EMPTY(THIS.this_tDtAlerts), "GETDATE()", ;
1020:                              FormatarDataSQL(THIS.this_tDtAlerts))
1021: 
1022:             loc_cSQL = "INSERT INTO SigAlert " + ;
1023:                        "(pkchaves, Emps, Dopes, Numes, Grupos, Contas, " + ;
1024:                        "emails, mensagems, prioridade, EmpDopNums, Acaos, " + ;
1025:                        "DtAlerts, msg1s, Usuars) VALUES (" + ;
1026:                        EscaparSQL(LEFT(loc_cPk, 36)) + ", " + ;
1027:                        EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmp), 3)) + ", " + ;
1028:                        EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
1029:                        FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;

--- BO Linhas 1085 a 1095 ---
1085:                        "Emps = "       + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmp), 3))   + ", " + ;
1086:                        "Dopes = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
1087:                        "Numes = "      + FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;
1088:                        "Grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
1089:                        "Contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + ", " + ;
1090:                        "emails = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmails), 50)) + ", " + ;
1091:                        "mensagems = "  + EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
1092:                        "prioridade = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cPrioridade), 15)) + ", " + ;
1093:                        "EmpDopNums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
1094:                        "Acaos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAcaos), 10)) + ", " + ;
1095:                        "DtAlerts = "   + loc_tData + ", " + ;

--- BO Linhas 1086 a 1096 ---
1086:                        "Dopes = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
1087:                        "Numes = "      + FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;
1088:                        "Grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
1089:                        "Contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + ", " + ;
1090:                        "emails = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmails), 50)) + ", " + ;
1091:                        "mensagems = "  + EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
1092:                        "prioridade = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cPrioridade), 15)) + ", " + ;
1093:                        "EmpDopNums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
1094:                        "Acaos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAcaos), 10)) + ", " + ;
1095:                        "DtAlerts = "   + loc_tData + ", " + ;
1096:                        "msg1s = "      + EscaparSQL(ALLTRIM(THIS.this_cMsg1s)) + ", " + ;

--- BO Linhas 1087 a 1097 ---
1087:                        "Numes = "      + FormatarNumeroSQL(loc_nNumes, 0) + ", " + ;
1088:                        "Grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
1089:                        "Contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + ", " + ;
1090:                        "emails = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmails), 50)) + ", " + ;
1091:                        "mensagems = "  + EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
1092:                        "prioridade = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cPrioridade), 15)) + ", " + ;
1093:                        "EmpDopNums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
1094:                        "Acaos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAcaos), 10)) + ", " + ;
1095:                        "DtAlerts = "   + loc_tData + ", " + ;
1096:                        "msg1s = "      + EscaparSQL(ALLTRIM(THIS.this_cMsg1s)) + ", " + ;
1097:                        "Usuars = "     + EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cUsuars, ;


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
