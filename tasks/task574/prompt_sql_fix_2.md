CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3017: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3017: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3073: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3073: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3073: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3183: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3183: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3183: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3183: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3183: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3241: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3241: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3241: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3241: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)
- [SQL-SCHEMA] Linha ~3241: Coluna 'empsubns' NAO EXISTE na tabela 'sigopdev' (referenciada como a.EmpSubns)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

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
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGMVMVTBO.prg):

--- BO Linhas 433 a 443 ---
433: 
434:         IF USED(loc_cCursor)
435:             USE IN (loc_cCursor)
436:         ENDIF
437: 
438:         loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
439:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
440:             "SUM(c.Qtds) AS Qtds " + ;
441:             "FROM SigMvPec a " + ;
442:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
443:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;

--- BO Linhas 441 a 451 ---
441:             "FROM SigMvPec a " + ;
442:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
443:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
444:             "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
445:             IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
446:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
447:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
448:             "UNION ALL " + ;
449:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
450:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
451:             "SUM(c.Qtds) AS Qtds " + ;

--- BO Linhas 444 a 454 ---
444:             "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
445:             IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
446:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
447:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
448:             "UNION ALL " + ;
449:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
450:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
451:             "SUM(c.Qtds) AS Qtds " + ;
452:             "FROM SigOpDev a " + ;
453:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
454:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;

--- BO Linhas 489 a 499 ---
489: 
490:         IF USED(loc_cCursor)
491:             USE IN (loc_cCursor)
492:         ENDIF
493: 
494:         loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
495:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
496:             "SUM(c.Qtds) AS Qtds " + ;
497:             "FROM SigMvPec a " + ;
498:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
499:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;

--- BO Linhas 496 a 506 ---
496:             "SUM(c.Qtds) AS Qtds " + ;
497:             "FROM SigMvPec a " + ;
498:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
499:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
500:             "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
501:             "AND a.EmpSubns = " + EscaparSQL(LEFT(par_cEmpDopNums, 3)) + " " + ;
502:             IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
503:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
504:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
505:             "UNION ALL " + ;
506:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;

--- BO Linhas 498 a 508 ---
498:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
499:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
500:             "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
501:             "AND a.EmpSubns = " + EscaparSQL(LEFT(par_cEmpDopNums, 3)) + " " + ;
502:             IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
503:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
504:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
505:             "UNION ALL " + ;
506:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
507:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
508:             "SUM(c.Qtds) AS Qtds " + ;

--- BO Linhas 501 a 511 ---
501:             "AND a.EmpSubns = " + EscaparSQL(LEFT(par_cEmpDopNums, 3)) + " " + ;
502:             IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
503:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
504:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
505:             "UNION ALL " + ;
506:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
507:             "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
508:             "SUM(c.Qtds) AS Qtds " + ;
509:             "FROM SigOpDev a " + ;
510:             "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
511:             "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;

--- BO Linhas 540 a 550 ---
540: 
541:         IF USED(loc_cCursorDedup)
542:             USE IN (loc_cCursorDedup)
543:         ENDIF
544: 
545:         SELECT a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, SUM(qtds) AS qtds ;
546:             FROM (par_cCursorOrigem) a ;
547:             GROUP BY a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns ;
548:             INTO CURSOR (loc_cCursorDedup) READWRITE
549: 
550:         SELECT (loc_cCursorDedup)

--- BO Linhas 542 a 552 ---
542:             USE IN (loc_cCursorDedup)
543:         ENDIF
544: 
545:         SELECT a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, SUM(qtds) AS qtds ;
546:             FROM (par_cCursorOrigem) a ;
547:             GROUP BY a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns ;
548:             INTO CURSOR (loc_cCursorDedup) READWRITE
549: 
550:         SELECT (loc_cCursorDedup)
551:         DELETE FOR qtds <> 0
552:         GO TOP

--- BO Linhas 599 a 609 ---
599: 
600:         IF USED(loc_cCursor)
601:             USE IN (loc_cCursor)
602:         ENDIF
603: 
604:         loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
605:             "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
606:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
607:             "AND a.EmpDopNums = b.EmpDopNums " + ;
608:             "AND a.EmpDopNums = c.EmpDopNums " + ;
609:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;

--- BO Linhas 605 a 615 ---
605:             "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
606:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
607:             "AND a.EmpDopNums = b.EmpDopNums " + ;
608:             "AND a.EmpDopNums = c.EmpDopNums " + ;
609:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
610:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
611:             "UNION ALL " + ;
612:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
613:             "FROM SigMvPec a, SigMvCab b " + ;
614:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
615:             "AND a.EmpDopNums = b.EmpDopNums " + ;

