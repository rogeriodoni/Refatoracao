CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1358: Coluna 'cbars' NAO EXISTE na tabela 'sigmvest' (referenciada como a.CBars)
- [SQL-SCHEMA] Linha ~1358: Coluna 'empos' NAO EXISTE na tabela 'sigmvest' (referenciada como a.EmpOs)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvest
CREATE TABLE [dbo].[SigMvEst](
	[codcors] [char](4) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[emps] [char](3) NOT NULL,
	[estos] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[moedmeds] [char](3) NOT NULL,
	[sqtds] [numeric](11, 3) NOT NULL,
	[teqtds] [numeric](11, 3) NOT NULL,
	[tipests] [char](15) NOT NULL,
	[tsqtds] [numeric](11, 3) NOT NULL,
	[unitmeds] [numeric](13, 4) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[dtalts] [datetime] NULL,
	[empgruests] [char](23) NOT NULL,
	[tipoestos] [numeric](1, 0) NOT NULL,
	[dtimeds] [datetime] NULL,
	[qtimeds] [numeric](4, 0) NOT NULL,
	[spesos] [numeric](15, 3) NOT NULL,
	[unitmfis] [numeric](15, 6) NOT NULL,
	[medipis] [numeric](15, 6) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigreeqeBO.prg):

--- BO Linhas 21 a 31 ---
21: *   cursor_4c_SigCdCot  - cotacoes (CMoes, Datas, ...)
22: *   cursor_4c_SigCdGrp  - grupos (CGrus, Arreds)
23: *   cursor_4c_SigCdCfi  - configuracao ICMS (Grupos, Ests, ICMs)
24: *
25: * Cursor de resultado produzido por PrepararDados():
26: *   CsRelatorio - CBars, DPros, Units, SitTribs, Aliqs
27: *
28: * Cursor de cabecalho produzido por GerarCabecalho():
29: *   CsCabecalho - nomeempresa, titulo1, Barra
30: *==============================================================================
31: 

--- BO Linhas 378 a 388 ---
378:                 USE IN CsRelatorio
379:             ENDIF
380: 
381:             *-- Criar cursor de resultado: estrutura identica ao original
382:             CREATE CURSOR CsRelatorio ;
383:                 (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))
384: 
385:             IF loc_nAgrupa = 2
386:                 INDEX ON CBars TAG CBars
387:             ENDIF
388: 

--- BO Linhas 381 a 391 ---
381:             *-- Criar cursor de resultado: estrutura identica ao original
382:             CREATE CURSOR CsRelatorio ;
383:                 (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))
384: 
385:             IF loc_nAgrupa = 2
386:                 INDEX ON CBars TAG CBars
387:             ENDIF
388: 
389:             *-- Numero de parcelas da tabela de desconto
390:             loc_nParcs = 0
391:             IF !EMPTY(loc_cTabela)

--- BO Linhas 416 a 426 ---
416:                     GO TOP
417:                 ENDIF
418:             ENDIF
419: 
420:             *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
421:             loc_cSQL = "SELECT '1' AS Ps, a.CPros, a.CBars, b.DPros, b.PVens," + ;
422:                 " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
423:                 " b.Sgrus, b.sittricms, b.CodFinP" + ;
424:                 " FROM SigOpEtq a, SigCdPro b, SigCdUni c" + ;
425:                 " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
426:                 loc_cFiltroGrupo + loc_cFiltroEsto + ;

--- BO Linhas 420 a 430 ---
420:             *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
421:             loc_cSQL = "SELECT '1' AS Ps, a.CPros, a.CBars, b.DPros, b.PVens," + ;
422:                 " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
423:                 " b.Sgrus, b.sittricms, b.CodFinP" + ;
424:                 " FROM SigOpEtq a, SigCdPro b, SigCdUni c" + ;
425:                 " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
426:                 loc_cFiltroGrupo + loc_cFiltroEsto + ;
427:                 " AND b.CPros = a.CPros" + ;
428:                 " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
429:                 " UNION ALL" + ;
430:                 " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;

--- BO Linhas 425 a 435 ---
425:                 " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
426:                 loc_cFiltroGrupo + loc_cFiltroEsto + ;
427:                 " AND b.CPros = a.CPros" + ;
428:                 " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
429:                 " UNION ALL" + ;
430:                 " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;
431:                 " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
432:                 " b.Sgrus, b.sittricms, b.CodFinP" + ;
433:                 " FROM SigMvEst a, SigCdPro b, SigCdUni c" + ;
434:                 " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa)
435: 

--- BO Linhas 531 a 541 ---
531:                     ENDIF
532:                 ENDIF
533: 
534:                 *-- Situacao tributaria e codigo de barras (string)
535:                 m.SitTribs = IIF(EMPTY(m.SitTricms), "00", m.SitTricms)
536:                 loc_cCBars = STR(m.CBars, 14)
537: 
538:                 *-- Inserir no cursor de resultado
539:                 IF loc_nAgrupa = 2
540:                     *-- Identidade: deduplicar por codigo de barras, manter maior preco
541:                     SELECT CsRelatorio

--- BO Linhas 537 a 547 ---
537: 
538:                 *-- Inserir no cursor de resultado
539:                 IF loc_nAgrupa = 2
540:                     *-- Identidade: deduplicar por codigo de barras, manter maior preco
541:                     SELECT CsRelatorio
542:                     IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
543:                         INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
544:                             VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
545:                     ELSE
546:                         IF m.Units > CsRelatorio.Units
547:                             GATHER MEMVAR FIELDS Units

--- BO Linhas 538 a 548 ---
538:                 *-- Inserir no cursor de resultado
539:                 IF loc_nAgrupa = 2
540:                     *-- Identidade: deduplicar por codigo de barras, manter maior preco
541:                     SELECT CsRelatorio
542:                     IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
543:                         INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
544:                             VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
545:                     ELSE
546:                         IF m.Units > CsRelatorio.Units
547:                             GATHER MEMVAR FIELDS Units
548:                         ENDIF

--- BO Linhas 548 a 558 ---
548:                         ENDIF
549:                     ENDIF
550:                 ELSE
551:                     *-- Barra: inserir todos os registros
552:                     SELECT CsRelatorio
553:                     INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
554:                         VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
555:                 ENDIF
556: 
557:                 SELECT CsRel
558: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg
- BO: C:\4c\projeto\app\classes\sigreeqeBO.prg