--- BO Linhas 607 a 617 ---
607:             "AND a.EmpDopNums = b.EmpDopNums " + ;
608:             "AND a.EmpDopNums = c.EmpDopNums " + ;
609:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
610:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
611:             "UNION ALL " + ;
612:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
613:             "FROM SigMvPec a, SigMvCab b " + ;
614:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
615:             "AND a.EmpDopNums = b.EmpDopNums " + ;
616:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
617:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;

--- BO Linhas 611 a 621 ---
611:             "UNION ALL " + ;
612:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
613:             "FROM SigMvPec a, SigMvCab b " + ;
614:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
615:             "AND a.EmpDopNums = b.EmpDopNums " + ;
616:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
617:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
618:             "UNION ALL " + ;
619:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps AS EmpSubns, SUM(c.Qtds) AS Qtds " + ;
620:             "FROM SigOpDev a, SigMvCab b, SigMvItn c " + ;
621:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;

--- BO Linhas 612 a 622 ---
612:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
613:             "FROM SigMvPec a, SigMvCab b " + ;
614:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
615:             "AND a.EmpDopNums = b.EmpDopNums " + ;
616:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
617:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
618:             "UNION ALL " + ;
619:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps AS EmpSubns, SUM(c.Qtds) AS Qtds " + ;
620:             "FROM SigOpDev a, SigMvCab b, SigMvItn c " + ;
621:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
622:             "AND a.EmpDopNums = b.EmpDopNums " + ;

--- BO Linhas 614 a 624 ---
614:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
615:             "AND a.EmpDopNums = b.EmpDopNums " + ;
616:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
617:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
618:             "UNION ALL " + ;
619:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps AS EmpSubns, SUM(c.Qtds) AS Qtds " + ;
620:             "FROM SigOpDev a, SigMvCab b, SigMvItn c " + ;
621:             "WHERE a.Codigos = " + loc_cCodigo + " " + ;
622:             "AND a.EmpDopNums = b.EmpDopNums " + ;
623:             "AND a.EmpDopNums = c.EmpDopNums " + ;
624:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;

--- BO Linhas 657 a 667 ---
657: 
658:         IF USED(loc_cCursor)
659:             USE IN (loc_cCursor)
660:         ENDIF
661: 
662:         loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
663:             "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
664:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
665:             "AND a.EmpDopNums = b.EmpDopNums " + ;
666:             "AND a.EmpDopNums = c.EmpDopNums " + ;
667:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;

--- BO Linhas 663 a 673 ---
663:             "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
664:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
665:             "AND a.EmpDopNums = b.EmpDopNums " + ;
666:             "AND a.EmpDopNums = c.EmpDopNums " + ;
667:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
668:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
669:             "UNION ALL " + ;
670:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
671:             "FROM SigMvPec a, SigMvCab b " + ;
672:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
673:             "AND a.EmpDopNums = b.EmpDopNums " + ;

--- BO Linhas 665 a 675 ---
665:             "AND a.EmpDopNums = b.EmpDopNums " + ;
666:             "AND a.EmpDopNums = c.EmpDopNums " + ;
667:             "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
668:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
669:             "UNION ALL " + ;
670:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
671:             "FROM SigMvPec a, SigMvCab b " + ;
672:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
673:             "AND a.EmpDopNums = b.EmpDopNums " + ;
674:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
675:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;

--- BO Linhas 669 a 679 ---
669:             "UNION ALL " + ;
670:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
671:             "FROM SigMvPec a, SigMvCab b " + ;
672:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
673:             "AND a.EmpDopNums = b.EmpDopNums " + ;
674:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
675:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
676:             "UNION ALL " + ;
677:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps AS EmpSubns, 0 AS Qtds " + ;
678:             "FROM SigOpDev a, SigMvCab b " + ;
679:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;

--- BO Linhas 670 a 680 ---
670:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
671:             "FROM SigMvPec a, SigMvCab b " + ;
672:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
673:             "AND a.EmpDopNums = b.EmpDopNums " + ;
674:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
675:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
676:             "UNION ALL " + ;
677:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps AS EmpSubns, 0 AS Qtds " + ;
678:             "FROM SigOpDev a, SigMvCab b " + ;
679:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
680:             "AND a.EmpDopNums = b.EmpDopNums " + ;

--- BO Linhas 672 a 682 ---
672:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
673:             "AND a.EmpDopNums = b.EmpDopNums " + ;
674:             "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
675:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
676:             "UNION ALL " + ;
677:             "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps AS EmpSubns, 0 AS Qtds " + ;
678:             "FROM SigOpDev a, SigMvCab b " + ;
679:             "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
680:             "AND a.EmpDopNums = b.EmpDopNums " + ;
681:             "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums"
682: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg
- BO: C:\4c\projeto\app\classes\SIGMVMVTBO.prg
